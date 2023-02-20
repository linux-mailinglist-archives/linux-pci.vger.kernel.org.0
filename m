Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4EC69D1E9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 18:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjBTRLo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 12:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjBTRLn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 12:11:43 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C4E20549;
        Mon, 20 Feb 2023 09:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PwMBg7lbJaBvrGvhwA+E78qzUHxVlRrDHtFl3T5RvI8=; b=KEUwoP4TBZDHFcXyCjMQIIuwsW
        XFvBIN+c+W0mmhqi07YYT/c8BKXGYzC2Tm9tkvNXCjH7ZUkXxUKds7R2duNTUY+B5EEbq/kN/QJac
        CfJlrHJzrtA1NQQfIM8nD6MuTw0NQBX/Uwlr+mM7VHPvL662/VTm0rPzBtb6+siFIEWg47yTmNRXN
        8uSMi3ChWRoiFBBaw/l5m3oIriLC1WB0XvSfs5FfD7kakdVa9R0MSBK9+eYOE13/yNYwb5uxA43FF
        MEnwbwNxxIu0rsm9mRADKepJtFXmBkHZ+cngSCQkthi56ev+UGDpHVYPmkM2xtlhVHOFMU5N26W4G
        cy7BYBUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51188)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pU9hJ-0004oY-KE; Mon, 20 Feb 2023 17:11:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pU9hD-0001Nd-7W; Mon, 20 Feb 2023 17:11:23 +0000
Date:   Mon, 20 Feb 2023 17:11:23 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: [REGRESSION] Re: [patch V3 09/33] genirq/msi: Add range checking to
 msi_insert_desc()
Message-ID: <Y/Opu6ETe3ZzZ/8E@shell.armlinux.org.uk>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124232325.798556374@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 25, 2022 at 12:25:59AM +0100, Thomas Gleixner wrote:
> Per device domains provide the real domain size to the core code. This
> allows range checking on insertion of MSI descriptors and also paves the
> way for dynamic index allocations which are required e.g. for IMS. This
> avoids external mechanisms like bitmaps on the device side and just
> utilizes the core internal MSI descriptor storxe for it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Hi Thomas,

This patch appears to cause a regression on Macchiatobin, delaying the
boot by about ten seconds due to all the warnings the kernel now
produces.

> @@ -136,11 +149,16 @@ static bool msi_desc_match(struct msi_de
>  
>  static bool msi_ctrl_valid(struct device *dev, struct msi_ctrl *ctrl)
>  {
> +	unsigned int hwsize;
> +
>  	if (WARN_ON_ONCE(ctrl->domid >= MSI_MAX_DEVICE_IRQDOMAINS ||
> -			 !dev->msi.data->__domains[ctrl->domid].domain ||
> -			 ctrl->first > ctrl->last ||
> -			 ctrl->first > MSI_MAX_INDEX ||
> -			 ctrl->last > MSI_MAX_INDEX))
> +			 !dev->msi.data->__domains[ctrl->domid].domain))
> +		return false;
> +
> +	hwsize = msi_domain_get_hwsize(dev, ctrl->domid);

This calls msi_get_device_domain() without taking dev->msi.data->mutex,
resulting in the lockdep_assert_held() firing for what seems to be every
MSI created by the Armada 8040 ICU driver, which suggests something isn't
taking the lock as you expect. Please can you take a look and propose a
patch to fix this regression.

Thanks.

[    0.960451] WARNING: CPU: 2 PID: 1 at kernel/irq/msi.c:588 msi_get_device_domain+0x70/0xa0
[    0.967454] Modules linked in:
[    0.969216] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.2.0+ #1134
[    0.974116] Hardware name: Marvell 8040 MACCHIATOBin Single-shot (DT)
[    0.979276] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.984961] pc : msi_get_device_domain+0x70/0xa0
[    0.988292] lr : msi_get_device_domain+0x6c/0xa0
[    0.991623] sp : ffffffc080083460
[    0.993643] x29: ffffffc080083460 x28: 0000000000000000 x27: ffffffc041dcb6c8
[    0.999506] x26: ffffff8101f23810 x25: ffffffc080083668 x24: ffffff8101f23080
[    1.005370] x23: 0000000000000012 x22: ffffff81003d1000 x21: ffffff81025dfd90
[    1.011234] x20: ffffff8101f23810 x19: 0000000000000000 x18: 00000000fffffffd
[    1.017097] x17: 00000000cc510454 x16: 0000000000000051 x15: 0000000000000002
[    1.022960] x14: 00000000000389cb x13: 0000000000000001 x12: 0000000000000040
[    1.028822] x11: ffffff8100400490 x10: ffffff8100400492 x9 : 0000000000000000
[    1.034685] x8 : 0000000000000000 x7 : ffffff81001c8858 x6 : ffffffc0402ad718
[    1.040547] x5 : 00000000ffffffff x4 : ffffff81003d4c80 x3 : 0000000000000000
[    1.046410] x2 : ffffffc0fed09000 x1 : 0000000000000000 x0 : 0000000000000000
[    1.052274] Call trace:
[    1.053422]  msi_get_device_domain+0x70/0xa0
[    1.056404]  msi_ctrl_valid+0x5c/0x94
[    1.058775]  msi_domain_populate_irqs+0x64/0x1b0
[    1.062106]  platform_msi_device_domain_alloc+0x20/0x30
[    1.066048]  mvebu_icu_irq_domain_alloc+0xa0/0x1a0
[    1.069555]  __irq_domain_alloc_irqs+0xf8/0x46c
[    1.072799]  irq_create_fwspec_mapping+0x224/0x320
[    1.076303]  irq_create_of_mapping+0x68/0x90
[    1.079284]  of_irq_get+0x88/0xd0
[    1.081308]  platform_get_irq_optional+0x20/0x114
[    1.084725]  platform_get_irq+0x18/0x50
[    1.087269]  dw8250_probe+0x60/0x6e0
[    1.089552]  platform_probe+0x64/0xd0
[    1.091923]  really_probe+0xb8/0x2d4
[    1.094207]  __driver_probe_device+0x74/0xdc
[    1.097190]  driver_probe_device+0xd0/0x160
[    1.100085]  __driver_attach+0x94/0x1a0
[    1.102631]  bus_for_each_dev+0x6c/0xc0
[    1.105176]  driver_attach+0x20/0x30
[    1.107460]  bus_add_driver+0x148/0x200
[    1.110006]  driver_register+0x74/0x120
[    1.112550]  __platform_driver_register+0x24/0x30
[    1.115966]  dw8250_platform_driver_init+0x18/0x20
[    1.119473]  do_one_initcall+0x70/0x370
[    1.122018]  kernel_init_freeable+0x1d0/0x238
[    1.125087]  kernel_init+0x20/0x120
[    1.127283]  ret_from_fork+0x10/0x20
[    1.129567] ---[ end trace 0000000000000000 ]---

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
