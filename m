Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A757A5EFE73
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 22:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiI2UMk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 16:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiI2UMj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 16:12:39 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043DB252A4;
        Thu, 29 Sep 2022 13:12:39 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id r136-20020a4a378e000000b004755953bc6cso863256oor.13;
        Thu, 29 Sep 2022 13:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yGYFZ4ePouD/u9A7MBvenqOXWaQw3PNpljUBB7558Qc=;
        b=U5NuQqYphu7TFBk3eVytHC2C1SevPIeCCPP8X2AsULiEUlszgvbW+7+FzO8HZCED9R
         e+kKCFkYWUJAyxPgT4cSxB/4TRncy/+4QLBTY0ZU6PILtH+rIMjR9lXORXsYPDjOeR0H
         Qp5jotLfy+8xcBEVSdKAYCVzd1+TMWvhuHtWSH4NbPJgGUZDZllgKJJs296ePy0Jnh/l
         E6nfLT2xVSYbz4DASRVMbRdr+qgSl98mSIjmpOHxJN5jqR1dNv1r41urxIHcv3PkEP+J
         5tbCa2q50gn4c+jwt0k+20PFBtpxoZTgZHbywlV/AKoV23hZEkxeClbrJdSaCZTpYYB8
         J70g==
X-Gm-Message-State: ACrzQf2TCvkpmLtFd1qPbOcq2b+VJzeaLgNOUuN6evjTIwGcO4Lrwi2x
        dKH9toW8YbMpMr6Ok7F20A==
X-Google-Smtp-Source: AMsMyM53EGc9oig6lgi5IwYnyu2iktDu3aU/q1BoOWkcrL1ru8htz8w1H/tD/lXE74tnK1QljgTfoA==
X-Received: by 2002:a9d:2924:0:b0:65c:424c:343d with SMTP id d33-20020a9d2924000000b0065c424c343dmr2121338otb.181.1664482358187;
        Thu, 29 Sep 2022 13:12:38 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a30-20020a9d2621000000b00618fa37308csm146676otb.35.2022.09.29.13.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:12:37 -0700 (PDT)
Received: (nullmailer pid 2662331 invoked by uid 1000);
        Thu, 29 Sep 2022 20:12:37 -0000
Date:   Thu, 29 Sep 2022 15:12:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     kishon@ti.com, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com, krzk@kernel.org,
        vigneshr@ti.com, robh+dt@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: ti,j721e-pci-*: Add missing
 interrupt properties
Message-ID: <166448233656.2661829.7240169247803923570.robh@kernel.org>
References: <20220924223517.123343-1-mranostay@ti.com>
 <20220924223517.123343-3-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924223517.123343-3-mranostay@ti.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 24 Sep 2022 15:35:17 -0700, Matt Ranostay wrote:
> Both interrupts, and interrupt names weren't defined in both EP and host
> yaml. Also define the only possible interrupt-name as link_state, and
> maxItems of interrupts to one.
> 
> This patch resolves the following warning:
> 
> arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb: pcie-ep@2910000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts' were unexpected)
>         From schema Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml | 7 +++++++
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml         | 7 +++++++
>  2 files changed, 14 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
