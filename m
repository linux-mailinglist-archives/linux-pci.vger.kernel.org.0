Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B184C1D33
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 21:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbiBWUgk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 15:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbiBWUgk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 15:36:40 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1D7457B7;
        Wed, 23 Feb 2022 12:36:10 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id p12-20020a05683019cc00b005af1442c9e9so8967946otp.13;
        Wed, 23 Feb 2022 12:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=AtS1UhK3oifjJ90VCpSbRXxg8A7dCgkWJ8FEFysGrNE=;
        b=CBPkKjgroBHtOSYBtixEUBb2xjmn7meWcCZu5FrElZ2RsVCOQ0FuT2IRa+zOw/QOe/
         a4xpXyYfu9GJf1rnnrLN8nAYPtQwho3U7wZZrXhSMasl+TX2R7HkKEPcVc82LCDJSyvl
         H1efaC+/IFhVn5+FjtBet3+aRBX0hgBcpMvWZ2XiTKZ4OlUg+U++yvggYOcync/Ms+jB
         nLu7amStk9UMRp+xYoJOvvsHuJAwXBvED7Jd8k8G4z83KfgefmjcPcj9kN90qZKJryWy
         S5x/c6fLMNHM9P6QS91FpI9JYAWUqPP46vJWpXYfiFIDKlDRrgvu9RMe0HjD55xnoeDg
         AFQA==
X-Gm-Message-State: AOAM5310tEIiZSsFXJfq3j5zq0vmT52iUUqcXyPqTsjKN4JK7M8P8jxM
        tRh0BIHmB9PnXoHayjEKBRZmCw8sWQ==
X-Google-Smtp-Source: ABdhPJz3ckJaYRybKmgJJ/q1yQDRwRp85ZQ09OgnYrUvPTy8PaiR7k8K4X4hzPGzUBOutazacMW3fw==
X-Received: by 2002:a9d:452:0:b0:5a3:8357:f43 with SMTP id 76-20020a9d0452000000b005a383570f43mr524585otc.319.1645648570113;
        Wed, 23 Feb 2022 12:36:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f16sm355550oae.6.2022.02.23.12.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 12:36:09 -0800 (PST)
Received: (nullmailer pid 1426824 invoked by uid 1000);
        Wed, 23 Feb 2022 20:36:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     devicetree@vger.kernel.org, svarbanov@mm-sol.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org
In-Reply-To: <20220223192946.473172-3-bhupesh.sharma@linaro.org>
References: <20220223192946.473172-1-bhupesh.sharma@linaro.org> <20220223192946.473172-3-bhupesh.sharma@linaro.org>
Subject: Re: [PATCH 2/6] dt-bindings: phy: qcom,qmp: Add SM8150 PCIe PHY bindings
Date:   Wed, 23 Feb 2022 14:36:08 -0600
Message-Id: <1645648568.439634.1426821.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 24 Feb 2022 00:59:42 +0530, Bhupesh Sharma wrote:
> Add the following two PCIe PHYs found on SM8150, to the QMP binding:
> 
> QMP GEN3x1 PHY - 1 lane
> QMP GEN3x2 PHY - 2 lanes
> 
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1596890


phy@1c06000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml

phy@1c07000: '#clock-cells' is a required property
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml

phy@1c07000: 'lanes@1c06000' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml

phy@1c0a000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml

phy@1c0e000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml

phy@1c0e000: 'lanes@1c0e200' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml

phy@1c16000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml

phy@1d87000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dt.yaml
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8450-qrd.dt.yaml

phy@1d87000: 'lanes@1d87400', 'vdda-max-microamp', 'vdda-pll-max-microamp' do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm8450-qrd.dt.yaml

phy@1d87000: 'vdda-max-microamp', 'vdda-pll-max-microamp' do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dt.yaml

phy@1da7000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dt.yaml

phy@34000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml

phy@58000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dt.yaml

phy@627000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml

phy@627000: 'vdda-phy-max-microamp', 'vdda-pll-max-microamp', 'vddp-ref-clk-always-on', 'vddp-ref-clk-max-microamp' do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml

phy@7410000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml

phy@78000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dt.yaml

phy@88e9000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dt.yaml
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dt.yaml

phy@88eb000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml

phy@c010000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dt.yaml

phy@ff6000: '#clock-cells' is a required property
	arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml

phy-wrapper@88e9000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml
	arch/arm64/boot/dts/qcom/sm8450-qrd.dt.yaml

phy-wrapper@88e9000: 'vdda-phy-supply' is a required property
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml

phy-wrapper@88e9000: 'vdda-pll-supply' is a required property
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml

phy-wrapper@88eb000: '#clock-cells' is a required property
	arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml

ssphy@78000: 'lane@78200' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dt.yaml

