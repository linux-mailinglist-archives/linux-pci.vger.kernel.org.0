Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B94E5D6D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 04:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiCXDLS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 23:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiCXDLR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 23:11:17 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0A090FDA
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 20:09:46 -0700 (PDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B61743F6C6
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 03:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1648091384;
        bh=yfWPx49ia0Oq9KnR/zdf6cTRm4Fx3KUjs75NQ5Bs2aQ=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=PJP5cKoML4n19Ls2rhrajAqXHps4CzA89rrHFiXiMpPb/Ihu6cMcy8l34L9mEESBb
         L1wXG51NhCrEfjAXN85JbdgrlHkSdUx0/wyZPu3yoLG2+5NG7anK/7QGtagg8qUep/
         Bs3lNRkUgqvNXwinVSDDzzGMx0LMP8AVmPdd9aaZ0Z3tyO+deOHa3SoXez4QjF9Es8
         VKbL5BrPfepvKEYJZcZ+Lw2EY0gEbzikSt25QK2h1D38xGSBtSI9D3++UNBItBRA0V
         sPnqOVmFHUXwD7gfrmZvCdJI6pTxqXcgt23Z9una8LveqjVlTaD/o/21SRyG7oXFVw
         6UJkmxJfqTsRA==
Received: by mail-io1-f70.google.com with SMTP id z10-20020a056602080a00b00645b9fdc630so2310063iow.5
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 20:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yfWPx49ia0Oq9KnR/zdf6cTRm4Fx3KUjs75NQ5Bs2aQ=;
        b=mO1+iTe5nm2S/tLTAIQpSjVekL8a/DvsOkJ52KyNajYESlPwbD+G7YZJeHnnkgrBIM
         4e9lR3ipLtl0FFNcDKuPBY3UbXIx5xBf9i5Rg9r+igyIOgtQYytwYUAaunhQ737KzZ1o
         Dk+2JKCQdvE7fiBriyrkYCN2/j3sGHqK/K6S4s3UKqECjM9szRJi23pnt92I/H4lrzSZ
         PtpQv64tm5P2qn+XZQOgCsqTTJYjUoIMk0kt5WMCR1yxUGOfp+R9TGsDeR69hg6dVLe9
         fON+AXQXHuHgDLUW1FkKvRztBo7bYZshuIgGaNoGZUbPUR51onRCDZh+3/Dxt0r2ruMW
         WHZw==
X-Gm-Message-State: AOAM530RNY2fwmk4M85QmYDBP3Ye1o2gzjlJGO1knLj/f+L8HWTzNmQG
        mR/XRyehZSw/rjoc7qe7UE+rP71j1mQA5RNjRjLIypy3bfYoVf1ryA6/bf2Ktz+5B9SKBiTg3Xx
        EqHky/Ad6avuTm2CypqqIgrTAiBQ7loO6OnHFJA==
X-Received: by 2002:a05:6638:4129:b0:319:f5e5:2d21 with SMTP id ay41-20020a056638412900b00319f5e52d21mr1775620jab.148.1648091383544;
        Wed, 23 Mar 2022 20:09:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6e3IYZRLfskdJ+DZp2Uaz51HnZfEwes4aBSpX0UEk+ZXiYNBuaMeCuXyfqFYokd4kyWP1iQ==
X-Received: by 2002:a05:6638:4129:b0:319:f5e5:2d21 with SMTP id ay41-20020a056638412900b00319f5e52d21mr1775608jab.148.1648091383293;
        Wed, 23 Mar 2022 20:09:43 -0700 (PDT)
Received: from xps13.dannf (c-73-14-97-161.hsd1.co.comcast.net. [73.14.97.161])
        by smtp.gmail.com with ESMTPSA id e15-20020a92194f000000b002c25e778042sm885509ilm.73.2022.03.23.20.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 20:09:42 -0700 (PDT)
Date:   Wed, 23 Mar 2022 21:09:39 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] iommu/dma: Explicitly sort PCI DMA windows
Message-ID: <Yjvg846XOpsAbgi6@xps13.dannf>
References: <65657c5370fa0161739ba094ea948afdfa711b8a.1647967875.git.robin.murphy@arm.com>
 <874k3pxalr.wl-maz@kernel.org>
 <Yjub51Ct3esuNA9B@xps13.dannf>
 <CAL_JsqLFnN46WixKwsuhPswNo8fye4ERhU7_hPdPABi=70p7HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLFnN46WixKwsuhPswNo8fye4ERhU7_hPdPABi=70p7HA@mail.gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 23, 2022 at 07:55:23PM -0500, Rob Herring wrote:
> On Wed, Mar 23, 2022 at 5:15 PM dann frazier <dann.frazier@canonical.com> wrote:
> >
> > On Wed, Mar 23, 2022 at 09:49:04AM +0000, Marc Zyngier wrote:
> > > On Tue, 22 Mar 2022 17:27:36 +0000,
> > > Robin Murphy <robin.murphy@arm.com> wrote:
> > > >
> > > > Originally, creating the dma_ranges resource list in pre-sorted fashion
> > > > was the simplest and most efficient way to enforce the order required by
> > > > iova_reserve_pci_windows(). However since then at least one PCI host
> > > > driver is now re-sorting the list for its own probe-time processing,
> > > > which doesn't seem entirely unreasonable, so that basic assumption no
> > > > longer holds. Make iommu-dma robust and get the sort order it needs by
> > > > explicitly sorting, which means we can also save the effort at creation
> > > > time and just build the list in whatever natural order the DT had.
> > > >
> > > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > > ---
> > > >
> > > > Looking at this area off the back of the XGene thread[1] made me realise
> > > > that we need to do it anyway, regardless of whether it might also happen
> > > > to restore the previous XGene behaviour or not. Presumably nobody's
> > > > tried to use pcie-cadence-host behind an IOMMU yet...
> > >
> > > This definitely restores PCIe functionality on my Mustang (XGene-1).
> > > Hopefully dann can comment on whether this addresses his own issue, as
> > > his firmware is significantly different.
> >
> > Robin, Marc,
> >
> > Adding just this patch on top of v5.17 (w/ vendor dtb) isn't enough to
> > fix m400 networking:
> 
> I wouldn't expect it to given both the IB register selection changed
> and the 2nd dma-ranges entry is ignored.
> 
> Can you (and others) try out this branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git xgene-pci-fix
> 
> It should maintain the same IB register usage for both cases and
> handle the error in 'dma-ranges'.

Looks good Rob :)

https://paste.ubuntu.com/p/zJF9PKhQpS/


  -dann

