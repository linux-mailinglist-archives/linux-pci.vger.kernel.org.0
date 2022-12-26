Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA567656598
	for <lists+linux-pci@lfdr.de>; Mon, 26 Dec 2022 23:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiLZWvX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Dec 2022 17:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiLZWuv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Dec 2022 17:50:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EBE2657;
        Mon, 26 Dec 2022 14:50:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15F8DB80DB4;
        Mon, 26 Dec 2022 22:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B18C433D2;
        Mon, 26 Dec 2022 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672095047;
        bh=tkSpVVjv/nV+XYJhqA1quZ54G/qu34LwdP3dgR/CNa0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Cv9admjKnRTsrrXUqVkooE5cwmrOTtgKmj2VwQxoDDP7eeDvT9o5Dgy/6mOo/qdWp
         Z3vEvPT8Y2ElP5INS41StaKtU11U3Xf+FgKBV3j4oicXNVsqGQueuD2vDXXFb0V4TR
         hv316bXcRdSnmrAI2AuMQjg0894qB2SV1U9OWF5ceZGGTuAiE7DP+He0JIBJUMFik9
         yyHAlIDd5Vwzf5Ohv3UDQ2nU3OymMTy8FVgsQje3ifxNwdZZyfpLUccy8dHRhwFGjh
         Qt5QSQCh0kjfU7EphWjHC4cehN3DfARSaqs/A5swYsSbFtZTMjP/iPdL2qU/yw92Ae
         DsR4UDDD+pVtg==
Date:   Mon, 26 Dec 2022 16:50:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH] PCI/portdrv: Avoid enabling AER on Thunderbolt devices
Message-ID: <20221226225045.GA400369@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226153048.1208359-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc David]

Hi Kai-Heng,

Thanks for the report and the debugging!

On Mon, Dec 26, 2022 at 11:30:31PM +0800, Kai-Heng Feng wrote:
> We are seeing igc ethernet device on Thunderbolt dock stops working
> after S3 resume because of AER error, or even make S3 resume freeze:
> pcieport 0000:00:1d.0: AER: Multiple Corrected error received: 0000:00:1d.0
> pcieport 0000:00:1d.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
> pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00008000/00002000
> pcieport 0000:00:1d.0:    [15] HeaderOF
> pcieport 0000:00:1d.0: AER: Multiple Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 0a000052 00000000 00000000

From a very quick look, I think 34...... ......52 is a PTM message (as
you suggest below).

> pcieport 0000:00:1d.0: AER:   Error of this Agent is reported first
> pcieport 0000:04:01.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> pcieport 0000:04:01.0:   device [8086:1136] error status/mask=00300000/00000000
> pcieport 0000:04:01.0:    [20] UnsupReq               (First)
> pcieport 0000:04:01.0:    [21] ACSViol
> pcieport 0000:04:01.0: AER:   TLP Header: 34000000 04000052 00000000 00000000
> thunderbolt 0000:05:00.0: AER: can't recover (no error_detected callback)
> 
> This supposedly should be fixed by commit c01163dbd1b8 ("PCI/PM: Always disable
> PTM for all devices during suspend"), but somehow it doesn't work for
> this case.
> 
> By dumping the PCI_PTM_CTRL register on resume, it turns out PTM is
> already flipped on by either the Thunderbolt dock firmware or the host
> BIOS. Writing 0 to PCI_PTM_CTRL yields the same result.

Can you share your debug patch and corresponding dmesg log in the
bugzilla?

> Windows is however not affected by this issue, by using WinDbg's !pci
> command, it shows that AER is not enabled for devices connected via
> Thunderbolt port, and that's the reason why Windows doesn't exhibit the
> issue.
> 
> So turn a blind eye on external Thunderbolt devices like Windows does by
> disabling AER.

Unless there's something in the PCIe or Thunderbolt spec that says AER
shouldn't be used on external devices, I think we need to figure out
the root cause before disabling AER on all removable devices.

The dmesg in the bugzilla below is from an HP ZBook Fury 16.  Do you
see this on any other platforms?  Do you have any HP BIOS contacts to
ask about this?

It seems like a firmware defect to enable PTM without knowing whether
upstream devices have PTM enabled.

We could leave PTM enabled on upstream devices when suspending, but
that apparently prevents some low-power states.  Adding David since he
worked on that.

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216850
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/portdrv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 2cc2e60bcb396..59d00e20e57bf 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -237,7 +237,8 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>               pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>  	    dev->aer_cap && pci_aer_available() &&
> -	    (pcie_ports_native || host->native_aer))
> +	    (pcie_ports_native || host->native_aer) &&
> +	    !dev_is_removable(&dev->dev))
>  		services |= PCIE_PORT_SERVICE_AER;
>  #endif
>  
> -- 
> 2.34.1
> 
