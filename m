Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F1D6D69E3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjDDRJh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 13:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjDDRJg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 13:09:36 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946E0CF;
        Tue,  4 Apr 2023 10:09:35 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id bj20so24721267oib.3;
        Tue, 04 Apr 2023 10:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6H1CnmaYD1ILwp+VcjbZQm8EbJhKwj2OJVE8FjdAMCw=;
        b=JzQHB5DS/6nydDyXoBHoauN/7ZnzfHiZxyvHrdxFSDgxfFOtg7f35VVTI62ymdmO49
         p/yPZlkSkRdO/3EugLNXubTa/2S7lI8HXf/FX1A+XPHlSWDsAoli0Eg8h1aClZxMJ7UD
         jCUWLhgCya3hIM/lCx0gzTPL81zIYjiiFchyG6a1+9g1dtbmj/7rd9ktS56zhyRsPn4p
         wUG0cJ0XA9K49llu1+af3k7vX59NHTRbUGYNbq32SKVMkgF9Kf7SwMDFqVqbioAl6fFk
         HUqIvlFQMdbhGcLncb9aUjti55K2xOgehx04dtrKfvHTjUnfETpXX9/OV7lL+u6WSyxW
         a0zA==
X-Gm-Message-State: AAQBX9cx0MX4/cZr8f2m+uTb62gn2sessJjHUwuJ0ZfinrCzXt3YOjM5
        rb92Pb5NQ91G4cAbwQh0WJXNjPptOg==
X-Google-Smtp-Source: AKy350bzXz+KM07Z6ghxSIozeb5vXQ9jMix/XK+MQYxeeXeuQgAj8RDRawgpUHIYTNQcxAvMuDSwsg==
X-Received: by 2002:a05:6808:68e:b0:389:14bd:8246 with SMTP id k14-20020a056808068e00b0038914bd8246mr76571oig.13.1680628174494;
        Tue, 04 Apr 2023 10:09:34 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i185-20020aca3bc2000000b003848dbe505fsm5382750oia.57.2023.04.04.10.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:09:33 -0700 (PDT)
Received: (nullmailer pid 130248 invoked by uid 1000);
        Tue, 04 Apr 2023 17:09:32 -0000
Date:   Tue, 4 Apr 2023 12:09:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: Drop unneeded quotes
Message-ID: <20230404170932.GE49361-robh@kernel.org>
References: <20230320233911.2920364-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320233911.2920364-1-robh@kernel.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 20, 2023 at 06:39:11PM -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml        | 2 +-
>  .../devicetree/bindings/pci/cdns,cdns-pcie-host.yaml      | 2 +-
>  Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml   | 8 ++++----
>  Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml | 8 ++++----
>  Documentation/devicetree/bindings/pci/cdns-pcie.yaml      | 4 ++--
>  .../devicetree/bindings/pci/intel,keembay-pcie-ep.yaml    | 4 ++--
>  .../devicetree/bindings/pci/intel,keembay-pcie.yaml       | 4 ++--
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml   | 2 +-
>  .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml          | 6 +++---
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml        | 6 +++---
>  .../bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml     | 4 ++--
>  11 files changed, 25 insertions(+), 25 deletions(-)

Applied, thanks.
