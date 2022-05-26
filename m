Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EE2535536
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 22:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbiEZUzh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 16:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244201AbiEZUzf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 16:55:35 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9140E730C;
        Thu, 26 May 2022 13:55:33 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-e93bbb54f9so3588689fac.12;
        Thu, 26 May 2022 13:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0rsUA/r8b1VLCSXXA51xwgErV5/qlfc8d3fNqN04xO0=;
        b=spnfhMpMhAjdd6jWq549Ylyea6wgJ7BKG2ER1Da1N6f2pgTWsamPsIKD9jGLnUKWXq
         Xb4Zhd7caInuykdC/H3k2iGY8JGi4+ydf2fmaaBgkK/YpZBjFhiZc9sE88Wfo3A4lsoL
         VwfRMs40PxqjbOTGumwLOgb8SIblJMLL0n7hXLPgY9KYmramAQ5bi6X21B5oGr2qoQn1
         9j42KrIQhuB+aIJiLkWH6Cl5CkL+RbJdrsEIy3eDpSd4HD4Z3etKbbbfM/e6R4o5fsUp
         v1xvixY+SmukWGkEFgCP3tMAt7RW5ChDBjm6aq1I+57Gm/pDUVQ6m/kHpU6bxU7zNOMN
         e7HQ==
X-Gm-Message-State: AOAM531sPOn3pcGIAuLRZ4DtfZJo/1CrPAySBigYGrS8FVKahv8bjo+/
        wrTDSLgmwHrI8vm2q32tfQ==
X-Google-Smtp-Source: ABdhPJw6djuYwIgSpAVSESYRpRxq78ur90L4c8S/aM5Gbaf5N/mBqzGtd1Enhsbzsdo0bNXDtMUzPw==
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id v5-20020a056870310500b000f29615ff8emr2193394oaa.200.1653598532945;
        Thu, 26 May 2022 13:55:32 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-37.sw.biz.rr.com. [192.154.179.37])
        by smtp.gmail.com with ESMTPSA id gc6-20020a056870678600b000f28d8f2debsm118543oab.2.2022.05.26.13.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:55:32 -0700 (PDT)
Received: (nullmailer pid 248196 invoked by uid 1000);
        Thu, 26 May 2022 20:55:28 -0000
Date:   Thu, 26 May 2022 15:55:28 -0500
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
Subject: Re: [PATCH v6 3/6] PCI: rcar-gen2: Add RZ/N1 SOCs family compatible
 string
Message-ID: <20220526205528.GM54904-robh@kernel.org>
References: <20220520094155.313784-1-herve.codina@bootlin.com>
 <20220520094155.313784-4-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520094155.313784-4-herve.codina@bootlin.com>
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

On Fri, May 20, 2022 at 11:41:52AM +0200, Herve Codina wrote:
> Add the Renesas RZ/N1 SOCs family support to the Renesas R-Car Gen2
> PCI bridge driver.
> 
> The Renesas RZ/N1 SOCs internal PCI bridge is compatible with the one
> available in the R-Car Gen2 family.
> 
> Tested with the RZ/N1D (R9A06G032) SOC.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pci/controller/pci-rcar-gen2.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
