Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCDB39ABFD
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 22:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhFCUwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 16:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhFCUwd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 16:52:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87E34613BF;
        Thu,  3 Jun 2021 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622753448;
        bh=XhynFkzdeD9GRXeKMAwdZQeHQ/caSAVlAZxGaEI0kEw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pXdpBl14RR3CzXBgDuMFtWvEg9uVo9699udJRyf11QxcTgFnn23FHahdUhKnXm+5Z
         rear6rNrQ4ilCGDUxjXMFsRsx7PKYpy+RyCrc5n3rtAv/QernJL8CTMHBUkoNp639X
         iuH8CGjcZ53vmsJc/ClgdcVL46RmV042SweTdOXXywlwr5kZCGoNgyhp+aUpiFBPeM
         Z0dk2MJdI++4uOT+wKnu+nqiTHfupLi8QsuE8Xq7NnxKKF5iLYNXP9ZXZrG48dV/sP
         bJwlQlnFEE53UuAzmNw9aQADB7E5Uw0q4IzJ0D2yqXYoVieZMPCP3BTicwvwyzGW0N
         M7s8/wbt3K+BQ==
Date:   Thu, 3 Jun 2021 15:50:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jroedel@suse.de
Subject: Re: [PATCH] PCI/APCI: Move acpi_pci_osc_support() check to
 negotiation phase
Message-ID: <20210603205047.GA2135380@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603124814.19654-1-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 03, 2021 at 02:48:14PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>

I like this patch a lot and I plan to apply it because you've managed
to simplify the nasty _OSC path a little bit.  But I'm confused about
the justification.

> The acpi_pci_osc_support() does an _OSC query with _OSC supported set
> to what the OS supports but a zero _OSC control value. This is
> problematic on some platforms where the firmware allows to configure
> whether DPC is under OS or Firmware control.
>
> When DPC is configured to be under OS control these platforms will
> issue a warning in the firmware log that the OS does not support DPC.

My understanding is that DPC is under platform control until the OS
requests it via _OSC(Request, Control & OSC_PCI_EXPRESS_DPC_CONTROL)
and the platform grants it.  And after the OS is granted control of
DPC, it must preserve OSC_PCI_EXPRESS_DPC_CONTROL in all subsequent
_OSC calls (i.e., there is no way for the OS to relinquish DPC
control).

So what does it mean for "DPC to be under OS control, but the OS does
_OSC(Query, Control=0)"?  That doesn't sound like a legal sequence:
the OS has already been granted DPC control, but it failed to preserve
OSC_PCI_EXPRESS_DPC_CONTROL?

If instead you mean that the OS has *not* been granted DPC control,
but does _OSC(Query, SUPPORT=x, CONTROL=0), I think that means the OS
is telling the platform what it supports but not requesting anything.
That sounds legal to me, so if firmware complains about it, I would
say it's a firmware problem.

> Avoid an _OSC query with _OSC control set to zero by moving the
> supported check into the acpi_pci_osc_control_set() path. This is
> still early enough to fail as nothing before that depends on the
> results of acpi_pci_osc_support().
> 
> As a result the acpi_pci_osc_support() function can be removed and
> acpi_pci_query_osc() be simplified because it no longer called with a
> NULL pointer for *control.

So I think we should do this, but not because it avoids a firmware
warning, which looks like a firmware bug to me.  We should do it just
because it simplifies this ugly code.

But please help me out if I'm misunderstanding something above.  I'm
never confident that I really understand _OSC.

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/acpi/pci_root.c | 50 ++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index dcd593766a64..530ecf4970b1 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -199,16 +199,11 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
>  
>  	support &= OSC_PCI_SUPPORT_MASKS;
>  	support |= root->osc_support_set;
> +	*control &= OSC_PCI_CONTROL_MASKS;

Unrelated to *this* patch, but I don't understand the point of
OSC_PCI_SUPPORT_MASKS and OSC_PCI_CONTROL_MASKS.  These are all
internal static functions and it looks like pointless work to apply
masks here and in acpi_pci_osc_control_set().

