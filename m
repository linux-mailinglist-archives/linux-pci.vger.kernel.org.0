Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC76D75CD2A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 18:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjGUQIQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGUQIP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 12:08:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822B326A4;
        Fri, 21 Jul 2023 09:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FFBB61D2E;
        Fri, 21 Jul 2023 16:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9A4C433D9;
        Fri, 21 Jul 2023 16:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689955693;
        bh=LGA32XouZSWJqq0j7YFFUr/XUGfKOFro0mhkNduNZf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4smuBCWpK0nupF6c3zfXOgsB0Hls9yafxK5mozt4nuL2Isfdn8woAcjtta73YWSV
         b9YsrIK03VZUT0uL3keo9H3LtdoaP1l/KQwupReDFA7dxcBdLUAlZ3lCduBxxcmo1m
         NUbMimf41jozFjiONXnwjA9mXuXCYv1w6A9hAvfi0He8dQDt4AEyWMbZcI11DPnE4d
         FQuVIWNGuWvB7L1rjxLgIGUq1QCi0APMFZR7SOsS14djYbML3h5wVLaAZ1+xclChPD
         X1wdRUSiXHiSj9ukafEfcKnmw9Xzlk3L7Mdzbacx6YlXopsiiRLz5oSWC0Jwz/D66d
         b+2LHaYbLqE0A==
Date:   Fri, 21 Jul 2023 21:37:55 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        helgaas@kernel.org, imx@lists.linux.dev, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <20230721160755.GD2536@thinkpad>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <20230717164526.GC35455@thinkpad>
 <ZLWKI1lRqxejfUgK@lizhi-Precision-Tower-5810>
 <20230718100400.GB4771@thinkpad>
 <20230720142509.GB48270@thinkpad>
 <ZLlGsM/D/b+udmAD@lizhi-Precision-Tower-5810>
 <20230720160738.GC48270@thinkpad>
 <6f1eb449-5609-0b17-1323-0d114c38d969@rock-chips.com>
 <ZLqRwxmQr0jrhS3M@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLqRwxmQr0jrhS3M@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 10:10:11AM -0400, Frank Li wrote:
