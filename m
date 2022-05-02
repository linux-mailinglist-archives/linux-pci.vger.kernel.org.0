Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D58651778B
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 21:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387158AbiEBTrm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 15:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387149AbiEBTrl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 15:47:41 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225E565CF;
        Mon,  2 May 2022 12:44:12 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id m25so2311105oih.2;
        Mon, 02 May 2022 12:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ucAvB47OLCc21fcBaiRNI7ffxRGUPPe35CD1iyIndks=;
        b=KblTwfLJj7M7U4HD5HMFhttNSsv0YwdjupljaNzVqZidKHqMXbG+vqzsS91aTO98Ar
         9mw+CCd/jVm4c8xww5aw6lZPFi2wjtblDj9PTfUo1uXsBAjD0tvnH/Wlh8dbHVODBR5k
         WFYF8PZ/su/iX0y4PGw/Fgfxr9x272D16/yabW6Fhu2hLQznq7nINpB6RqU8GG4E+U9O
         fTzIlrLS2KfKUanP789+FE8QoijxtDnHeZaTyYcOmRVpoINP0z7ihhcaxlUAW6jljA2e
         mjxDKLHk4xkp4Py32uqRx+kqW2nwtuNxhUHrs4aiRec+Gz7amrj5kJdpPK6BqwfuzW+r
         O0Sg==
X-Gm-Message-State: AOAM532qiardx51AwSeb6GJ68YkkNZwv1zWxSElzZHij2qUkK/X1HqhB
        yxFJIY9CEXqYEgfBryWKQA==
X-Google-Smtp-Source: ABdhPJzG0RRJdyMVQN6p9lCm1Mkp6SZ7X84M3460ToEWrNZlJfrvlz74VS86/3RCEHBwMzht6kudBQ==
X-Received: by 2002:a05:6808:220c:b0:325:c254:9b0a with SMTP id bd12-20020a056808220c00b00325c2549b0amr324140oib.239.1651520651405;
        Mon, 02 May 2022 12:44:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z17-20020a9d4691000000b006060322125dsm3283901ote.45.2022.05.02.12.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 12:44:10 -0700 (PDT)
Received: (nullmailer pid 1611767 invoked by uid 1000);
        Mon, 02 May 2022 19:44:09 -0000
Date:   Mon, 2 May 2022 14:44:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
Message-ID: <YnA0id1rXlNHNz+N@robh.at.kernel.org>
References: <20220429134143.628428-1-herve.codina@bootlin.com>
 <20220429134143.628428-4-herve.codina@bootlin.com>
 <29ba3db6-e5c7-06d3-29d9-918ee5b34555@linaro.org>
 <CAMuHMdWN_ni_V+e3QipWH2qKXeNPkEcVpHpb5iBYw1YQSAnCDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWN_ni_V+e3QipWH2qKXeNPkEcVpHpb5iBYw1YQSAnCDA@mail.gmail.com>
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

On Mon, May 02, 2022 at 11:19:19AM +0200, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Sun, May 1, 2022 at 10:51 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 29/04/2022 15:41, Herve Codina wrote:
> > > Add internal PCI bridge support for the r9a06g032 SOC. The Renesas
> > > RZ/N1D (R9A06G032) internal PCI bridge is compatible with the one
> > > present in the R-Car Gen2 family.
> > > Compared to the R-Car Gen2 family, it needs three clocks instead of
> > > one.
> > >
> > > The 'resets' property for the RZ/N1 family is not required since
> > > there is no reset-controller support yet for the RZ/N1 family.
> >
> > This should not be a reason why a property is or is not required. Either
> > this is required for device operation or not. If it is required, should
> > be in the bindings. Otherwise what are you going to do in the future?
> > Add a required property breaking the ABI?
> 
> The problem is that there are no bindings for the reset controller
> (actually the reset controller feature of the system-controller) yet.
> Yeah, we can just add #reset-cells = <1> to the system-controller
> device node, but we cannot add the actual resets properties to the
> consumers, until the actual cell values are defined.

Sounds like you should implement providers first. Or just live with the 
warning as a reminder to implement the reset provider?

Rob
