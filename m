Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63655911DF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 16:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiHLOHI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 10:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbiHLOHF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 10:07:05 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A98D8E44B
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 07:07:00 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id cb8so839905qtb.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 07:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=o4cCmpae5Idf9m29hglIkfFTnBFWQVCZxl7mM3GbfcU=;
        b=B3yaLfs9Wy7dodnPS67DfPjojKeP/JGGel7gsgyzSoXI8lwU3k3smrdy/iqw0vpBmt
         naTNFw3+feF9dkb2/Sd4AjglFJoIxWleV54qkIjmBHMeJ6LSTgOIzRIiPAFVBlr5gC59
         v+kozDyx9Sav+v5z9Cu0dUSH0tbGISETEOOwWHQt7v0lmzXIlxJ2ni1D4uxIaJ7hbL9b
         YV9vRtbsR8zhz1K3THK38vdRKmxtOO9/sC0/VnXEJr/bQ422VJ1GiDSsHI+RNVQzC0+Z
         +vO9g3L7ZLS36fdcBURDgnAUKaKM4rqHOF3VQZUb2ADaT54MBg0Z6DfHkYF48X6YD7NK
         TP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=o4cCmpae5Idf9m29hglIkfFTnBFWQVCZxl7mM3GbfcU=;
        b=vvq3N9AaY6pVQPU0NQdclB70UjE4k7mRcQFIsyItwXKrofM3byWxcEcrRTv13kLpT6
         tV38dDbICv/3INYkIDNnz8NVwj18VuADVpqqeOh51Ecyhd82DA7+RhdG/lDifr9Q1KTR
         QpN3VBIupSblKgwepBRD+IdG3dDWFLWQmgzz0D0ijX+1lDA7HfkvMbPOxazFK+z+tnS/
         dFws7QOXAs4utYivB/M8oRUK5pOyehp0tS6PchlJrkGjAKa8U1IlHWu2aEXzioSCWI+G
         ZgCH3IaXrQc3g5DSoGgaj+zo+wzF47sFcs8ZVWrve86ToRvId7/fnnZlSXq598Pwnb7s
         pxaA==
X-Gm-Message-State: ACgBeo2xPtvW6fkdZ2aMRGW81LjzPWU18KIgczh0piws13k+n2nvEB3f
        MGpfm30J8REsyxpAWNWW5W1hcw==
X-Google-Smtp-Source: AA6agR4YuIPl4rmACKJQ36o7TO+IeIUSBODJJr3K7YFMV9Zrpd9l7IJHYIgIYA5RCSIb4R/ZZ4vlhg==
X-Received: by 2002:ac8:5f4c:0:b0:320:795c:b414 with SMTP id y12-20020ac85f4c000000b00320795cb414mr3754593qta.302.1660313219471;
        Fri, 12 Aug 2022 07:06:59 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a249500b006b8fb2a1145sm1830463qkn.124.2022.08.12.07.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:06:58 -0700 (PDT)
Date:   Fri, 12 Aug 2022 10:06:57 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Frank.Li@nxp.com, kishon@ti.com, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com
Subject: Re: [PATCH -next v2] PCI: endpoint: pci-epf-vntb: fix error handle
 in epf_ntb_mw_bar_init()
Message-ID: <YvZegcACgf5vKTB1@kudzu.us>
References: <20220625021516.431473-1-yangyingliang@huawei.com>
 <20220627202704.GA1775928@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627202704.GA1775928@bhelgaas>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 27, 2022 at 03:27:04PM -0500, Bjorn Helgaas wrote:
> On Sat, Jun 25, 2022 at 10:15:16AM +0800, Yang Yingliang wrote:
> > In error case of epf_ntb_mw_bar_init(), memory window BARs should be
> > cleared, so add 'num_mws' parameter in epf_ntb_mw_bar_clear() and
> > calling it in error path to clear the BARs. Also add missing error
> > code when pci_epc_mem_alloc_addr() fails.
> 
> Another one for Jon, since ff32fac00d97 appeared in -next via his
> tree
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ff32fac00d97

Sorry for the extremely long delay in response.  This series is in my
ntb branch and will be in my pull request for v5.20 which should be
going out later today.

Thanks,
Jon

> 
> > Fixes: ff32fac00d97 ("NTB: EPF: support NTB transfer between PCI RC and EP connection")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> > v2:
> >   add error label err_set_bar and move pci_epc_clear_bar() to it
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 20 ++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index ebf7e243eefa..ee9fee167d48 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -567,6 +567,8 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
> >  	return -1;
> >  }
> >  
> > +static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
> > +
> >  /**
> >   * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
> >   *   allocated in peers outbound address space
> > @@ -625,13 +627,21 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  							      &ntb->vpci_mw_phy[i],
> >  							      size);
> >  		if (!ntb->vpci_mw_addr[i]) {
> > +			ret = -ENOMEM;
> >  			dev_err(dev, "Failed to allocate source address\n");
> > -			goto err_alloc_mem;
> > +			goto err_set_bar;
> >  		}
> >  	}
> >  
> >  	return ret;
> > +
> > +err_set_bar:
> > +	pci_epc_clear_bar(ntb->epf->epc,
> > +			  ntb->epf->func_no,
> > +			  ntb->epf->vfunc_no,
> > +			  &ntb->epf->bar[barno]);
> >  err_alloc_mem:
> > +	epf_ntb_mw_bar_clear(ntb, i);
> >  	return ret;
> >  }
> >  
> > @@ -640,12 +650,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >   * @ntb: NTB device that facilitates communication between HOST and vHOST
> >   *
> >   */
> > -static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
> > +static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
> >  {
> >  	enum pci_barno barno;
> >  	int i;
> >  
> > -	for (i = 0; i < ntb->num_mws; i++) {
> > +	for (i = 0; i < num_mws; i++) {
> >  		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
> >  		pci_epc_clear_bar(ntb->epf->epc,
> >  				  ntb->epf->func_no,
> > @@ -774,7 +784,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
> >  	return 0;
> >  
> >  err_write_header:
> > -	epf_ntb_mw_bar_clear(ntb);
> > +	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
> >  err_mw_bar_init:
> >  	epf_ntb_db_bar_clear(ntb);
> >  err_db_bar_init:
> > @@ -794,7 +804,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
> >  static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
> >  {
> >  	epf_ntb_db_bar_clear(ntb);
> > -	epf_ntb_mw_bar_clear(ntb);
> > +	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
> >  }
> >  
> >  #define EPF_NTB_R(_name)						\
> > -- 
> > 2.25.1
> > 
