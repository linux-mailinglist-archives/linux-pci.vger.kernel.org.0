Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E465EFE71
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 22:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiI2ULr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 16:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiI2ULq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 16:11:46 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8437124C29;
        Thu, 29 Sep 2022 13:11:45 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id c81so2743090oif.3;
        Thu, 29 Sep 2022 13:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PGDqjhxStxww23s/2xVm81CVyhARFEogzxBeLT1khFc=;
        b=7JZS3ErLQQSO6xjirj9otRJZ3+DTzfHG2YJIEYwn8AfmVhwTnjHJyUdQbpHAb71pEv
         eMxnjwKav5Vtq1Ady6bTXPhmyR1oN6t4RxLo0V3KgH9ogLsQB7CDUhf65IPA5kbfsNZl
         K+nT43Bd8SLy69m9ze/lxbGTvoXP6655uE4P5I4sZi4/EVOgMJCTyQc2aC4VqfowMvuY
         KtYZecZi8xuLzkFQspCqo82EMHAaOzNr4OEDeFbuZO/MR0O1VLAtLr+547L9WXv+fUKE
         v5ea5SfDVEt0sW4fBqEAUm7bcBo5nAKpD7w7JduGMu+KbdZufPt3ZrHd7ekJYIpmOb5K
         E15A==
X-Gm-Message-State: ACrzQf2uWMSIYBtVGGb1E4AwT5JS8MuHCGCFR/LAv7oUCE32QSGlE07o
        WG6lhxMu0ck72g1fuMUeKg==
X-Google-Smtp-Source: AMsMyM6WQHyfmtmD07CkTraCfJrS8YcjLQf9miLY8dWEL685eNb9amN/1gf8IoihH9kQ5Vl9znvxmA==
X-Received: by 2002:a05:6808:11c5:b0:34b:75dd:2ee9 with SMTP id p5-20020a05680811c500b0034b75dd2ee9mr2362842oiv.285.1664482305161;
        Thu, 29 Sep 2022 13:11:45 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r17-20020a4ae5d1000000b00476989d42ebsm100376oov.8.2022.09.29.13.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:11:44 -0700 (PDT)
Received: (nullmailer pid 2661159 invoked by uid 1000);
        Thu, 29 Sep 2022 20:11:44 -0000
Date:   Thu, 29 Sep 2022 15:11:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     vigneshr@ti.com, krzk@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: ti,j721e-pci-host: add
 interrupt controller definition
Message-ID: <166448230340.2661104.5023282722786734103.robh@kernel.org>
References: <20220924223517.123343-1-mranostay@ti.com>
 <20220924223517.123343-2-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924223517.123343-2-mranostay@ti.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 24 Sep 2022 15:35:16 -0700, Matt Ranostay wrote:
> Add missing 'interrupt-controller' property and related subnodes to resolve
> the following warning:
> 
> arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb: pcie@2910000: Unevaluated properties are not allowed ('interrupt-controller' was unexpected)
>         From schema: Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml  | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