> On Fri, Jul 21, 2023 at 10:09:18AM +0800, Shawn Lin wrote:
> > 
> > On 2023/7/21 0:07, Manivannan Sadhasivam wrote:
> > > On Thu, Jul 20, 2023 at 10:37:36AM -0400, Frank Li wrote:
> > > > On Thu, Jul 20, 2023 at 07:55:09PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Tue, Jul 18, 2023 at 03:34:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Mon, Jul 17, 2023 at 02:36:19PM -0400, Frank Li wrote:
> > > > > > > On Mon, Jul 17, 2023 at 10:15:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > > On Wed, Apr 19, 2023 at 12:41:17PM -0400, Frank Li wrote:
> > > > > > > > > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > > > > > > > > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> > > > > > > > > 
> > > > > > > > > Typical L2 entry workflow:
> > > > > > > > > 
> > > > > > > > > 1. Transmit PME turn off signal to PCI devices.
> > > > > > > > > 2. Await link entering L2_IDLE state.
> > > > > > > > 
> > > > > > > > AFAIK, typical workflow is to wait for PME_To_Ack.
> > > > > > > 
> > > > > > > 1 Already wait for PME_to_ACK,  2, just wait for link actual enter L2.
> > > > > > > I think PCI RC needs some time to set link enter L2 after get ACK from
> > > > > > > PME.
> > > > > > > 
> > > > > 
> > > > > One more comment. If you transition the device to L2/L3, then it can loose power
> > > > > if Vaux was not provided. In that case, can all the devices work after resume?
> > > > > Most notably NVMe?
> > > > 
> > > > I have not hardware to do such test, NVMe driver will reinit everything after
> > > > resume if no L1.1\L1.2 support. If there are L1.1\L1.2, NVME expect it leave
> > > > at L1.2 at suspend to get better resume latency.
> > > > 
> > > 
> > > To be precise, NVMe driver will shutdown the device if there is no ASPM support
> > > and keep it in low power mode otherwise (there are other cases as well but we do
> > > not need to worry).
> > > 
> > > But here you are not checking for ASPM state in the suspend path, and just
> > > forcing the link to be in L2/L3 (thereby D3Cold) even though NVMe driver may
> > > expect it to be in low power state like ASPM/APST.
> > > 
> > > So you should only put the link to L2/L3 if there is no ASPM support. Otherwise,
> > > you'll ending up with bug reports when users connect NVMe to it.
> > > 
> > 
> > 
> > At this topic, it's very interesting to look at
> > 
> > drivers/pci/controller/dwc/pcie-tegra194.c
> > 
> > 
> > static int tegra_pcie_dw_suspend_noirq(struct device *dev)
> > {
> >         struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> > 
> >         if (!pcie->link_state)
> >                 return 0;
> > 
> >         tegra_pcie_downstream_dev_to_D0(pcie);
> >         tegra_pcie_dw_pme_turnoff(pcie);
> >         tegra_pcie_unconfig_controller(pcie);
> > 
> >         return 0;
> > }
> > 
> > It brings back all the downstream components to D0, as I assumed it was L0
> > indeed, before sending PME aiming to enter L2.
> 
> If current state is L1.1 or L1.2, hardware can auto enter to D0\L0 when
> there are any PCI bus activity, include PME. I supposed
> tegra_pcie_downstream_dev_to_D0() just make sure come back from L2/L3,
> which may enter by runtime PM previously, or other reason.
> 
> NVME ASPM problem is (at least when I debug at other platform about 1 year
> ago): 
> 
>     1. NVME will not release MSI interrupt during suspsend.
>     2. PCI controler enter L2 at suspned_noirq();
>     3. CPU hot plug try to down second core (CORE1, CORE2, ...)
>     4. GIC try to disable MSI irq by write config space.

Just for the record, this will only happen during deep sleep (s2ram) where the
CPUs are powered down (including the boot CPU).

>     5. panic here because config space can't be access at L2.
> 
> I suposed tegra should have problem when ASPM enable with NVME devices.
> 

NVMe suspend issue has several faces:

If NVMe is powered down during suspend, it will result in considerable power
savings. But at the same time, the suspend should not happen too frequently as
it may deteriorate the lifetime of the device. Most of the recent NVMe devices
have 2M power cycles (only).

We can workaround the above lifetime issue by powering down the device only
during s2ram. It will work great for Laptop use cases if s2ram is supported.
Unfortunately, not all Laptops support s2ram though. And if the device is
powered down during s2idle, it will hit the above life time issue when it is
used in Android platforms such as Tablets (even future mobile phones?) which
doesn't support s2ram.

So I'm thinking of the following options to address the issue(s):

1. Modify the NVMe driver to power down the device during s2ram (the driver can
use the global pm_suspend_target_state flag to detect the suspend state) and use
the same logic to put the link into L2/L3 state in the PCIe controller drivers.
For s2idle, maintain both the device and link in low power states.

2. Get the power management decision from the userspace and use that to decide
the power down logic in s2idle for both NVMe and PCIe drivers. This will ensure
that the NVMe device will be powered down in suitable usecases like Laptop
without s2ram and kept in low power states for Android platforms. But this is
quite an involved task and I don't know if it is possible at all.

I'm just dumping my thoughts here. And I plan to intiate a discussion with NVMe/
power folks soon. Maybe during Plumbers?

- Mani

> Frank
> > 
> > > - Mani
> > > 
> > > > This API help remove duplicate codes and it can be improved gradually.
> > > > 
> > > > 
> > > > > 
> > > > > - Mani
> > > > > 
> > > > > 
> > > > > -- 
> > > > > மணிவண்ணன் சதாசிவம்
> > > 

-- 
மணிவண்ணன் சதாசிவம்
