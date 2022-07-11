Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B9B570A51
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 21:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiGKTGc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 15:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGKTGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 15:06:31 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E113AB15;
        Mon, 11 Jul 2022 12:06:30 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id n68so5830561iod.3;
        Mon, 11 Jul 2022 12:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wX41LN3dh2u+0svUHznNTjjMf2ePSwJL9NLtwCrMQKk=;
        b=iOaxbZ9QrsrVa8N2i0VlcHDpkj68RooUqnlVqK6lIr+uhD9mqrEWm8LbExG/BbuK5T
         A3lEPwXggrzdqsfJx3EFAqe38cb30I0/QtnQfrI5ty+ofDDtyx0DnrerRoVHyvBM40o0
         /KKccfZiClDW9hMcbV3TuK/Kk1q8Xxrwde/yZQTuWDlmakla6BnTN9g/2UoCVwOl+RWN
         FH3pcu+bDD5H7cRHjaGt/fU+lMKqgFHU2zA4MdFUZHI/7bPlajnA7t0EHTxiwGQN2Wy/
         2LcTnthDjaykAB6g4z9PE5DOIyhVj86M2i6c98GfK7hehJEbptDaq+lyDQj4phhx6jX2
         8o9A==
X-Gm-Message-State: AJIora/iDXRrZK1dL75J+zHuO066c1De0TY+twzxD3s95H8P+uwbheUx
        uEgvBLRDsPtY5o0FVkkrqw==
X-Google-Smtp-Source: AGRyM1sITpaBuLTT490LtsBJlqETbA4AxHOpMxSRW3v9+E50WM+H560Ga9sgY9mPYWD3uIA5/cpgaA==
X-Received: by 2002:a5d:9919:0:b0:675:48c7:d959 with SMTP id x25-20020a5d9919000000b0067548c7d959mr10346592iol.27.1657566389975;
        Mon, 11 Jul 2022 12:06:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r1-20020a02aa01000000b0033cd78a3612sm3200699jam.18.2022.07.11.12.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 12:06:29 -0700 (PDT)
Received: (nullmailer pid 103083 invoked by uid 1000);
        Mon, 11 Jul 2022 19:06:28 -0000
Date:   Mon, 11 Jul 2022 13:06:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, geert+renesas@glider.be,
        lpieralisi@kernel.org, kw@linux.com, magnus.damm@gmail.com,
        devicetree@vger.kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v3 08/13] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Message-ID: <20220711190628.GA103026-robh@kernel.org>
References: <20220701085420.870306-1-yoshihiro.shimoda.uh@renesas.com>
 <20220701085420.870306-9-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701085420.870306-9-yoshihiro.shimoda.uh@renesas.com>
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

On Fri, 01 Jul 2022 17:54:15 +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe endpoint module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
