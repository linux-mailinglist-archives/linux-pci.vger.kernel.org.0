Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF743B6879
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 20:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhF1Sby (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbhF1Sbx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 14:31:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21975C061574
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 11:29:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so633840pjo.3
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J8lIPhDa0aN5Z09YS1ndQLHjxxQgjCDJkC6vth7t2Xo=;
        b=mDSY5XVszlcxgPSlWZm3HK2BRJf6nC5YOAyOXN3CrkFXE0fSO2kq7dYu+Ud8Hof2OS
         NYixFqYqReQkL9X/76ycgqIQJd0VxqUydvbKcnIP7RB4gvWNNwSEs6MrwHvPHQn9ZCaO
         Wr6AKVyp85b+W3c/WG7mrIKPGpv1XOf46ksFGFtO7xB0NLtTItYiJA6hF/Lwa/3Vg5lY
         jRSkUpaFJ5AiAuFNuSfOCUK4aoEdReTxk9xY48PfmRJ5kfHIhXVMwrI1FytZJMLvD5wP
         woRzKe7+xpECissNwIbok3UmpWIOnr4dwJLY1MtNem3wxFgFPgdfLX3MuXzMisJlPOAF
         4P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J8lIPhDa0aN5Z09YS1ndQLHjxxQgjCDJkC6vth7t2Xo=;
        b=t/+uHoGVwemim8/xs+WpIbpAmr8ixEk+2vCfMs3b9xAcYmenh7RTGawXB9qOHt/0PT
         jooSCobZJU9UOGWsukvqlBdgQmhzMyev9TYBDxPSTkoWt70XgaEdeF8e6LKz21Jodkkn
         7vbnWzfXnIgCyTwpPxV4qhFdgZOu560avG1Ga7BWqB6WDXEB09Bt59Zn6vunxgBO/Gph
         fw/xXJZrsMiRktmYv2NcA3Hc9xaXcA3A2A4J12wdA4WtehtCpBaV9SZWlJ291/hEhapl
         YJs4vOcltxcJIF4vK+bijWZ9FeQCsNG0Yo2iY/2SQytzqssHZrFomapfthqpx7u5fsFB
         ld4Q==
X-Gm-Message-State: AOAM531yhc9Fu9Vx8HtaigCncHHobPcu7M3rH7CWdXQo5DhakjncVA47
        yvTnSoyKxPeRCqexAg2Qj2AUm6ReIONyg9JIjull2g==
X-Google-Smtp-Source: ABdhPJygLrbXD36Z0ZnhmqRQrrw201Y5GuGPrup/syGVYSz8nri1RzD5aQWB7uZah+zpuH7Wkgcwl2qh/9r6cmWkvQg=
X-Received: by 2002:a17:902:b497:b029:115:e287:7b55 with SMTP id
 y23-20020a170902b497b0290115e2877b55mr23621685plr.79.1624904966710; Mon, 28
 Jun 2021 11:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210625233118.2814915-1-kw@linux.com> <20210625233118.2814915-2-kw@linux.com>
 <YNmf9sAB2NEnivsk@infradead.org> <CAPcyv4ihEZB7kXKVA1GCbWv=ZR2hvBfhwBX9fBFYYTCdg=aLrg@mail.gmail.com>
 <20210628180654.GA168658@rocinante>
In-Reply-To: <20210628180654.GA168658@rocinante>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 28 Jun 2021 11:29:16 -0700
Message-ID: <CAPcyv4i-0g5q3dN7SzFNQsGS5JtFOT3YM+M1b7m0WDdd8qK0nQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sysfs: Invoke iomem_get_mapping() from the sysfs open callback
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 28, 2021 at 11:07 AM Krzysztof Wilczy=C5=84ski <kw@linux.com> w=
rote:
>
> Hi Dan,
>
> On 21-06-28 10:36:13, Dan Williams wrote:
> > On Mon, Jun 28, 2021 at 3:12 AM Christoph Hellwig <hch@infradead.org> w=
rote:
> > >
> > > On Fri, Jun 25, 2021 at 11:31:17PM +0000, Krzysztof Wilczy??ski wrote=
:
> > > >       if (battr->mapping)
> > > > -             of->file->f_mapping =3D battr->mapping;
> > > > +             of->file->f_mapping =3D battr->mapping();
> > >
> > > I think get_mapping() is a better name now.  That being said this
> > > whole programming model looks a little weird.
> >
> > I think both those points are fair.
>
> Anything for us to do?
>
> > > Also, does this patch imply the mapping field of the sysfs bin
> > > attributes wasn't used before at all?
> >
> > It defaulted to an address_space per file rather than a shared address
> > space across all files that map physical addresses as file offsets.
>
> I will include this in the commit message for v3 of the patch series, if
> you don't mind.  Also, would this shared address space be a potential
> issue?  Security, functional, etc.

The shared address_space arrangement is what allows for a "revoke"
mechanism for /dev/mem and pci-resource-sysfs mappings. Without a
shared address space there would need to be tracking for each 'inode'
instance to run revoke_iomem(). Note that this shared address_space
scheme is also deployed for block-device special files, see
blkdev_open(). It's done for similar reasons of allowing all
address_space operations to act on a common representation of the
single block-device.
