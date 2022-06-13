Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A642C54A14A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 23:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbiFMVXQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 17:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352256AbiFMVXG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 17:23:06 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A613921A6;
        Mon, 13 Jun 2022 14:09:32 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id e80so7446781iof.3;
        Mon, 13 Jun 2022 14:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cg0d1+ouTX0eBZRpIRt4D0XN+6+hS9B34O3oHEu1R4A=;
        b=P9GTD5NU4Q8mjcJh6k0zqhe8KUNSzYRqlpshzDN2MeLqn6DXif3YRRyCOfl5UY3Fls
         vOnucSLlXjppSmWN7tSQhPce8uSoQrDAhkYq4PyLpNC8wZ9y6OmTR95GJ+V+4MBQF/pl
         ngE61ciMOQFfZjuUdIbm4pt85cheHtxFFSzrNxttwFVvD7M/hDMaXAO4jhdM8gbIbvQ9
         jmEP5td5Yy0y1psmJPp0xv2RI2iABgZFovEbsQqRCWBXDjf05869Zh73IRIsuWLzNDmt
         hf3HBZ6mW4GrF6/BuNDMK3aVBIKJaYdgQHmdnTIe1vgM2f1wlQo6X27zUb9zGEfPw2jV
         up3A==
X-Gm-Message-State: AOAM531o//s49P3x6KkMBHXL41HdgM9Xnkwnr8Ui44zontCaoOGTGs9K
        pOouPvGnXo+ATuU3LI5DGg==
X-Google-Smtp-Source: ABdhPJwGqBxe1KfTw9CYHXQYZMQALlxJ1yAKiy9RitPGOvhCBz/2qSQEy4Es0iL8V51N3Kc8wfNS5Q==
X-Received: by 2002:a05:6638:438c:b0:331:adac:a274 with SMTP id bo12-20020a056638438c00b00331adaca274mr1035193jab.192.1655154571635;
        Mon, 13 Jun 2022 14:09:31 -0700 (PDT)
Received: from robh.at.kernel.org ([69.39.28.171])
        by smtp.gmail.com with ESMTPSA id l11-20020a02390b000000b003320e4b5bb7sm700175jaa.57.2022.06.13.14.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:09:31 -0700 (PDT)
Received: (nullmailer pid 89813 invoked by uid 1000);
        Mon, 13 Jun 2022 21:09:29 -0000
Date:   Mon, 13 Jun 2022 15:09:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] PCI: dwc: Fix MSI msi_msg dma mapping
Message-ID: <20220613210929.GA87830-robh@kernel.org>
References: <20220525223316.388490-1-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525223316.388490-1-willmcvicker@google.com>
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

On Wed, May 25, 2022 at 10:33:16PM +0000, Will McVicker wrote:
> As of commit 07940c369a6b ("PCI: dwc: Fix MSI page leakage in
> suspend/resume"), the PCIe designware host driver has been using the
> driver data allocation for the msi_msg dma mapping which can result in
> a DMA_MAPPING_ERROR due to the DMA overflow check in
> dma_direct_map_page() when the address is greater than 32-bits (reported
> in [1]). The commit was trying to address a memory leak on
> suspend/resume by moving the MSI mapping to dw_pcie_host_init(), but
> subsequently dropped the page allocation thinking it wasn't needed.
> 
> To fix the DMA mapping issue as well as make msi_msg DMA'able, let's
> switch back to allocating a 32-bit page for the msi_msg. To avoid the
> suspend/resume leak, we can allocate the page in dw_pcie_host_init()
> since that function shouldn't be called during suspend/resume.
> 
> [1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/
> 
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
>  2 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
