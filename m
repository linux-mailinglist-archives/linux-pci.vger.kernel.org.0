Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7122E183D77
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 00:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgCLXjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 19:39:15 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42063 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgCLXjP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2020 19:39:15 -0400
Received: by mail-il1-f196.google.com with SMTP id x2so7183646ila.9
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2020 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E2ILZNWl22AS1muXAlpbVVcHeSznVkag52uINnT+bq8=;
        b=YOgdzH8JhMYfga2MYOd2q7yhzATVkNZuzH1f7azOE6nrbxzSX0/rBIA2lOVlycdzxI
         ZmKNIfc2cxyP9sV0aV9jCQsX7oDn1W8/4tgLyDu5/ccHeHYQKbWnST8uxOkOmKZqsVOI
         Pj0j5UDjKl3iMr/YUISOxz26IonD+t70GBsekOQzu69c6f2xs8hqH5yVEANY4lmgaRE5
         i7YK72NvLuw4cdNQdx2xRU4tJvb7xX2S/o4ciDJdaVhzvcaSk8DkvW2nt57SFek0Z4nM
         M+W8yvM3ROto8164oqck4dOcGQ9WNN9PsFSQRXMXpgdG1LpZHiF5jO+EqoMjGAGVz8Nd
         NJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2ILZNWl22AS1muXAlpbVVcHeSznVkag52uINnT+bq8=;
        b=L9EbwZs3SwDxPT4/RaHsEVzZkmFSR59mgZrBJMd1RRIvC6AT3dFqI9SJdOt7+9XOKG
         BZE5FNacjrBDSyGwY79E6VWAXgHzyo9I0kkpwV3aZWLm6suE1mmVSg6Z9eWtILW/hFkA
         33WjULAdhJlHN9m0hn+059nsc2cccCAHednod8ANtsAdZaJ7bd8+hNg8HW+VQfCfucwk
         6Um7t1jfry8VAcdMNf0K1iLVE1TS/Onbu3Bpa29Xs8ekM6wfhZcUhkdDg4IiTXaHZjqX
         miYz4jEi84cfjqyxMM4msuOynZPZPWOU+WFbCbdW/TtFuG7lWt0Ezp8kEtzjiEbbB4nd
         7I3A==
X-Gm-Message-State: ANhLgQ0JJfKZEl9q1D31/xrZYyiSDrbwgyQcQCgyFKx8hdNFDR8PSqtE
        MN4PuetQ5ClFFvIk08B69otvM8mItI+UDhKcL23uGQ==
X-Google-Smtp-Source: ADFU+vunuYFHmMTxeXbhxXw5Uo3b21PaNtX9C+qjpC09bzDOgW+g1Oz+LN22IIBOGacrxlsq7PCOscSQslCifdDB7Rw=
X-Received: by 2002:a92:280a:: with SMTP id l10mr11155037ilf.49.1584056352713;
 Thu, 12 Mar 2020 16:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190710084427.7iqrhapxa7jo5v6y@yadro.com> <20200122131510.d5ckfj22idh56ef5@yadro.com>
 <20200303123223.i3fvwfmbhklfq2l5@yadro.com>
In-Reply-To: <20200303123223.i3fvwfmbhklfq2l5@yadro.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Thu, 12 Mar 2020 19:39:02 -0400
Message-ID: <CAPoiz9wAFfxSNh8MZo3N4hxJ9VMbF7qcx2SOOgq_1NDN=iVVQQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] ntb_hw_switchtec: Fix ntb_mw_clear_trans returning
 error if size == 0
To:     Alexander Fomichev <fomichev.ru@gmail.com>
Cc:     linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org,
        linux@yadro.com, Logan Gunthorpe <logang@deltatee.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 3, 2020 at 7:32 AM Alexander Fomichev <fomichev.ru@gmail.com> wrote:
>
> Ping?

Sorry, I missed this somehow  :(

I just pulled it in and it should be in my github tree in the next hour or so.

Thanks,
Jon

>
> CC: Jon Mason <jdmason@kudzu.us>
> CC: Dave Jiang <dave.jiang@intel.com>
> CC: Allen Hubbe <allenbh@gmail.com>
> CC: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> CC: Logan Gunthorpe <logang@deltatee.com>
>
> On Wed, Jan 22, 2020 at 04:15:13PM +0300, Alexander Fomichev wrote:
> > Somehow this patch was lost. The problem is still actual.
> > Please, add to upstream.
> >
> > On Wed, Jul 10, 2019 at 11:44:27AM +0300, Alexander Fomichev wrote:
> > > ntb_mw_set_trans should work as ntb_mw_clear_trans when size == 0 and/or
> > > addr == 0. But error in xlate_pos checking condition prevents this.
> > > Fix the condition to make ntb_mw_clear_trans working.
> > >
> > > Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>
> > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > > ---
> > >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > > index 1e2f627d3bac..19d46af19650 100644
> > > --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > > +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > > @@ -299,7 +299,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
> > >     if (widx >= switchtec_ntb_mw_count(ntb, pidx))
> > >             return -EINVAL;
> > >
> > > -   if (xlate_pos < 12)
> > > +   if (size != 0 && xlate_pos < 12)
> > >             return -EINVAL;
> > >
> > >     if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
> > > --
> > > 2.17.1
> >
> > --
> > Regards,
> >   Alexander
