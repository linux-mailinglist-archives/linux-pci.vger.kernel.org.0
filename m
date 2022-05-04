Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D7751A164
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 15:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiEDN44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 09:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiEDN4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 09:56:55 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850403E5EC;
        Wed,  4 May 2022 06:53:19 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-ed9a75c453so1210070fac.11;
        Wed, 04 May 2022 06:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AXUAqmMP0IKTrRo8ZlNuVuepbf5KrJWQjBDK1HtGLLw=;
        b=YSLFEcLQ0MGTlODY9bX7+8wMzmR+0fXdDIF4k1Q3LwvW/C4nZEwCMXITPZ3ZeR0aFV
         JfwaoGpr8G+spYz3Ls9fJZKSq+OfOG9PvJFvcpyUwjCF3Lz/XDEkcMurm8NpVvBrJ1o5
         pafiJBBAY5L9N04IB73RNqAZRXdoraw+oTPWEZuLJW8vAPDl0It7GiHfXAuarfiUgcy1
         NVay1yrJpopmNrxtfmTsFLToHkFjgWnS9k2e5YCgNeRS0YK8oFAPkGw48NnHuY5JtSL1
         AZ3pm8VaLaaDZmNZZLO+Za28TOt5Sk4Bx6nvEHBaj4W1EkKMp77QnD5i9lHOUzlpNTSu
         fPdA==
X-Gm-Message-State: AOAM533jCKY+mgmZo0M/6oKRvinfssH5bPE+lYY98+gVv+khW/tMjoxc
        vG2oM4WeA0PNpN4dyZv6hg==
X-Google-Smtp-Source: ABdhPJzjCamIbsRnwMxIYYcdgHb0qtrrxFace/QMGM+oPVnpbU+5MGTcMTiDynIHesGyt/SIPpgG4Q==
X-Received: by 2002:a05:6870:9a17:b0:e9:3d1:f91a with SMTP id fo23-20020a0568709a1700b000e903d1f91amr3798837oab.44.1651672398836;
        Wed, 04 May 2022 06:53:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n3-20020a056870a44300b000e90544b79fsm8497700oal.41.2022.05.04.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 06:53:18 -0700 (PDT)
Received: (nullmailer pid 1609314 invoked by uid 1000);
        Wed, 04 May 2022 13:53:17 -0000
Date:   Wed, 4 May 2022 08:53:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v5 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
Message-ID: <YnKFTVFaYO9uk2m0@robh.at.kernel.org>
References: <20220429134143.628428-1-herve.codina@bootlin.com>
 <20220429134143.628428-4-herve.codina@bootlin.com>
 <29ba3db6-e5c7-06d3-29d9-918ee5b34555@linaro.org>
 <CAMuHMdWN_ni_V+e3QipWH2qKXeNPkEcVpHpb5iBYw1YQSAnCDA@mail.gmail.com>
 <YnA0id1rXlNHNz+N@robh.at.kernel.org>
 <CAMuHMdWktaRAw8Y6TR93_rH8v4mPR2yt3wGqeXeTA2p_Dh--wA@mail.gmail.com>
 <5a89e9bf-1004-500a-75e1-995732629937@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a89e9bf-1004-500a-75e1-995732629937@linaro.org>
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

On Tue, May 03, 2022 at 11:29:53AM +0200, Krzysztof Kozlowski wrote:
> On 03/05/2022 08:51, Geert Uytterhoeven wrote:
> >>>> This should not be a reason why a property is or is not required. Either
> >>>> this is required for device operation or not. If it is required, should
> >>>> be in the bindings. Otherwise what are you going to do in the future?
> >>>> Add a required property breaking the ABI?
> >>>
> >>> The problem is that there are no bindings for the reset controller
> >>> (actually the reset controller feature of the system-controller) yet.
> >>> Yeah, we can just add #reset-cells = <1> to the system-controller
> >>> device node, but we cannot add the actual resets properties to the
> >>> consumers, until the actual cell values are defined.
> >>
> >> Sounds like you should implement providers first. Or just live with the
> >> warning as a reminder to implement the reset provider?
> > 
> > I'd go for the latter. The upstream r9a06g032.dtsi is still under active
> > development. Until very recently, the only device supported was the
> > serial console.
> 
> For clocks we use in such cases fixed-clock placeholders or empty
> phandles. Maybe something like that would work here as well?

IMO, we should move away from doing that for clocks. It's a guaranteed 
ABI break.

Rob
