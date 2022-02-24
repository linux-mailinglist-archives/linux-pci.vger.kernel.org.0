Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9CA4C2A89
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 12:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiBXLNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 06:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiBXLM4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 06:12:56 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB26C8F61A
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 03:12:25 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id z7so2063949oid.4
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 03:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMGh5b3H8B1bptKT8dWZUQN/k3IrOManq25i31eRbuk=;
        b=c49R9bDpXj/oafr3iHjCnY5W2Vj9UJGTrjRgwfwFt6AIYTwbBhYN2el3Eqjy98kKMh
         Ic5s8DId1D1SMvukPGa2DbOu4UgCCsihS9xXqadR9edyNx0un88WQCWzYQqZzA6IzNJd
         UdsqqMauNbe+TGq/32WY5n3ZQWxFa3Gkmq0bx1CTpX2vmQ4wc43XjPZZquUhGGq8Wj2n
         d6XwoEnok/vy/pB6ugQc9GfsEfCO67JC7ZHy/HhYUEvkP3FSOtGa6YCb33PekoCJth1v
         0zsF3XYLLEfyD9f56q5T2ak6GRSEXjQWYEs2a2MtCXyiCAAm+rQj0+FsQmLs5bLm/uI9
         pTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMGh5b3H8B1bptKT8dWZUQN/k3IrOManq25i31eRbuk=;
        b=g3nICtAp+CPFvyCXCh+9FxaRHBuB0EisCIm84ATIgwpTop16rgigV6eGW3jcIC8w+C
         FHXhXY8pOIpkKoYyiTuKDs43Yac0OFKifQ/agpfGmIZqNnwVikVagrnGUnchfp0wXkLx
         vWnFH1gRLAN9SEipHk+xFAN/1Gr0IP22uXWjjdsD5O7tkh049ZxYJwQ8yIvkj89j+T/o
         r+sB3WjpTruS9qeToal0jciEXYWBQuyBHAAdF1lJLAIdXsHCEbMHEl7n410t0nhwssqL
         wwawC0s13H5w4K58eIooIVYti9jO3HSeNuKMVIEPK0AUe3QnvCaqX9TucXRpNnLkTayk
         8PTQ==
X-Gm-Message-State: AOAM531ECsp2exb0k/m3gSYfIBupDNNFd9W0kdZd4mh+IUCsiAdpDLA9
        NzFGiaQGU2+epmuAhuu91bZDl8mD55V26oTS//x+4w==
X-Google-Smtp-Source: ABdhPJww70Jos29ndOrNHrP/xD9umRk+JrJsK85ae+qoKVMNIi03s3zLdmtbsVSAA1SAscvAge2rfX6oJITlz0DP/fE=
X-Received: by 2002:a05:6808:1823:b0:2d7:1bfc:1f4f with SMTP id
 bh35-20020a056808182300b002d71bfc1f4fmr903633oib.129.1645701145036; Thu, 24
 Feb 2022 03:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20220223192946.473172-1-bhupesh.sharma@linaro.org>
 <20220223192946.473172-3-bhupesh.sharma@linaro.org> <1645648568.439634.1426821.nullmailer@robh.at.kernel.org>
In-Reply-To: <1645648568.439634.1426821.nullmailer@robh.at.kernel.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 24 Feb 2022 16:42:14 +0530
Message-ID: <CAH=2Ntx0zKV7SNtuh6ATVp2qA1LKaks8KSMQoU2qtM=EmB52pQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: phy: qcom,qmp: Add SM8150 PCIe PHY bindings
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, svarbanov@mm-sol.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Thu, 24 Feb 2022 at 02:06, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 24 Feb 2022 00:59:42 +0530, Bhupesh Sharma wrote:
> > Add the following two PCIe PHYs found on SM8150, to the QMP binding:
> >
> > QMP GEN3x1 PHY - 1 lane
> > QMP GEN3x2 PHY - 2 lanes
> >
> > Cc: Rob Herring <robh@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
>
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
>
> Full log is available here: https://patchwork.ozlabs.org/patch/1596890
>
>
> phy@1c06000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-mtp.dt.yaml
>         arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml

Thanks for the above check.
Although the warnings reflected in 'dtbs_check' are not related to this patch.

Still, looking at them, I can figure out that an additional patch is
required to make
''#clock-cells'' as optional property in the bindings as several qmp
phy variants
don't require the same.

I will add it in v2.

Regards,
Bhupesh


>
> phy@1c07000: '#clock-cells' is a required property
>         arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml
>
> phy@1c07000: 'lanes@1c06000' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
>         arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
>         arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
>         arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml
>
> phy@1c0a000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
>
> phy@1c0e000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml
>
> phy@1c0e000: 'lanes@1c0e200' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
>         arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
>         arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml
>
> phy@1c16000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml
>
> phy@1d87000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
>         arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8150-mtp.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8250-hdk.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8450-qrd.dt.yaml
>
> phy@1d87000: 'lanes@1d87400', 'vdda-max-microamp', 'vdda-pll-max-microamp' do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
>         arch/arm64/boot/dts/qcom/sm8450-qrd.dt.yaml
>
> phy@1d87000: 'vdda-max-microamp', 'vdda-pll-max-microamp' do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
>         arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dt.yaml
>
> phy@1da7000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-mtp.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dt.yaml
>
> phy@34000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml
>
> phy@58000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/ipq8074-hk01.dt.yaml
>
> phy@627000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
>         arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml
>
> phy@627000: 'vdda-phy-max-microamp', 'vdda-pll-max-microamp', 'vddp-ref-clk-always-on', 'vddp-ref-clk-max-microamp' do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
>         arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml
>
> phy@7410000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
>
> phy@78000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/ipq8074-hk01.dt.yaml
>
> phy@88e9000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8150-mtp.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dt.yaml
>
> phy@88eb000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
>         arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml
>         arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8250-hdk.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml
>
> phy@c010000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-mtp.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dt.yaml
>         arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dt.yaml
>
> phy@ff6000: '#clock-cells' is a required property
>         arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
>         arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
>         arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml
>
> phy-wrapper@88e9000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8450-qrd.dt.yaml
>
> phy-wrapper@88e9000: 'vdda-phy-supply' is a required property
>         arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml
>
> phy-wrapper@88e9000: 'vdda-pll-supply' is a required property
>         arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml
>
> phy-wrapper@88eb000: '#clock-cells' is a required property
>         arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dt.yaml
>         arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml
>
> ssphy@78000: 'lane@78200' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
>         arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dt.yaml
>
