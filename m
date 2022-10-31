Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3598161400C
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 22:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiJaVlh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 17:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJaVlh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 17:41:37 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C67813F3F;
        Mon, 31 Oct 2022 14:41:36 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-13b23e29e36so14908847fac.8;
        Mon, 31 Oct 2022 14:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcI0kyKn8cZbGuLpOtO1mv+Kxd6UqslGrJVaFZhYmE8=;
        b=uJ1YLUajOvn2dRVLu+LAc4sTkdDwmDTUjIszf0buFh51QKmQl87kttCNiS669cDvEz
         Wak8EnAVqGgv5OwjhUZuzOrCjd32jiJ1cSNzbKXAZrxvAYOb8zd95vGUas0A28PhbJKQ
         +hw6XUKiTW/82uHQCT70fInW1Ac+N8RFx0WPmyWZvLCKjvclfDQHn5oYLJ3VVpprr+8Y
         kmBKYuG3xa51p79yJwPQ57JS+Y2Kv7AYUxxFKJovOfgxwbvSaedh4xJ0SP49/yqcDHX2
         F5qqjzf2XYVNgof4t9KCAJIbGOeDhaXYAbzvGrFeXpHCRKRY18fAm09JhjtOfjrR4spV
         4FNA==
X-Gm-Message-State: ACrzQf24s9eVpFrImPHbOUaXeuoXIkaABE/10eijZuNbSXRFNtFb068b
        OsLPT4dySDh6FMFcqZW3LA==
X-Google-Smtp-Source: AMsMyM5gEDn+v8FtcjVtTsmNxCqAjnGMCDqmiyURwxRSwgQ0L/lI8gWwRhVd0bJSL60yRW2+0Zja+g==
X-Received: by 2002:a05:6870:4798:b0:12c:fdf7:e948 with SMTP id c24-20020a056870479800b0012cfdf7e948mr8606870oaq.247.1667252495847;
        Mon, 31 Oct 2022 14:41:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x32-20020a05683040a000b0066aba96addbsm3200540ott.81.2022.10.31.14.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:41:35 -0700 (PDT)
Received: (nullmailer pid 3618755 invoked by uid 1000);
        Mon, 31 Oct 2022 21:41:37 -0000
Date:   Mon, 31 Oct 2022 16:41:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-phy@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v1 2/7] dt-bindings: phy: qcom,qmp-pcie: add sm8350
 bindings
Message-ID: <166725249648.3618701.17839968861509422583.robh@kernel.org>
References: <20221029211312.929862-1-dmitry.baryshkov@linaro.org>
 <20221029211312.929862-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029211312.929862-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Sun, 30 Oct 2022 00:13:07 +0300, Dmitry Baryshkov wrote:
> Add bindings for the PCIe QMP PHYs found on SM8350.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
