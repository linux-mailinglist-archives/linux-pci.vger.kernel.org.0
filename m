Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74098701F79
	for <lists+linux-pci@lfdr.de>; Sun, 14 May 2023 22:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjENUNM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 May 2023 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENUNL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 May 2023 16:13:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E671715
        for <linux-pci@vger.kernel.org>; Sun, 14 May 2023 13:12:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3063b5f32aaso7698328f8f.2
        for <linux-pci@vger.kernel.org>; Sun, 14 May 2023 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684095149; x=1686687149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=trxx593xGVVTBZQ2cVBIs4BQig3bV+gIqas6sTlmB70=;
        b=j7KujMKstTU6Oe/q4lw3Z8YCQtT7+/7IEtfkfCb4nSr2ZexvYPMcnvm4PFTslnxaG5
         Fz0ikhYE8/AIyZFGucKuwx/VZgP4Vur4I3RnYVU3EHdpJAT2nm9n6ERZavqAEH4gE6bH
         vc+DLv7XncUOylTGuGo3CAJ105kXUj1TU8aBwDZ6p1xHASgHim+UuH7lBEaxVRcnWihv
         9bWh26TBfIAKz+tzCvXR3A+feklV0v+MsGA9G+h4SF86rgQ7xCQseNC87Y44ZC0rxmCl
         PjYHqXkGojamQ6AOA8fPFERW7zsZRFe69LNFgd1bgWbtEaWiQhrQSJXICnW1hrm36ipC
         OKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684095149; x=1686687149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trxx593xGVVTBZQ2cVBIs4BQig3bV+gIqas6sTlmB70=;
        b=ZJ1y0xxcCn/bmpE6w94A3uwKCqajVuLJWWBgAB1GKAF4Jg2kKSPwR8Ui6pq2jA+Gqf
         gP0eWmpop7OtvkcFMSpE8LHM78xKBRewQybzuwixHQ8Uf1yk2PwJnB/z6GHt3dCRHpOH
         0O7Qs/OOgFLjFEqLzCB/bim6Pu6vwHGvw4qztp0qg4/jONUDMRoYia9ZtZF9Zlcp6X/K
         FOlcanG2siQB/v87K0uKsldHUafWKhLixhv7Pq/bePswlgEm3womYSb+83HHAbdrLDlr
         D/OK65wxiim2pbyhWpplxcVMkWqpktp6k3pPWe95pVH4Wg7g9t12/vj4vG0rlPM3S9cr
         amNw==
X-Gm-Message-State: AC+VfDx6P9pIXNC10mf37cCI/VdFiy52HxpZ38hHovIHymRdLSffAbwq
        fNNe6J2PwUwViYLB8hymivzQ5A==
X-Google-Smtp-Source: ACHHUZ479CBgPKdgsbCsQA1FPWIyBikpp3VztAke1PO6Lg91f0NNWXGzAr5J36MCrwflR3atkqR2cg==
X-Received: by 2002:adf:e341:0:b0:307:5097:ab60 with SMTP id n1-20020adfe341000000b003075097ab60mr20194918wrj.63.1684095149648;
        Sun, 14 May 2023 13:12:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q9-20020adff789000000b002c71b4d476asm30352279wrp.106.2023.05.14.13.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 13:12:26 -0700 (PDT)
Date:   Sun, 14 May 2023 23:12:22 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     dlemoal@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [bug report] PCI: endpoint: Automatically create a function
 specific attributes group
Message-ID: <b75546ef-017b-4029-8512-0546f9360291@kili.mountain>
References: <95d23290-496a-462c-87c5-944df1e20ba1@kili.mountain>
 <20230514133652.GA116991@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514133652.GA116991@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 14, 2023 at 07:06:52PM +0530, Manivannan Sadhasivam wrote:
> On Thu, May 11, 2023 at 10:06:40AM +0300, Dan Carpenter wrote:
> > Hello Damien Le Moal,
> > 
> > The patch 01c68988addf: "PCI: endpoint: Automatically create a
> > function specific attributes group" from Apr 15, 2023, leads to the
> > following Smatch static checker warning:
> > 
> > 	drivers/pci/endpoint/pci-ep-cfs.c:540 pci_ep_cfs_add_type_group()
> > 	warn: 'group' isn't an ERR_PTR
> > 
> > drivers/pci/endpoint/pci-ep-cfs.c
> >     532 static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
> >     533 {
> >     534         struct config_group *group;
> >     535 
> >     536         group = pci_epf_type_add_cfs(epf_group->epf, &epf_group->group);
> >     537         if (!group)
> >     538                 return;
> >     539 
> > --> 540         if (IS_ERR(group)) {
> > 
> > pci_epf_type_add_cfs() does not return error pointers currently.  Which
> > is fine.  Presumably it will start returning them later.  But could you
> > add some comments next to the pci_epf_type_add_cfs() to explain what a
> > NULL return means vs an error pointer return?
> > 
> 
> pci_epf_type_add_cfs() may return ERR_PTR from add_cfs() callback.
> 

Right, we presumably will add new implementations of ->add_cfs in the
future which return error pointers.  Currently in linux-next there are
only two and neither of them fail.  (Smatch looks at the returns from
->add_cfs when it says that these don't return error pointers.  Of
course, it depends on your .config as well.  But a quick grep confirms
that both implementations are included in my ARM allmodconfig).

> Regarding comments, it should be added as a part of kdoc for
> pci_epf_type_add_cfs(). It already does for NULL part but not for ERR_PTR.

Excelent thanks.

regards,
dan carpenter

