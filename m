Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8E2535385
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 20:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbiEZSoH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 14:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbiEZSoG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 14:44:06 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02652E089;
        Thu, 26 May 2022 11:44:05 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e656032735so3278548fac.0;
        Thu, 26 May 2022 11:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wKj6c5x0G9h14gAgRjlnIg1V0UzbG9yv5fvPYLIplQo=;
        b=Ryv3drFzY/XSEIhLv2ocx9CKapu1sw+dmgsekHNYNnsUnM3l8ctBrsy14VpcD82kKc
         9+MUOb+x24clSOR7DI05Hdvr2Ui8FWQmtGYXV1mhNnnfvBtuxcF5zcVwhU9ll4qPhQpX
         Yzz3fvZG2e8xR81Hop0gVmJ6wvDJI828EXfbuUaJQmxB3TaoYJKlsxUNEROLYk3/vgQL
         hFdoofsrvLZU255O7t4HmusT8Up4DbcQwwG5viH4iW3LtkHsKS9TjBM8ZWigImkMD4kE
         X63iLhqhSZddlMAse0/qaZsA5XAfR0QAbadaGfhz3txx2YbdOxXEbUc8DZP2fMBf99e9
         0R0Q==
X-Gm-Message-State: AOAM530y6rIgyUO9sAspB0AmJia3OsiQWNisAqB59+DRrah+l0FhQKpr
        PU82gWRJ1GKzOUG5ij/50Q==
X-Google-Smtp-Source: ABdhPJzho6DAQtfhK29KwkbvdvgM75vBci2yXDAGyEUMQN/OE+K8Nq9EEeEbXUewJq8apWsKJGzRMw==
X-Received: by 2002:a05:6870:e409:b0:f2:4cf4:f187 with SMTP id n9-20020a056870e40900b000f24cf4f187mr2025157oag.154.1653590643624;
        Thu, 26 May 2022 11:44:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z10-20020a9d468a000000b0060603221235sm926121ote.5.2022.05.26.11.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:44:02 -0700 (PDT)
Received: (nullmailer pid 125873 invoked by uid 1000);
        Thu, 26 May 2022 18:44:01 -0000
Date:   Thu, 26 May 2022 13:44:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek-gen3: Fix refcount leak in
 mtk_pcie_init_irq_domains
Message-ID: <20220526184401.GG54904-robh@kernel.org>
References: <20220526110246.53502-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526110246.53502-1-linmq006@gmail.com>
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

On Thu, May 26, 2022 at 03:02:46PM +0400, Miaoqian Lin wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 814cceebba9b ("PCI: mediatek-gen3: Add INTx support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
