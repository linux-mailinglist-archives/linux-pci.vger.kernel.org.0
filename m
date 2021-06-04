Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F68039BE1D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhFDRL1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 13:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFDRL0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 13:11:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31FED61400;
        Fri,  4 Jun 2021 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622826580;
        bh=ekYNNM0J7LDGUfjPAWcrV85LQws7eJp6g7nHhYT6wEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HY3URPuumDVSZrrelO8gsO5Co+IGLwxBPdMyGiAvw94C2fsdaJXUYXVhpx+Iicpbt
         +wzmkyFGpE0oUm+srrDRIvIo+Ou5Ksm9c+lyU5hKOdOzL9OreFqlda6cViOt4Zs/Df
         A9Ujf1WkqORYf3utoPQUsvD3aiCmwMHtv5TYn5u0brbkYXaLojpwoW6ltqeeuNkNkH
         Il2IXRvIygybw4jObaIww49F9K6NYpdPPcfcfebN3VfBgzMIGY9lOxMQZv7mepdABO
         G4GBQ8hHXTH09DUNe0+8ZEFeSGgrBH3WfmtosSdctZDShwjn/mwu0YTzi3kVrbgyJT
         Qo9PawL16RkKg==
Date:   Fri, 4 Jun 2021 12:09:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jroedel@suse.de
Subject: Re: [PATCH] PCI/APCI: Move acpi_pci_osc_support() check to
 negotiation phase
Message-ID: <20210604170938.GA2218177@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603205047.GA2135380@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 03, 2021 at 03:50:47PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 03, 2021 at 02:48:14PM +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > ...

> > -static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
> > +static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32
> > +					    *mask, u32 req, u32 support)
> >  {
> >  	struct acpi_pci_root *root;
> >  	acpi_status status;
> > @@ -370,7 +361,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
> >  
> >  	/* Need to check the available controls bits before requesting them. */
> >  	while (*mask) {
> > -		status = acpi_pci_query_osc(root, root->osc_support_set, mask);
> > +		status = acpi_pci_query_osc(root, support, mask);
> >  		if (ACPI_FAILURE(status))
> >  			return status;
> >  		if (ctrl == *mask)
> > @@ -433,18 +424,6 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
> >  		support |= OSC_PCI_EDR_SUPPORT;
> >  
> >  	decode_osc_support(root, "OS supports", support);
> > -	status = acpi_pci_osc_support(root, support);
> > -	if (ACPI_FAILURE(status)) {
> > -		*no_aspm = 1;
> > -
> > -		/* _OSC is optional for PCI host bridges */
> > -		if ((status == AE_NOT_FOUND) && !is_pcie)
> > -			return;
> > -
> > -		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> > -			 acpi_format_exception(status));
> > -		return;
> > -	}
> >  
> >  	if (pcie_ports_disabled) {
> >  		dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
> 
> Also not related to this patch, but it seems pointless to compute and
> decode "support" above when we're not going to use _OSC at all.  I
> think the "pcie_ports_disabled" test should be the very first thing in
> this function (I'm assuming the "pcie_ports=compat" command line
> argument *should* apply even on x86_apple_machine, which it doesn't
> today).

I think I was wrong about this.  Even when "pcie_ports_disabled", the
current code *does* evaluate "_OSC(Query, SUPPORT=x, CONTROL=0)",
i.e., it tells the platform what Linux supports, but doesn't request
control of anything.

I think the platform may rely on this knowledge of what the OS
supports.  For example, if we tell the platform that Linux has
OSC_PCI_EXT_CONFIG_SUPPORT, that may change the behavior of ASL that
accesses config space.

So I don't think it's safe to move this test to the beginning of the
function as I proposed.

For the same reason, I'm not sure that it's safe to remove
acpi_pci_osc_support() as in this patch.  If either
"pcie_ports_disabled" or Linux doesn't support everything in
ACPI_PCIE_REQ_SUPPORT, we will never evaluate _OSC at all, so
the platform won't know that Linux has OSC_PCI_SEGMENT_GROUPS_SUPPORT,
OSC_PCI_HPX_TYPE_3_SUPPORT, OSC_PCI_EXT_CONFIG_SUPPORT, etc.

Bjorn
