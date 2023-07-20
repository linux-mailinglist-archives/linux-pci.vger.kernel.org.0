Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A0575B4C0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 18:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGTQnk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 12:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjGTQng (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 12:43:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA224123;
        Thu, 20 Jul 2023 09:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8699661B7D;
        Thu, 20 Jul 2023 16:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EFAC433C8;
        Thu, 20 Jul 2023 16:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689871414;
        bh=OwyRAgPQy2DIEoiNl5+rnP5XfOp6/5Ovx1Ve+Ex+3ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwA8WBwYSlW+g9aCDEQ4p8aH2boK1co0b/oh8YOnofOh9pCisrBQH5ZfwqodASCZt
         YZS4TnjZ62ZIkV20RJxhF02ZdOHyUk11ledYBHLt3PG/2Uja3TGi0zVsPOD5uDcoPt
         Q/q27B0RdxnotMfU6knFumTqqTkk1967rg1ZCJPj5yG+gFDFfWaIbrgndKfQHaiAr1
         XUblCMHCELNktO5bY9SR1ktcoBalIXOKbsr6pDp1OMTRNUGudR5WPgoEg/LvslSV/p
         9JSoW5z6bcTkkALbe/Et+VKI9Z/re1IbSFWxYB09FN4kylbYTZ6CvOXcY95nGlH+H+
         5t/WXTYGFd+1Q==
Date:   Thu, 20 Jul 2023 22:13:18 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Message-ID: <20230720164318.GE48270@thinkpad>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <20230717164526.GC35455@thinkpad>
 <ZLWKI1lRqxejfUgK@lizhi-Precision-Tower-5810>
 <20230718100400.GB4771@thinkpad>
 <20230720142509.GB48270@thinkpad>
 <ZLlGsM/D/b+udmAD@lizhi-Precision-Tower-5810>
 <20230720160738.GC48270@thinkpad>
 <ZLlgPprvtuDbGFVu@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLlgPprvtuDbGFVu@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 20, 2023 at 12:26:38PM -0400, Frank Li wrote:
> On Thu, Jul 20, 2023 at 09:37:38PM +0530, Manivannan Sadhasivam wrote:
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
> 
> I supposed this should work. but I have not hardware to test it now. NMVE already
> sent shut down command to SSD, which can safely turn off. after resume, that most
> likely a cold reset.
> 

NO, it won't work and that's the reason the Qcom platforms are not transitioning
the link to L2/L3 state during suspend. This applies to other platforms
including layerscape as well.

> > 
> > But here you are not checking for ASPM state in the suspend path, and just
> > forcing the link to be in L2/L3 (thereby D3Cold) even though NVMe driver may
> > expect it to be in low power state like ASPM/APST.
> 
> This function is not called defaultly and need platform driver to call it as need.
> Actually, I think PCI framework should handle L1.2 and L2 case, some devices
> or user case want to L1.2 to get better resume latency, some devices want to
> L2 to get better power saving, which out of scope of this patches.
> 

I'm referring to the platform where these helper functions are being used which
is layerscape. It doesn't matter whether you test this series with NVMe or not,
it will not work unless you disable ASPM.

> This patch just handle L2 case, I remember L1.2 don't expect send PME at all.
> 
> > 
> > So you should only put the link to L2/L3 if there is no ASPM support. Otherwise,
> > you'll ending up with bug reports when users connect NVMe to it.
> 
> Platform should choose call or no call this function according to their
> user case. So far, I have not found a good mathod to let ASPM to affect
> suspend/resume. 
> 

You are missing my point here. If any platform decides to use these helper
functions, they will face problems with NVMe. So please add a check for ASPM
state before doing any L2/L3 handling.

I agree that it may not be optimal w.r.t power savings, but the PCIe controller
driver should work for all devices.

- Mani

> > 
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
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
