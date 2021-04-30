Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB9736F5D1
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 08:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhD3GoO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 02:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhD3GoM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 02:44:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2136BC06174A;
        Thu, 29 Apr 2021 23:43:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e15so11034219pfv.10;
        Thu, 29 Apr 2021 23:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jroDrDSkc2zjLVJv+XjAib6CMc9iA3RYm71xD9Qkdkk=;
        b=Skt7B+GvmAVrdi+Hp2msdDATO0VSDbFCfoaYKe+1lmHc718uRKbvALjVYuMsZHp8pP
         /B8w5wj6Je1Gc21gVre3lSirzyQNtj3kz6hSgsXS4EXPxTlb6Kb1mwExDBzKxjGXnso8
         fp9rEY180455Hf34uL8fZp+1p6cpnOVdFdvdeHrNr5moYmHPkAg5n7nmhDL2zcc39UpV
         95qWjF7EYnfAup6ZgeR8io64nUBJ6GsM1n4NtDF6kMmWt2rXulY3e6QsCQfR1pLBrmLj
         5rrGNurAWDseAhW1fNbnbLWmU28A9ChFQ79II8TZ1HuSewWAVjJYwnqp0aMZIlFMvImA
         4JGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jroDrDSkc2zjLVJv+XjAib6CMc9iA3RYm71xD9Qkdkk=;
        b=nYvsQ76m9C8zXsL4asC2oYdfWphCuSudggyMebyCq2zJKYwXJDhZD+rl0wpazMyN1g
         74hZd3aQ9VjIMDqTbg2CDstIeal5C0yGtaxkJ4OqXvpaaOuR22JluI28efFm693ge+Bc
         bSFuJvNKb9cqbp8Q1zBb510vJyILoJI6MgRLr8fascqqoz6mX9eQH/yyxoNgLYk9t0/A
         ljxEiJtLfBooRFBukF506FjyykeODIuYhTiG032/kwz6oHaBv1pEcmBcAvM5Y9bV9yKH
         nJnQO4pCTGcWFqwKcvqBz5BFqy5hKgKZap10DNllsfnRGrYZOJbGHH2otUaiYQif6f0c
         7nrg==
X-Gm-Message-State: AOAM530lA/G+vSksxCHZkzqvhpynAwyDYgOiErzbqGQL++JWIc3UcMly
        OPw9YAHvCNY14BbwxxlZyTmUf8aZ3Jc=
X-Google-Smtp-Source: ABdhPJwHPyptjdh+yN/klQVmPmij330PGDruMNhex1YxJLHJ4PmvvYWAEGIfwvcL1mG4PP1/4YvnhQ==
X-Received: by 2002:a65:464c:: with SMTP id k12mr3390312pgr.82.1619765003698;
        Thu, 29 Apr 2021 23:43:23 -0700 (PDT)
Received: from localhost ([103.248.31.149])
        by smtp.gmail.com with ESMTPSA id o5sm1843662pgq.58.2021.04.29.23.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 23:43:23 -0700 (PDT)
Date:   Fri, 30 Apr 2021 12:13:20 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>, lorenzo.pieralisi@arm.com,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek: Verify whether the free_ck clock is
 ungated or not
Message-ID: <20210430064320.ktnr2wjhza4p44dk@archlinux>
References: <20210429134749.75157-1-ameynarkhede03@gmail.com>
 <20210429223838.GA588275@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429223838.GA588275@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/04/29 05:38PM, Bjorn Helgaas wrote:
> Can you make the subject say something at a higher level instead of
> just paraphrasing the C code?  I'm guessing this means resume will now
> fail if the clock isn't turned on?
>
> On Thu, Apr 29, 2021 at 07:17:49PM +0530, Amey Narkhede wrote:
> > Verify that the free_ck clock is ungated on device resume
> > by checking return value of clk_prepare_enable().
>
> Also the commit log -- this doesn't say anything more than the code
> itself.  Did you find this by tripping over it?  Or just by code
> inspection?  I guess without the check, we continue on and try to
> resume, but accesses to PCI devices fail and maybe return ~0 data or
> cause machine checks or something?
>
I found this with code inspection. Sorry for the unclear commit
messsage. I'll try to clarify it in v2.
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 23548b517..9b13214bf 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -1154,11 +1154,14 @@ static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
> >  {
> >  	struct mtk_pcie *pcie = dev_get_drvdata(dev);
> >  	struct mtk_pcie_port *port, *tmp;
> > +	int ret;
> >
> >  	if (list_empty(&pcie->ports))
> >  		return 0;
> >
> > -	clk_prepare_enable(pcie->free_ck);
> > +	ret = clk_prepare_enable(pcie->free_ck);
> > +	if (ret)
> > +		return ret;
>
> Most callers print an error message when clk_prepare_enable() fails.
>
[...]
I'll update this in v2.

Thanks,
Amey
