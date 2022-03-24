Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0194E6A14
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 22:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347569AbiCXVE7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 17:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347111AbiCXVE5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 17:04:57 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FD92E9FF;
        Thu, 24 Mar 2022 14:03:23 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 12so6157921oix.12;
        Thu, 24 Mar 2022 14:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q25spFCj2OPBzQfCV+Da/CWuMLQodxbTw+TkS6+i2hU=;
        b=XtVDAk2Q0RmKFIsJHKCpPJHygtgl6UsSECM0WtKrTNIa2wf6uCcGCSUXHffmHfKVQL
         Jnwl4jwKoABLp0R8Ut3Q8K0IbiWFnQMw3q4TD2MgEKRngCVJtyxN5P54JflUJcQgI1+Y
         5b8BN4lCvwaF3rgVRfQcncU4OVQLiFRR8VFk+fPiW88Z3UXII9q/XuELKZLsj2q1PZaJ
         BLGOR+VYyz9PgNwqeWSyEIIB6wGj7yJI+p32Jikb3VovSWkHNed2rlnzdXvfDU9ErvrT
         0FQ/0jqp+fe2BG9ndFC4sRRSrPlS/I/NEiqASs15JHXAR5gagHYfd+MtrAxfNIYg7pwW
         Wkhw==
X-Gm-Message-State: AOAM530T7VMzgkrOcH9Cw7Di2IWwnvI4ixpvegIOtHR7CpBnBFeur9kf
        lcu82EbSOG9LN+nSR66Y+A==
X-Google-Smtp-Source: ABdhPJzu1o2h/08FinAKWrwc0wvgq1Sj7A0Omdxcxve8G62Ja8afHn/d/gmFouU1Wtr1FSpHVCH5Pg==
X-Received: by 2002:a05:6808:1a9b:b0:2ec:9c38:185 with SMTP id bm27-20020a0568081a9b00b002ec9c380185mr8323647oib.165.1648155802614;
        Thu, 24 Mar 2022 14:03:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 2-20020a056870124200b000dd9ac0d61esm1812407oao.24.2022.03.24.14.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 14:03:21 -0700 (PDT)
Received: (nullmailer pid 2568899 invoked by uid 1000);
        Thu, 24 Mar 2022 21:03:20 -0000
Date:   Thu, 24 Mar 2022 16:03:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek: Fix refcount leak in
 mtk_pcie_subsys_powerup
Message-ID: <YjzcmAgS7twWntMf@robh.at.kernel.org>
References: <20220309091953.5630-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309091953.5630-1-linmq006@gmail.com>
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

On Wed, Mar 09, 2022 at 09:19:52AM +0000, Miaoqian Lin wrote:
> The of_find_compatible_node() function returns a node pointer with
> refcount incremented, We should use of_node_put() on it when done
> Add the missing of_node_put() to release the refcount.
> 
> Fixes: 87e8657ba99c ("PCI: mediatek: Add new method to get shared pcie-cfg base address")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
