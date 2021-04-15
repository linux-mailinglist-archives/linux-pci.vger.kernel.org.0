Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC4636000E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 04:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhDOChV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 22:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229598AbhDOChU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Apr 2021 22:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618454218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJ/NhFJ/5w97cge6L4nB3sFH5WwdkeYqRWij9oLcRHk=;
        b=VxArDwZn+IWKxlEiLjCMOhUp7juycMu1u2naOIDd5Hcw0QPhzqI9zyIpLoKbFwJfZ17Nj/
        JIq/yffUsClnh19LOqlPzhaBpJGJc+A1Yjaqlp7qtrp5oPLRBTWFAwsYxjFLnvVf17nBlo
        3anJaXkA3Q+lICPIn2DPvra2Owq8gxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-wkaO773ZNSyuj9guWvsjXw-1; Wed, 14 Apr 2021 22:36:53 -0400
X-MC-Unique: wkaO773ZNSyuj9guWvsjXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B94A64157;
        Thu, 15 Apr 2021 02:36:52 +0000 (UTC)
Received: from x1.home.shazbot.org (ovpn-117-254.rdu2.redhat.com [10.10.117.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DCF16064B;
        Thu, 15 Apr 2021 02:36:51 +0000 (UTC)
Date:   Wed, 14 Apr 2021 20:36:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ingmar Klein <ingmar_klein@web.de>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: QCA6174 pcie wifi: Add pci quirks
Message-ID: <20210414203650.1f83a5dd@x1.home.shazbot.org>
In-Reply-To: <20210414210350.GA2537653@bjorn-Precision-5520>
References: <08982e05-b6e8-5a8d-24ab-da1488ee50a8@web.de>
        <20210414210350.GA2537653@bjorn-Precision-5520>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 14 Apr 2021 16:03:50 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex]
> 
> On Fri, Apr 09, 2021 at 11:26:33AM +0200, Ingmar Klein wrote:
> > Edit: Retry, as I did not consider, that my mail-client would make this
> > party html.
> > 
> > Dear maintainers,
> > I recently encountered an issue on my Proxmox server system, that
> > includes a Qualcomm QCA6174 m.2 PCIe wifi module.
> > https://deviwiki.com/wiki/AIRETOS_AFX-QCA6174-NX
> > 
> > On system boot and subsequent virtual machine start (with passed-through
> > QCA6174), the VM would just freeze/hang, at the point where the ath10k
> > driver loads.
> > Quick search in the proxmox related topics, brought me to the following
> > discussion, which suggested a PCI quirk entry for the QCA6174 in the kernel:
> > https://forum.proxmox.com/threads/pcie-passthrough-freezes-proxmox.27513/
> > 
> > I then went ahead, got the Proxmox kernel source (v5.4.106) and applied
> > the attached patch.
> > Effect was as hoped, that the VM hangs are now gone. System boots and
> > runs as intended.
> > 
> > Judging by the existing quirk entries for Atheros, I would think, that
> > my proposed "fix" could be included in the vanilla kernel.
> > As far as I saw, there is no entry yet, even in the latest kernel sources.  
> 
> This would need a signed-off-by; see
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.11#n361
> 
> This is an old issue, and likely we'll end up just applying this as
> yet another quirk.  But looking at c3e59ee4e766 ("PCI: Mark Atheros
> AR93xx to avoid bus reset"), where it started, it seems to be
> connected to 425c1b223dac ("PCI: Add Virtual Channel to save/restore
> support").
> 
> I'd like to dig into that a bit more to see if there are any clues.
> AFAIK Linux itself still doesn't use VC at all, and 425c1b223dac added
> a fair bit of code.  I wonder if we're restoring something out of
> order or making some simple mistake in the way to restore VC config.

I don't really have any faith in that bisect report in commit
c3e59ee4e766.  To double check I dug out the card from that commit,
installed an old Fedora release so I could build kernel v3.13,
pre-dating 425c1b223dac and tested triggering a bus reset both via
setpci and by masking PM reset so that sysfs can trigger the bus reset
path with the kernel save/restore code.  Both result in the system
hanging when the device is accessed either restoring from the kernel
bus reset or reading from the device after the setpci reset.  Thanks,

Alex

