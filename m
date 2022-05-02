Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36145179FD
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 00:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbiEBWbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 18:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiEBWbk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 18:31:40 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FA8656D;
        Mon,  2 May 2022 15:28:10 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id z15-20020a9d65cf000000b00605f064482cso7816638oth.6;
        Mon, 02 May 2022 15:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AiUtMghJJu4VQTdQvZz9IOUZgagJkbQTTmej6MXeemE=;
        b=LrReLHXBkokNC8S5vZp3TsYr7Pv5RBzPSABdGeeUY9LIjXLFsy3jCXdLMtD1YvcQZR
         MDyRolk5Nm7V0vTlhjexzM0kXwsg2kwaaMQngeIbUV6OchsbcQc7C/xwtqXeQddmONC3
         J7qhxx9Bi3yqdrB1IrHDC/jmgo3lVsj+eBgrdVnFjA1HwNxqItTV9Yn2XClviWNFXXJx
         ZpvsTthX/rkh3YRx326xmuUTwYeRwhTPsGtAMlHeDwILG2mDOogY9CegZhJHfhJTt4y4
         cOglBo/t9lGf2zofWLnIil5wN/NcW2NyLbAzfjgKati/4i+UtAretW6D02aHNbeT3DyU
         nYIg==
X-Gm-Message-State: AOAM532XlhIK84zXS8MM5S4mAKkE6VcjxqwMqlvHKLVSf1EGSi41jfKr
        AMhvKW8/+5R35+OxikjsuA==
X-Google-Smtp-Source: ABdhPJwOIV024X6NuWnmN5TD2GGMj37f7RXZ4V/jnn+IrfIC/dd9kAKtGJAe5eSOuCRTgrLmIvtxtA==
X-Received: by 2002:a9d:6442:0:b0:5b2:3851:597 with SMTP id m2-20020a9d6442000000b005b238510597mr4848051otl.247.1651530490037;
        Mon, 02 May 2022 15:28:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q17-20020a9d6651000000b006060322127dsm3314132otm.77.2022.05.02.15.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 15:28:09 -0700 (PDT)
Received: (nullmailer pid 1909309 invoked by uid 1000);
        Mon, 02 May 2022 22:28:08 -0000
Date:   Mon, 2 May 2022 17:28:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        vkoul@kernel.org, kw@linux.com, krzk@kernel.org,
        p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 2/8] dt-bindings: PCI: tegra: Add device tree support
 for Tegra234
Message-ID: <YnBa+I/PjQJXhACK@robh.at.kernel.org>
References: <20220423124858.25946-1-vidyas@nvidia.com>
 <20220423124858.25946-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423124858.25946-3-vidyas@nvidia.com>
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

On Sat, Apr 23, 2022 at 06:18:52PM +0530, Vidya Sagar wrote:
> Add support for Tegra234 PCIe controllers. These controllers are based
> on Synopsys DesignWare core IP.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Addressed review comment from Rob
> 
>  .../bindings/pci/nvidia,tegra194-pcie.txt     | 104 +++++++++++++++++-
>  1 file changed, 101 insertions(+), 3 deletions(-)

That's a large change, please convert to schema first.

Rob
