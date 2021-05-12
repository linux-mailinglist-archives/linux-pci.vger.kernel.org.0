Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C6237B5F9
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 08:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhELGV5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 02:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhELGV4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 02:21:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06396C061574
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 23:20:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id s20so27736048ejr.9
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 23:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWe3f2KaV4ucuKOqi1OHFmAX7yggC4XTJ0UGVoiI1EA=;
        b=CBjeWCzb2XWiL/RONCz+Smmcur/f8QhwEMNI9JuhGdO/GTfaD4T62RuWifH2dF1+2K
         xn8sK92KR8/pdrUVKy+kLKPkGNk9WIkPV9DxVGiE04IEMQuFFAgQi3DWED4S8NifAcAb
         ljvsECmzQKOhazeXoN4p68WwntXlVwPjpaojDB5JIsi8SFL48lrAYNtIqKOrfAwqZtz7
         wJNxN0YUYoIb0Tz34COxJdZjlNWmcpDH5oI/TbguU3MUrnIa4G40i8HDOKIgQQW+5KL/
         k98LmOfYw9nvf/rE0TBr8RlDcPtOw5di9HQwH6jobl6aqJQzsws72O5l2m0GE81JFXdz
         U0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWe3f2KaV4ucuKOqi1OHFmAX7yggC4XTJ0UGVoiI1EA=;
        b=AiK0yo8eI6PT94S8Z5tjPECf59mzwG/frIX6j6/ZxpnZL3T/hPHRUCLvpJr5b1gUYJ
         2qY20DEApxJumCE1ttQiXsbpXYecVrQLSHDUP4AvX86tkDkY8ThIsky/U5w4WYcgB9co
         3Ni6YywTyDtEtSnpznxpwjtvXaYPKjBTgpxCNvRIch/W/HyGYX+JfyQ++lvthrkJ5LnT
         HWwYPj5YW7Mpgx2HaOh2r34jt2tgwiuC3B8YgQgyhjLYPrJNCtkjfCMTABf/94orTlZY
         1IQC3Z4sNifB312Ic57T2ITXt+yObAPegZfHsN1VkGZsStnj0Z+I3/oHXunDuaur/GgA
         aLeg==
X-Gm-Message-State: AOAM531m7N7m0W/DKH3+AyBDmeQpTVvYxgioBebHSoxMt+qb+13S5J92
        bTDB0rsw6h4sKqFwzW0oRQASBUe9imYLAbA2zRPb4A==
X-Google-Smtp-Source: ABdhPJzHDt830feXpHIVuJaRosIuWG1d6sjohvjzNdcEKTsuepWpH89I1cUi0er6PwgqXKy8un1eWBrvcJc35eB6b+E=
X-Received: by 2002:a17:907:1183:: with SMTP id uz3mr34984199ejb.264.1620800447812;
 Tue, 11 May 2021 23:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162042788015.1202325.6094533661799093199.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210510161458.00006ac4@Huawei.com>
In-Reply-To: <20210510161458.00006ac4@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 May 2021 23:20:37 -0700
Message-ID: <CAPcyv4gC1QqgAVnsjWdBp=BYGvSf4HAY+2oAPWbb+k88jR0y0g@mail.gmail.com>
Subject: Re: [PATCH 1/8] cxl/mem: Move some definitions to mem.h
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 8:17 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 7 May 2021 15:51:20 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > In preparation for sharing cxl.h with other generic CXL consumers,
> > move / consolidate some of the memory device specifics to mem.h.
> >
> > The motivation for moving out of cxl.h is to maintain least privilege
> > access to memory-device details since cxl.h is used in multiple files.
> > The motivation for moving definitions into a new mem.h header is for
> > code readability and organization. I.e. minimize implementation details
> > when reading data structures and other definitions.
> >
> > Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> I'll do these one by one as not sure if you use automated scripts to pick up
> (which get confused by any time people do "for patches 1-4 + 7")
> Basically I'm fine with all but patch 5...

Sounds good. I do use b4 which has the "--apply-cover-trailers"
option. So in the future if you do want to apply reviewed-by to the
whole series it's sufficient to just reply to the cover letter.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks, Jonathan.
