Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305326591FB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 22:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiL2VGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 16:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiL2VGl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 16:06:41 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734001D0
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 13:06:40 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r18so13057743pgr.12
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 13:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdskgyIi5HvpyNp2iKqow1i130J9BhAc/PjmQQc1hHw=;
        b=ad35wNtSjdI2C7J3TWPZ7Q8fIEr9Bs3nUGzfTBRwMSBzbHzk9t6nZHlvb8WgQXxam2
         AdNKd88jl1U2+amMvOchU/jBkR5SWNBisccrdJss2PKcttHr5XrBYv4KS3YS0AbnKrYb
         yi+OXqFbHVo8g+dkfaiFOrIlSwEgv1py6pyCG2a3R4m661kObNmU32v/iDyjChFK/t/6
         v0zV+PQxvPBVCDvX9tShxX0q+D41iJa32AJq1RmvZps4ZN2dSQN/6QtkT+jrtoSFwZ93
         ZDMQt5JptE6vqKdqutTEe5d2ZTZaTLzEfF4Mb/ppgPPUp0Z7YIM1jokounBhHivFJV68
         MivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdskgyIi5HvpyNp2iKqow1i130J9BhAc/PjmQQc1hHw=;
        b=SyUDlvLWiqCocWpnL6VxyjIiEo3ZX6FpaHb3iTjM6GgN5KawWshq+FZs1alX/74TT/
         6vZspRuWWZ1wbvSV4enhzo/fbuTOv3hkxEj0HkLlYg2HpV/CS1dt2RMu7RkB+SGaCRM0
         vJiD/ItJZ7Y8f3YxIXg47/xKbnM27gy1NVvQWE1jwrQbrF9pNS2TCEY2WGFSNVpdgFKy
         bI5cvpgJKLsbe0DunvhUNP7NXCOxAbXs4/adSvv6kWcB2/IOv8qTJhSqI7DWE7+6e5M1
         m21rbkYZ+pA/kRYoPUeJ77TqU7T8qNgNSWeO+hypVk2abuQUQCa/iMiEC/XeKzuVUyni
         G0ig==
X-Gm-Message-State: AFqh2kqTJgXKJRW/iRRxgCzwUlsKGFq6qAO9k9z+xRTzaM1RDBD+rnBD
        nIlVzxac2B7wwy4irBpfddR5FbTPGpJHmMhIiy1eew==
X-Google-Smtp-Source: AMrXdXvMcn8YEvNjJqpoYiiBYNqx15HArmsbU6syFt6sA+P3D05TjOJlkq+YTTlnsJrx4TbdXxRlCvGksokcQ1Jka78=
X-Received: by 2002:a63:40c5:0:b0:489:17a2:a53d with SMTP id
 n188-20020a6340c5000000b0048917a2a53dmr1503230pga.255.1672347999807; Thu, 29
 Dec 2022 13:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20221219083511.73205-2-alvaro.karsz@solid-run.com> <20221229195551.GA626165@bhelgaas>
In-Reply-To: <20221229195551.GA626165@bhelgaas>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Thu, 29 Dec 2022 23:06:02 +0200
Message-ID: <CAJs=3_AJnj9udpJ1LRtC+9qvo5Fw-=FjvZRqZkHCaQSEP-FyYg@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/3] Add SolidRun vendor id
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> Hi Alvaro,
>
> On Mon, Dec 19, 2022 at 10:35:09AM +0200, Alvaro Karsz wrote:
> > The vendor id is used in 2 differrent source files,
> > the SNET vdpa driver and pci quirks.
>
> s/id/ID/                   # both in subject and commit log
> s/differrent/different/
> s/vdpa/vDPA/               # seems to be the conventional style
> s/pci/PCI/
>
> Make the commit log say what this patch does.
>
> > Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
>
> With the above and the sorting fix below:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> > ---
> >  include/linux/pci_ids.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index b362d90eb9b..33bbe3160b4 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -3115,4 +3115,6 @@
> >
> >  #define PCI_VENDOR_ID_NCUBE          0x10ff
> >
> > +#define PCI_VENDOR_ID_SOLIDRUN               0xd063
>
> Move this to the right spot so the file is sorted by vendor ID.
> PCI_VENDOR_ID_NCUBE, PCI_VENDOR_ID_OCZ, and PCI_VENDOR_ID_XEN got
> added in the wrong place.
>
> >  #endif /* _LINUX_PCI_IDS_H */
> > --

Thanks for your comments.

The patch was taken by another maintainer (CCed)
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=afc9dcfb846bf35aa7afb160d5370ab5c75e7a70

So, Michael and Bjorn,
Do you want me to create a new version, or fix it in a follow up patch?

BTW, the same is true for the next patch in the series, New PCI quirk
for SolidRun SNET DPU
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=136dd8d8f3a0ac19f75a875e9b27b83d365a5be3

Thanks.
