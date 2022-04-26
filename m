Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D8650EDCA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 02:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbiDZAtU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 20:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbiDZAtT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 20:49:19 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6889678928;
        Mon, 25 Apr 2022 17:46:14 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id r85so19060789oie.7;
        Mon, 25 Apr 2022 17:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EDE0zD5BIndqKa2VaNIh8yBysMv4iwF5V38pzI4Vei0=;
        b=SGdEtzoVoVRstNbnwdge07vtDx+1y9buzKR6Dszlrs35wqO1vEK9X8U0iybGqaI8V9
         vmI+Ee5AkKBT/IqIulQajJ9npzmw952sSU1ZFOqhpaWtg7yAgolRu09LT1Hpq4VCEgRS
         wh70zyigTlAjhDOkv76ME1SJaHIq7At4qUu78oS56m7AXvX5o61nTY5Yz8Qefl1s16DR
         oYv7BZi6sHDvJuXD6v/uDgKywTBznxQmi3assOfBJ+xmRe20xQLuVMXTx8E+ItmQaYAg
         wwQLnuqM42ONDLR8LCjjAuEG9Cf0WrhYSnhfG68yVOXnbFN2KmHZ105qCUu7kcPTB2oe
         GJig==
X-Gm-Message-State: AOAM532SJI+oNTDoOxg11WoUd0e2JSJ76k6RfZ/AC1/LUfE1FCo8HYB5
        24+3AksWrO0RYYaQ76thOA==
X-Google-Smtp-Source: ABdhPJzR8mwCyNyhyHr/Jc9mlShXCzj+vYEWMu1KDZnGEnVmg5pj0FEOIjRtUs8ugQTXQ2OrrAoxuQ==
X-Received: by 2002:a54:4d9b:0:b0:324:f014:80d5 with SMTP id y27-20020a544d9b000000b00324f01480d5mr8256923oix.110.1650933973691;
        Mon, 25 Apr 2022 17:46:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 30-20020a9d0ba1000000b005e95b29b95dsm4313812oth.5.2022.04.25.17.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 17:46:13 -0700 (PDT)
Received: (nullmailer pid 643080 invoked by uid 1000);
        Tue, 26 Apr 2022 00:46:12 -0000
Date:   Mon, 25 Apr 2022 19:46:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-renesas-soc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
Message-ID: <YmdA1O+3PgL9Eep3@robh.at.kernel.org>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
 <20220422120850.769480-3-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422120850.769480-3-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 22 Apr 2022 14:08:44 +0200, Herve Codina wrote:
> Add internal PCI bridge support for the r9a06g032 SOC. The Renesas
> RZ/N1D (R9A06G032) internal PCI bridge is compatible with the one
> present in the R-Car Gen2 family.
> Compared to the R-Car Gen2 family, it needs three clocks instead of
> one.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 43 ++++++++++++++++---
>  1 file changed, 37 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
