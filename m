Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450E45AF0E7
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiIFQne (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiIFQnD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 12:43:03 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6277B8E4FC;
        Tue,  6 Sep 2022 09:20:53 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1279948d93dso9597984fac.10;
        Tue, 06 Sep 2022 09:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rR2dGcgU3Avgajl3EcMm1g9CpPk21WU3ulLPg/s1H+E=;
        b=ahICpWPRPpHorg4yNx6eI2hwy0It2HGi6CQ7M+M+XuzqRxl7gue0QPIS3q90Zn2csr
         5kgR/KwK5k75RjUUINJp6NW4TtHO1AzvAGPMotV1yTo8CSf1xtCtktBQysYPEn7SHKqh
         GYYQdajsZY4qUwlKwdC3SdrG7ih7Akdu3xUs3Mib/uKS3OnFLVqtd/oxezZeYf5coZd6
         wI+DNDx/q6vNSsZVe0qCH7qPHaJKg2svtZG1QL2uL6lSPqXWoVTxX+zlRuPWugz4C2Aw
         uR5wkdN4cnXtfyM4sN+0/vBocHLhRx/3yObdjeTR0Ov/1MjsSYDJeb4pmfJb/DDStx6s
         c84Q==
X-Gm-Message-State: ACgBeo2DrfqOCs/3GkY+5B7BeQ0adCd7/0lfMmgibnbrsvUO3JB9Q6Yp
        +CHjlig1KzFnEpcNiwrVgw==
X-Google-Smtp-Source: AA6agR7ETGljIxyZ8Bqaz4EhxbTTRfSdRZsDUoPt2jX5fmeviQtE2SfVJoSd+GnJVKGVA8X1y+j5fw==
X-Received: by 2002:a05:6870:888a:b0:127:2c9e:e73b with SMTP id m10-20020a056870888a00b001272c9ee73bmr6838486oam.220.1662481253253;
        Tue, 06 Sep 2022 09:20:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n3-20020a9d7403000000b00636956b3080sm6118676otk.43.2022.09.06.09.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:20:52 -0700 (PDT)
Received: (nullmailer pid 636194 invoked by uid 1000);
        Tue, 06 Sep 2022 16:20:52 -0000
Date:   Tue, 6 Sep 2022 11:20:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/7] dt-bindings: PCI: mvebu: Add orion5x compatible
Message-ID: <20220906162052.GA636104-robh@kernel.org>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220905192310.22786-1-pali@kernel.org>
 <20220905192310.22786-4-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905192310.22786-4-pali@kernel.org>
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

On Mon, 05 Sep 2022 21:23:06 +0200, Pali Rohár wrote:
> From: Mauri Sandberg <maukka@ext.kapsi.fi>
> 
> Add a compatible string to bindings to indicate that orion5x PCIe is
> supported too. Orion requires additional bindings for config space
> registers.
> 
> Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
> Changes in v3:
> * Add more detailed information about MMIO registers
> ---
>  Documentation/devicetree/bindings/pci/mvebu-pci.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
