Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8896F3D92B6
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 18:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhG1QHq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 12:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbhG1QFI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 12:05:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0CBC061765;
        Wed, 28 Jul 2021 09:03:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e21so3245029pla.5;
        Wed, 28 Jul 2021 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DohKmaOm/zwQ2P9QFmgx3wEwck5+bB7sVxm44FsrpYE=;
        b=XJ308Hi10yPx5xgCjRg89oRQt9zk7X1SMwWEKyWRdQMFc04fDasAkFE0aNK823E9fI
         0JZxtWABF2MqVMVHzdf8+rypUR08hUFEpYBHEv25ECLB8OBqJDTxIVOSW5T7+hRTgHfG
         TtxxYC2npCgjRkVHeD+CzhscLypIY4sRHuTsxpeJvDrCtPbyhYYBcVT8YoNxB1/x9trA
         KQg1Shpwuj86F6q554eakcxyN8d8wx5ssoILn3fCnX4mXArXEw98TAtbfpCMp13SPCY0
         ILw+OTyVL8rUirRXxgvI0BBx0bWmXKvI30zCKUH6bP9fUH/JFjFQ1fOOLY1NxzuQAgzg
         n5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DohKmaOm/zwQ2P9QFmgx3wEwck5+bB7sVxm44FsrpYE=;
        b=cBQrNoBwacVFbOfn3aYUVMQ75ZxxOlD/igkmi/EvW4cx5USInG2GdPG3B96NEMENTl
         /n7FpDuBoR9nU/wOwBix2d4qmnB0P9z6Z6YNGJ2lDsa9kpTW99qv/+ym4xShJGQn0iGv
         hqFQerUyBYvf/zpltwuUATG8/Zqeyl0a1WIa+pb6KsWe1SJuU8SeWolvhIUQltBIhjHF
         1jGGW9SNtmcA3ftADWMFHN10A4AXBhf+OI9bEvouSI4JUmJwzJBpxpSSZqpYdjPz4R6v
         9gj+gtK3J0H9Pgj/wRhzXro4B2/4S28C9jrKgUM91IGjBEl32CCgdsuPohIqFDXJkIdM
         xxyQ==
X-Gm-Message-State: AOAM533vrE5iChoeF3dk/kiRxL1z7Nzp4Tyw1eeUl+yxZHAOdvKY+O2E
        KDlfsWrkUhi1Nw4QzzPL6m9pjiugL2TdEFNM9fk=
X-Google-Smtp-Source: ABdhPJxJ+G7hcyR34BEFUSBwCTPCdA8kqXedy8NMDhSH+aAbLbfKT/vM/3KcMZyZzV5eQJXwbPlWjHmpbyMJ2utj3gk=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr5032438pjq.181.1627488238478;
 Wed, 28 Jul 2021 09:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210728105558.23871-1-andriy.shevchenko@linux.intel.com> <20210728155002.GA822338@bjorn-Precision-5520>
In-Reply-To: <20210728155002.GA822338@bjorn-Precision-5520>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Jul 2021 19:03:18 +0300
Message-ID: <CAHp75Vex4NffM_H0sK8LnyauMizmk3CjhKYurrcm==80K+qQ-Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PCI: keystone: Use device_get_match_data()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 28, 2021 at 6:51 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Jul 28, 2021 at 01:55:58PM +0300, Andy Shevchenko wrote:
> > Instead of manipulations with OF APIs, use device_get_match_data().
> >
> > While at it, drop of_match_ptr() completely and make compiler happy,
> > otherwise it complains:
> >
> >   pci-keystone.c:1069:34: warning: =E2=80=98ks_pcie_of_match=E2=80=99 d=
efined but not used [-Wunused-const-variable=3D]
>
> These are two separate things and I'd prefer two separate patches.
>
> I have a to-do item on my list to replace of_match_device(), as you
> did here.  I originally suggested replacing with
> device_get_match_data(), but I think Rob prefers
> of_device_get_match_data() because there's really no benefit to the
> extra indirection of device_get_match_data().  These are not drivers
> that may potentially be used with either ACPI or OF; they're just OF.
>
> Either way, I'd like to see a patch that does this for all drivers in
> drivers/pci/controller/ at the same time so they get slightly more
> consistent.
>
> Same for the .of_match_table update; a good change that I'd like to
> apply universally.  It looks like pcie-spear13xx.c, pcie-armada8k.c,
> pci-ftpci100.c, pci-v3-semi.c, pci-xgene.c, pcie-iproc-platform.c also
> have the same issue.

Thanks for the review, I will drop this.

--=20
With Best Regards,
Andy Shevchenko
