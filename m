Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B66763DC79
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 18:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiK3Rwz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 12:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiK3Rww (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 12:52:52 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A8D218F;
        Wed, 30 Nov 2022 09:52:51 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id s141so1831527oie.10;
        Wed, 30 Nov 2022 09:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSlps2lO6kCxeY6Q9GE4IYnCWFyrr/PGTU9AP8KVTOU=;
        b=BdqdwvuxZed+uxbWHNp2ciRAeuu9XctVJ1z6ESLwVj51sv4iS61SSPyIOg2RhPQmf/
         MsqzIFCeWBdI6BAkkbQSnmPYs0T7znlFQVRj8mbkAbdkTat0UTH1KSLk4iJ+5N+/Js3y
         +dT/lp4aP9ggsLbkF8EDSyTU5YfbWPQhvILDbu/1O2yLsjtTmn4PqJWP92GnnLqqCqSS
         imDIGIEKtRg37yB44qk2gmMH+GwS/Ec5M72f2rUOudiY85Tl1O9/GNDan1UJ3UZO3BYG
         C5mSffDeEqBbQVtIytvnQysP/Aa4NqSIxQqjAtaspBd4R5abrWWVW9CR3TtCM9FfMK7f
         1vaQ==
X-Gm-Message-State: ANoB5pm0q08aFqdS7WpRSFQgGjmidJ/dzt+ewhUWpdK3OSpWd/XGne8b
        ZoGTKDparQYsSDmXZhkV8UySUcVfKA==
X-Google-Smtp-Source: AA0mqf6haeFjN9z5n+Ry7PT0y+LyzMDXnOYGF7JGBkzg+/Ez7jTH186tItTcf9QGXPvoZD1q9xtz1w==
X-Received: by 2002:aca:1705:0:b0:35a:528b:d6e8 with SMTP id j5-20020aca1705000000b0035a528bd6e8mr31333729oii.146.1669830770480;
        Wed, 30 Nov 2022 09:52:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t15-20020a056808158f00b00353fe4fb4casm858126oiw.48.2022.11.30.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 09:52:50 -0800 (PST)
Received: (nullmailer pid 2517901 invoked by uid 1000);
        Wed, 30 Nov 2022 17:52:49 -0000
Date:   Wed, 30 Nov 2022 11:52:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        =?utf-8?q?=2C?=linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: PCI: qcom: Add sm8350 to bindings
Message-ID: <166983076821.2517843.6476270112700027226.robh@kernel.org>
References: <20221118233242.2904088-1-dmitry.baryshkov@linaro.org>
 <20221118233242.2904088-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118233242.2904088-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Sat, 19 Nov 2022 01:32:35 +0200, Dmitry Baryshkov wrote:
> Add bindings for two PCIe hosts on SM8350 platform. The only difference
> between them is in the aggre0 clock, which warrants the oneOf clause for
> the clocks properties.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
