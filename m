Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448A95179F3
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 00:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiEBW3R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 18:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiEBW3R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 18:29:17 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254FF6558;
        Mon,  2 May 2022 15:25:47 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-deb9295679so15643852fac.6;
        Mon, 02 May 2022 15:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZPti66UXm4IfcYFrgHcjam8ivBztkVbKAN8MYJx8xXQ=;
        b=Ov7duLdPGjVqWvBPsPXHV+BIM5HYMYw7LF9RmmehjFd4S3mudRk8NurLZlAyE4TEky
         f7XJRg6oJFcHFnjdWMTqt+lRCVojuEj2gThSLrHz7symD/yZN/JEBD/Hz7su5+2FPVP8
         At4OagDXbNishLuhT0jg6JklHrht1ZW+CUl5wMuCn1H08H0KA5u5Zkoa5iGUXQv9SbyZ
         UjXv7hqjp0qyOaDioWwsgX89AzQxacNOPsF8NFLBiTlq2ETSG+dPTVgtfII5X2FJP05c
         A3ieUWyenbLOSI6oppNHPWmQtyjAjCkCsJHTZaThkNUcvaztRPsLoGNdUcTYEgfPYrhq
         M5Tg==
X-Gm-Message-State: AOAM531tP7aBLaUfTxihlWhUD6BU07PEYiad3fYmGC0xVa28wSx9DYit
        hrexD8rAU/voaaG/p++htQ==
X-Google-Smtp-Source: ABdhPJzc4zIGhmlMsPFpeqVHjYHKdxOfI2UDtoL6zkpdou6xZUxdMnFAkvVXaS7pha3iEYhHB6FtYQ==
X-Received: by 2002:a05:6870:c59d:b0:e2:bd6d:afcc with SMTP id ba29-20020a056870c59d00b000e2bd6dafccmr589284oab.284.1651530346411;
        Mon, 02 May 2022 15:25:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v186-20020aca61c3000000b00325cda1ffa1sm2800603oib.32.2022.05.02.15.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 15:25:45 -0700 (PDT)
Received: (nullmailer pid 1905532 invoked by uid 1000);
        Mon, 02 May 2022 22:25:44 -0000
Date:   Mon, 2 May 2022 17:25:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, devicetree@vger.kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, kw@linux.com,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, robh+dt@kernel.org, vkoul@kernel.org,
        p.zabel@pengutronix.de, mmaddireddy@nvidia.com, krzk@kernel.org,
        thierry.reding@gmail.com, linux-pci@vger.kernel.org,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        mperttunen@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 1/8] dt-bindings: PHY: P2U: Add support for Tegra234
 P2U block
Message-ID: <YnBaaA4HIg0bVGUV@robh.at.kernel.org>
References: <20220423124858.25946-1-vidyas@nvidia.com>
 <20220423124858.25946-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423124858.25946-2-vidyas@nvidia.com>
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

On Sat, 23 Apr 2022 18:18:51 +0530, Vidya Sagar wrote:
> Add support for Tegra234 P2U (PIPE to UPHY) module block which is a glue
> module instantiated once for each PCIe lane between Synopsys DesignWare
> core based PCIe IP and Universal PHY block.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Addressed review comments from Rob and Raul
> * Ran 'dt_binding_check' and 'dtbs_check' on this change
> 
>  .../bindings/phy/phy-tegra194-p2u.yaml          | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
