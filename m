Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D64D518F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 20:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbiCJTOg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 14:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbiCJTOg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 14:14:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A332C14FFF0;
        Thu, 10 Mar 2022 11:13:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A604B8279C;
        Thu, 10 Mar 2022 19:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAB2C340F5;
        Thu, 10 Mar 2022 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646939612;
        bh=MFqvsPhJ5FQFN9ZJ8GxngZigWjLHIqTL7/ZSq+djCtY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QE+FlqFj2DYnzMMFwVfj3vAw6KWI1HM2OxSGexXLiAmnLSSEumiNtLCf4h+1Ad614
         98I8Cvv4D6VJkkfB1Dym2hn/e1JbR4lelLfzqlQMRdrn0kO2HPdUbj8W6W123F1/nL
         sIYCZuH0OPRbE56YoOkrj9TsmMpvUepi3Bk9uYYi2h7y2xeT1C3L0+kywPJWYYHAAL
         2SrZk6ylTk8iemDXLZhnVFAWR/TYuqjLrWFWzTszrzkjjTdL/uUVLp4Lyk6v5WFfDL
         rkUEoPiOl46GdwirsruolkbT/JRXfUaS6hxO1fCc5CqnhGgdk427GchL/6a3vsm0PU
         vvnX0RUL/Khqg==
Received: by mail-ej1-f48.google.com with SMTP id kt27so14390112ejb.0;
        Thu, 10 Mar 2022 11:13:31 -0800 (PST)
X-Gm-Message-State: AOAM532Uu0kwIOH5Rgp0TJie6DxZuc6n8IlN0QqxYfFes0ZmWHC8cr4q
        tpO6MEVEpELzYx4jvagonY+0Cm6YZtb9E5UYog==
X-Google-Smtp-Source: ABdhPJw/7Hn8wBEKMu7V2R+odPO0hI5sV48PqGvd1xtKQ39XTlRkabyhzSktXJv26NsRfyOT74sdCDYTis/v/9pA1e4=
X-Received: by 2002:a17:907:298f:b0:6da:b3da:19e with SMTP id
 eu15-20020a170907298f00b006dab3da019emr5542466ejc.423.1646939610179; Thu, 10
 Mar 2022 11:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20220309120025.6721-1-bharat.kumar.gogada@xilinx.com> <20220309120025.6721-2-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <20220309120025.6721-2-bharat.kumar.gogada@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Mar 2022 13:13:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL3CSERnTihfc_CKB96bbdN2xxkb78H383pMfC_bGg+Xw@mail.gmail.com>
Message-ID: <CAL_JsqL3CSERnTihfc_CKB96bbdN2xxkb78H383pMfC_bGg+Xw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michals@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 9, 2022 at 6:00 AM Bharat Kumar Gogada
<bharat.kumar.gogada@xilinx.com> wrote:
>
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functioning at Gen5 speed.
>
> Add support for YAML schemas documentation for Versal CPM5 Root Port driver.
>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 47 ++++++++++++++++---
>  1 file changed, 40 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index 32f4641085bc..97c7229d7f91 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -14,17 +14,21 @@ allOf:
>
>  properties:
>    compatible:
> -    const: xlnx,versal-cpm-host-1.00
> +    contains:

Nope. That means 'compatible = "foo", "xlnx,versal-cpm-host-1.00",
"bar";' would be valid.

> +      enum:
> +        - xlnx,versal-cpm-host-1.00
> +        - xlnx,versal-cpm5-host-1.00

Where does 1.00 come from? My guess is you or whoever did the original
binding just made it up. Version numbers are only used when they
correspond to something documented for the h/w. In the case of Xilinx,
that should be soft IP (which I assume has versioned releases) and
nothing else. If 'versal' is not specific enough to identify a
specific SoC, then add to it.


>    reg:
> -    items:
> -      - description: Configuration space region and bridge registers.
> -      - description: CPM system level control and status registers.
> +    description: |
> +      Should contain cpm_slcr, cfg registers location and length.
> +      For xlnx,versal-cpm5-host-1.00, it should also contain cpm_csr.

Not an improvement in defining what each entry is.

> +    minItems: 2
> +    maxItems: 3
