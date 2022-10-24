Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B842760BBE0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 23:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiJXVRL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 17:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJXVQi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 17:16:38 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5E82D2873;
        Mon, 24 Oct 2022 12:22:26 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-13b103a3e5dso13022572fac.2;
        Mon, 24 Oct 2022 12:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWGGk3FSvDrDNlj7m3/+RkyTCBK7scHSBvuDcHj894A=;
        b=b4w07ECEL03vaL+fIShk3B86XWVGaNU7T0f0Qa95NYvELT8+MnL/baxzCp/jT7Zv2j
         HWmnvcUqjrZ+NLP7HoJO46H/SPWNhrVKDloccB8bHgYDDBuQik9dn8+FBOMRFpIV6iuv
         QBUqZDGiOotKn4/g6qpzZfkT2+wd3uaB/s4Owad52xC2T6haFx7+cwnMFTXDrKH6+A9t
         pqeFZcCwHRMwzKY6OQrbHya14zAJzBxj8aNO75KbRGSAWj6Kjs7Uyz9ZuiF/UYFnGBXi
         R1ELUcR1ntfPNAu2wLbJZxBYtd4cW/Pjckn28ci6z3heRm+jFrcDyPl088iOka3UX84E
         QBWQ==
X-Gm-Message-State: ACrzQf0gn6clAisML1EuKVl6Ht6m8rs4kYVIMyVoVjemD0nFBn8bFZMb
        P5GNqt6lm+Fh8m6ASajNng==
X-Google-Smtp-Source: AMsMyM7Kon71TlhiViOgQoNGKfyW7PqeyYXqSISfxJSgf75N31P+dvtYVbGx3ovjnog4dpNSMlMyYA==
X-Received: by 2002:a05:6870:f692:b0:13a:f2be:7b49 with SMTP id el18-20020a056870f69200b0013af2be7b49mr15736513oab.77.1666639275109;
        Mon, 24 Oct 2022 12:21:15 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r40-20020a05683044a800b0066194e0e1casm102893otv.75.2022.10.24.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 12:21:14 -0700 (PDT)
Received: (nullmailer pid 2069404 invoked by uid 1000);
        Mon, 24 Oct 2022 19:21:15 -0000
Date:   Mon, 24 Oct 2022 14:21:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Steven Liu <steven.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sam Shih <Sam.Shih@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: mediatek-gen3: add SoC based clock
 config
Message-ID: <166663927468.2069331.7937155894835281223.robh@kernel.org>
References: <20221023170234.83621-1-linux@fw-web.de>
 <20221023170234.83621-2-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023170234.83621-2-linux@fw-web.de>
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

On Sun, 23 Oct 2022 19:02:32 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> The PCIe driver covers different SOC which needing different clock
> configs. Define them based on compatible.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 48 ++++++++++++++-----
>  1 file changed, 36 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
