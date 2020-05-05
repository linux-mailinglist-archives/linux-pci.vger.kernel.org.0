Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD091C4AE1
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 02:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgEEAG3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 20:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgEEAG3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 20:06:29 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8259206CC;
        Tue,  5 May 2020 00:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588637188;
        bh=l+4gYXBpKbNrF4ziMzIsWh2ZrMr3XPwzNigICi+Qxjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Qw0vVErOHOLQa3ibDNCztf3CB7OsHtyy/F5Cv38xlFn5njJWQ/aHpYE8qMfNOVXrQ
         K1ILwLnA0cOeZg/Nhgbfr81ltW/5DmshUcXynNeIP022oVFGTDUnsNqqSTQJejXX5w
         JvthQ+0qfSMSVdrcjPefdHsBXImw7OH1cQ1EaEIg=
Date:   Mon, 4 May 2020 19:06:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     refactormyself@gmail.com
Cc:     bjorn@helgaas.com, yangyicong@hisilicon.com,
        skhan@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] pci: Make return value of pcie_capability_*()
 consistent
Message-ID: <20200505000626.GA303564@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504051812.22662-2-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Wherever you're working in the tree, pay attention to the existing
style of code, comments, and commit logs and make yours match.  For
example,

  $ git log --oneline drivers/pci/access.c
  af65d1ad416b PCI/AER: Save AER Capability for suspend/resume
  984998e3404e PCI: Make pcie_downstream_port() available outside of access.c
  5180fd913558 PCI: Uninline PCI bus accessors for better ftracing
  df62ab5e0f75 PCI: Tidy comments
  f0eb77ae6b85 PCI/VPD: Move VPD access code to vpd.c
  ab8c609356fb Merge branch 'pci/spdx' into next
  7328c8f48d18 PCI: Add SPDX GPL-2.0 when no license was specified
  7506dc798993 PCI: Add wrappers for dev_printk()

So your subject needs to be something like:

  PCI: Make return value of pcie_capability_*() consistent

On Mon, May 04, 2020 at 07:18:11AM +0200, refactormyself@gmail.com wrote:
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> 
> pcie_capability_{read|write}_*() could return 0, -EINVAL, or any of the
> PCIBIOS_* error codes. This is behaviour is now changed to ONLY return a
> PCIBIOS_* error code or -ERANGE on error.
> This has now been made consistent across all accessors. Callers now have
> a consistent way for checking which error has occurred.
> 
> An audit of the callers of these functions was made and no contradicting
> case was found in the examined call chains.
> 
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> ---
>  drivers/pci/access.c | 64 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 51 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 79c4a2ef269a..10c771079e35 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -402,6 +402,8 @@ static bool pcie_capability_reg_implemented(struct pci_dev *dev, int pos)
>   * Note that these accessor functions are only for the "PCI Express
>   * Capability" (see PCIe spec r3.0, sec 7.8).  They do not apply to the
>   * other "PCI Express Extended Capabilities" (AER, VC, ACS, MFVC, etc.)
> + *
> + * Return 0 on success, otherwise a negative value

Actually, a negative *error value*.

>  int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>  {
> @@ -409,7 +411,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>  
>  	*val = 0;
>  	if (pos & 1)
> -		return -EINVAL;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;

This does not match the commit log or the function comment.  I know
the *next* patch will make it true, but the commit log and function
comment must describe the code at this point.  Everything must be
consistent and buildable after every commit because future patches may
not ever be applied.

I think there's no reason to change these pcie_capability_*() return
values.  I think the end state we want to get to would be to deprecate
the PCIBIOS_* #defines and use the -E* definitions instead.

>  int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
>  {
> +	int ret;
>  	if (pci_dev_is_disconnected(dev)) {

Nit: style is to leave a blank line between local variables and the
first line of executable code.

>  		*val = ~0;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
> -	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
> +
> +	ret = pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
> +
> +	if (ret > 0)
> +		ret = -ERANGE;

I don't understand what you're doing here.  pci_bus_read_config_byte()
returns things like PCIBIOS_BAD_REGISTER_NUMBER,
PCIBIOS_FUNC_NOT_SUPPORTED, PCIBIOS_BAD_VENDOR_ID, etc.

These are all positive at this point, so this collapses all of them to
-ERANGE, which throws away the information about the different types
of errors, which is not what we want.

Another coding style nit: normally a check for error would be
immediately after the function call, so omit the blank line in this
case.  Generally you can learn things like this by looking at the
existing code and following the same style.

> +	return ret;
>  }
