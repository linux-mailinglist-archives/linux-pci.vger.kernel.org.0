Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129B8578C15
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 22:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiGRUt4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 16:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiGRUtz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 16:49:55 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B57FBE25;
        Mon, 18 Jul 2022 13:49:54 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id n138so9057825iod.4;
        Mon, 18 Jul 2022 13:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ajY7j0BfYhi2jE6qNJgMjzXc0PMFIPwLrREeXQz3rSQ=;
        b=fNfzerfrh2dBQMLfor6tndFKQaR0SoXmucHx0a3ir64yu6mEtD8q+fff7cmQXaEf7+
         /UyBd4hTc/i7xa4v74ioD33Wa1la/8YK3Q/2bKjUF6Mc5NQinSEx0NeRBHrPUhS3VbTi
         u+tP+B4FEAlQ3kVPdVOSnFoztFr6fLiMXmHEe+0PcGy5rugFygxCPc7BGa+TWHg85LXm
         s05x1QXZQG5q/hhl09MdQ6bIU1ESLFHIJSEeHKVWNxWHBDYPdxzJ3U6KNhbgAzDxBM9h
         JEgE23+ShBZkXfC9BVOwPMkYnQv8CI1fc8jXtclijlX2tiErcfOJuYpcObK01Jw96Jo/
         YZbQ==
X-Gm-Message-State: AJIora8QcF2rN9Waf4Bttf4q1s9fr7p/rhDavEhT3vxDhln3hyFawyjG
        hEbWwIIQ2w8K7koDYtXXXA==
X-Google-Smtp-Source: AGRyM1tnESu2T5sFWAqJyROEKa2KQBLBCdWQG0dk7/6q9lnP/jxHZhFA1efOB6uDF2IIcRun/Nf5aw==
X-Received: by 2002:a05:6638:4089:b0:33f:7f78:1cd2 with SMTP id m9-20020a056638408900b0033f7f781cd2mr15859064jam.130.1658177393523;
        Mon, 18 Jul 2022 13:49:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p7-20020a0566022b0700b0067885c5fd94sm6444061iov.29.2022.07.18.13.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:49:53 -0700 (PDT)
Received: (nullmailer pid 3527793 invoked by uid 1000);
        Mon, 18 Jul 2022 20:49:50 -0000
Date:   Mon, 18 Jul 2022 14:49:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     thierry.reding@gmail.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, kw@linux.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, mmaddireddy@nvidia.com,
        lpieralisi@kernel.org, sagar.tv@gmail.com, robh+dt@kernel.org,
        kthota@nvidia.com, kishon@ti.com, jingoohan1@gmail.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH V5 3/9] dt-bindings: PCI: tegra234: Add schema for
 tegra234 endpoint mode
Message-ID: <20220718204950.GA3527732-robh@kernel.org>
References: <20220713090029.30395-1-vidyas@nvidia.com>
 <20220713090029.30395-4-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713090029.30395-4-vidyas@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 13 Jul 2022 14:30:23 +0530, Vidya Sagar wrote:
> Add support for PCIe controllers that operate in the endpoint mode
> in tegra234 chipset.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V5:
> * Addressed review comments from Rob
> 
> V4:
> * Rebased on top of previous patch
> 
> V3:
> * New patch in this series
> 
>  .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 97 ++++++++++++++++++-
>  1 file changed, 95 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
