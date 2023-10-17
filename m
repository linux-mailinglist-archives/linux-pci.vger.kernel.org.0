Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9387CC73E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 17:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbjJQPQc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjJQPQb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 11:16:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C6BB6;
        Tue, 17 Oct 2023 08:16:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7D1C433C7;
        Tue, 17 Oct 2023 15:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697555789;
        bh=I1YFtN9wuNunqV/8C+16JPV6zk4eRK/ldWnQjVGx8aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qA4geOls98dkMNxYMDgCn65zpRiJmV2KO+qotVGrvE0qtEk/7fjxWi/q2HL7rKl9Z
         kj0JpTm+XpMrAsYD2VZoszFGYd4YQ+1LGzp2DT/XZ6LNOPe16prjFCc//75pmLImBx
         2uKj9yw87tdihnwbdr6lYHW1H1JtVQgVUh3KNuh+Kq1npFYHf+aaOj5AVNOl2I+xKC
         APt5T1LFdRfPErrRRFDD7uvRQhruXokJYQnDp48jT7z45wayjq/67WnFfzo2se94ND
         W1zDB4XjN/fQa5EGr+u4i5xihPbebqAKicnrGguO3rg7wHedrfv0z6Uv1Mo+D4AZJM
         sbnQV7nllokFg==
Date:   Tue, 17 Oct 2023 20:46:19 +0530
From:   "mani@kernel.org" <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v24 08/16] PCI: dwc: Disable two BARs to avoid
 unnecessary memory assignment
Message-ID: <20231017151619.GE5274@thinkpad>
References: <20231011071423.249458-1-yoshihiro.shimoda.uh@renesas.com>
 <20231011071423.249458-9-yoshihiro.shimoda.uh@renesas.com>
 <CGME20231017091924eucas1p2e65759cd05340e3e5b3a1d9ab9de1320@eucas1p2.samsung.com>
 <a85158a0-858c-43c3-b64a-c09de72a50f9@samsung.com>
 <TYBPR01MB5341006D4CEAA1422B0A41F3D8D6A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYBPR01MB5341006D4CEAA1422B0A41F3D8D6A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 12:05:12PM +0000, Yoshihiro Shimoda wrote:
