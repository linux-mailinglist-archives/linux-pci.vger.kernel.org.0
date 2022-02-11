Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4984B2857
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 15:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351057AbiBKOwx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 09:52:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245724AbiBKOwx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 09:52:53 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6912C188;
        Fri, 11 Feb 2022 06:52:52 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id r27so9791298oiw.4;
        Fri, 11 Feb 2022 06:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=46nJd9VYthdKI2/dTQgQ5KJwSvr+W0mSUj90tGsID1w=;
        b=Ryn86BN3Cuoh8nEP+9x3s+8frJ0swja7vWDuOPqTUd9J3vM1B2J3/MgvRtHs+YAkZk
         5hTC6/ZqY2kp2Ifk5QGebK5PA5iNfo+W78iBKgfTi2a1VP5sxZ3oMdEX+kMISLd+6Jjr
         tdG+vLqPCadL8gdYSwIDoRTnqqXavm+stv8eSgNezM8/p7UXRvp9pUFtvSxF65/cr+sf
         SgctXXMlXT+BPeeCqR8RcEGJ3pgGSPfg9Bm5ZAFLdz54iqHT1UYeK9C2VSH4+G8x+jwk
         KwkKnLj8Jo1uk4DbHkq7VVqbbhRewvTxM2ZnazHv1Bk0JcPzOrrMDui9p9mAGWqHC4H4
         fYng==
X-Gm-Message-State: AOAM532CVbcbdcpcXeG+lZOVvGI7yaKrpslCX32mIGLlpmNo3dLEWAhN
        UHpnEA0CaHgWGjvX+D8EHhy5acfLIQ==
X-Google-Smtp-Source: ABdhPJzjLt/nrOkIStmrf8fYfRIpHNQE7BswQGiucXY+k/ocnhmOjbldY/S0KRiqFtQgwkNuf/Haeg==
X-Received: by 2002:a05:6808:1b0a:: with SMTP id bx10mr344230oib.292.1644591171744;
        Fri, 11 Feb 2022 06:52:51 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d7:a802:e6b0:6d9c:32f7:4bd9])
        by smtp.gmail.com with ESMTPSA id w7sm9509991oou.13.2022.02.11.06.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:52:50 -0800 (PST)
Received: (nullmailer pid 348965 invoked by uid 1000);
        Fri, 11 Feb 2022 14:52:48 -0000
Date:   Fri, 11 Feb 2022 08:52:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     vkoul@kernel.org, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mperttunen@nvidia.com, bhelgaas@google.com,
        linux-phy@lists.infradead.org, krzysztof.kozlowski@canonical.com,
        sagar.tv@gmail.com, mmaddireddy@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        kw@linux.com, thierry.reding@gmail.com, p.zabel@pengutronix.de
Subject: Re: [PATCH V1 02/10] dt-bindings: power: Add Tegra234 PCIe power
 domains
Message-ID: <YgZ4QGokqbUbm2o7@robh.at.kernel.org>
References: <20220205162144.30240-1-vidyas@nvidia.com>
 <20220205162144.30240-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205162144.30240-3-vidyas@nvidia.com>
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

On Sat, 05 Feb 2022 21:51:36 +0530, Vidya Sagar wrote:
> Add power domain IDs for the four PCIe power partitions found on
> Tegra234.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  .../dt-bindings/power/tegra234-powergate.h    | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 include/dt-bindings/power/tegra234-powergate.h
> 

Acked-by: Rob Herring <robh@kernel.org>
