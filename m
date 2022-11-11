Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A04626118
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 19:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiKKS3D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 13:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiKKS2x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 13:28:53 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100E8BCBC;
        Fri, 11 Nov 2022 10:28:53 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-13c569e5ff5so6255741fac.6;
        Fri, 11 Nov 2022 10:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TcmOGmmYiSG/QGlL3sk22CJub5zIwfLLTqFpgVWrk8=;
        b=MEHf/W7QWFPLReNJ5akgDgXR5zeCzNlmLEF5VwTj1sE70oPfNQuTgninx2T1eX6P2t
         8JCNuZbhcXftbIL8eoKkoP0TH99Yr+OvBs7lAbiOm2cmV3UqClhD1x8S+66m99xGCgwY
         OnWIrrKR/R9nPtn/qOUbeB6DiNaPrH05TElO5/IrnroMFgz31m0+/t8ejCFuVnmDDcFc
         PE7bMRGI/GWTQ7qzHHIBUoK/lbLFDTdQstKupPS+oao95TP0w2QyqYqrgCaRf6O46h4N
         NFgHm3Bb+WsRdzs7JTHGXPsGOQSVMbr0Y9rs2p/JEqQxhLHlIggMZMOxaT1o8xRKN8uP
         8gTg==
X-Gm-Message-State: ANoB5ploMAQfHCVzK1POjN7xo3TsGW7n6V0Asf+8Hg3pCSWF47hD3OF/
        hk3mWBo/9NklyvEOxN5fKA==
X-Google-Smtp-Source: AA0mqf6VbzOeXikXL7bdhPzGV31U47rmN4t950wVNkpCcWfXu/nU7kMtdnWn96ueZ6kNQFU8qr+/lQ==
X-Received: by 2002:a05:6870:3b84:b0:13b:470:6108 with SMTP id gi4-20020a0568703b8400b0013b04706108mr1686669oab.168.1668191332276;
        Fri, 11 Nov 2022 10:28:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 21-20020a9d0815000000b00667d9a866b0sm1236251oty.59.2022.11.11.10.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 10:28:51 -0800 (PST)
Received: (nullmailer pid 3650482 invoked by uid 1000);
        Fri, 11 Nov 2022 18:28:53 -0000
Date:   Fri, 11 Nov 2022 12:28:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     bhelgaas@google.com, bharat.kumar.gogada@amd.com,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, michals@xilinx.com, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, nagaradhesh.yeleswarapu@amd.com
Subject: Re: [PATCH v6 1/2] dt-bindings: PCI: xilinx-pcie: Convert to YAML
 schemas of Xilinx AXI PCIe Root Port Bridge
Message-ID: <166819133139.3650395.6723990497430227550.robh@kernel.org>
References: <20221111053709.1474323-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111053709.1474323-1-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Fri, 11 Nov 2022 11:07:08 +0530, Thippeswamy Havalige wrote:
> Convert to YAML dtschemas of Xilinx AXI PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/xilinx-pcie.txt   | 88 -------------------
>  .../bindings/pci/xlnx,axi-pcie-host.yaml      | 88 +++++++++++++++++++
>  2 files changed, 88 insertions(+), 88 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/xilinx-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
> 

Applied, thanks!
