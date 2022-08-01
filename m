Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCE58727A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 22:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiHAUvc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 16:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiHAUvc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 16:51:32 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73373BE3D;
        Mon,  1 Aug 2022 13:51:31 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id o2so9299758iof.8;
        Mon, 01 Aug 2022 13:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qgUhYsG/SYQmVu/9j7OPoFS1V3zLSqEU7jYdb6tWXhY=;
        b=0sHBpclR+IHBBMBuB8FkRxYFhJBvHRbN5vl/igSD56k9PzpdhSMvudfw2IQuMJgNvR
         Kv+6m0Nd8KnIunEpcFqm4IuwP8YD3APHHdhQhWP1ccInmWX68XKGr5RoNIgWBl5hOUIN
         e9xFCWpwVAHpA++3Ggdwu+0clVHJfAsa22FiYCYPp77BVuJe5UdPajGuGb1SAm8E3oID
         JfBA2nog/TwOKfY9pEA9MnPeWcaeMfsjasHvTgBLKjcBBHEs3H6oinUBMs0N15SJzWKL
         O1BDNeW+8qTRYjy4y4Kiu1HvmbpHS4bTleh8qbKe/nfTbL25RfWClEhNjFJyj2As+eaU
         BJcg==
X-Gm-Message-State: AJIora+PApn6WkbEZXhVwEwVoDheqPnpxuo/+7iq77HVve6B6ByeUgmi
        hIgimvszogqar3JMwAh9OfuuU4Aa5g==
X-Google-Smtp-Source: AGRyM1tnJuzsCSZNhFYqrZAkbxWwxTjobiIrgH/A29DqVlb0dQa0BjGPlS97Edwzw8MIDswVZ4j+mg==
X-Received: by 2002:a05:6638:1508:b0:342:3f57:290a with SMTP id b8-20020a056638150800b003423f57290amr6991377jat.279.1659387090698;
        Mon, 01 Aug 2022 13:51:30 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a15-20020a056638018f00b0034142dad202sm5797270jaq.31.2022.08.01.13.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 13:51:30 -0700 (PDT)
Received: (nullmailer pid 1487097 invoked by uid 1000);
        Mon, 01 Aug 2022 20:51:29 -0000
Date:   Mon, 1 Aug 2022 14:51:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: host-generic-pci: Allow IOMMU and MSI
 properties
Message-ID: <20220801205129.GA1487043-robh@kernel.org>
References: <20220728175137.1172841-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728175137.1172841-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Jul 2022 11:51:37 -0600, Rob Herring wrote:
> Allow 'iommu-map', 'iommu-map-mask', and 'msi-parent' properties for
> generic host. This fixes unevaluated property warnings on Arm Juno, AMD
> Seattle, and FSL LS1028a.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