I'm happy to make this change, but if you do it, please make it a
separate patch for bisection purposes.

>  	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
>  	capbuf[OSC_SUPPORT_DWORD] = support;
> -	if (control) {
> -		*control &= OSC_PCI_CONTROL_MASKS;
> -		capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
> -	} else {
> -		/* Run _OSC query only with existing controls. */
> -		capbuf[OSC_CONTROL_DWORD] = root->osc_control_set;
> -	}
> +	capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
>  
>  	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
>  	if (ACPI_SUCCESS(status)) {

We can also drop the "if (control)" check inside the ACPI_SUCCESS()
block, can't we?

> @@ -219,11 +214,6 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
>  	return status;
>  }
>  
> -static acpi_status acpi_pci_osc_support(struct acpi_pci_root *root, u32 flags)
> -{
> -	return acpi_pci_query_osc(root, flags, NULL);
> -}
> -
>  struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
>  {
>  	struct acpi_pci_root *root;
> @@ -346,7 +336,8 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
>   * _OSC bits the BIOS has granted control of, but its contents are meaningless
>   * on failure.
>   **/
> -static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
> +static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32
> +					    *mask, u32 req, u32 support)
>  {
>  	struct acpi_pci_root *root;
>  	acpi_status status;
> @@ -370,7 +361,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
>  
>  	/* Need to check the available controls bits before requesting them. */
>  	while (*mask) {
> -		status = acpi_pci_query_osc(root, root->osc_support_set, mask);
> +		status = acpi_pci_query_osc(root, support, mask);
>  		if (ACPI_FAILURE(status))
>  			return status;
>  		if (ctrl == *mask)
> @@ -433,18 +424,6 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  		support |= OSC_PCI_EDR_SUPPORT;
>  
>  	decode_osc_support(root, "OS supports", support);
> -	status = acpi_pci_osc_support(root, support);
> -	if (ACPI_FAILURE(status)) {
> -		*no_aspm = 1;
> -
> -		/* _OSC is optional for PCI host bridges */
> -		if ((status == AE_NOT_FOUND) && !is_pcie)
> -			return;
> -
> -		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> -			 acpi_format_exception(status));
> -		return;
> -	}
>  
>  	if (pcie_ports_disabled) {
>  		dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");

Also not related to this patch, but it seems pointless to compute and
decode "support" above when we're not going to use _OSC at all.  I
think the "pcie_ports_disabled" test should be the very first thing in
this function (I'm assuming the "pcie_ports=compat" command line
argument *should* apply even on x86_apple_machine, which it doesn't
today).

Again, I'm happy to do this if it makes sense to you.

> @@ -483,7 +462,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  
>  	requested = control;
>  	status = acpi_pci_osc_control_set(handle, &control,
> -					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
> +					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL,
> +					  support);
>  	if (ACPI_SUCCESS(status)) {
>  		decode_osc_control(root, "OS now controls", control);
>  		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
> @@ -496,10 +476,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  			*no_aspm = 1;
>  		}
>  	} else {
> -		decode_osc_control(root, "OS requested", requested);
> -		decode_osc_control(root, "platform willing to grant", control);
> -		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> -			acpi_format_exception(status));
> +		/* Platform wants to control PCIe features */

Or _OSC just failed because of an OS or firmware defect ;)

> +		root->osc_support_set = 0;
>  
>  		/*
>  		 * We want to disable ASPM here, but aspm_disabled
> @@ -509,6 +487,16 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  		 * root scan.
>  		 */
>  		*no_aspm = 1;
> +
> +		/* _OSC is optional for PCI host bridges */
> +		if ((status == AE_NOT_FOUND) && !is_pcie)
> +			return;
> +
> +		decode_osc_control(root, "OS requested", requested);
> +		decode_osc_control(root, "platform willing to grant", control);
> +		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> +			acpi_format_exception(status));
> +
>  	}
>  }
>  
> -- 
> 2.31.1
> 
