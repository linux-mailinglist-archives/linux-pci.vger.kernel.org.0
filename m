Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2619C4B284D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244850AbiBKOvg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 09:51:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351051AbiBKOvf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 09:51:35 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED12F1E3;
        Fri, 11 Feb 2022 06:51:33 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id t199so9750417oie.10;
        Fri, 11 Feb 2022 06:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+5HYimg0tnFafFhrdKH24tvbdQcqH1zrjEeXF+N6Kzw=;
        b=Qo/1K1D6s5ePl/USOjZA16gwyOH2xgXOUYs73CgNiEmSYmBvh3Ornq+O+c7wF+bGGa
         LZ1ZKgEib3pwyu0b35cEzs7RvkLoBuzqG6YP4j+vW0VEJ6XL6iJ3+UfNwQVVI9aGYz47
         A04UhpxmxJ+xUqQjoeEYg9Kx5QyQuW3pXRl88tIyh8rA2rgQ0La/I2jVLyB2FI8Xb/86
         MsWaDLZbd5LK8A6DfKfeaeQxEmWbsN83z0pYQoy9fbCzs45Kcm1032WHaCQGkBnIREAG
         JxF/BkUlmviYFJBlpkwCC6FrlBgc3Q3icsWHFrplGiTKr4OS6Nk7kAOl3BRNj0AerpG5
         uHvw==
X-Gm-Message-State: AOAM530cxdOizAmbl8EMJwq2jarbbN8VMs/I9mCa7fe2kl7I4SpE0nh4
        ijqo1Gm/8pfSGQ/IUB8yUzWPzTbJDg==
X-Google-Smtp-Source: ABdhPJxSkCKYKDlnidQlV/ZXv5y6FgA77jqYTWxtKOLiC1oSke9iBJJE5U2Avuu5UkGuGCAM2B9IdQ==
X-Received: by 2002:a05:6808:15aa:: with SMTP id t42mr303368oiw.227.1644591093217;
        Fri, 11 Feb 2022 06:51:33 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d7:a802:e6b0:6d9c:32f7:4bd9])
        by smtp.gmail.com with ESMTPSA id r41sm9261548oap.2.2022.02.11.06.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:51:32 -0800 (PST)
Received: (nullmailer pid 347029 invoked by uid 1000);
        Fri, 11 Feb 2022 14:51:29 -0000
Date:   Fri, 11 Feb 2022 08:51:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     sagar.tv@gmail.com, kw@linux.com,
        krzysztof.kozlowski@canonical.com, kthota@nvidia.com,
        p.zabel@pengutronix.de, mmaddireddy@nvidia.com,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        vkoul@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        kishon@ti.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, mperttunen@nvidia.com
Subject: Re: [PATCH V1 01/10] dt-bindings: Add Tegra234 PCIe clocks and resets
Message-ID: <YgZ38TRtmTkQBzqL@robh.at.kernel.org>
References: <20220205162144.30240-1-vidyas@nvidia.com>
 <20220205162144.30240-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205162144.30240-2-vidyas@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 05 Feb 2022 21:51:35 +0530, Vidya Sagar wrote:
> Add the clocks and resets used by the PCIe hardware found on
> Tegra234 SoCs.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  include/dt-bindings/clock/tegra234-clock.h | 25 +++++++++++++++++++-
>  include/dt-bindings/reset/tegra234-reset.h | 27 +++++++++++++++++++++-
>  2 files changed, 50 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
