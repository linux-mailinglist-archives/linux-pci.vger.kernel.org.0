Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2833A6EB154
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 20:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjDUSEW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 14:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjDUSEJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 14:04:09 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68795C5;
        Fri, 21 Apr 2023 11:04:08 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6a437526b7cso2123734a34.1;
        Fri, 21 Apr 2023 11:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682100247; x=1684692247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co8FuF/c7gAHcCMjkVAi9/q3BiFxF8PNVGRX/kGO2qM=;
        b=ToYKNvXrHzodHx1P5xep1z2DkwX3p4jnovK97hoaWu5fBN3yNBkIw+/jU+Ku9IiaG3
         oCkNUrdB2M0JmQGGyjYCuEpeTsD6AMLOXCFYQ5FdKLy8ispoQZJvAI95oiAZc+Ivf2fM
         ZXoQs8PmM9Oyby3dkqFvfutpC7MKVmXqC0ReFewbdqX9Vg1YF2YMFzGXS5B9xe8KEmBm
         RzI5P5Cy5DbNxMaEzXsp+VWQ3jM7AqmWab5LpCL/NdXR8VJ5P9niSnFhSlL6eosyZvNM
         ZbTNs7t8TvmzSBwZ/9Ya96JormacyVp3apq5SBNbowGtlg2Sfgw3ilHj9w2Jh7odHZ8k
         MP2A==
X-Gm-Message-State: AAQBX9fd7UHbH67YqxFA84EsivInuhR+cWCIOmv95MkbNnyaOzVr/Ucq
        0ZjC9zQVFSf/u491dlfNKA==
X-Google-Smtp-Source: AKy350b90WVQIgDMVoGX/eXhcr5LX9Nl02T1b/9WRvffRkjKaJKT+ujN9ynrH6QEh/f6dMog/WyyiQ==
X-Received: by 2002:a9d:6d95:0:b0:6a5:b8e0:d62a with SMTP id x21-20020a9d6d95000000b006a5b8e0d62amr3112088otp.27.1682100247667;
        Fri, 21 Apr 2023 11:04:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t4-20020a9d66c4000000b006a4244d2a7asm239565otm.9.2023.04.21.11.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 11:04:07 -0700 (PDT)
Received: (nullmailer pid 1557202 invoked by uid 1000);
        Fri, 21 Apr 2023 18:04:06 -0000
Date:   Fri, 21 Apr 2023 13:04:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     robh+dt@kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, marek.vasut+renesas@gmail.com,
        fancer.lancer@gmail.com, kw@linux.com, jingoohan1@gmail.com,
        kishon@kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        bhelgaas@google.com, mani@kernel.org
Subject: Re: [PATCH v13 16/22] dt-bindings: PCI: dwc: Update maxItems of reg
 and reg-names
Message-ID: <168210024605.1557152.8860596690613716414.robh@kernel.org>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-17-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418122403.3178462-17-yoshihiro.shimoda.uh@renesas.com>
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


On Tue, 18 Apr 2023 21:23:57 +0900, Yoshihiro Shimoda wrote:
> Update maxItems of reg and reg-names on both host and endpoint
> for supporting a new SoC later.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 4 ++--
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

