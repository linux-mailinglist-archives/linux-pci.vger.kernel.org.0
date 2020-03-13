Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0F184251
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 09:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgCMIRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 04:17:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36953 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgCMIRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Mar 2020 04:17:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id j11so7128148lfg.4
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2020 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tXsPcGv8Fan/bvdsN0nNGI5CETM/nKN+bYEsELNFYjE=;
        b=dncNFMS2LpYI20o+tjF63pfNPsX8pOB4GiY6I7BAdTNhCeySB2h9wTxCr0uWt6a3J4
         vbj5nTEItfYrZ+0xuYij2pDIyZHjqfELOc9/og6UDADghyEZMTryg0hEZbrTgmLT/hUy
         9AYz3WAdM4N/cW3JIzBhrjtSbIFtQyJ6JFAaxYKwk1TzcGfPQlyG9HFkleQbAvnyY3/Y
         R35qZB5eN9ZtOp4CBzuZBrftSgEcCRpLCggRmcM/RaaZjC8VPVV+IVN9arSqGeUDy99k
         DVazLSsa+P9TFK/HodW37wEKItL3B3iXHf2FmzzKzLFIApuh2H7pCWYgZNdZ5aZmHe93
         7r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tXsPcGv8Fan/bvdsN0nNGI5CETM/nKN+bYEsELNFYjE=;
        b=Oe7Di2CPb1WVDEhP5bujKSWe72uefeWNmkrOOHyEx7EtpwDnIsMb56/RZiAYvRQUhj
         5S8z+ytEuIYRjPlfknvR9hbkZi1PFu0Cr8L6Tbz+HQVP7kx+S+t+Y23EdoPr8P2cVO8l
         WdKb0R48RaRpSAHHSiItry5EEeVgWy/VLUkpdg9dNwXoR3S2MSccgkOq6/6QnbXlpYyu
         Lh5+Vsnnq5LXZhwFVLYt/FbKhZaupObVYPH4/i5leq/AWobp8yBk6VR2FwQ6p41MRPAs
         9bM1Qo2pfQjLnSNhBHvrfv1JeRtqtZRGId/0I7db2gaPUPjq1Z43VQp7oo0/X3PHJ2Ql
         GMYg==
X-Gm-Message-State: ANhLgQ1bsVnbrqMFInF22mPk4IGwBbw4BgvvEMZjNA4ryeoMTFTnHnN4
        QKvAOgjC0yuM97yOVdbwUcY=
X-Google-Smtp-Source: ADFU+vsqY7Jn3YNpezVqsWk13XzlvAMsD1Rf3S8+1W8k9TV+G2ZzXDMMCkldC8PVIL00G/rkxn2g0A==
X-Received: by 2002:a19:c7cd:: with SMTP id x196mr7645924lff.106.1584087448610;
        Fri, 13 Mar 2020 01:17:28 -0700 (PDT)
Received: from localhost ([89.207.88.249])
        by smtp.gmail.com with ESMTPSA id g20sm4945780lfe.65.2020.03.13.01.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 01:17:27 -0700 (PDT)
Date:   Fri, 13 Mar 2020 11:17:27 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     Jon Mason <jdmason@kudzu.us>
Cc:     linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org,
        linux@yadro.com, Logan Gunthorpe <logang@deltatee.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH RESEND] ntb_hw_switchtec: Fix ntb_mw_clear_trans
 returning error if size == 0
Message-ID: <20200313081727.fs4lfzfbuafo34nk@yadro.com>
References: <20190710084427.7iqrhapxa7jo5v6y@yadro.com>
 <20200122131510.d5ckfj22idh56ef5@yadro.com>
 <20200303123223.i3fvwfmbhklfq2l5@yadro.com>
 <CAPoiz9wAFfxSNh8MZo3N4hxJ9VMbF7qcx2SOOgq_1NDN=iVVQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPoiz9wAFfxSNh8MZo3N4hxJ9VMbF7qcx2SOOgq_1NDN=iVVQQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you very much.

Regards,
Alexander.

On Thu, Mar 12, 2020 at 07:39:02PM -0400, Jon Mason wrote:
> On Tue, Mar 3, 2020 at 7:32 AM Alexander Fomichev <fomichev.ru@gmail.com> wrote:
> >
> > Ping?
> 
> Sorry, I missed this somehow  :(
> 
> I just pulled it in and it should be in my github tree in the next hour or so.
> 
> Thanks,
> Jon
> 
> >
> > CC: Jon Mason <jdmason@kudzu.us>
> > CC: Dave Jiang <dave.jiang@intel.com>
> > CC: Allen Hubbe <allenbh@gmail.com>
> > CC: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> > CC: Logan Gunthorpe <logang@deltatee.com>
> >
> > On Wed, Jan 22, 2020 at 04:15:13PM +0300, Alexander Fomichev wrote:
> > > Somehow this patch was lost. The problem is still actual.
> > > Please, add to upstream.
> > >
> > > On Wed, Jul 10, 2019 at 11:44:27AM +0300, Alexander Fomichev wrote:
> > > > ntb_mw_set_trans should work as ntb_mw_clear_trans when size == 0 and/or
> > > > addr == 0. But error in xlate_pos checking condition prevents this.
> > > > Fix the condition to make ntb_mw_clear_trans working.
> > > >
> > > > Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>
> > > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > > > ---
> > > >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > > > index 1e2f627d3bac..19d46af19650 100644
> > > > --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > > > +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > > > @@ -299,7 +299,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
> > > >     if (widx >= switchtec_ntb_mw_count(ntb, pidx))
> > > >             return -EINVAL;
> > > >
> > > > -   if (xlate_pos < 12)
> > > > +   if (size != 0 && xlate_pos < 12)
> > > >             return -EINVAL;
> > > >
> > > >     if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
> > > > --
> > > > 2.17.1
> > >
> > > --
> > > Regards,
> > >   Alexander

-- 
Regards,
  Alexander
