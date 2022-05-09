Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2508E520551
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 21:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbiEITb2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 15:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240608AbiEITb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 15:31:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5697C277;
        Mon,  9 May 2022 12:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A202B8190E;
        Mon,  9 May 2022 19:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC31C385B8;
        Mon,  9 May 2022 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652124451;
        bh=LHhMugA56ra1E/f4M4s+HXIm7ikQL8aa6G58KTVtBz4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h2xt4MIT0hq1byYBVWoaJFVZH1PqfmapTHYVbY4QF1GfBw0gWYpkJvffxYVJROp/w
         o5e5XlseTtAbyczalx8WZma7nau3776eEMiPnAb+aH7DGy0paSceaMMK2NgH7mDaq7
         V6qTzsl90AZuCQCvlnnxzD8SWTPrbuwvdWXVVtFaMT3bvb+XpjRevOipjIyd5LJ+QM
         5lmV1PyqZUkQhLRASuo/BMjBfrdnF6ogjqVZ5ErYdH/2BTdCsGCeE1sWNtQT8ooI2a
         1MGt9OfEic40lzbwntnx56i0TY8f3A/Y94vuuNcULimj4Higp6KJ9f0rpfeGaAwk44
         BUgdRk+a2pzvw==
Received: by mail-pl1-f179.google.com with SMTP id j14so14800996plx.3;
        Mon, 09 May 2022 12:27:31 -0700 (PDT)
X-Gm-Message-State: AOAM531f9bsYZJMpKqUmdf0NYCNlt6bO0bCfARm12OJf+46qQCGNjslO
        06P5XsNNjEfQ5A6fiuh8/3Jh0fXWF5smmndZUQ==
X-Google-Smtp-Source: ABdhPJxsHGmg1x9eSAFKq3936wK9SVxFgpdBQ4tMi6tmOw4dHd/EQlYww4Lzlp1GP6qEzY5zGXKq8YCcknR/kaYKZuM=
X-Received: by 2002:a17:902:9345:b0:15f:186b:e478 with SMTP id
 g5-20020a170902934500b0015f186be478mr4219682plp.117.1652124450742; Mon, 09
 May 2022 12:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <35661036a7e4160850895f9b37f35408b6a29f2f.1652091160.git.robin.murphy@arm.com>
In-Reply-To: <35661036a7e4160850895f9b37f35408b6a29f2f.1652091160.git.robin.murphy@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 May 2022 14:27:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLSt4n2LMC_Rcz01jYdzeAVM0aodBibSNxOcqt1m0vJfw@mail.gmail.com>
Message-ID: <CAL_JsqLSt4n2LMC_Rcz01jYdzeAVM0aodBibSNxOcqt1m0vJfw@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/dma: Explicitly sort PCI DMA windows
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 9, 2022 at 5:16 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Originally, creating the dma_ranges resource list in pre-sorted fashion
> was the simplest and most efficient way to enforce the order required by
> iova_reserve_pci_windows(). However since then at least one PCI host
> driver is now re-sorting the list for its own probe-time processing,
> which doesn't seem entirely unreasonable, so that basic assumption no
> longer holds. Make iommu-dma robust and get the sort order it needs by
> explicitly sorting, which means we can also save the effort at creation
> time and just build the list in whatever natural order the DT had.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> v2: Clean up now-unused local variable
>
>  drivers/iommu/dma-iommu.c | 13 ++++++++++++-
>  drivers/pci/of.c          |  8 +-------
>  2 files changed, 13 insertions(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
