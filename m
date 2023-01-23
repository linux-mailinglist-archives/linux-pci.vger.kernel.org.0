Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6A4677DCB
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 15:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjAWORW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 09:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAWORV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 09:17:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFFB211F;
        Mon, 23 Jan 2023 06:17:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 847FCB80D2F;
        Mon, 23 Jan 2023 14:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6A8C433EF;
        Mon, 23 Jan 2023 14:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674483438;
        bh=oARpShREgynxaPbK8Ov7RvXgvvHmNN/Z6I795Bq13vI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iM+x2sLrGQKFJxuGbun9XAJPrr99iQ59q3Jx0fcAynZy2b5lTkdBDkKbmJDq0r4tq
         E4IsfP9bb/haM3BwuzSZayi2uue2+QcjJROHfTNdymVw954x9Ov9w/Yymu4whA0sPj
         oERESoDOFnYpYEsMq5Sq+xpdtRBgmc98aGk4KNeokrhD6N+Nk/vMAs+wXDdY1/TVPj
         VT9vNRtWEIXvR+H0y6NKSMQa5Co/M0DyozE/vuWEllFiHGP6q2gOpS8+3zHY36yN3a
         Eu951O1Xp8uEpge/KepBK7vAxMN4uzjz/5VY+9ZOSCb/BRPyZTd5il/Twfkwspekxq
         FfP1aAANnArug==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJxdL-0003cs-Mo; Mon, 23 Jan 2023 15:17:15 +0100
Date:   Mon, 23 Jan 2023 15:17:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 11/12] arm64: dts: qcom: sm8550: Add PCIe PHYs and
 controllers nodes
Message-ID: <Y86W60Lsh1zyiECF@hovoldconsulting.com>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
 <20230119140453.3942340-12-abel.vesa@linaro.org>
 <Y85KiKD+iQamchB5@hovoldconsulting.com>
 <Y86AG7ev++wYiza4@linaro.org>
 <Y86HjPwj2Fb3t09r@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y86HjPwj2Fb3t09r@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 03:11:40PM +0200, Abel Vesa wrote:
> On 23-01-23 14:39:55, Abel Vesa wrote:
> > On 23-01-23 09:51:20, Johan Hovold wrote:
> > > On Thu, Jan 19, 2023 at 04:04:52PM +0200, Abel Vesa wrote:
> > > > Add PCIe controllers and PHY nodes.
> > > > 
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

> > > > +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> > > > +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> > > > +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> > > > +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> > > > +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> > > > +				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
> > > > +				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>;
> > > > +			clock-names = "aux",
> > > > +				      "cfg",
> > > > +				      "bus_master",
> > > > +				      "bus_slave",
> > > > +				      "slave_q2a",
> > > > +				      "ddrss_sf_tbu",
> > > 
> > > You're reusing a clock name which doesn't seem to match this SoC. I
> > > don't know what "QTB" refers to here and if it's just some Qualcomm
> > > alternate name for "TBU" which could make this ok.
> > 
> > I'll come back later with an answer here, once I know exactly what QTB
> > means.
> 
> So, AFAICT, they replaced the TBU with QTB, which basically does the
> same thing. It is part of the SMMU. So, yes, it is just an alternate
> name, at least from the clock point of view.

Good, thanks for checking.

Johan
