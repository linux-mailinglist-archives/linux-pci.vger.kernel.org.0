Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B156563E0
	for <lists+linux-pci@lfdr.de>; Mon, 26 Dec 2022 16:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiLZPqv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Dec 2022 10:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLZPqu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Dec 2022 10:46:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027B273;
        Mon, 26 Dec 2022 07:46:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 297A5B80D53;
        Mon, 26 Dec 2022 15:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FD6C433D2;
        Mon, 26 Dec 2022 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672069606;
        bh=Uom+2CEda3eC3rPnPw0DKcEougkX6GjwzRBssTnD6Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MWzoRhJwRGnll7yOMD/n+cgYf8e03UbOxRsiMrQ8Zg++abhIBxGWn8pxvrLD+FY39
         Atdjw8CEQGfEGQpIeBPgVcRsvP3fT4AelGEOUzVBhCyffHXP0gTfwOXWxfelCqlAfh
         r1kWxT6udO6TtKf4aj1peMSW/6oI+iGoN87eUV0Xl1q7tDWQEVeDuIXmmzCSDOEh89
         x0W0aWjfwFdGNzZeY0YyIURurkWZEKJ+gtiHsQvS0IPy0LQdrfR0LtiK8PJryLcl3v
         87WMlGohnJuQVVnV0n+g+6vd7kkYNgWouleYf8YywuhF4yuZLOn69XmX09QQzu5BB6
         Rq4DohehooXBw==
Received: by pali.im (Postfix)
        id 6B7E49D7; Mon, 26 Dec 2022 16:46:43 +0100 (CET)
Date:   Mon, 26 Dec 2022 16:46:43 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/portdrv: Avoid enabling AER on Thunderbolt devices
Message-ID: <20221226154643.kidhqooedmijj3iw@pali>
References: <20221226153048.1208359-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226153048.1208359-1-kai.heng.feng@canonical.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 26 December 2022 23:30:31 Kai-Heng Feng wrote:
> We are seeing igc ethernet device on Thunderbolt dock stops working
> after S3 resume because of AER error, or even make S3 resume freeze:

Hello! Is igc ethernet the only device which does not work after resume?
Or do you have also more devices to test and check for this issue?

I'm asking it just because to know if we are dealing with one device or
there are lot of more. Because if it is just one device then it could be
better to disable AER only for one targeted device instead of all. Error
reporting is a feature which may help to detect broken HW unit and be useful.

> pcieport 0000:00:1d.0: AER: Multiple Corrected error received: 0000:00:1d.0
> pcieport 0000:00:1d.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
> pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00008000/00002000
> pcieport 0000:00:1d.0:    [15] HeaderOF
> pcieport 0000:00:1d.0: AER: Multiple Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 0a000052 00000000 00000000
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
> 
> Windows is however not affected by this issue, by using WinDbg's !pci
> command, it shows that AER is not enabled for devices connected via
> Thunderbolt port, and that's the reason why Windows doesn't exhibit the
> issue.

Could you try to manually enable AER on Windows (via touching PCIe
config registers) if Windows can trigger this issue too, or not?

> So turn a blind eye on external Thunderbolt devices like Windows does by
> disabling AER.
> 
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
