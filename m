Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAE362611D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 19:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiKKS3g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 13:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiKKS3G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 13:29:06 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8305CD21;
        Fri, 11 Nov 2022 10:29:04 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso3255268otb.2;
        Fri, 11 Nov 2022 10:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn6cAuYLHXjup8F+hSWw66Gou+VIIUB2Qhp5H7Bh0Tg=;
        b=WDNOUSpMqQl/fxfudEl62wBJeUyiczXnbDCbYSXhuJO5OVqgsAEpEWui4nGpmhL0xA
         8pb+nrHWgv7nuRIe40GwTjfcs020HIQ5bUbdt8zs7c0xn7c/dcY6ZWeysp+hD+0FaZQ7
         qGWOfl1AAtB4I8v0hKyNt0SHtl7HcYv2rClQeomkcwf3q0CnbsP4hdSrTS4feVDbtB/i
         ZyITpfBddHvx1gsk96rwOuoPTjXW0DeY1G/KFH23ra5l0qriLV/M2XL/3Ei+bmGEaBxe
         Acf3DvT7pe0jeLMJNj57T4KZhFueo4nKvgwIy4PYN18Fe8GILa9PJc2k4eSwd4G7nari
         ffVA==
X-Gm-Message-State: ANoB5pnbi4g2fxRp/AHGuWPcuwi6WNP2cY+tXt35Dl0Y8OeOk+XNSoMG
        631drFWYEwQvyXZvMF72Ww==
X-Google-Smtp-Source: AA0mqf4vvOwpMmuZbUoSfNP/tvj1KV5ImhkBMZ+xV6rlZ9oL/EWWI+dPEitu0oRTvnzovddFX5JKhw==
X-Received: by 2002:a9d:3e4:0:b0:662:2458:3ef7 with SMTP id f91-20020a9d03e4000000b0066224583ef7mr1880568otf.150.1668191344118;
        Fri, 11 Nov 2022 10:29:04 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v13-20020a05683011cd00b00661b5e95173sm1249469otq.35.2022.11.11.10.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 10:29:03 -0800 (PST)
Received: (nullmailer pid 3650938 invoked by uid 1000);
        Fri, 11 Nov 2022 18:29:05 -0000
Date:   Fri, 11 Nov 2022 12:29:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     krzysztof.kozlowski@linaro.org, michals@xilinx.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        bharat.kumar.gogada@amd.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        nagaradhesh.yeleswarapu@amd.com
Subject: Re: [PATCH v6 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Message-ID: <166819134102.3650802.6455003560050534177.robh@kernel.org>
References: <20221111053709.1474323-1-thippeswamy.havalige@amd.com>
 <20221111053709.1474323-2-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111053709.1474323-2-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Fri, 11 Nov 2022 11:07:09 +0530, Thippeswamy Havalige wrote:
> Convert to YAML schemas for Xilinx NWL PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> changes in v6:
> Added maxItems to clocks property.
> 
>  .../bindings/pci/xilinx-nwl-pcie.txt          |  73 ---------
>  .../bindings/pci/xlnx,nwl-pcie.yaml           | 149 ++++++++++++++++++
>  2 files changed, 149 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> 

Applied, thanks!
