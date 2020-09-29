Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC5127BADD
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 04:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgI2Cfa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 22:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgI2Cfa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 22:35:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834E6C061755;
        Mon, 28 Sep 2020 19:35:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u21so12746637eja.2;
        Mon, 28 Sep 2020 19:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fispIEpvKzQ4yK99Q5GZdxzrqvs5hFT355gL1BD8Ux8=;
        b=jlGtjwrZx/9uMiv9ZibPYP2cdAQGnAgA0Qn2ynTyFmxLUeLsZ0iQbZGioWKVQPTnDO
         iAO1vT2ozPJoSLm+2um+GmrvOWUr6GqO+jFuDeWlMNYdUdFH4rFAPNDkyCPgj05+tZYx
         sTeauxfwsTmf8TNF3IDalgItv0rvdhD8Khg5pksHiCGqIBpmXW8VVIyNgL83sZ0jcCFH
         IZLCwd8opRhQceH027gyW1kz17FPywXI4tnf1AF4wSNwuAG7nCrpoy3Wj6tU724RCPrD
         wUwpKqU8arpZjZIAox7JPhAfs8XTIEeSVgUqvZ0rClUpSQtuCRsP+9U+AOkyT9VDUwBt
         i7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fispIEpvKzQ4yK99Q5GZdxzrqvs5hFT355gL1BD8Ux8=;
        b=B57Lgrh7zCXMJU6vo9LRIKiEEIim93LgXPu39nbvdxEGJvHm4kBQgD3wFzJaBOfx2R
         Z0OFgltGcydy4tONDzQEXuHXiZahSSKIlsA/5UVb78bG1iFd6VOE986wK0xOTuYx+bt5
         gi8gB1933fHZp9FtMjnhJFK4y1DmUpJ3567EMayGJSopmrIcVACU6qk/yvk2R6b3bPEI
         JxvFZDCEm0jpC7wvoJcDyUul9GpziD1YP1AkkjJypukGJPv8oktKeHdN53J8kKtFBTtR
         hGXc5yPosnZHbF4F2N21ql6gYdUc/8zre8gpqd9jFToYLL0t6eihpusLfwWoP9mjiYq6
         e8mQ==
X-Gm-Message-State: AOAM532rDVdk3fgjp4lTpdtiM2yfefrBpJewB+Bg/H/JlK6OX0L7MfyV
        8nyhhld417KrbdVOthNpAWoGSTMirIsNXAaoTH8=
X-Google-Smtp-Source: ABdhPJyu6D8OayMr5IUYnr9YLRD1yDfO7Yj1MvWlAS6jspKb6UKU6joWizLvFp7R9Sl6zWrNw4rgtN3kGbJd9AmSE2I=
X-Received: by 2002:a17:906:4956:: with SMTP id f22mr1629762ejt.62.1601346926062;
 Mon, 28 Sep 2020 19:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
 <20200925023423.42675-4-haifeng.zhao@intel.com> <20200925123515.GF3956970@smile.fi.intel.com>
In-Reply-To: <20200925123515.GF3956970@smile.fi.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Tue, 29 Sep 2020 10:35:14 +0800
Message-ID: <CAKF3qh1j-D=6mmyjuLQu9=Pka3ZbB+43_Ec4oge0LhRNnQz-Ug@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI/ERR: get device before call device driver to
 avoid null pointer reference
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Preferred style, there will be cleared comment in v6.

Thanks,
Ethan

On Sat, Sep 26, 2020 at 12:42 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Sep 24, 2020 at 10:34:21PM -0400, Ethan Zhao wrote:
> > During DPC error injection test we found there is race condition between
> > pciehp and DPC driver, null pointer reference caused panic as following
>
> null -> NULL
>
> >
> >  # setpci -s 64:02.0 0x196.w=000a
> >   // 64:02.0 is rootport has DPC capability
> >  # setpci -s 65:00.0 0x04.w=0544
> >   // 65:00.0 is NVMe SSD populated in above port
> >  # mount /dev/nvme0n1p1 nvme
> >
> >  (tested on stable 5.8 & ICX platform)
> >
> >  Buffer I/O error on dev nvme0n1p1, logical block 468843328,
> >  async page read
> >  BUG: kernel NULL pointer dereference, address: 0000000000000050
> >  #PF: supervisor read access in kernel mode
> >  #PF: error_code(0x0000) - not-present page
>
> Same comment about Oops.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
