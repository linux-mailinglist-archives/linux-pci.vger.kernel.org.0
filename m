Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2895355C8
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 23:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349279AbiEZVpz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 17:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244735AbiEZVpy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 17:45:54 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E04C1EC0;
        Thu, 26 May 2022 14:45:52 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id l10-20020a9d7a8a000000b0060b151de434so1851953otn.2;
        Thu, 26 May 2022 14:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PCG4r4X+asFA0jZTA+Ife3/8wPAarl7+c0uuxFcUqiE=;
        b=JDFIzcLAmfYbfGDx7kE82SI7WwZMoBTNmqVhWXDsztkst/94OV4pW5aixB/V/SRlN9
         SreK5VJ7D5aWmOXRD4om/8hVYF7gz6xtzotz7mVB+uFv59/xCfomUzuFqzFgV1Rkzyi8
         WDgg4xjHvqLSEqRzq64nLh2gtEAbQD1PwHMXQuUcccwlFcvbt6THpgoU2s94MXhEK0cj
         h6+UcWarSGU0GcVZTgN+KMVIN3qJR7b5Y3wwbFLSdiP0IS37T1wj404J3f7B8pC5O9/1
         KS9q7vpeMKJEyBajbArMYMEJHs1Wbmk1T9g+2h6nXKs5F/cYmcIkS7uilzRkV07yaEBU
         Bfww==
X-Gm-Message-State: AOAM531JxC8dznnmQ8bD6+AkcQacAnbYZ16K+w/iwwHB2XsXOTK+UqTq
        S0cT3VTS+5GNUjRktyw8+w==
X-Google-Smtp-Source: ABdhPJy9ZcPJjkdrjLie5XqS/prFVhv90S8NFQPbVS8lSLRs2N3IH+W94qTPJpzkcMVN5bqyoYrIDg==
X-Received: by 2002:a9d:1b42:0:b0:60b:20f9:7849 with SMTP id l60-20020a9d1b42000000b0060b20f97849mr6345709otl.383.1653601552019;
        Thu, 26 May 2022 14:45:52 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-37.sw.biz.rr.com. [192.154.179.37])
        by smtp.gmail.com with ESMTPSA id h19-20020a9d3e53000000b00606b1f72fcbsm1060327otg.31.2022.05.26.14.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:45:51 -0700 (PDT)
Received: (nullmailer pid 317160 invoked by uid 1000);
        Thu, 26 May 2022 21:45:49 -0000
Date:   Thu, 26 May 2022 16:45:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: apple: Add missing 'power-domains'
 property
Message-ID: <20220526214549.GA315754-robh@kernel.org>
References: <20220526014107.2871787-1-robh@kernel.org>
 <a3636e0e-a804-4701-9240-225a3131b16a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3636e0e-a804-4701-9240-225a3131b16a@www.fastmail.com>
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

On Thu, May 26, 2022 at 03:48:15PM +0200, Sven Peter wrote:
> Hi,
> 
> 
> On Thu, May 26, 2022, at 03:41, Rob Herring wrote:
> > The 'unevaluatedProperties' schema checks is not fully working and doesn't
> > catch some cases where there's a $ref to another schema. A fix is pending,
> > but results in new warnings in examples.
> >
> > The Apple PCIe host has 3 power domains at least according to the example.
> > Add the 'power-domains' property to the schema.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Ideally, we'd define what each power domain is, but I don't know what
> > they are.
> > ---
> 
> I think the example is just wrong (or outdated) and we only need a single
> power-domain for pcie.
> 
> The hierarchy is ps_pcie_ref -> ps_apcie -> ps_apcie_gp and the pcie
> node then only depends on ps_apcie_gp.

Okay, I'll update the example and schema.
