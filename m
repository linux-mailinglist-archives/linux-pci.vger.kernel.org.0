Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA9E38C438
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 11:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhEUKAO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 06:00:14 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:10824 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhEUJ6o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 May 2021 05:58:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621591041; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=N/Af6V6q0Pni5GJnu4A7BBwQUu+JckGgzbmRx6pgO9Q=;
 b=hyxr0hSlumALd9RLjyHi6DfubqOQDD05A7/WF5VQKYVp3dFKTAl7vynUpE25VRDQqNGsAR70
 xZsoB5NjqZ9KRgXQWvzy3z8DLepZimfjWYEb3HWZboF/iJyOqnGi718/o6DY9urBuhrfHu4F
 5Yf33DF6iBx4tXrr1K2grtO1X0A=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60a783ee60c53c8c9d0e3119 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 May 2021 09:57:02
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 931F1C43145; Fri, 21 May 2021 09:57:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25B5CC4360C;
        Fri, 21 May 2021 09:57:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 May 2021 15:27:00 +0530
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mgautam@codeaurora.org, dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc7280: Add PCIe and PHY related
 nodes
In-Reply-To: <CAE-0n530bSPupOHVDzwpd_JVVN0tOfrAOm9dAt1ZGj7zaXOZ6A@mail.gmail.com>
References: <1620382648-17395-1-git-send-email-pmaliset@codeaurora.org>
 <1620382648-17395-3-git-send-email-pmaliset@codeaurora.org>
 <CAE-0n530bSPupOHVDzwpd_JVVN0tOfrAOm9dAt1ZGj7zaXOZ6A@mail.gmail.com>
Message-ID: <3b3701bb1e23dec88f2231722872fc40@codeaurora.org>
X-Sender: pmaliset@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-05-08 01:36, Stephen Boyd wrote:
> Quoting Prasad Malisetty (2021-05-07 03:17:27)
>> Add PCIe controller and PHY nodes for sc7280 SOC.
>> 
>> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 138 
>> +++++++++++++++++++++++++++++++++++
>>  1 file changed, 138 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 2cc4785..a9f25fc1 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -12,6 +12,7 @@
>>  #include <dt-bindings/power/qcom-aoss-qmp.h>
>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> 
>>  / {
>>         interrupt-parent = <&intc>;
>> @@ -316,6 +317,118 @@
>>                         };
>>                 };
>> 
> [...]
>> +
>> +               pcie1_phy: phy@1c0e000 {
>> +                       compatible = 
>> "qcom,sm8250-qmp-gen3x2-pcie-phy";
>> +                       reg = <0 0x01c0e000 0 0x1c0>;
>> +                       #address-cells = <2>;
>> +                       #size-cells = <2>;
>> +                       ranges;
>> +                       clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
>> +                                <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
>> +                                <&gcc GCC_PCIE_CLKREF_EN>,
>> +                                <&gcc GCC_PCIE1_PHY_RCHNG_CLK>;
>> +                       clock-names = "aux", "cfg_ahb", "ref", 
>> "refgen";
>> +
>> +                       resets = <&gcc GCC_PCIE_1_PHY_BCR>;
>> +                       reset-names = "phy";
>> +
>> +                       assigned-clocks = <&gcc 
>> GCC_PCIE1_PHY_RCHNG_CLK>;
>> +                       assigned-clock-rates = <100000000>;
>> +
>> +                       status = "disabled";
> 
> I think the style is to put status disabled close to the compatible?

Generally I have added status disabled in end as like many nodes. just 
curious to ask is there any specific reason to put close to compatible.
> 
>> +
>> +                       pcie1_lane: lanes@1c0e200 {
>> +                               reg = <0 0x1c0e200 0 0x170>, /* tx0 */
> 
> Please pad reg addresses to 8 characters.

Done
> 
>> +                                     <0 0x1c0e400 0 0x200>, /* rx0 */
>> +                                     <0 0x1c0ea00 0 0x1f0>, /* pcs */
>> +                                     <0 0x1c0e600 0 0x170>, /* tx1 */
>> +                                     <0 0x1c0e800 0 0x200>, /* rx1 */
>> +                                     <0 0x1c0ee00 0 0xf4>; /* 
>> "pcs_com" same as pcs_misc? */
> 
> Is this a TODO? I'd prefer all the comments on the reg properties to be
> removed.
> 
Done
>> +                               clocks = <&rpmhcc RPMH_CXO_CLK>;
>> +                               clock-names = "pipe0";
>> +
>> +                               #phy-cells = <0>;
>> +                               #clock-cells = <1>;
>> +                               clock-output-names = 
>> "pcie_1_pipe_clk";
>> +                       };
>> +               };
>> +
>>                 stm@6002000 {
>>                         compatible = "arm,coresight-stm", 
>> "arm,primecell";
>>                         reg = <0 0x06002000 0 0x1000>,
>> @@ -871,6 +984,31 @@
>>                                 pins = "gpio46", "gpio47";
>>                                 function = "qup13";
>>                         };
>> +
>> +                       pcie1_default_state: pcie1-default {
>> +                               clkreq {
>> +                                       pins = "gpio79";
>> +                                       function = "pcie1_clkreqn";
>> +                                       bias-pull-up;
> 
> Move this bias-pull-up to the idp file?

Done
> 
>> +                               };
>> +
>> +                               reset-n {
>> +                                       pins = "gpio2";
>> +                                       function = "gpio";
>> +
>> +                                       drive-strength = <16>;
>> +                                       output-low;
>> +                                       bias-disable;
>> +                               };
>> +
>> +                               wake-n {
>> +                                       pins = "gpio3";
>> +                                       function = "gpio";
>> +
>> +                                       drive-strength = <2>;
>> +                                       bias-pull-up;
>> +                               };
> 
> These last two nodes with the pull-up and drive-strength settings 
> should
> be in the board files, like the idp one, instead of here in the SoC
> file. That way board designers can take the SoC and connect the pcie to
> an external device using these pins and set the configuration they want
> on these pins, or choose not to connect them to the SoC at all and use
> those pins for something else.
> 
> In addition, it looks like the reset could be a reset-gpios property
> instead of an output-low config.
> 
we are using reset property as perst gpio in pcie node.
>> +                       };
>>                 };
>> 
