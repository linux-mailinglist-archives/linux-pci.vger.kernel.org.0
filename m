Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6A76551A4
	for <lists+linux-pci@lfdr.de>; Fri, 23 Dec 2022 15:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbiLWOwj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Dec 2022 09:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiLWOwi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Dec 2022 09:52:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8742613F23
        for <linux-pci@vger.kernel.org>; Fri, 23 Dec 2022 06:52:37 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id m4so5173543pls.4
        for <linux-pci@vger.kernel.org>; Fri, 23 Dec 2022 06:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p4c7xeEqpZFltAtynpIOAI0IKcOIz2iKznrCv3M1zGs=;
        b=qjYXQuHB9RGkuu3DlFhIcPMc97bB/cL5IGsGEG64Cqi/hdbrIWqiJ5xkynxwxjGWkI
         XR1FF7e4OsW0R+BLrkRKgmncZJImyMzkZwp+2I5RqxqO+A7z/rXkdcL5TdRptLL9m3Z/
         QaN+AMQOCKf6V3a2MXMDZvYRH6kKvuEvwWtJFfpGBq2aIAHS5NC+Sv6jF1CnD4auFnJ6
         7MZWAtfHSIMgCk/zbrvZNVN/AY6ogLx78bOHbM0RO57PB2a2Uh9M0m7sLMJ+tMKLuCHS
         uAphnpXs8MwcsLQ/haIGwqhMwBghrVdcs3LBfQO9UWL/BGqqcxe87A5r0aPNV6bDmWh+
         JIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4c7xeEqpZFltAtynpIOAI0IKcOIz2iKznrCv3M1zGs=;
        b=KYMq3TieqssYKDE5ESz81u3JymM892RLkHdYUE+t3Y+DwSN2TyytZjOS1R+ljK8KEv
         ZNjCxyEY4ezbKAzpg+M6H9ySDR1Xx2W+OLZOZj1ZGKacQuca8PZcJVjDS4FqaM9JvGHW
         t1bidrw7Y8RcULUeo+9lNjY08US3TydQMBOf2v8ZFH8IpYCTIwL+CHI/kYcBagMvfQ+u
         nc3a20mUPzoiLmsFnonTjRLjdI9zNafbjnNVT4yMIFM9PdRe9FhvA8jhqNumPiYXNCPK
         VltzRzF6O5yPqtAEW7TJtirTC7VYETY6eKeaF/Kh7DUCY/GPMohUIPoykG0zv1R9Ux5B
         IhQQ==
X-Gm-Message-State: AFqh2kqPn0VAPxH+FVXSJvMyLOZOY599VIbDuauMy8C/DqoRzYBD8H5U
        W8D1f0O8DVj5GYMtLHeXMPGy
X-Google-Smtp-Source: AMrXdXvSa1lWysAnMFmjkHDIkODKzciYlSGUdV5+Y7XWDKHP7unxftXnBP2vnAr5u8uO/nVChVFEFA==
X-Received: by 2002:a05:6a21:168c:b0:a4:2a7d:59a5 with SMTP id np12-20020a056a21168c00b000a42a7d59a5mr30259905pzb.59.1671807157028;
        Fri, 23 Dec 2022 06:52:37 -0800 (PST)
Received: from thinkpad ([27.111.75.82])
        by smtp.gmail.com with ESMTPSA id p30-20020a635b1e000000b0043a0de69c94sm2406393pgb.14.2022.12.23.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 06:52:36 -0800 (PST)
Date:   Fri, 23 Dec 2022 20:22:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: qcom: Document msi-map and
 msi-map-mask properties
Message-ID: <20221223145226.GB4587@thinkpad>
References: <20221222133123.50676-1-manivannan.sadhasivam@linaro.org>
 <20221222133123.50676-3-manivannan.sadhasivam@linaro.org>
 <20221222190141.GA1908434-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221222190141.GA1908434-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 22, 2022 at 01:01:41PM -0600, Rob Herring wrote:
> On Thu, Dec 22, 2022 at 07:01:22PM +0530, Manivannan Sadhasivam wrote:
> > The Qcom PCIe controller is capable of using either internal MSI controller
> > or the external GIC-ITS for receiving the MSIs from endpoint devices.
> > Currently, the binding only documents the internal MSI implementation.
> > 
> > Let's document the GIC-ITS imeplementation by making use of msi-map and
> > msi-map-mask properties. Only one of the implementation should be used
> > at a time.
> 
> Isn't that up to the OS to decide? Some versions may not support MSIs.
> 

Yes, OS may choose either of them but the controller supports both and only one
implementation can be used at a time.

AFAIK, all of the SoCs supported in upstream support both MSI and legacy
interrupts.

> What about legacy interrupts? Don't you need to keep the interrupt 
> properties for them?
> 

We have "interrupt-map-mask" and "interrupt-map" properties for legacy
interrupts.

Thanks,
Mani

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > index 02450fb26bb9..10fec6a7abfc 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -104,14 +104,20 @@ required:
> >    - compatible
> >    - reg
> >    - reg-names
> > -  - interrupts
> > -  - interrupt-names
> > -  - "#interrupt-cells"
> >    - interrupt-map-mask
> >    - interrupt-map
> >    - clocks
> >    - clock-names
> >  
> > +oneOf:
> > +  - required:
> > +      - interrupts
> > +      - interrupt-names
> > +      - "#interrupt-cells"
> > +  - required:
> > +      - msi-map
> > +      - msi-map-mask
> > +
> >  allOf:
> >    - $ref: /schemas/pci/pci-bus.yaml#
> >    - if:
> > -- 
> > 2.25.1
> > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
