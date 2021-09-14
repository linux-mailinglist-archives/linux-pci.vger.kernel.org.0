Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D6740B9AB
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 23:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhINVMn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 17:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233954AbhINVMn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 17:12:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D71F61213;
        Tue, 14 Sep 2021 21:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631653885;
        bh=Bxd0VKLvfxzsriy+yfxBwQo/1hSOtbhmS3G7wRMa/Vo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jXsA6V2AtKrgjvlY9XmQf9jWCECD4NEffshM1CgcN+n50D4I1Imkb8OibAdo59Vom
         b9MjI1AxzOddUUvqHMoD+ZwUsTZj2zc3lCogBnp2vLElQ78VB/7RQDPdpvKm4uBx5+
         igEMMGVjwfNx6QWGz1U0Oj1W88znhmjRrhHbHWEoMUz86A+pc8kGC1j8V/jsbb1nFo
         Rb7vgUXVZDBZnjp92BA7HUjrkiXeRgvVcBvX9HZz6Pxp01KYojZZmukhNwPwJsFCpw
         0U56j+2O9crxszjrugUgRs65+V9dqDr4xSaDcmMCoVzieHeXkN33kZYJXvCqnAaOom
         nCf0afDpF9yVQ==
Date:   Tue, 14 Sep 2021 16:11:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ingmar Klein <ingmar_klein@web.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: QCA6174 pcie wifi: Add pci quirks
Message-ID: <20210914211123.GA1457901@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08982e05-b6e8-5a8d-24ab-da1488ee50a8@web.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 09, 2021 at 11:26:33AM +0200, Ingmar Klein wrote:
> Edit: Retry, as I did not consider, that my mail-client would make this
> party html.
> 
> Dear maintainers,
> I recently encountered an issue on my Proxmox server system, that
> includes a Qualcomm QCA6174 m.2 PCIe wifi module.
> https://deviwiki.com/wiki/AIRETOS_AFX-QCA6174-NX
> 
> On system boot and subsequent virtual machine start (with passed-through
> QCA6174), the VM would just freeze/hang, at the point where the ath10k
> driver loads.
> Quick search in the proxmox related topics, brought me to the following
> discussion, which suggested a PCI quirk entry for the QCA6174 in the kernel:
> https://forum.proxmox.com/threads/pcie-passthrough-freezes-proxmox.27513/
> 
> I then went ahead, got the Proxmox kernel source (v5.4.106) and applied
> the attached patch.
> Effect was as hoped, that the VM hangs are now gone. System boots and
> runs as intended.
> 
> Judging by the existing quirk entries for Atheros, I would think, that
> my proposed "fix" could be included in the vanilla kernel.
> As far as I saw, there is no entry yet, even in the latest kernel sources.
> 
> Thank you very much!
> Best regards,
> Ingmar

I wrote a commit log and applied this to pci/virtualization for v5.16
with Pali's reviewed-by and your signed-off-by from
https://lore.kernel.org/r/408e5b45-3eaa-fa13-318d-48f7d1ecdacf@web.de

    PCI: Mark Atheros QCA6174 to avoid bus reset
    
    When passing the Atheros QCA6174 through to a virtual machine, the VM hangs
    at the point where the ath10k driver loads.
    
    Add a quirk to avoid bus resets on this device, which avoids the hang.
    
    [bhelgaas: commit log]
    Link: https://lore.kernel.org/r/08982e05-b6e8-5a8d-24ab-da1488ee50a8@web.de
    Signed-off-by: Ingmar Klein <ingmar_klein@web.de>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Pali Rohár <pali@kernel.org>
    Cc: stable@vger.kernel.org

Thank you!

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 706f27a86a8e..ecfe80ec5b9c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3584,6 +3584,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
>  
>  /*
>   * Root port on some Cavium CN8xxx chips do not successfully complete a bus

