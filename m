Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741243A7674
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 07:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFOF2Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 01:28:16 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34981 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhFOF2P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 01:28:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623734771; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=doO/lOyS2nno44eUAbzgpveEi+a60C/4rJxR/gZVDKM=;
 b=A7yTS+5qWQj+mqHz+H/oJd18Rmc1S4aYOd5EEwIEzd74uboCxu5JB9vqiesIEnLmsOTc7spH
 tCOd5eLIMzBjptOOmeOwODChiETNEjS1MYHJTXN3CBCGMQ+sfeOU8djqLwRgM/2Mm2Ih8PDp
 Fco5heWkOL3w927yc13slBbyRnA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60c839edf726fa418829cd39 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 05:26:05
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E239BC4338A; Tue, 15 Jun 2021 05:26:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A5C5C433D3;
        Tue, 15 Jun 2021 05:26:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Jun 2021 10:56:03 +0530
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mgautam@codeaurora.org, dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc7280: Add PCIe and PHY related
 nodes
In-Reply-To: <YLxI3NTvgTJ3qt7h@builder.lan>
References: <1620382648-17395-1-git-send-email-pmaliset@codeaurora.org>
 <1620382648-17395-3-git-send-email-pmaliset@codeaurora.org>
 <CAE-0n530bSPupOHVDzwpd_JVVN0tOfrAOm9dAt1ZGj7zaXOZ6A@mail.gmail.com>
 <3b3701bb1e23dec88f2231722872fc40@codeaurora.org>
 <CAE-0n50k9z0ZFqP_pOmQjp0s3NCSKYHTmHvZ5rxLb3MzqgavrA@mail.gmail.com>
 <YLxI3NTvgTJ3qt7h@builder.lan>
Message-ID: <108a693b952c6dd84f60130f83a572d7@codeaurora.org>
X-Sender: pmaliset@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-06-06 09:32, Bjorn Andersson wrote:
> On Fri 04 Jun 16:43 CDT 2021, Stephen Boyd wrote:
> 
>> Quoting Prasad Malisetty (2021-05-21 02:57:00)
>> > On 2021-05-08 01:36, Stephen Boyd wrote:
>> > > Quoting Prasad Malisetty (2021-05-07 03:17:27)
>> > >> Add PCIe controller and PHY nodes for sc7280 SOC.
>> > >>
>> > >> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
>> > >> ---
>> > >>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 138
>> > >> +++++++++++++++++++++++++++++++++++
>> > >>  1 file changed, 138 insertions(+)
>> > >>
>> > >> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> > >> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> > >> index 2cc4785..a9f25fc1 100644
>> > >> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> > >> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> > >> @@ -12,6 +12,7 @@
>> > >>  #include <dt-bindings/power/qcom-aoss-qmp.h>
>> > >>  #include <dt-bindings/power/qcom-rpmpd.h>
>> > >>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> > >> +#include <dt-bindings/gpio/gpio.h>
>> > >>
>> > >>  / {
>> > >>         interrupt-parent = <&intc>;
>> > >> @@ -316,6 +317,118 @@
>> > >>                         };
>> > >>                 };
>> > >>
>> > > [...]
>> > >> +
>> > >> +               pcie1_phy: phy@1c0e000 {
>> > >> +                       compatible =
>> > >> "qcom,sm8250-qmp-gen3x2-pcie-phy";
>> > >> +                       reg = <0 0x01c0e000 0 0x1c0>;
>> > >> +                       #address-cells = <2>;
>> > >> +                       #size-cells = <2>;
>> > >> +                       ranges;
>> > >> +                       clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
>> > >> +                                <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
>> > >> +                                <&gcc GCC_PCIE_CLKREF_EN>,
>> > >> +                                <&gcc GCC_PCIE1_PHY_RCHNG_CLK>;
>> > >> +                       clock-names = "aux", "cfg_ahb", "ref",
>> > >> "refgen";
>> > >> +
>> > >> +                       resets = <&gcc GCC_PCIE_1_PHY_BCR>;
>> > >> +                       reset-names = "phy";
>> > >> +
>> > >> +                       assigned-clocks = <&gcc
>> > >> GCC_PCIE1_PHY_RCHNG_CLK>;
>> > >> +                       assigned-clock-rates = <100000000>;
>> > >> +
>> > >> +                       status = "disabled";
>> > >
>> > > I think the style is to put status disabled close to the compatible?
>> >
>> > Generally I have added status disabled in end as like many nodes. just
>> > curious to ask is there any specific reason to put close to compatible.
>> 
>> It's really up to qcom maintainers, which I am not.
>> 
> 
> I like when it's the last item, as it lends itself nicely to be
> surrounded by empty lines and thereby easy to spot...
> 
>> Sure, I will change as like previous one.

> Regards,
> Bjorn
> 
>> > >> +                               };
>> > >> +
>> > >> +                               reset-n {
>> > >> +                                       pins = "gpio2";
>> > >> +                                       function = "gpio";
>> > >> +
>> > >> +                                       drive-strength = <16>;
>> > >> +                                       output-low;
>> > >> +                                       bias-disable;
>> > >> +                               };
>> > >> +
>> > >> +                               wake-n {
>> > >> +                                       pins = "gpio3";
>> > >> +                                       function = "gpio";
>> > >> +
>> > >> +                                       drive-strength = <2>;
>> > >> +                                       bias-pull-up;
>> > >> +                               };
>> > >
>> > > These last two nodes with the pull-up and drive-strength settings
>> > > should
>> > > be in the board files, like the idp one, instead of here in the SoC
>> > > file. That way board designers can take the SoC and connect the pcie to
>> > > an external device using these pins and set the configuration they want
>> > > on these pins, or choose not to connect them to the SoC at all and use
>> > > those pins for something else.
>> > >
>> > > In addition, it looks like the reset could be a reset-gpios property
>> > > instead of an output-low config.
>> > >
>> > we are using reset property as perst gpio in pcie node.
>> 
>> Ok, perst-gpios should be fine. Presumably perst-gpios should be in 
>> the
>> board and not in the SoC because of what I wrote up above.

>> Sure, I will move perst into board specific file
