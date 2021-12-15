Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D7A4764AC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 22:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhLOVhe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 16:37:34 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:36403 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhLOVhe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 16:37:34 -0500
Received: by mail-ot1-f43.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so26580305otl.3;
        Wed, 15 Dec 2021 13:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HjJ54UfO9E48NaUzn6T4uGICKfYei5YmhLn1HLnxei0=;
        b=10cv1iryceUPeDxHjHK8SShEXHxkQVs8Ggk4jImIQDBmEMklvWB/Zu3woeN/nDMWdr
         hDynA7+sl5nfT/A8t97rekMv4xkqiqy4PMfgbQ4sKLQBwPsg003FUUs4TFPBNqznOBcq
         jPGU40QFbCsaIvahbjzvI02zSW5Yk+meQqGWbe9j8SKLS2oJAonAUnfpLcdhXnBTrXoP
         Mw03XSLJJoaNtH2fN3NBaSSRXZvAvTh6VwGPG7P2jItpw/s7rqqzxs6nXZ0+AgUnZKBB
         NsQsZpIC+K8wDmGMdJahnhIhLnfReu/+mjVev84d7mxcdh+QgJBidA9JBacT4/yG02OQ
         sk4g==
X-Gm-Message-State: AOAM533et22SXfRVPS/t0NEsTUVULtSgiBtam97hfwSip7aoJzLpHTH1
        ZzVsmYvBQrRgqYVT6MYuOQ==
X-Google-Smtp-Source: ABdhPJwMAB4wXEDQFwp8uOUqy66XNIW/wZPJYaEb/Pnk0gGjp9pan3xBLCiOJJuZnWugB2wb3ufiPw==
X-Received: by 2002:a9d:2085:: with SMTP id x5mr10603941ota.228.1639604253092;
        Wed, 15 Dec 2021 13:37:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m6sm673216ooe.24.2021.12.15.13.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:37:32 -0800 (PST)
Received: (nullmailer pid 1883288 invoked by uid 1000);
        Wed, 15 Dec 2021 21:37:31 -0000
Date:   Wed, 15 Dec 2021 15:37:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v4 01/10] dt-bindings: pci: qcom: Document PCIe bindings
 for SM8450
Message-ID: <YbpgGwe7H2d/oinZ@robh.at.kernel.org>
References: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
 <20211214225846.2043361-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214225846.2043361-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 15 Dec 2021 01:58:37 +0300, Dmitry Baryshkov wrote:
> Document the PCIe DT bindings for SM8450 SoC.The PCIe IP is similar
> to the one used on SM8250. Add the compatible for SM8450.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 21 ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
