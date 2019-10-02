Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A348C469E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2019 06:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbfJBEbQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Oct 2019 00:31:16 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43575 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJBEbP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Oct 2019 00:31:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id o44so13581136ota.10;
        Tue, 01 Oct 2019 21:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYgFz/utX2CouzKGq/of876ifiNaKh9wLXb3Iy4aFb4=;
        b=Ds5EsMaPGzVMM8DDhvv62+pUiadKKQJ5R4iijkhLFpJLwGR4V6hsZqJ8lu5aWUyXK7
         gUzhnbAXZi92zmFI2XDFhOcbOLVmwKq1gSa2j6kYsVyupokW4R21bAxbVgXGNYU6T9Zr
         GfRimKs0uzRmtoxMWBy78Fd+pMBV+hj2M9e4O5yeyMGTo0S3DVwZRjX7svWn3dc3sFVq
         Z/GxfKm5RceOsY/syu/CjUT1Nyg7N9xsflXt5A5RpTGSrD56mtfNMz0aNp4wQND2Y/Rm
         EWC+K76S8kIk/BdjoMtTbtAxdVmqNDn6DuOm4NyjdHcGOFUcQMVJhvhX3KkK2uvM4THM
         mLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYgFz/utX2CouzKGq/of876ifiNaKh9wLXb3Iy4aFb4=;
        b=gFHZbtFKRb1PfvdtlqiTpaqAIQajKSE4Ug2ukJ3btk7hdfLFDffGmLcSAb+SSJwquT
         zjkhQUwIv/ZifxZfgsos4myTkXuZMTGtnkZPMoSe83kyVFiDcvukJHH1JliAYVBdSsDF
         4DRwWNNcBGvmMZ+MH1qup5T7dU0XcnCIoq3MPStNI6mexroslli7tRQbgh7tQDFaR+Th
         r2Rm6jtrCdNycppJaSmQTYppFGMVS6ffVsEBOGHgzFv1lNWWcVWCaEcblRRyS5B7JA20
         KyGKdrHNtTfdw5v2cmmBJA1xu8ydjw2IhQME7jSR1hdF5hA1kJE7wLfamBOCtRZUBawz
         xU3g==
X-Gm-Message-State: APjAAAUV5DhCwx9AZaQ1nRO++Xk+0scYlq3soCdhcDhbcSA/t9pew2Gz
        1S3oHY3fQ8Gd2YbuL+91GEtypa4WLRRlo/m8eW8=
X-Google-Smtp-Source: APXvYqycNyChGfYo0NoGXSEbQOypCsbYIrk2guwoa/QPuK4yFQSWZlvYnzn2rPeWXxfSIuxE+bvJb+YjNARGDqJMH+o=
X-Received: by 2002:a9d:5f6:: with SMTP id 109mr1094978otd.358.1569990674840;
 Tue, 01 Oct 2019 21:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191001211419.11245-1-stuart.w.hayes@gmail.com> <20191002041315.6dpqpis5zikosyyc@wunner.de>
In-Reply-To: <20191002041315.6dpqpis5zikosyyc@wunner.de>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Date:   Tue, 1 Oct 2019 23:31:02 -0500
Message-ID: <CAL5oW02sCZ_Mz17wnY7deRtTat1=eX=uU8Q2HCcKDPTuoruJtw@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI: pciehp: Do not turn off slot if presence comes
 up after link
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 1, 2019 at 11:13 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, Oct 01, 2019 at 05:14:16PM -0400, Stuart Hayes wrote:
> > This patch set is based on a patch set [1] submitted many months ago by
> > Alexandru Gagniuc, who is no longer working on it.
> >
> > [1] https://patchwork.kernel.org/cover/10909167/
> >     [v3,0/4] PCI: pciehp: Do not turn off slot if presence comes up after link
>
> If I'm not mistaken, these two are identical to Alex' patches, right?
>
>   PCI: pciehp: Add support for disabling in-band presence
>   PCI: pciehp: Wait for PDS when in-band presence is disabled
>
> I'm not sure if it's appropriate to change the author and
> omit Alex' Signed-off-by.
>
> Otherwise I have no objections against this series.
>
> Thanks,
>
> Lukas

Thanks!  The first patch is identical to the one Alex submitted, and
the second is nearly so... they both basically his work.  I wasn't
sure what proper etiquette was--I was thinking the signed-off-by was
taking responsibility that the patch was ok (functional, not
copyrighted by someone else, etc) rather than giving credit, but he
definitely deserves credit for them.  I'm happy to add a signed-off-by
for Alex on the first two and resubmit if he doesn't object.
