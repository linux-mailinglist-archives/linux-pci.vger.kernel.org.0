Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990AA48CB66
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 19:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356355AbiALS5t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 13:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356336AbiALS5V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 13:57:21 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D637C06173F
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 10:57:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d19so6060713wrb.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 10:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0HbSGbHvCFtajHs/XH7UxwKFR0DdFL7YzXtWMort64=;
        b=AXRooDA6Vl5l8TpEe1CqVhvsXxilmfXtWie9MLYCiQ9W7rjRJ5WdZ0wXbjT0gs4M5I
         aYtj8JpY+eXCHNq7Z0hPFMfPLCWBpDCFuNFc59LGl1Tlh7JndoEU4R4W381oJDaPzY8w
         bGKL/2wwmaFo+B1utTylCZggKexZjDe8WEuZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0HbSGbHvCFtajHs/XH7UxwKFR0DdFL7YzXtWMort64=;
        b=vO/pBENsmZSZ0Z54SF4z5xRyXE1LwdqrbOrzAGNIAZhe6Nh6MZv/gHD1fpjyN62Rwp
         73MgcQ6rmdTMmNYIRJpuqdazo2lgPoU/5vijHdqVMRCd2qbEO46Tv8dJbKOzIEzGT4vt
         mHc1s3khiwkZgB23v0DWVqY+D/qB8kyVY4OXLexco6nmRCAq0RxpV6e5r3IdBlBgYYDp
         BDYiLh46ZijgtMx9OiglBYhCLm+ypCNMoN2FZ2rZMNJp21ar8bDkhA1L+cAEDEE0sPbq
         lbOCEmTHojLY4zxfHU96U+MwrocBtlmC1mbC+9097sPBuoi41PsLKN7DNQsKfUjKhNfK
         yczQ==
X-Gm-Message-State: AOAM533o/CX4FDFKtk9hZjcLxWQ9GoCUpKcp158Cz4fd/Z1YcYf6h9BT
        6Hyq3OeKSo2Rg/ImEakSOUmbH6dsnxy32JdoUABWPw==
X-Google-Smtp-Source: ABdhPJwfVNqPRdvuwq3wBtjEQDJJE9ljsklfdm9KOckRPpkWXmDfWTfcPZzhliwFhh+x7XvYnWh9j21ep3TwnDt8W5Y=
X-Received: by 2002:a5d:64e1:: with SMTP id g1mr941801wri.403.1642013839221;
 Wed, 12 Jan 2022 10:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20220112013100.48029-1-jim2101024@gmail.com> <20220112175106.GA267550@bhelgaas>
 <20220112180011.GA1319@lpieralisi>
In-Reply-To: <20220112180011.GA1319@lpieralisi>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 12 Jan 2022 13:57:08 -0500
Message-ID: <CA+-6iNxmQrcq2Xw-YayObwqYCD0nmOEjH1cCVJLnL2No5aeFfA@mail.gmail.com>
Subject: Re: [PATCH] fixup! PCI: brcmstb: Add control of subdevice voltage regulators
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 1:00 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Jan 12, 2022 at 11:51:06AM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 11, 2022 at 08:31:00PM -0500, Jim Quinlan wrote:
> >
> > What's this connected to?  Is this a fix for a patch that has already
> > been merged?  If so, which one?  If it's a standalone thing, it needs
> > a commit log and a Signed-off-by.  Actually, that would be good in any
> > case.  Maybe a lore link to the relevant patch?
>
> I was about to reply. It is a fixup for one of the branches I am
> queueing for v5.17 (pci/brcmstb), I can either squash that it myself or
> you can do it, provided that Jim gives us the commit id this is actually
> fixing (or a lore link to the patch posting so that we can infer the
> commit to fix).
Hi,

Sorry, I am unfamiliar with the proper  process of sending a fixup
like this.  The Lore URL is

https://lore.kernel.org/linux-pci/20220106160332.2143-7-jim2101024@gmail.com/T/#m3da60632bd79330cfdfc99ae7bac4367200f5ae5

And the target commit for the fixup is 6/7

Regards,
Jim Quinlan
Broadcom STB
>
> Lorenzo
>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > index 8a3321314b74..4134f01acd87 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -1392,7 +1392,8 @@ static int brcm_pcie_resume(struct device *dev)
> > >  err_reset:
> > >     reset_control_rearm(pcie->rescal);
> > >  err_regulator:
> > > -   regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
> > > +   if (pcie->sr)
> > > +           regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
> > >  err_disable_clk:
> > >     clk_disable_unprepare(pcie->clk);
> > >     return ret;
> > > --
> > > 2.17.1
> > >
