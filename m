Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539724F1CF5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 23:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379826AbiDDV3m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 17:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380049AbiDDSqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 14:46:15 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413411C117;
        Mon,  4 Apr 2022 11:44:18 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-df02f7e2c9so11733934fac.10;
        Mon, 04 Apr 2022 11:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+DVZa9rgC7XCqVmwQpif8MjcfgqohlHJqzZVbT4NdPA=;
        b=6JF+JH6wd0/7ywTfr5v3ryTISkOXdlpaCcfqq+v+gSqf6hBI+8vk8ngOOlYaDhAbb4
         WAy3YTXsYLkb1vr+wbPrDfOsGJfX3f+9W9bHS9uLBVL5MZY00DQ9MZCrEU7Ls0vJ4m0z
         72hpsvSSTG+VINgD/AfqXSudkPVbKrNNyb5Gmz8/SnMgmR7yyL6xzU3T8eZC1oqqavmB
         ZPWoP/q3+pS1OtwM0s71ApPn5GFqc2Mbytkvjze2+3hPAhLDiGmSwm3ezOUseinYdxRR
         hDE7GZh5u59AgOui+SX1NM9BhXol1Wx/eP0/kHfd6EZJg8sI3hyUfmNV7Lw6uqrXD+DP
         1U2g==
X-Gm-Message-State: AOAM530hZi/cwbYGnskuyb3YyqLikeh4mmXx3JWiXYwGQOiUrpvfSLnd
        3xNLPVVPw3NXJbBciNqLfA==
X-Google-Smtp-Source: ABdhPJxQfrcUZKKhBzVlnqfwkA2XRgYhsqJUmARYpgm43Nh3Hvc35k/tV+fKp7H5hXzW0gHNQ64G6g==
X-Received: by 2002:a05:6870:c353:b0:de:d908:3e6d with SMTP id e19-20020a056870c35300b000ded9083e6dmr323176oak.190.1649097857541;
        Mon, 04 Apr 2022 11:44:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t3-20020a05680800c300b002f935a7daa9sm4505802oic.19.2022.04.04.11.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:44:17 -0700 (PDT)
Received: (nullmailer pid 1703057 invoked by uid 1000);
        Mon, 04 Apr 2022 18:44:16 -0000
Date:   Mon, 4 Apr 2022 13:44:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: uniphier: Convert
 uniphier-pcie.txt to json-schema
Message-ID: <Yks8gNN0wp7xJDST@robh.at.kernel.org>
References: <1648617814-9217-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648617814-9217-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648617814-9217-2-git-send-email-hayashi.kunihiko@socionext.com>
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

On Wed, 30 Mar 2022 14:23:33 +0900, Kunihiko Hayashi wrote:
> Convert the file into a JSON description at the yaml format.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/pci/socionext,uniphier-pcie.yaml | 96 +++++++++++++++++++
>  .../devicetree/bindings/pci/uniphier-pcie.txt | 82 ----------------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 97 insertions(+), 83 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> 

Applied, thanks!
