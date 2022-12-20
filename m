Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E592A651F1B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 11:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiLTKnF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 05:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiLTKnE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 05:43:04 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47515DEAB
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 02:43:03 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 65so8211028pfx.9
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 02:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b0sworZPpV39dvKSU5Er/1+K+fBlUn/pwprcfA9fWjg=;
        b=UPZjp3NhkTvRx7voavcOfvoi0wXnDbntHlqrWLQEpJRMH70XIGjTUH4Ic1t5K8jP1n
         ySm8VsLljS21AO8zugdKzI4QMcKfgu1qUsUJg1HPbg90mv4hRp1HYyG5ocVXiljFtkuR
         RXU6PiSHItDCRhhZOLc0DgIrZZW2elyRPm9j+ecXBif+ZH4dlPH5Z55YgXA9XHb/yGku
         TMewQReh0D0JzzxVLPqAYEHFNvhqxwg30vk3Ji3g6zdO35XlDCumwzVEz5pJcWtRFLxp
         lJrh4W6Udcj4HOyIGdYDhA5s1MHJ76Dx/X1YrTJ5FFEJN1FK4Re2XJmiahOrXJl2OIfq
         arOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0sworZPpV39dvKSU5Er/1+K+fBlUn/pwprcfA9fWjg=;
        b=2cYtUxDcxVYMFrU90J+SaSK5Yob4Jxmh6MdYjz2Ywp0VnNx8v6P9rtY63DvF4spAPl
         Uhn9Tw2TYL2B92L+ZpeR+gVLlXCwKgDOlIBx5TMxRpQRjrKtAzpUNSWAoh2dYjQDhGeu
         h3Bn251AmwHk2zmOk4MLcYoQz0bzShOXJrFuaiKcVwRw/uY8DlNd4pNn6QM6urJKf1tY
         Fa048bTUuaWkEM73UfDN4ha7DvX+6Q9jFuQD1C8ysH7azJuUNGSnlEe49rGyOs7oANIG
         SyqHTTzJF8mqIExU6ZHaakPkyTXGkE7KGbkWY22+JTbOSfe0ocesqIyqiKU8PbzqNUmK
         5mdQ==
X-Gm-Message-State: AFqh2kqFzuTGkOMbPkD24z4l8JFb1D0CUdc1/eEFW0Qgw6C1NJQFuqe2
        EDWe5JBZYu7hfNafOCP33Cnf
X-Google-Smtp-Source: AMrXdXvDC3OcmYhX7lW8IjrwijjX+MzcN/cD5PBnovhqEiCJ9LQXD/3u0dWKi7FfhTdkXuhJzMw85Q==
X-Received: by 2002:a05:6a00:1da5:b0:576:5a71:454a with SMTP id z37-20020a056a001da500b005765a71454amr9275995pfw.2.1671532982752;
        Tue, 20 Dec 2022 02:43:02 -0800 (PST)
Received: from thinkpad ([117.217.181.222])
        by smtp.gmail.com with ESMTPSA id i126-20020a62c184000000b0056c349f5c70sm8264005pfg.79.2022.12.20.02.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 02:43:01 -0800 (PST)
Date:   Tue, 20 Dec 2022 16:12:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0 and
 PCIe1
Message-ID: <20221220104252.GC38609@thinkpad>
References: <20221219191427.480085-1-manivannan.sadhasivam@linaro.org>
 <20221219191427.480085-4-manivannan.sadhasivam@linaro.org>
 <741887b5-8f83-4db5-bb17-755afc18716d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <741887b5-8f83-4db5-bb17-755afc18716d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 19, 2022 at 09:51:40PM +0100, Konrad Dybcio wrote:
> 
> 
> On 19.12.2022 20:14, Manivannan Sadhasivam wrote:
> > Both PCIe0 and PCIe1 controllers are capable of receiving MSIs from
> > endpoint devices using GIC-ITS MSI controller. Add support for it.
> > 
> > Currently, BDF (0:0.0) and BDF (1:0.0) are enabled and with the
> > msi-map-mask of 0xff00, all the 32 devices under these two busses can
> > share the same Device ID.
> > 
> > The GIC-ITS MSI implementation provides an advantage over internal MSI
> > implementation using Locality-specific Peripheral Interrupts (LPI) that
> > would allow MSIs to be targeted for each CPU core.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> This breaks PCIe Wi-Fi on Xperia 1 IV:
> 
> [   32.711199] ath11k_pci 0000:01:00.0: Adding to iommu group 5
> [   32.713738] ath11k_pci 0000:01:00.0: BAR 0: assigned [mem 0x60400000-0x605fffff 64bit]
> [   32.715447] ath11k_pci 0000:01:00.0: MSI vectors: 32
> [   32.715485] ath11k_pci 0000:01:00.0: wcn6855 hw2.1
> [   32.873873] mhi mhi0: Requested to power ON
> [   32.873896] mhi mhi0: Power on setup success
> [   65.161798] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x91517088, fsynr=0x640001, cbfrsynra=0x1c00, cb=5
> 

Thanks a lot for testing! Can you please share the full dmesg log?

Thanks,
Mani

> 
> Konrad
> >  arch/arm64/boot/dts/qcom/sm8450.dtsi | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > index 570475040d95..276ceba4c247 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > @@ -1733,9 +1733,9 @@ pcie0: pci@1c00000 {
> >  			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> >  				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
> >  
> > -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> > -			interrupt-names = "msi";
> > -			#interrupt-cells = <1>;
> > +			msi-map = <0x0 &gic_its 0x5980 0x1>,
> > +				  <0x100 &gic_its 0x5981 0x1>;
> > +			msi-map-mask = <0xff00>;
> >  			interrupt-map-mask = <0 0 0 0x7>;
> >  			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> >  					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> > @@ -1842,9 +1842,9 @@ pcie1: pci@1c08000 {
> >  			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
> >  				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
> >  
> > -			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> > -			interrupt-names = "msi";
> > -			#interrupt-cells = <1>;
> > +			msi-map = <0x0 &gic_its 0x5a01 0x1>,
> > +				  <0x100 &gic_its 0x5a00 0x1>;
> > +			msi-map-mask = <0xff00>;
> >  			interrupt-map-mask = <0 0 0 0x7>;
> >  			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> >  					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */

-- 
மணிவண்ணன் சதாசிவம்
