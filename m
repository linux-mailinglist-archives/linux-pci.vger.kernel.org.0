Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF3737256
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 19:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjFTRJZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 13:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjFTRJY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 13:09:24 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B9D10DC;
        Tue, 20 Jun 2023 10:09:22 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-77e35504c1bso146226439f.1;
        Tue, 20 Jun 2023 10:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687280962; x=1689872962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13Dm6ish5ljtrNKR8ShIOYakHPs79RL05/Hxe+Nwj2s=;
        b=aAmQVyVyxBxtCffDi5CWaB1j0ivE7iyMG9tPNpX/1MlKguIrhoEWn8pleDTSVcQ/hw
         vF4Yj/dzfWsAHjPqLobNFiow6f+lt1JpeTkQmHET6EDOnOxrE436b1dYzqhOkd27ola+
         WfPI5CT/xzTmCEFMoxUvHHo4QJYXiDPRR4jBzCzw/jmiSbSElmDnGBxgMpatfo7WwgJE
         Dc2ksho2XXLUy2daj5t7eecjw9+kbNcy9YaNoOIEeJ69lB0JQisyrSVHq9jlGuxXobvb
         Gts2BdkPqvcnmdKY4UWD88tpZjPCHcqsxGY5+VFbVD9i5pzpydlfHbXFUdvhBrzokUJv
         wBnA==
X-Gm-Message-State: AC+VfDxyI88ldC00xxNr5bc4yN18KGqhsG5gruJzIEEMaUHwGV4SV4qP
        X9rTYdZo0IL69yuf4pCtbw==
X-Google-Smtp-Source: ACHHUZ5lP+cTWutXtE25nut8TrfmSUmgxv8iwy7NyrWlNqCqNPgb4GFtdJW/ia41WEsVOwU5fBbnCA==
X-Received: by 2002:a05:6602:2995:b0:777:a581:e0b4 with SMTP id o21-20020a056602299500b00777a581e0b4mr13657910ior.14.1687280960608;
        Tue, 20 Jun 2023 10:09:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h1-20020a5e8401000000b0077e35ffac2fsm780858ioj.32.2023.06.20.10.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:09:19 -0700 (PDT)
Received: (nullmailer pid 3834673 invoked by uid 1000);
        Tue, 20 Jun 2023 17:09:18 -0000
Date:   Tue, 20 Jun 2023 11:09:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Subject: Re: [PATCH v1 2/4] dt-bindings: PCI: dwc: rockchip: Add missing
 legacy-interrupt-controller
Message-ID: <20230620170918.GA3833779-robh@kernel.org>
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
 <20230616170022.76107-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616170022.76107-3-sebastian.reichel@collabora.com>
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

On Fri, Jun 16, 2023 at 07:00:20PM +0200, Sebastian Reichel wrote:
> Rockchip RK356x and RK3588 handle legacy interrupts via a ganged
> interrupts. The RK356x DT implements this via a sub-node named
> "legacy-interrupt-controller", just like a couple of other PCIe
> implementations. This adds proper documentation for this and updates
> the example to avoid regressions.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index 98e45d2d8dfe..bf81d306cc80 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -67,6 +67,22 @@ properties:
>        - const: legacy
>        - const: err
>  
> +  legacy-interrupt-controller:
> +    description: Interrupt controller node for handling legacy PCI interrupts.
> +    type: object

       additionalProperties: false

With that, 

Reviewed-by: Rob Herring <robh@kernel.org>
