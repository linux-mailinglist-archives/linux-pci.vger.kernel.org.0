Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F81535530
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 22:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiEZUzc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 16:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbiEZUy5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 16:54:57 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F316E733D;
        Thu, 26 May 2022 13:54:43 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e656032735so3686707fac.0;
        Thu, 26 May 2022 13:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uw3bM0P3pe33VfUehU1c4lxugP1Ro3/xxEg5stMeRUQ=;
        b=taQI4jUBkqCyCp6uha8ZwU+bI+w7k4Q/7+RRNVGJdKWR2dbYbMvRUOU5gm8ZTDdP9O
         +tcoR7Hxu4KGQ/ex8YQlmNKJiKZEQeUs00ruEI1YKgYcSL9KArnwvq2YTxDl7lc9j4d2
         vKn4FQJB1EHHzdehlSgOmuTRQbXv74bE4Cy0ybNbcr2SEItHwz1sH8DwLvswYJih3rMC
         QyykSoJwvkuNE05mNUmPNo00XRZsXLjQ56b2Syj4cv9ShaEnprY+wYqO4ChdUz2pm5bE
         RaCeSsm0KNEYJgVIpWc/DxB1ayD621mQ5uhBZRmVcoQGYSw9v9epjLjJblnfpib053kv
         r29Q==
X-Gm-Message-State: AOAM530LNhItCbm3qk1gOEaCL/s1doaC8N43Y3bPY2s5WYjDuuz0k/Yg
        PQAMBD6rezps2e/1pTjKqw==
X-Google-Smtp-Source: ABdhPJxXA7Cuayn5tDjkcgtUo6Nj2SthCdPrBoTmM6N+bBfv5KYBviYzOvfn/Lz2qpaKacV/LB2ASQ==
X-Received: by 2002:a05:6870:468b:b0:f2:d163:450e with SMTP id a11-20020a056870468b00b000f2d163450emr2302477oap.31.1653598482329;
        Thu, 26 May 2022 13:54:42 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-37.sw.biz.rr.com. [192.154.179.37])
        by smtp.gmail.com with ESMTPSA id a32-20020a056870a1a000b000f1a2378a12sm131959oaf.37.2022.05.26.13.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:54:41 -0700 (PDT)
Received: (nullmailer pid 247119 invoked by uid 1000);
        Thu, 26 May 2022 20:54:40 -0000
Date:   Thu, 26 May 2022 15:54:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v6 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
Message-ID: <20220526205440.GL54904-robh@kernel.org>
References: <20220520094155.313784-1-herve.codina@bootlin.com>
 <20220520094155.313784-3-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520094155.313784-3-herve.codina@bootlin.com>
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

On Fri, May 20, 2022 at 11:41:51AM +0200, Herve Codina wrote:
> Add internal PCI bridge support for the r9a06g032 SOC. The Renesas
> RZ/N1D (R9A06G032) internal PCI bridge is compatible with the one
> present in the R-Car Gen2 family.
> Compared to the R-Car Gen2 family, it needs three clocks instead of
> one.
> 
> The 'resets' property for the RZ/N1 family is not required.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 50 +++++++++++++++----
>  1 file changed, 40 insertions(+), 10 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