> Dear Marek,
> 
> > From: Marek Szyprowski, Sent: Tuesday, October 17, 2023 6:19 PM
> > 
> > Dear All,
> > 
> > On 11.10.2023 09:14, Yoshihiro Shimoda wrote:
> > > According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> > > Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> > > assignment during device enumeration. Otherwise, Renesas R-Car Gen4
> > > PCIe controllers cannot work correctly in host mode.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > 
> > This patch landed in today's linux-next 20231017 as commit e308528cac3e
> > ("PCI: dwc: Disable two BARs to avoid unnecessary memory assignment").
> > Unfortunately it causes the following kernel panic on Samsung
> > Exynos5433-based TM2e board:
> > 
> > exynos-pcie 15700000.pcie: host bridge /soc@0/pcie@15700000 ranges:
> > exynos-pcie 15700000.pcie:       IO 0x000c001000..0x000c010fff ->
> > 0x0000000000
> > exynos-pcie 15700000.pcie:      MEM 0x000c011000..0x000ffffffe ->
> > 0x000c011000
> > exynos-pcie 15700000.pcie: iATU: unroll F, 3 ob, 5 ib, align 4K, limit 4G
> > Unable to handle kernel paging request at virtual address ffff800084196010
> > Mem abort info:
> > ...
> > Data abort info:
> > ...
> > swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000022047000
> > [ffff800084196010] pgd=10000000df6ff003, p4d=10000000df6ff003,
> > pud=10000000df6fe003, pmd=1000000024ad9003, pte=0000000000000000
> > Internal error: Oops: 0000000096000047 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 4 PID: 55 Comm: kworker/u18:0 Not tainted 6.6.0-rc1+ #14129
> > Hardware name: Samsung TM2E board (DT)
> > Workqueue: events_unbound deferred_probe_work_func
> > pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : dw_pcie_write_dbi2+0xb8/0xc8
> > lr : dw_pcie_setup_rc+0x30/0x4e4
> > ...
> > Call trace:
> >   dw_pcie_write_dbi2+0xb8/0xc8
> >   dw_pcie_setup_rc+0x30/0x4e4
> >   dw_pcie_host_init+0x238/0x608
> >   exynos_pcie_probe+0x23c/0x340
> >   platform_probe+0x68/0xd8
> >   really_probe+0x148/0x2b4
> >   __driver_probe_device+0x78/0x12c
> >   driver_probe_device+0xd8/0x160
> >   __device_attach_driver+0xb8/0x138
> >   bus_for_each_drv+0x84/0xe0
> >   __device_attach+0xa8/0x1b0
> >   device_initial_probe+0x14/0x20
> >   bus_probe_device+0xb0/0xb4
> >   deferred_probe_work_func+0x8c/0xc8
> >   process_one_work+0x1ec/0x53c
> >   worker_thread+0x298/0x408
> >   kthread+0x124/0x128
> >   ret_from_fork+0x10/0x20
> > Code: d50332bf 79000023 17ffffe2 d50332bf (b9000023)
> > ---[ end trace 0000000000000000 ]---
> > Kernel panic - not syncing: Oops: Fatal exception
> > SMP: stopping secondary CPUs
> > Kernel Offset: disabled
> > CPU features: 0x8c00020e,3c020000,0000421b
> > Memory Limit: none
> > ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
> > 
> > I've observed similar issue on Qualcomm's RB5 platform with some
> > additional not-yet merged patches enabling PCIe support. Reverting
> > $subject on top of linux-next fixes this issue.
> > 
> > Let me know if you need more information.
> 
> Thank you for the report. I guess that the issue is related to
> out-of-range access of dbi2:
> - In arch/arm64/boot/dts/exynos/exynos5433.dtsi, the dbi reg size is 0x1000
>   like below:
> -----
>                 pcie: pcie@15700000 {
>                         compatible = "samsung,exynos5433-pcie";
>                         reg = <0x15700000 0x1000>, <0x156b0000 0x1000>,
>                               <0x0c000000 0x1000>;
>                         reg-names = "dbi", "elbi", "config";
> ...
> -----
> 
> - In drivers/pci/controller/dwc/pcie-designware.c, "dbi2" area is calculated
>   by the following if reg-names "dbi2" didn't exist:
> -----
>                         pci->dbi_base2 = pci->dbi_base + SZ_4K;
> -----
> 
> - However, this is out-of-memory on exynos5433.dtsi because the "dbi" size is
>   0x1000 only.
> - And then, this patch always writes PCI_BASE_ADDRESS_[01] to dbi2 area.
>   So, since this is out-of-range, the kernel panic happens.
> 

I could reproduce the issue Marek reported on RB5. As you pointed out, it is due
to not mapping dbi2 explicitly. But we were not using DBI2 on the host earlier
and it looks to me that DBI2 may not be implemented on Qcom host platforms.

Atleast on EP, I confirmed with Qcom that DBI=DBI2 as represented in the driver,
but I couldn't confirm if it is same for host as well.

> Perhaps, we should revert this patch at first. And, add the settings into
> my environment (pcie-rcar-gen4.c) only. I also have alternative solution which
> modifies the "dbi2" area calculation and avoid out-of-range access somehow.
> But, it may complicate source code...
> 

Yes, let's revert this patch for now and move it to rcar driver.

- Mani

> Best regards,
> Yoshihiro Shimoda
> 
> > > ---
> > >   drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index a7170fd0e847..56cc7ff6d508 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -737,6 +737,14 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> > >   	u32 val, ctrl, num_ctrls;
> > >   	int ret;
> > >
> > > +	/*
> > > +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> > > +	 * Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> > > +	 * assignment during device enumeration.
> > > +	 */
> > > +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, 0x0);
> > > +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_1, 0x0);
> > > +
> > >   	/*
> > >   	 * Enable DBI read-only registers for writing/updating configuration.
> > >   	 * Write permission gets disabled towards the end of this function.
> > 
> > Best regards
> > --
> > Marek Szyprowski, PhD
> > Samsung R&D Institute Poland
> 

-- 
மணிவண்ணன் சதாசிவம்
