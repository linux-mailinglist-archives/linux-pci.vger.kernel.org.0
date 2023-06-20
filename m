Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EDB736F81
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 16:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjFTO71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 10:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjFTO7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 10:59:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2961BC5;
        Tue, 20 Jun 2023 07:58:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-54f87d5f1abso2105497a12.0;
        Tue, 20 Jun 2023 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687273114; x=1689865114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRhsrk7uXeHgVGLFj/D6U74jUewZ/NwDci/F+F6tH7A=;
        b=JyoP6Jc0Zu9MvSMWYO8BEaXsYDGMX2Kjulm7Pu6qSwz9K67Y8WS66S8ZFTYmuz9JEK
         nGI2POAa7S25V+bIS0+WcgNruZtZQUmVxHrty8HduEmimL6/KjHXlKliA6exDt1iSjrm
         1nSBdRguP0mPvbw57IOo8Lvnunbftt9I0D3gPk0iH6kUySVuiMFijAutHcXkMHFeLt+M
         huSuTOt9pVBz/0xjVXjMOIwi3E3Cm6hpDiURgKVhMj6R5uW7a6HYCKrXM1InNoHEas7g
         lIS7Hi6POBnhQFHiZWWx9QMY4or4WSJrpKViuN/tfpAWhTrPlSRtQ4I2RtF9zL0nozUN
         ZFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687273114; x=1689865114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRhsrk7uXeHgVGLFj/D6U74jUewZ/NwDci/F+F6tH7A=;
        b=US8VXd83m2+vAAaLH0wEnHyu2hA2YtD6JNGtuNfoLpyAZ1K19VGswXq7758R3GGpA9
         wrj0Pk1sN8uvwu3aGuyolVDHyhCf7vpvdFuePHHI9dlWeV6x2xALjh2PKz10rmcxX5IX
         ulVDL6B6F8Zf+rTIEs8f3i0h+3xuq2s4XAXcPPajA6y2ZuziKYN8hZzZGP1vI5GhX3I2
         m0Yx4PmRjhvv15Dniln22zVabgnf/3j9TKoJw172yXXFtogQZzSKT841DUBNMftM9F1M
         gq1kzQ4cL+WlJBmKtJQMbDLwEOQuEs2exm4TzoWNggV3OGOIPbk2p3I0fwIDdVA2hIZ/
         5+QA==
X-Gm-Message-State: AC+VfDwYrXTY65PLm2/CfsqrMjX2Q/ii237f9FgRIJE9cmDBfIslW3LV
        v44oEcZgF4XogVYFcjcLCW24oR8OI1Mb4JWzY6I=
X-Google-Smtp-Source: ACHHUZ7yJMnMY6FDtSd/XWCckyH6R1hVHPtnx0cMQkr5ACy51MJhHAgQHdS+UINbl7W7htBVtE0/6YOX5PV5R1UiKzQ=
X-Received: by 2002:a05:6a20:1456:b0:111:1bc4:cf0a with SMTP id
 a22-20020a056a20145600b001111bc4cf0amr9359163pzi.52.1687273113870; Tue, 20
 Jun 2023 07:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com> <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com>
 <ZIiRK2Dzl2/9Jqle@ziepe.ca> <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZIxTmGU4a5dniEY3@nvidia.com> <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
 <520e2be4-726f-c680-c010-a308cdddbae0@arm.com> <ZIyxFpzh3WG+ifws@nvidia.com>
 <90823b33-1f44-8789-9a38-282407fd9f15@arm.com> <ZJBf5DP60prFH5R2@nvidia.com>
In-Reply-To: <ZJBf5DP60prFH5R2@nvidia.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 20 Jun 2023 07:57:57 -0700
Message-ID: <CAKgT0UccM=_D-gJdzjqeUmRZWnSHVaUABjgQBEamLYauE8WTCA@mail.gmail.com>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 19, 2023 at 7:02=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Jun 19, 2023 at 11:20:58AM +0100, Robin Murphy wrote:
> > On 2023-06-16 19:59, Jason Gunthorpe wrote:
> > > On Fri, Jun 16, 2023 at 05:34:53PM +0100, Robin Murphy wrote:
> > > >
> > > > If the system has working ACS configured correctly, then this issue=
 should
> > > > be moot;
> > >
> > > Yes
> > >
> > > > if it doesn't, then a VFIO user is going to get a whole group of
> > > > peer devices if they're getting anything at all, so it doesn't seem=
 entirely
> > > > unreasonable to leave it up to them to check that all those devices=
'
> > > > resources play well with their expected memory map.
> > >
> > > I think the kernel should be helping here.. 'go figure it out from
> > > lspci' is a very convoluted and obscure uAPI, and I don't see things
> > > like DPDK actually doing that.
> > >
> > > IMHO the uAPI expectation is that the kernel informs userspace what
> > > the usable IOVA is, if bridge windows and lack of ACS are rendering
> > > address space unusable then VFIO/iommufd should return it as excluded
> > > as well.
> > >
> > > If we are going to do that then all UNAMANGED domain users should
> > > follow the same logic.
> > >
> > > We probably have avoided bug reports because of how rare it would be
> > > to see a switch and an UNMANAGED domain using scenario together -
> > > especially with ACS turned off.
> > >
> > > So it is really narrow niche.. Obscure enough I'm not going to make
> > > patches :)
> >
> > The main thing is that we've already been round this once before; we tr=
ied
> > it 6 years ago and then reverted it a year later for causing more probl=
ems
> > than it solved:
>
> As I said earlier in this thread if we do it for VFIO then the
> calculation must be precise and consider bus details like
> ACS/etc. eg VFIO on an ACS system should not report any new regions.
>
> It looks like that thread confirms we can't create reserved regions
> which are wrong :)
>
> I think Alex is saying the same things I'm saying in that thread too:
>
> https://lore.kernel.org/all/20180226161310.061ce3a8@w520.home/
>
> (b) is what the kernel should help prevent.
>
> And it is clear there are today scenarios where a VFIO user will get
> data loss because the reported valid IOVA from the kernel is
> incorrect. Fixing this is hard, much harder than what commit
> 273df9635385 ("iommu/dma: Make PCI window reservation generic") has.

I think this may have gone off down a rathole as my original question
wasn't anything about adding extra reserved regions. It was about
exposing what the IOVA is already reserving so it could be user
visible.

The issue was that the reservation(s) didn't appear in the
reserved_regions sysfs file, and it required adding probes or printk
debugging in order to figure out what is reserved and what is not.
Specifically what I was trying to point out is that there are regions
reserved in iova_reserve_pci_windows() that are not user/admin
visible. The function reserve_iova doesn't do anything to track the
reservation so that it can be recalled later for display. It made
things harder to debug as I wasn't sure if the addresses I was seeing
were valid for the IOMMU or not since I didn't know if they were
supposed to be reserved and the documentation I had found implied they
were.
