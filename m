Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A21307935
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 16:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhA1PKU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 10:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhA1PJg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 10:09:36 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5ADC061788
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 07:07:51 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h12so7997314lfp.9
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 07:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aNwqdghQUB8qwuBarbPc7i8JEfxkf7wc5ZzBwCioF3A=;
        b=cfpNPoiXBCbJflsi+7nYsILgbsQRDxwGzGM5qUMwO2V7hbj4m2562sJhp8CH7NQEFY
         tfYaMEFxttRkwYn7JwHaFceDB6Xnquu13ZXB9GBBfX1UU1lavgmQCvq3E31N5fJpv+He
         spnPQWJhfBRF4QIeZgY2HwRsK0TmkipDv7NdKQTb1bd+p2zaebFdu9ZtRdJVIdcrDPuI
         1Il0u2oNGVhdXSEIdM4n0LEkSSAu87/OFRYW08y6D95lx+2EGKs5pVnGgHXaFal0mHCR
         UtzedxEvdIhjojarCJumeYNt0PPFxn0LgIE2s1pRiyn28+tN4NYHDLK5dtlPblhjQnVV
         GfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aNwqdghQUB8qwuBarbPc7i8JEfxkf7wc5ZzBwCioF3A=;
        b=RFUHuGRPQa7hJv0B91AqTKVdlzq6CCBqhY3hZyOKF81gqpY8i0lY3RzrRaIzoTKhb/
         LEpvA2ldnctzUkYtp2aKctrk9tadRbZ6P1QSV5ixTRQnTxbmWltGJF5NYFGzT3C21p7h
         cB4sjg6OZvA4mNGsQu1IrkAy9WAB4PViYaiLTsP1/mmna90ppfP/WJID7gx7EgSHcxH6
         G/PC/8ZnRwvuGYWPTLZcPfj7rESoBzyy0No35QBjPIwfkzDC3pq2nKUEneENSVFe4MEf
         jzdU5yFKNustw5k0mhzBHwcI/EfSvzZvM+4a5ZTSGIQdC9SPeMUmri3XJy1L4yowiHQD
         qnMA==
X-Gm-Message-State: AOAM533npa86BMv9rP1VeYFClvXRjGn2J/yKDlOETkU0snKJhmtyODQJ
        0AorFOJvW4H7reeUYoJLbhaezUV1LMj0DlgO3qYMtQ==
X-Google-Smtp-Source: ABdhPJxyHDIjUWutN8SgreeiW3OllQNM7emmCXxyDfsEybkUeDGKr6KIcA1+bLnW6zAGOi9wSKw1M+XFNTP1xPQVYPI=
X-Received: by 2002:a19:2245:: with SMTP id i66mr7725116lfi.400.1611846469473;
 Thu, 28 Jan 2021 07:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20210128122311.1.I42c1001f8b0eaac973a99e1e5c2170788ee36c9c@changeid>
 <YBK/wa2AuwYJ/zTp@rocinante>
In-Reply-To: <YBK/wa2AuwYJ/zTp@rocinante>
From:   Victor Ding <victording@google.com>
Date:   Fri, 29 Jan 2021 02:07:13 +1100
Message-ID: <CANqTbdYLmbGe9GQB6QE5pdrsJYTXZo--PUEhE87-0pZCQzuYag@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Disable ASPM when save/restore PCI state
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 29, 2021 at 12:44 AM Krzysztof Wilczy=C5=84ski <kw@linux.com> w=
rote:
>
> Hi Victor,
>
> Thank you for working on this!
>
> [...]
> >       i =3D pci_save_pcie_state(dev);
> >       if (i !=3D 0)
> > -             return i;
> > +             goto Exit;
> >
> >       i =3D pci_save_pcix_state(dev);
> >       if (i !=3D 0)
> > -             return i;
> > +             goto Exit;
> [...]
> > +Exit:
> > +     pcie_restore_aspm_control(dev);
> > +     return i;
> >  }
> [...]
>
> A silly thing, but the goto labels are customary lower-case.
>
> Nonetheless, this is probably something that can be corrected when
> applying, so that you don't need to unnecessarily send a new version
> (unless you will eventually following other reviews, then don't forget
> about it).
>
> Krzysztof

Thank you for reviewing. I am about to send out a V2 for a bug fix,
it will include this style change too.

Victor
