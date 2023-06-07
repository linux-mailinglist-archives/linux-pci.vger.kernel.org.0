Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004217272AA
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 01:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjFGXEe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 19:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjFGXEd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 19:04:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8674011A;
        Wed,  7 Jun 2023 16:04:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-25692ff86cdso6444231a91.2;
        Wed, 07 Jun 2023 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686179070; x=1688771070;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEQmXBu5dD2JANi2wiTQk+OaHV1+Cn5N+E2Jx9Z9qA4=;
        b=RylNv+3BIY+SkOFVAD23uBHZj3gl+6CGLSkAPg+jewP+TXl+yMgPLX6SW4utvQFk5H
         EH7z/qzntgcgtmMbuBotoKMWdu1zz6kl61hyvmvMZemO0yBPxR5qJxn+hlm5VEyDdIwX
         ASrRHvjOICNXkznM1ujPM6yNPppmEjhbN5H/OcrhR9xY+BAYQUVBWXyfAd28VEcEAGRJ
         W6uwAK3z8RHShgB+B3TR+0qli2YJ9J5nN2uHEiUIy7UAHQcBknMD0d05qMnd5aL4gqcd
         LdwMS7BKs1bMUBiJQvpGkweej2mWnwYJKjDUZ1rkkTAvpN2mrpqTEaFdTLdsRAZvO1eR
         yk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686179070; x=1688771070;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEQmXBu5dD2JANi2wiTQk+OaHV1+Cn5N+E2Jx9Z9qA4=;
        b=fvSeaUio12PSHfo29bUmtGP6UNJwLUhC23kRyp+deAwfwYTCpPjBfwBUnrdVP3yM1W
         VyWiijzudjsUoaIEqJghsy04ZrYGCpX3ceMzcUZm5f9gqwokdcumY03eSl7Ydm1tUAdc
         fJ+UMAiGu4RmLeBrNPQ0tDD6QPkcXH8hF+3L3khoacnyZUhrfLSc74u1wBd6EEOemAkc
         o0SPE3LdNhOcPa2tAEOppSr2IF3HaSdeMjKUtjX3oDH3+Znq9sj+asFkuykCPC2DdfzH
         9CtBJa/jlSJZWCKIh1X7oyxg3Bz5bq2NXyJdRMaHMSTfz5OXmSHlRyYYr4jQJC338F0e
         CwTQ==
X-Gm-Message-State: AC+VfDz2dViX7b5iP4MrqMBM1LAdpjT2fAOAncHKpvHGljUsGKjmQT/r
        YVVyBuuxdNsYp7Vethq6JrKsr/2QP1s0u0NHUmFXig3So7Y=
X-Google-Smtp-Source: ACHHUZ72aumlNuKAoBEIFQvO8H4ETvfhLNixmshgtGFlUP5g7IApmZyyIjopu2EXDuiSlejJtibjp5Y+wkJnk1Q5LAs=
X-Received: by 2002:a17:90b:4a08:b0:256:4217:b955 with SMTP id
 kk8-20020a17090b4a0800b002564217b955mr5585682pjb.35.1686179070356; Wed, 07
 Jun 2023 16:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
In-Reply-To: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 7 Jun 2023 16:03:54 -0700
Message-ID: <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
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

On Wed, Jun 7, 2023 at 3:40=E2=80=AFPM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> I am running into a DMA issue that appears to be a conflict between
> ACS and IOMMU. As per the documentation I can find, the IOMMU is
> supposed to create reserved regions for MSI and the memory window
> behind the root port. However looking at reserved_regions I am not
> seeing that. I only see the reservation for the MSI.
>
> So for example with an enabled NIC and iommu enabled w/o passthru I am se=
eing:
> # cat /sys/bus/pci/devices/0000\:83\:00.0/iommu_group/reserved_regions
> 0x00000000fee00000 0x00000000feefffff msi
>
> Shouldn't there also be a memory window for the region behind the root
> port to prevent any possible peer-to-peer access?

Since the iommu portion of the email bounced I figured I would fix
that and provide some additional info.

I added some instrumentation to the kernel to dump the resources found
in iova_reserve_pci_windows. From what I can tell it is finding the
correct resources for the Memory and Prefetchable regions behind the
root port. It seems to be calling reserve_iova which is successfully
allocating an iova to reserve the region.

However still no luck on why it isn't showing up in reserved_regions.
