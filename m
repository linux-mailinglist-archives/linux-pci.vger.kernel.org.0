Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BACC7B2565
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 20:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjI1SiV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 14:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1SiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 14:38:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDDA99;
        Thu, 28 Sep 2023 11:38:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFD6C433C7;
        Thu, 28 Sep 2023 18:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695926298;
        bh=HMv3aMNoQ1ckn87bJWhrEpphtLY+eMk4huwl12R2LLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wkr5Pf+3amVHfP6FSk/1eyM89AvNhWEm0oU7ROMuZE7CO68q1DrLwATVVqjK4kuSQ
         +9ImYpuMaANe3g+fFzXcQk4wKnE5xJ9kiz7ls8hod3JB/dbrhBD81GmvyJxyH7KsX0
         jfGZ2jcwqqi6CAPwcwS+Wj6a9C0JazEgxAX4afFUlYmjuH9DjYTrDdaOjiowdVi4zz
         WrCz6jwRI3s/xZxyieHQZFnq0GtBtgdyJf3iEumhfYv2banu/bAOiL8QyniI9gRmCg
         UxqA8ZXzuPewLgHMma/dTf/ANd+czFg72Eb2ymH+ooXLqz70H7T2aMBaZj/9Mg1eLB
         vKiDbKzik/fXA==
Date:   Thu, 28 Sep 2023 20:38:08 +0200
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v5 2/5] arm64: dts: qcom: sm8450: Add opp table support
 to PCIe
Message-ID: <20230928183808.GA10963@thinkpad>
References: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
 <1694066433-8677-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1694066433-8677-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 07, 2023 at 11:30:30AM +0530, Krishna chaitanya chundru wrote:
> PCIe needs to choose the appropriate performance state of RPMH power
> domain based up on the PCIe gen speed.
> 
> So let's add the OPP table support to specify RPMH performance states.
> 
> Use opp-level for the PCIe gen speed for easier use.
> 

So, you just want to control RPMh performance state using OPP and not clock
rates? What will happen if you switch to lowest performance state of RPMh but
still run PCIe clocks at max rate?

- Mani

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 47 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 2a60cf8..a6264a5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -1820,7 +1820,28 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pcie0_default_state>;
>  
> +			operating-points-v2 = <&pcie0_opp_table>;
> +
>  			status = "disabled";
> +
> +			pcie0_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-1 {
> +					opp-level = <1>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-2 {
> +					opp-level = <2>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-3 {
> +					opp-level = <3>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +				};
> +			};
>  		};
>  
>  		pcie0_phy: phy@1c06000 {
> @@ -1932,7 +1953,33 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pcie1_default_state>;
>  
> +			operating-points-v2 = <&pcie1_opp_table>;
> +
>  			status = "disabled";
> +
> +			pcie1_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-1 {
> +					opp-level = <1>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-2 {
> +					opp-level = <2>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-3 {
> +					opp-level = <3>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-4 {
> +					opp-level = <4>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +				};
> +			};
>  		};
>  
>  		pcie1_phy: phy@1c0f000 {
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
