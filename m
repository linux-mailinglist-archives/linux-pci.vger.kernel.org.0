Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C855A578C10
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiGRUtU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 16:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiGRUtT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 16:49:19 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CADBC10;
        Mon, 18 Jul 2022 13:49:18 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id u20so10305106iob.8;
        Mon, 18 Jul 2022 13:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nv+IAt2KrXC1YsMwgz/3SPPCPTXqf1A56qVYg6JYqJU=;
        b=e8c7/BB3uoA3O7VtsCIsWeGaBDg0usniEdaScII/f9ql3g9NLnb5wzmUTcb6460sVm
         V+HNkwpTptAd1AL2ulF9FyTDnSfYEkCE7UKu1ceD39da/SlSZYIRupOWSHDXDvkLyVG5
         EwO+J3D8RrkvMHl0h41xXW8ewYQIALz+9giGfz4UrOA2AuFTg4rfX4lfwhJXVD6qIDfh
         +/It75uDsb/XNB6M8V525dD5DBEkQbD/akfwE+WDhGmyebFzDDx53S5dYNlQekiGoTol
         O+V3Ya5JT7seBk4xqvpVof5rBIQsbaElSguCE0N61t54ihuuApTPvdrkKS8cb/PhlZo5
         SZEg==
X-Gm-Message-State: AJIora9Sig9Y1B8lxSidFcmE8HVlLcqXWBnHCDvbrCvdmb24GAUDzrME
        XQUyvSiSXVTodREfhqDjTn25ESCv9w==
X-Google-Smtp-Source: AGRyM1uqScuOl3f7VRVbpisNewCpXjaPDKPuJYAtTg54N6uM+Qki4EHBJdsF8CbWLvKlJxOiaFYpMw==
X-Received: by 2002:a02:970a:0:b0:33f:42a8:a63f with SMTP id x10-20020a02970a000000b0033f42a8a63fmr15708479jai.115.1658177357368;
        Mon, 18 Jul 2022 13:49:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f19-20020a022413000000b00339ceeec5edsm5914760jaa.12.2022.07.18.13.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:49:17 -0700 (PDT)
Received: (nullmailer pid 3526738 invoked by uid 1000);
        Mon, 18 Jul 2022 20:49:14 -0000
Date:   Mon, 18 Jul 2022 14:49:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     kthota@nvidia.com, lpieralisi@kernel.org, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, kw@linux.com,
        linux-pci@vger.kernel.org, robh+dt@kernel.org, sagar.tv@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, mmaddireddy@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Subject: Re: [PATCH V5 2/9] dt-bindings: PCI: tegra234: Add schema for
 tegra234 rootport mode
Message-ID: <20220718204914.GA3526680-robh@kernel.org>
References: <20220713090029.30395-1-vidyas@nvidia.com>
 <20220713090029.30395-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713090029.30395-3-vidyas@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 13 Jul 2022 14:30:22 +0530, Vidya Sagar wrote:
> Add support for PCIe controllers that operate in the rootport mode
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
>  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 102 +++++++++++++++++-
>  1 file changed, 100 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
