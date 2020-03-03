Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C639D1775EC
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 13:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgCCMc2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 07:32:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45696 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgCCMc1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 07:32:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id e18so3271428ljn.12
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2020 04:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=09C3nnwIuE/Iv16DhL+XJHp/9c9nE6JdQTn3LQR/p8s=;
        b=NOmn4fZ6ZQck6AWMHcmBlACN1BXy0lJdTB1/Jw/iBWqIQGRgSIFe2rCNOKm35tPlJ3
         gjOlpLQvpdQb5BA8who3vOvUxIYrQOJpPVO3qf+9tkUEEyCYkM8jNvlYVFrGMG7Imbhx
         2v5c+QTAbKhHAo8rljJvBk3An2XZfS6owXRIA+VOgV4Cz9F05vJfVLPlcwoITEf8LoCU
         4HospiLurW6FgPZRobgmSND9qac431GQvJDsfFlYgpRSXJhZQlZ8p0u9WFmrQdbvPs6J
         +PLwuryjoBrk0LdX0qi42M07pXoOp5LijnO6YZxul6PWmsf3UZ643SBZj8G3Ztji7Fap
         Hmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=09C3nnwIuE/Iv16DhL+XJHp/9c9nE6JdQTn3LQR/p8s=;
        b=fKhQYT3SzcgoJmIHOfi+deoqAxND1EjFJPZZMFyJI/NxQGInWRr5BdlrexN4Q+dP96
         6wRq/mXpqGEAdvVfdw+0i5bPHS5gE3oZVdoZl2ZbnRBTurT0wASND25BSUlCOE7COtqS
         CaLoBdE2sbXnVzavzqaaW+5rA2UC15wbjL6eUAxYyd4JHktHsPhc4v75a7J8irQ+mrMk
         7PV24Oa/+DdpJlnpIdsmtzYsdFzeXgJ//9uMPL4yhqo6H8cAY2loeVlqmgyd6h1LNh5i
         VWjfkgMNud2R8B+pb1YHJI473sojofE5laMbvUhHd+mq82DUDdZW9PscNvrDc4KUjSRB
         jvWQ==
X-Gm-Message-State: ANhLgQ3Y0gD7RX6zWazU2edeKTj1X58WGwvIB5nIVx9BajJ5HkS0R7IB
        sGitxVzqcf1TbswTBZYgc6g=
X-Google-Smtp-Source: ADFU+vv/mvvDez3Wq3BzeVeAtUC1Lq1Br/bEtF+kctKU89NGa60IoGevQw0hPAxf5BH783YlnPeZIQ==
X-Received: by 2002:a2e:8754:: with SMTP id q20mr2274725ljj.258.1583238744478;
        Tue, 03 Mar 2020 04:32:24 -0800 (PST)
Received: from localhost ([89.207.88.249])
        by smtp.gmail.com with ESMTPSA id 67sm8759384ljj.31.2020.03.03.04.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 04:32:23 -0800 (PST)
Date:   Tue, 3 Mar 2020 15:32:23 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Cc:     linux@yadro.com, Logan Gunthorpe <logang@deltatee.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH RESEND] ntb_hw_switchtec: Fix ntb_mw_clear_trans
 returning error if size == 0
Message-ID: <20200303123223.i3fvwfmbhklfq2l5@yadro.com>
References: <20190710084427.7iqrhapxa7jo5v6y@yadro.com>
 <20200122131510.d5ckfj22idh56ef5@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122131510.d5ckfj22idh56ef5@yadro.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping?

CC: Jon Mason <jdmason@kudzu.us>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Allen Hubbe <allenbh@gmail.com>
CC: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
CC: Logan Gunthorpe <logang@deltatee.com>

On Wed, Jan 22, 2020 at 04:15:13PM +0300, Alexander Fomichev wrote:
> Somehow this patch was lost. The problem is still actual.
> Please, add to upstream.
> 
> On Wed, Jul 10, 2019 at 11:44:27AM +0300, Alexander Fomichev wrote:
> > ntb_mw_set_trans should work as ntb_mw_clear_trans when size == 0 and/or
> > addr == 0. But error in xlate_pos checking condition prevents this.
> > Fix the condition to make ntb_mw_clear_trans working.
> > 
> > Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > ---
> >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > index 1e2f627d3bac..19d46af19650 100644
> > --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > @@ -299,7 +299,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
> >  	if (widx >= switchtec_ntb_mw_count(ntb, pidx))
> >  		return -EINVAL;
> >  
> > -	if (xlate_pos < 12)
> > +	if (size != 0 && xlate_pos < 12)
> >  		return -EINVAL;
> >  
> >  	if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
> > -- 
> > 2.17.1
> 
> -- 
> Regards,
>   Alexander
