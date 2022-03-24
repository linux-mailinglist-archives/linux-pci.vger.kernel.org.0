Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1EF4E5C7F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 01:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbiCXA5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 20:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbiCXA5I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 20:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211BB559B
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 17:55:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B21FE6190F
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 00:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25258C36AE9
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 00:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648083337;
        bh=Y0on+fjdMzikugBt55YCOFCiUxO2vyhhnfZ1+tZj3dM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YbgA8cNEkOuzUPh9PdBF+YfFt1LYibT6+Ty2RvBN2xiDZ0J6uoPuExioJsIUlM2Xi
         btPcoPpxpLU2vae+NgcGO1sV9/N3pfb2xN09MVKaFYsFj2ir5u+yPQmdc931mP8BWc
         dUfLnsULyuPzjQ6nUjE8CHOEj454uePbpUDn0NTx9GhTuaG8yim7zIn58nuphAGmVU
         cTIk5H5Nmk0WlBiB+llVc1EjCRUEd1eKMdb0Q/OpWdJLtKa/rjetOQo6Oypuro9i8Z
         4QZGYUOv7yvfB+bQvCBVn/1J8PGE63EC/kPAfT0Q36k9uihQUQkEib8L7eObwu9qqP
         nmua1yTbwzAiQ==
Received: by mail-ed1-f45.google.com with SMTP id r23so3890564edb.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 17:55:37 -0700 (PDT)
X-Gm-Message-State: AOAM531FfwFLRUo/DbFhqPSNMpEvgUbQ0AnTOSyXbu3q8N5cmaQaQHRZ
        YgHfx3QFs6ITrLPKtV7tVhevAMNZKW4cJyI+dQ==
X-Google-Smtp-Source: ABdhPJx1W8QOEZ5hwqRlDF/QFZDT+YJ7hcxbg7cfyRwDqZy6yyOAfpfXWiF/SIW30v36rh26i+KiOFb4/HbLsjBblEc=
X-Received: by 2002:a05:6402:686:b0:418:edaa:9cbc with SMTP id
 f6-20020a056402068600b00418edaa9cbcmr3676164edy.67.1648083335299; Wed, 23 Mar
 2022 17:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <65657c5370fa0161739ba094ea948afdfa711b8a.1647967875.git.robin.murphy@arm.com>
 <874k3pxalr.wl-maz@kernel.org> <Yjub51Ct3esuNA9B@xps13.dannf>
In-Reply-To: <Yjub51Ct3esuNA9B@xps13.dannf>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Mar 2022 19:55:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLFnN46WixKwsuhPswNo8fye4ERhU7_hPdPABi=70p7HA@mail.gmail.com>
Message-ID: <CAL_JsqLFnN46WixKwsuhPswNo8fye4ERhU7_hPdPABi=70p7HA@mail.gmail.com>
Subject: Re: [PATCH] iommu/dma: Explicitly sort PCI DMA windows
To:     dann frazier <dann.frazier@canonical.com>
Cc:     Marc Zyngier <maz@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 23, 2022 at 5:15 PM dann frazier <dann.frazier@canonical.com> wrote:
>
> On Wed, Mar 23, 2022 at 09:49:04AM +0000, Marc Zyngier wrote:
> > On Tue, 22 Mar 2022 17:27:36 +0000,
> > Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > Originally, creating the dma_ranges resource list in pre-sorted fashion
> > > was the simplest and most efficient way to enforce the order required by
> > > iova_reserve_pci_windows(). However since then at least one PCI host
> > > driver is now re-sorting the list for its own probe-time processing,
> > > which doesn't seem entirely unreasonable, so that basic assumption no
> > > longer holds. Make iommu-dma robust and get the sort order it needs by
> > > explicitly sorting, which means we can also save the effort at creation
> > > time and just build the list in whatever natural order the DT had.
> > >
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >
> > > Looking at this area off the back of the XGene thread[1] made me realise
> > > that we need to do it anyway, regardless of whether it might also happen
> > > to restore the previous XGene behaviour or not. Presumably nobody's
> > > tried to use pcie-cadence-host behind an IOMMU yet...
> >
> > This definitely restores PCIe functionality on my Mustang (XGene-1).
> > Hopefully dann can comment on whether this addresses his own issue, as
> > his firmware is significantly different.
>
> Robin, Marc,
>
> Adding just this patch on top of v5.17 (w/ vendor dtb) isn't enough to
> fix m400 networking:

I wouldn't expect it to given both the IB register selection changed
and the 2nd dma-ranges entry is ignored.

Can you (and others) try out this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git xgene-pci-fix

It should maintain the same IB register usage for both cases and
handle the error in 'dma-ranges'.

Rob
