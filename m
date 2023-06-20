Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85039737329
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 19:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjFTRrt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 13:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFTRrs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 13:47:48 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E885D1712;
        Tue, 20 Jun 2023 10:47:47 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-570002c9b38so54473697b3.1;
        Tue, 20 Jun 2023 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687283267; x=1689875267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEQQedTfk3CvXMUEMnX/qgx0uD7Zg1KalwFUtarcHWE=;
        b=X/h+sRHNzsC5FcGaSJrO3tW4Rxpa34N3Cmd54bilvTz2qbld2ShNygzXL/zF3Wgqle
         CDVm9DgJt8tLMxVoBvVepefDiFSu1w1y7L5sZ7UfLCLDo1XvLZ6a7dsZdqO7QjzJB5NA
         5ZdUE/wxeA5cSFZML9vW0f1d3UWGXpjBv1RqsbdfK1kXFusynnjw5nYDl+k2UAdQCLUK
         VjRGCApYXDho5KvtigNiBCfsv4Nal8NCc4EkKTJfVlFJ2VnxAN4ZiV9RQpPqa6EgFOFT
         ZNQJtgo5NT/eG67C4qRuPwrIYglj8cobVjHPzMBKhdw/wkm5H83kdSSEq2Ih8Zk3eB1/
         q58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687283267; x=1689875267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEQQedTfk3CvXMUEMnX/qgx0uD7Zg1KalwFUtarcHWE=;
        b=NsZjSMCU0jx7Ii+veVnUU1W+3ipV+XLqwCOFL17a6tU3ZwD2+x7RkfK9Qxkgv3d9XV
         VPi5Yw/vKPrkMCJUjs/13yimmrsGzCaBbx6sRbPQVu9doakciZCCosZqi8KQhObhQckp
         UwNOiDXV99imdsa8R4lMzZ4BWWuMLHSdW/7Q3JHsCPNYusDG6b9QNDbWLWTNITd1Dpsa
         LLjA4f4s6TDEZNHgofz5+RfbGVVGINjTerLAtG2Z0KI5NOTFcWoSN9fYAzDXiB+nNtW3
         OyUyp1a0QggxFAZzU1CYjiTMYRgEeeVMIEz+m0n/HqCrf8nUUs2dwfMhUN8gR9vrAIzK
         /91Q==
X-Gm-Message-State: AC+VfDx3OI483d1+Wx2fZRxDgXcQY7MzKouO9L74Unor8CkNWc6YRhMF
        +Ht7s32kDOFO5wY/9MHlFbE+RdzqII/qloQCL5I=
X-Google-Smtp-Source: ACHHUZ7HqkDEoGGZvLpAudJce8uaN/hmAuzPQsH1Ct+zekBEVf+h6LTLWNg25zLA1ducjT2NIXe8PkpbzKGJgjsGEmE=
X-Received: by 2002:a81:468b:0:b0:573:98a3:f01a with SMTP id
 t133-20020a81468b000000b0057398a3f01amr951191ywa.40.1687283267004; Tue, 20
 Jun 2023 10:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com> <ZIiRK2Dzl2/9Jqle@ziepe.ca>
 <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZIxTmGU4a5dniEY3@nvidia.com> <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
 <520e2be4-726f-c680-c010-a308cdddbae0@arm.com> <ZIyxFpzh3WG+ifws@nvidia.com>
 <90823b33-1f44-8789-9a38-282407fd9f15@arm.com> <ZJBf5DP60prFH5R2@nvidia.com>
 <CAKgT0UccM=_D-gJdzjqeUmRZWnSHVaUABjgQBEamLYauE8WTCA@mail.gmail.com> <ZJHaE2+XOgQj1q2k@nvidia.com>
In-Reply-To: <ZJHaE2+XOgQj1q2k@nvidia.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 20 Jun 2023 10:47:09 -0700
Message-ID: <CAKgT0UdbjDDkwV_uUGCTONGj2Xw_+Tb6J5enAX_+Wq0eKt=nGA@mail.gmail.com>
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

On Tue, Jun 20, 2023 at 9:55=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Jun 20, 2023 at 07:57:57AM -0700, Alexander Duyck wrote:
>
> > I think this may have gone off down a rathole as my original question
> > wasn't anything about adding extra reserved regions. It was about
> > exposing what the IOVA is already reserving so it could be user
> > visible.
>
> Your question points out that dma-iommu.c uses a different set of
> reserved regions than everything else, and its set is closer to
> functionally correct.
>
> IMHO the resolution to what you are talking about is not to add more
> debugging to dma-iommu but to make the set of reserved regions
> consistently correct for everyone, which will make them viewable in
> sysfs.

Okay, that makes sense to me, and I agree. If we had a consistent set
of reserved regions then it would make it easier to understand. If
nothing else my request would be to expose the iova reserved regions
and then most likely the other ones could be deprecated since they
seem to all be consolidated in the IOVA anyway.

Thanks,

- Alex
