Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A856C601684
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJQSmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 14:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJQSmf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 14:42:35 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA9F733CB;
        Mon, 17 Oct 2022 11:42:34 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id n130so13103473oia.6;
        Mon, 17 Oct 2022 11:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ+TOy+i0aYFJ/iFf9DtC13NpbD7/U7juh/tS5gbMQI=;
        b=nvQXgeE4P5RCjLpzj/MWLJJXfigI6KvTW887n/rJcA+AJHE6fHpnHLSLFFQeYyitba
         Xlh4t91r9TKU3CfkgOlJ2K74oxGmjXQB3Ddt+0GJrnjA1ZEHlMtUMXrW/u63jqpoLo0m
         1tCGKCTiZfUYh9uz9LfFlOyEIo259kAcI9w5P7ljttVAZ09QNcNK5dFVjyVsJzUHlBNt
         2DjxOQhHm/urKZqL304+j/lCfUd1+7DWgVMzpG+1VNgUMOD4WPqKrZkscpkDZiJQkQhd
         23/f1ea4A4e9NXoNsWFXoAUA8r+7L69j0qn265Xjii4AmTfbnKNuKIJhIH4F+GcAvQ7Z
         lAHw==
X-Gm-Message-State: ACrzQf0RkYvq4GiNT8uCl/wUnOGUAzN/j8k0uDO5/IkBQBYE9L6e32CG
        LukZk/gZD7kpwG/EFGLeow==
X-Google-Smtp-Source: AMsMyM69rBChqI2DHVCnodCENYuzVOrePDGda8YjhYza7SKgmCrl6bqqncNYE/8cx13f9zABeJZ+sg==
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id f18-20020a05680814d200b00354c733abd3mr5818411oiw.96.1666032153700;
        Mon, 17 Oct 2022 11:42:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bk15-20020a0568081a0f00b003546cb60859sm4707864oib.14.2022.10.17.11.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:42:33 -0700 (PDT)
Received: (nullmailer pid 2263866 invoked by uid 1000);
        Mon, 17 Oct 2022 18:42:33 -0000
Date:   Mon, 17 Oct 2022 13:42:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: mediatek-gen3: Add iommu and
 power-domain support
Message-ID: <20221017184233.GA2260080-robh@kernel.org>
References: <20221017070858.13902-1-tinghan.shen@mediatek.com>
 <20221017070858.13902-2-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017070858.13902-2-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 17, 2022 at 03:08:56PM +0800, Tinghan Shen wrote:
> From: Jianjun Wang <jianjun.wang@mediatek.com>
> 
> Add iommu and power-domain support, and add examples for MT8195, which
> has two PCIe ports with different clocks and phys.

Is that really a big enough difference to add a whole other example 
when we have a dts file with it too? I don't think so, and we certainly 
don't need to show all instances either.

Rob
