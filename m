Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739737282C3
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 16:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbjFHOeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 10:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjFHOeJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 10:34:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A792D59;
        Thu,  8 Jun 2023 07:34:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25690e009c8so353889a91.0;
        Thu, 08 Jun 2023 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686234848; x=1688826848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogxEtO10zQv7idp4qQrzpIhC6RXX1WD8S/obzp5FPO8=;
        b=riTC/3N/fynAvE5Sm3rVrRLtGarvt1CSaDOWe7izLt2EMbZwGqQOctCrs2JxP79wwA
         o5SBTnJcug5VQ969dfmfBCeTgmDNcEIerIvtrrXB0yGb2Eski+laTJF9NHWIqGSl5JR/
         8xU1g9aFrJp0zyM0MWHyn9OLDIlLAWWjlotC3jajlS80moPp7sKu/kBxCuMl+MhhPjEi
         R3e7cTdejmgfSCFEVzZnT7YjabnqPhRZQ8cSQqeUafoO2527CyiBBycT4/ANKiBVAT3v
         DvE0/kCprG3lowuS/sIT9URsCtmZdThWRcuPlXXBI4BcA8p/tAi4IP4rrvnQ1Z5KxA2P
         QP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686234848; x=1688826848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogxEtO10zQv7idp4qQrzpIhC6RXX1WD8S/obzp5FPO8=;
        b=cBG78jTDY2v5UdR/P4+fIbkFzvb86ksdlouV/ulMYvXXcmm1Otm1XyoAcnPlFPla+n
         v2kslwrY1+2NaPhNAApLKTP1iea85QrMQFF3eocPVSVO8BiscawNGWk8UqkRWJT9V8VB
         U8t4VyPI0VIyPs0/8Rr/o7KjO8uPoxOFui3ZO63K5enxEr9brwY5LB1P8xgLp11kdpUZ
         76JA1oxNnPR/je5q5LG45HgvneZC1pWTOWveZaUSaZvj+hJEScKNt9lSYc7khgb4Syg6
         ZzFx2c5pUs1U8VOXjb8mLSdHl2t0BpM2NIbSTaw+nfagwLBLQ4Tk9sGT9CbLSrKgtwsX
         3QJw==
X-Gm-Message-State: AC+VfDw6b7aFeIayPyxUo9MllENBM13MzcaunEdvZOOcm1sNlRT8ZZlW
        UIQzUuIEcyFPg/VbycCHJP10OmpfIqMIEXTA2Zs=
X-Google-Smtp-Source: ACHHUZ5AjxzhpRwD2YACGND7PcjUeMfdk0Rx0KCbQI87WLYw+UnOhm4RVx3HdMR6kQJdV/PyMdco8CA3DJ58HcVSl3I=
X-Received: by 2002:a17:90a:ea09:b0:255:5f47:c85c with SMTP id
 w9-20020a17090aea0900b002555f47c85cmr3963738pjy.30.1686234847900; Thu, 08 Jun
 2023 07:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com> <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
In-Reply-To: <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 8 Jun 2023 07:33:31 -0700
Message-ID: <CAKgT0UcE5bUe7ChytSyUWEkyqdwnNR1k_rcfyykPPWJ=ZzsdRg@mail.gmail.com>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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

On Wed, Jun 7, 2023 at 8:05=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com> =
wrote:
>
> On 6/8/23 7:03 AM, Alexander Duyck wrote:
> > On Wed, Jun 7, 2023 at 3:40=E2=80=AFPM Alexander Duyck
> > <alexander.duyck@gmail.com> wrote:
> >>
> >> I am running into a DMA issue that appears to be a conflict between
> >> ACS and IOMMU. As per the documentation I can find, the IOMMU is
> >> supposed to create reserved regions for MSI and the memory window
> >> behind the root port. However looking at reserved_regions I am not
> >> seeing that. I only see the reservation for the MSI.
> >>
> >> So for example with an enabled NIC and iommu enabled w/o passthru I am=
 seeing:
> >> # cat /sys/bus/pci/devices/0000\:83\:00.0/iommu_group/reserved_regions
> >> 0x00000000fee00000 0x00000000feefffff msi
> >>
> >> Shouldn't there also be a memory window for the region behind the root
> >> port to prevent any possible peer-to-peer access?
> >
> > Since the iommu portion of the email bounced I figured I would fix
> > that and provide some additional info.
> >
> > I added some instrumentation to the kernel to dump the resources found
> > in iova_reserve_pci_windows. From what I can tell it is finding the
> > correct resources for the Memory and Prefetchable regions behind the
> > root port. It seems to be calling reserve_iova which is successfully
> > allocating an iova to reserve the region.
> >
> > However still no luck on why it isn't showing up in reserved_regions.
>
> Perhaps I can ask the opposite question, why it should show up in
> reserve_regions? Why does the iommu subsystem block any possible peer-
> to-peer DMA access? Isn't that a decision of the device driver.
>
> The iova_reserve_pci_windows() you've seen is for kernel DMA interfaces
> which is not related to peer-to-peer accesses.

The problem is if the IOVA overlaps with the physical addresses of
other devices that can be routed to via ACS redirect. As such if ACS
redirect is enabled a host IOVA could be directed to another device on
the switch instead. To prevent that we need to reserve those addresses
to avoid address space collisions.

From what I can tell it looks like the IOVA should be reserved, but I
don't see it showing up anywhere in reserved_regions. What I am
wondering is if iova_reserve_pci_windows() should be taking some steps
so that it will appear, or if  intel_iommu_get_resv_regions() needs to
have some code similar to iova_reserve_pci_windows() to get the ranges
and verify they are reserved in the IOVA.
