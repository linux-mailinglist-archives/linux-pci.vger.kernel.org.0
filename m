Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF4575CAB8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 16:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjGUOys (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 10:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjGUOyr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 10:54:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC3171A;
        Fri, 21 Jul 2023 07:54:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1971561A0C;
        Fri, 21 Jul 2023 14:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC9DC433C7;
        Fri, 21 Jul 2023 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689951284;
        bh=t77fLoIms5dLMcLB46LECL7L1VO/tvMK+vqVQsPIqlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Limk3R8EchtkBCsao2b105jV+o8O3QHoPjrNlWm6PRLne6awIRyhcA7igPYdD3r5g
         N9fiF0odrupddTJaEA5pDPUxCP2QU31P0Nhe2vdU4zpsHRe5kf82XbGdR7rbPiJftI
         shJBb6ZmRyc2R7c3PqBG8uXLvLMFob6xf4SYHm4MLUhxmPDtbuP5XP2kqKmU/qzTpy
         rm/YxCJC+BA6V2D9t51a/UUL1zu9puYmdF5/U9qzItgspgSz9al952iytclsNH2m4T
         nJrjyS5sTaTfjCIW3oxF5TckItn8oMBTYRFYQywe3SGTfclDqQnQ8Im374akGTk9Rn
         FTPo1VqG35ICg==
Date:   Fri, 21 Jul 2023 20:24:22 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Frank Li <Frank.li@nxp.com>,
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
Message-ID: <20230721145422.GC2536@thinkpad>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <20230717164526.GC35455@thinkpad>
 <ZLWKI1lRqxejfUgK@lizhi-Precision-Tower-5810>
 <20230718100400.GB4771@thinkpad>
 <20230720142509.GB48270@thinkpad>
 <ZLlGsM/D/b+udmAD@lizhi-Precision-Tower-5810>
 <20230720160738.GC48270@thinkpad>
 <6f1eb449-5609-0b17-1323-0d114c38d969@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f1eb449-5609-0b17-1323-0d114c38d969@rock-chips.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 10:09:18AM +0800, Shawn Lin wrote:
> 
> On 2023/7/21 0:07, Manivannan Sadhasivam wrote:
> > On Thu, Jul 20, 2023 at 10:37:36AM -0400, Frank Li wrote:
> > > On Thu, Jul 20, 2023 at 07:55:09PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Jul 18, 2023 at 03:34:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Mon, Jul 17, 2023 at 02:36:19PM -0400, Frank Li wrote:
> > > > > > On Mon, Jul 17, 2023 at 10:15:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Wed, Apr 19, 2023 at 12:41:17PM -0400, Frank Li wrote:
> > > > > > > > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > > > > > > > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> > > > > > > > 
> > > > > > > > Typical L2 entry workflow:
> > > > > > > > 
> > > > > > > > 1. Transmit PME turn off signal to PCI devices.
> > > > > > > > 2. Await link entering L2_IDLE state.
> > > > > > > 
> > > > > > > AFAIK, typical workflow is to wait for PME_To_Ack.
> > > > > > 
> > > > > > 1 Already wait for PME_to_ACK,  2, just wait for link actual enter L2.
> > > > > > I think PCI RC needs some time to set link enter L2 after get ACK from
> > > > > > PME.
> > > > > > 
> > > > 
> > > > One more comment. If you transition the device to L2/L3, then it can loose power
> > > > if Vaux was not provided. In that case, can all the devices work after resume?
> > > > Most notably NVMe?
> > > 
> > > I have not hardware to do such test, NVMe driver will reinit everything after
> > > resume if no L1.1\L1.2 support. If there are L1.1\L1.2, NVME expect it leave
> > > at L1.2 at suspend to get better resume latency.
> > > 
> > 
> > To be precise, NVMe driver will shutdown the device if there is no ASPM support
> > and keep it in low power mode otherwise (there are other cases as well but we do
> > not need to worry).
> > 
> > But here you are not checking for ASPM state in the suspend path, and just
> > forcing the link to be in L2/L3 (thereby D3Cold) even though NVMe driver may
> > expect it to be in low power state like ASPM/APST.
> > 
> > So you should only put the link to L2/L3 if there is no ASPM support. Otherwise,
> > you'll ending up with bug reports when users connect NVMe to it.
> > 
> 
> 
> At this topic, it's very interesting to look at
> 
> drivers/pci/controller/dwc/pcie-tegra194.c
> 
> 
> static int tegra_pcie_dw_suspend_noirq(struct device *dev)
> {
>         struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> 
>         if (!pcie->link_state)
>                 return 0;
> 
>         tegra_pcie_downstream_dev_to_D0(pcie);
>         tegra_pcie_dw_pme_turnoff(pcie);
>         tegra_pcie_unconfig_controller(pcie);
> 
>         return 0;
> }
> 
> It brings back all the downstream components to D0, as I assumed it was L0
> indeed, before sending PME aiming to enter L2.
> 

The behavior is Tegra specific as mentioned in the comment in
tegra_pcie_downstream_dev_to_D0():

        /*
         * link doesn't go into L2 state with some of the endpoints with Tegra
         * if they are not in D0 state. So, need to make sure that immediate
         * downstream devices are in D0 state before sending PME_TurnOff to put
         * link into L2 state.
         * This is as per PCI Express Base r4.0 v1.0 September 27-2017,
         * 5.2 Link State Power Management (Page #428).
         */

But I couldn't find the behavior documented in the spec as per the comment. Not
sure if I'm reading it wrong!

Also, I can confirm from previous interations with the linux-nvme list that
Tegra also faces the suspend issue with NVMe devices.

- Mani

- Mani

> > - Mani
> > 
> > > This API help remove duplicate codes and it can be improved gradually.
> > > 
> > > 
> > > > 
> > > > - Mani
> > > > 
> > > > 
> > > > -- 
> > > > மணிவண்ணன் சதாசிவம்
> > 

-- 
மணிவண்ணன் சதாசிவம்
