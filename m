Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC0254CEA5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 18:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245548AbiFOQaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiFOQaH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 12:30:07 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970373CA73;
        Wed, 15 Jun 2022 09:30:06 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id s1so9185098ilj.0;
        Wed, 15 Jun 2022 09:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yjh1+r7kQKkklBAX8yt4ws0m3hqB7N6WBb2gIQuSFOk=;
        b=Pk/RCFm1tYc85Xx1TpHMfBLo6a4Kl7vUnokDRgpLWXJ8k+xfXc4i31TJ0jXCaztjR6
         yS7NIEt8gwHBds/qOc5NGq0z2x9PiEV8P4rFmz3g6lhUEYQ2fFM4TskZskODQkgmQc2b
         YQelQhcS1F1PXwi4Dyty/5kOn7P9X1knyjRgJ07f4ZGEcORqfRTqKNIQIzX2gxpa1YlP
         qEzokWYUS2YAl3VHRQr5LMVjd0ah+VwA4Gvp03zaoNdhmNkC2oi7f+Du7sBcWEyxhAdr
         v5U3UYw0bp6BZrHxvmGqN1PoRiY2lO9YGoUT/0bWnvOjKuE4kWGJacNQfD4taKHm9q7A
         pqPA==
X-Gm-Message-State: AJIora/Kad33BxqGgh2m5YF9TptCI6JW9zH5kvAm9IhVB+69cqXOql0/
        dbcYht0518Pq8V1n4f4oLA==
X-Google-Smtp-Source: AGRyM1tU2NMW3KY2z9dvAu+gMiHcE3NGahsP0X2Zu86k3z+l6tTjVbND7nRlT6zHhpafdmi8QTCg3A==
X-Received: by 2002:a92:cd41:0:b0:2d6:6553:db13 with SMTP id v1-20020a92cd41000000b002d66553db13mr355984ilq.307.1655310605859;
        Wed, 15 Jun 2022 09:30:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c26-20020a02c9da000000b0032e2dce10aesm6296145jap.160.2022.06.15.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:30:05 -0700 (PDT)
Received: (nullmailer pid 1393969 invoked by uid 1000);
        Wed, 15 Jun 2022 16:30:03 -0000
Date:   Wed, 15 Jun 2022 10:30:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v3 02/17] dt-bindings: PCI: dwc: Remove bus node from the
 examples
Message-ID: <20220615163003.GA1393851-robh@kernel.org>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610085706.15741-3-Sergey.Semin@baikalelectronics.ru>
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

On Fri, 10 Jun 2022 11:56:50 +0300, Serge Semin wrote:
> It's absolutely redundant seeing by default each node is embedded into its
> own example-X node with address and size cells set to 1.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch unpinned from the next one:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
>   by the Rob' request. (@Rob)
> ---
>  .../bindings/pci/snps,dw-pcie-ep.yaml         | 16 ++++-----
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 35 ++++++++++---------
>  2 files changed, 24 insertions(+), 27 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
