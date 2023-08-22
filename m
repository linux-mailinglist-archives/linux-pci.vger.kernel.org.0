Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111EE7841CC
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 15:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjHVNRn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 09:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjHVNRm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 09:17:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5D2CD5;
        Tue, 22 Aug 2023 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692710259; x=1724246259;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8QjVgJK0ehD50JuTqi+K7huI6Js9GaH6nNc65R78Mcw=;
  b=f5hER7qRAyWiRRu6cUgv9k19MYWWfup6HxN0yJYFSz3C3R3ByQU/aeNw
   ddJhm7DO8a0qF6Zhk/7IuGUULodB8pextokFrlwmm/KwOKZmtMKrQReQa
   EiM4niGJKr4UAJSnHx4WOJ3pDV5WA/NeEZNONumT3F4yEhTEWArMYYuDK
   IR2mIX873RdxLTnGON0m8l3sR1BStCqcDF7mx36LBusB1kdv11K/uukwB
   uy9/7FE+1lu9FjU74iRf69YshukqzqONbQC9MLqMgV++lLP8kl2RxOx7c
   EOFojBF079+JMiovwJLvdTDNupWcG0uIeXmQEOJB8njkHVbvXkxBNgwN1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353440328"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="353440328"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 06:17:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850616660"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="850616660"
Received: from refaase-mobl.ger.corp.intel.com ([10.252.53.244])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 06:17:34 -0700
Date:   Tue, 22 Aug 2023 16:17:32 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Anders Roxell <anders.roxell@linaro.org>
cc:     Feiyang Chen <chenfeiyang@loongson.cn>, bhelgaas@google.com,
        rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com,
        helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, guyinggang@loongson.cn,
        siyanteng@loongson.cn, chenhuacai@loongson.cn,
        loongson-kernel@lists.loongnix.cn, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v2] PCI/PM: Only read PCI_PM_CTRL register when
 available
In-Reply-To: <CADYN=9L-RS1NPZqogi4M9oLEB8Tod31pn2+D6sk1Am++b8LE9g@mail.gmail.com>
Message-ID: <5077577-baf2-39a1-d28e-e022bcd96039@linux.intel.com>
References: <20230822115514.999111-1-chenfeiyang@loongson.cn> <CADYN=9L-RS1NPZqogi4M9oLEB8Tod31pn2+D6sk1Am++b8LE9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 22 Aug 2023, Anders Roxell wrote:

> On Tue, 22 Aug 2023 at 13:55, Feiyang Chen <chenfeiyang@loongson.cn> wrote:
> >
> > When the current state is already PCI_D0, pci_power_up() will return
> > 0 even though dev->pm_cap is not set. In that case, we should not
> > read the PCI_PM_CTRL register in pci_set_full_power_state().
> >
> > Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > ---
> >  drivers/pci/pci.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 60230da957e0..7e90ab7b47a1 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1242,9 +1242,6 @@ int pci_power_up(struct pci_dev *dev)
> >                 else
> >                         dev->current_state = state;
> >
> > -               if (state == PCI_D0)
> > -                       return 0;
> > -
> >                 return -EIO;
> >         }
> >
> > @@ -1302,8 +1299,12 @@ static int pci_set_full_power_state(struct pci_dev *dev)
> >         int ret;
> >
> >         ret = pci_power_up(dev);
> > -       if (ret < 0)
> > +       if (ret < 0) {
> > +               if (dev->current_state == PCI_D0)
> > +                       return 0;
> > +
> >                 return ret;
> > +       }
> >
> >         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> >         dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
> 
> In fuction pci_power_up() there's another if-statement
> if (state == PCI_D0)
>         goto end;
>
> That also will return 0 if need_restore isn't true.
> What will happen then?

That case is only after pci_power_up() has returned because of 
!dev->pm_cap. As such, it looks unrelated to the case this patch is fixing 
which is the read from PCI_PM_CTRL when dev->pm_cap is not there.

> Would this work?
> 
>         ret = pci_power_up(dev);
> -       if (ret < 0)
> +       if (ret <= 0)
>                  return ret;


-- 
 i.

