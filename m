Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C962C0BF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 15:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiKPO1K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 09:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiKPO1K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 09:27:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E2111C08;
        Wed, 16 Nov 2022 06:27:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C0BC7CE1B7C;
        Wed, 16 Nov 2022 14:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C3EC433C1;
        Wed, 16 Nov 2022 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668608826;
        bh=ahD/4zXE9e7nQQFpuuGPjNGZrn9Bn9hkwL74eBJbe6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awj+6z41L1DfkGwzD4PaNsEiwuZfb+t8R/qG3aZnN0T6WrOsKuGBYvcdv3MFnY8TJ
         sMFb6ZSe3HKal8nvKxDy3qshp+B3QzMSeJQSwzhaUZqdUnoHrKSBBFqivM3hQuiIjW
         qam7sO/VH+Y1+eo8s80gTJOykJ60EcBp82vdJ9pmJQXePAhvasf/KLV+j0lf6Fd4zZ
         TzZKCZ7H8HZZuLkH+LVE82OWp3qCXG3Pky7rqENj9lTOMtxCYrNwJkPx/BxBRmgxpC
         /uMARJaiMXTWm6YL6PWJ3jJUBlqoecwVkhWFmA20PNTf0kq70/SUfgY1bF2joN5jWA
         ZJ+fQCfA/NaXg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovJN5-00038I-Hs; Wed, 16 Nov 2022 15:26:36 +0100
Date:   Wed, 16 Nov 2022 15:26:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sm8350: add PCIe devices
Message-ID: <Y3TzG4HGsFSU3sky@hovoldconsulting.com>
References: <20221110103345.729018-1-dmitry.baryshkov@linaro.org>
 <20221110103345.729018-8-dmitry.baryshkov@linaro.org>
 <Y2zYHEZDbNoGumTl@hovoldconsulting.com>
 <37fe9a22-7ca0-e4e5-ebff-4eb56dbb74eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37fe9a22-7ca0-e4e5-ebff-4eb56dbb74eb@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 10, 2022 at 05:20:11PM +0300, Dmitry Baryshkov wrote:
> On 10/11/2022 13:53, Johan Hovold wrote:
> > On Thu, Nov 10, 2022 at 01:33:44PM +0300, Dmitry Baryshkov wrote:
> >> Add PCIe0 and PCIe1 (and corresponding PHY) devices found on SM8350
> >> platform. The PCIe0 is a 1-lane Gen3 host, PCIe1 is a 2-lane Gen3 host.
> >>
> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> ---
> >>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 246 ++++++++++++++++++++++++++-
> >>   1 file changed, 244 insertions(+), 2 deletions(-)
> > 
> >> @@ -1761,6 +1957,52 @@ tlmm: pinctrl@f100000 {
> >>   			gpio-ranges = <&tlmm 0 0 204>;
> >>   			wakeup-parent = <&pdc>;
> >>   
> >> +			pcie0_default_state: pcie0-default-state {
> >> +				perst-pins {
> >> +					pins = "gpio94";
> >> +					function = "gpio";
> >> +					drive-strength = <2>;
> >> +					bias-pull-down;
> >> +				};
> >> +
> >> +				clkreq-pins {
> >> +					pins = "gpio95";
> >> +					function = "pcie0_clkreqn";
> >> +					drive-strength = <2>;
> >> +					bias-pull-up;
> >> +				};
> >> +
> >> +				wake-pins {
> >> +					pins = "gpio96";
> >> +					function = "gpio";
> >> +					drive-strength = <2>;
> >> +					bias-pull-up;
> >> +				};
> >> +			};
> > 
> > The pinconfig should go in the board file.
> 
> Usually yes. However for the PCIe we usually put them into the main 
> .dtsi. See sm8[124]50.dtsi.

Yeah, I noticed that too and had this discussion with Bjorn for
sc8280xp some months ago. Even if you may save a few lines by providing
defaults in a dtsi, the pin configuration is board specific and belongs
in the dts.

Also note that 'perst' and 'wake' above could in principle be connected
to other GPIOs on different boards.

Johan
