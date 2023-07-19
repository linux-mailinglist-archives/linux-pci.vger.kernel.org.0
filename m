Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392A3758DF3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 08:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjGSGim (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 02:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGSGil (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 02:38:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F4F1FCB;
        Tue, 18 Jul 2023 23:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F09B861150;
        Wed, 19 Jul 2023 06:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0B9C433C7;
        Wed, 19 Jul 2023 06:38:33 +0000 (UTC)
Date:   Wed, 19 Jul 2023 12:08:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, krzysztof.kozlowski@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v9 3/4] arm: dts: qcom: sdx55: Add CPU PCIe interconnect
 path
Message-ID: <20230719063823.GA9312@thinkpad>
References: <1689693645-28254-1-git-send-email-quic_krichai@quicinc.com>
 <1689693645-28254-4-git-send-email-quic_krichai@quicinc.com>
 <20230719044118.GC5990@thinkpad>
 <a3bb6e88-9b0f-c504-df35-96892395f188@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3bb6e88-9b0f-c504-df35-96892395f188@quicinc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 19, 2023 at 12:03:11PM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 7/19/2023 10:11 AM, Manivannan Sadhasivam wrote:
> > On Tue, Jul 18, 2023 at 08:50:44PM +0530, Krishna chaitanya chundru wrote:
> > > Add cpu-pcie interconnect path to sdx65 platform.
> > sdx55 and please mention "PCIe RC". Perhaps you should also add "missing"?
> > 
> > - Mani
> 
> I will reactify it.
> 
> for "PCIe RC" you mean "PCIe EP" as this endpoint node
> 

Oops, yeah it is PCIe EP only.

- Mani

> -KC
> 
> 
> > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> > > index df3cd9c..a7c0c26 100644
> > > --- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> > > +++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> > > @@ -422,8 +422,9 @@
> > >   			interrupt-names = "global",
> > >   					  "doorbell";
> > > -			interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>;
> > > -			interconnect-names = "pcie-mem";
> > > +			interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>,
> > > +					<&mem_noc MASTER_AMPSS_M0 &system_noc SLAVE_PCIE_0>;
> > > +			interconnect-names = "pcie-mem", "cpu-pcie";
> > >   			resets = <&gcc GCC_PCIE_BCR>;
> > >   			reset-names = "core";
> > > -- 
> > > 2.7.4
> > > 

-- 
மணிவண்ணன் சதாசிவம்
