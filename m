Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79F5467EF6
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 21:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383138AbhLCUx2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 15:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383115AbhLCUx1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 15:53:27 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D81BC061751
        for <linux-pci@vger.kernel.org>; Fri,  3 Dec 2021 12:50:03 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id iq11so3212307pjb.3
        for <linux-pci@vger.kernel.org>; Fri, 03 Dec 2021 12:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IiqXSBmJKS4kFGk8I5OsxyFVKYg9Egn5AKwrNVhe8+s=;
        b=0BG1lqGydoNBgMiY7AcikoL6dXY9LlGIHnXTfzov/oVqxmQB0ZXnBNrshPew1B0fOB
         TGxV5rt6TyDDqBx+CqReMnCqD0jpKZAbFCroW78Ma+Fjyba1GojEGlehVTfwg+5CSgPL
         TswwN3Zl7H86Z0GFLhM89qbG38sfFpuYbBDvm1c8Ao6k9A9HrfybPD1n/kq1ANbdnDzS
         Wchoc7OsFCuX2mEr5tzUzfEbOINoGOjh8Etewa4p8yAbM6D5wZLNtTxsh+8bb5ccwPiu
         I9sS0YTOUDqcPmPz/AFCrExO3jGBF2CsRPo4C4HtJzlcfKvp6TACro9z1OcLvVj9Pv/7
         B1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IiqXSBmJKS4kFGk8I5OsxyFVKYg9Egn5AKwrNVhe8+s=;
        b=4b2bYOF0nR3yX2H4ib/qi75KYAN30OmcyFT7HLA4hNUVFhp7KFy2p9PazPw8h4ujQi
         q8Y+n5GLFxwheQdNyBfkKdelS8bnXgYHY1c8mFG8Gz9/j0+91nWffPNlWtuyJDDnZXGO
         6O/JQJM7f8KJDktD5XBtXhXe4FvSd7QxjsuPH0WxiPXgJRAV6fOVSVweu+zDiiNUKbxI
         6MNYoRr4Udva3BB2W9ydUPeNg9rlHs/8O3HAZx0sXnjLG3r54cnrSHSIULCJCALSGA6F
         B7CKfSd9nojA0eKFKm67UWUwWeRRq+F5pHVsA/mYpR5c5OK+zB3KpoJvyzDQ3YSIMztU
         Z4yA==
X-Gm-Message-State: AOAM5307TuTV22uVc37xvZhzgIzwq4KoyuXrBCTef44/mi28B2Qanq7p
        FLdacWIILEjrjCgFwd5TFLeWCGJyyLYZEohw33EJzg==
X-Google-Smtp-Source: ABdhPJxbAQxHMArZuK3BX5qF3GrctQzCOwlbmxEmbIGAClliQ6dzUfk0Lmg9b98HGiDZAeBceGNDNNUjELHnf1amUG8=
X-Received: by 2002:a17:902:714f:b0:142:892d:a46 with SMTP id
 u15-20020a170902714f00b00142892d0a46mr24999096plm.39.1638564602684; Fri, 03
 Dec 2021 12:50:02 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2Pfwz5e0Jj6c5npceOwuNTB_dTVuL4NMD2qxr0CGyeGQ@mail.gmail.com>
 <20211203202831.GA3020182@bhelgaas>
In-Reply-To: <20211203202831.GA3020182@bhelgaas>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 3 Dec 2021 12:49:51 -0800
Message-ID: <CAJ+vNU0bZv4OKVgZCwqjstZrncU5pggzVZ_RnpON7XKYpKZ+EA@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx: do not remap invalid res
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 3, 2021 at 12:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Dec 01, 2021 at 02:06:44PM -0800, Tim Harvey wrote:
> > On Mon, Nov 1, 2021 at 11:03 AM Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > On imx6 and perhaps others when pcie probes you get a:
> > > imx6q-pcie 33800000.pcie: invalid resource
> > >
> > > This occurs because the atu is not specified in the DT and as such it
> > > should not be remapped.
> > >
> > > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index a945f0c0e73d..3254f60d1713 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -671,10 +671,11 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
> > >                 if (!pci->atu_base) {
> > >                         struct resource *res =
> > >                                 platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> > > -                       if (res)
> > > +                       if (res) {
> > >                                 pci->atu_size = resource_size(res);
> > > -                       pci->atu_base = devm_ioremap_resource(dev, res);
> > > -                       if (IS_ERR(pci->atu_base))
> > > +                               pci->atu_base = devm_ioremap_resource(dev, res);
> > > +                       }
> > > +                       if (!pci->atu_base || IS_ERR(pci->atu_base))
> > >                                 pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
> > >                 }
> > >
> > > --
> > > 2.17.1
> > >
> >
> > ping - any feedback on this?
>
> Looks like Lorenzo corrected the subject line for you and applied it:
>
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=6e5ebc96ec65

Yes, I saw that. Thanks everyone!

Best regards,

Tim
