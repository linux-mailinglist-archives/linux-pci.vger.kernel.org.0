Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E24F7022E4
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 06:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjEOEXQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 00:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjEOEXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 00:23:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC2B26AC
        for <linux-pci@vger.kernel.org>; Sun, 14 May 2023 21:22:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64395e741fcso12728336b3a.2
        for <linux-pci@vger.kernel.org>; Sun, 14 May 2023 21:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684124578; x=1686716578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hnKQ84FSZs4iHkhGdeRu5IgkheJ/axfI+KmndyWf+Kw=;
        b=xnuj80fB/op4NRd5x+18Cd0PP86ZLyC1vu9PKlaEEJYtbkesTySBxu7q/oFNdHP4jq
         4CD5BeuL6TY72LyNBeB0BkmXTm16iXsCjveEn8GP4+G4if3HuCxp1z3ScIj9jZ2hPNPd
         DR1wy9zFP+SLHeAA+R+g7a22cieETmeFjebuMRI013lMbqC7S1419BO0Kw4PU8pRxlLG
         2yPyvb7C6skg9P5AkX9a/RXqMgjcw0uYZjv9M44r1KzbPJLAbyYL7huiyt1g1ViWPn+9
         qPwrln20OsnhoWBHHYQguPefbL3h8R5qJLHBh+7O/x9+nT2rNpPf5UmFOfGIPFXt2N8/
         pBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684124578; x=1686716578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnKQ84FSZs4iHkhGdeRu5IgkheJ/axfI+KmndyWf+Kw=;
        b=PSyS9vf1Q/7GYFmuCmlC6vmAV2bAfm3kzMsTvt6J5wTLLmSnYS13CSR/0tSu8xv70H
         ZcdRUigAPyyNp+qqeQE78O7Wf5gBYPVdOTbq4h3mI2dWWfMhW+4v2VB/UzqLLzPFh1Ut
         FNykYVv3yu1KkFhf7WoMYil9/DiEDDk+x3x34bKWMswFFnd0BNjnAzJOf4cO7wlcPc9P
         WoS/Wwsx7yUZWxHm2fB4/zDOO2gg05EpUdqS5UrfJRaPwzrOGcp/l9VEQ69cvOmlmySG
         s7nrZqUrHIOimU5oWmK43btv1d+uIXT3R/imNrPidLylfLhNQg2zw8Z86Do+aL5yIos8
         ZznA==
X-Gm-Message-State: AC+VfDxe/mi4avJK6zlOvYToEmeJqsphslJ9XosByFq5/8eNTMo6iwGm
        vTf5D0aqLaZ9hhB11TySHR93
X-Google-Smtp-Source: ACHHUZ5DMtro7RTzPdBgzWp2Z+nCx0S5Zo1sX6HVxQTAfRfuzQVrQp0wkYNa4M4VHeZylza4I8G1uQ==
X-Received: by 2002:a05:6a00:15d5:b0:64c:a554:f577 with SMTP id o21-20020a056a0015d500b0064ca554f577mr3218272pfu.11.1684124578237;
        Sun, 14 May 2023 21:22:58 -0700 (PDT)
Received: from thinkpad ([103.28.246.73])
        by smtp.gmail.com with ESMTPSA id j17-20020aa783d1000000b00640e64aa9b7sm9111187pfn.10.2023.05.14.21.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 21:22:57 -0700 (PDT)
Date:   Mon, 15 May 2023 09:52:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     dlemoal@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [bug report] PCI: endpoint: Automatically create a function
 specific attributes group
Message-ID: <20230515042254.GB5143@thinkpad>
References: <95d23290-496a-462c-87c5-944df1e20ba1@kili.mountain>
 <20230514133652.GA116991@thinkpad>
 <b75546ef-017b-4029-8512-0546f9360291@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b75546ef-017b-4029-8512-0546f9360291@kili.mountain>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 14, 2023 at 11:12:22PM +0300, Dan Carpenter wrote:
> On Sun, May 14, 2023 at 07:06:52PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, May 11, 2023 at 10:06:40AM +0300, Dan Carpenter wrote:
> > > Hello Damien Le Moal,
> > > 
> > > The patch 01c68988addf: "PCI: endpoint: Automatically create a
> > > function specific attributes group" from Apr 15, 2023, leads to the
> > > following Smatch static checker warning:
> > > 
> > > 	drivers/pci/endpoint/pci-ep-cfs.c:540 pci_ep_cfs_add_type_group()
> > > 	warn: 'group' isn't an ERR_PTR
> > > 
> > > drivers/pci/endpoint/pci-ep-cfs.c
> > >     532 static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
> > >     533 {
> > >     534         struct config_group *group;
> > >     535 
> > >     536         group = pci_epf_type_add_cfs(epf_group->epf, &epf_group->group);
> > >     537         if (!group)
> > >     538                 return;
> > >     539 
> > > --> 540         if (IS_ERR(group)) {
> > > 
> > > pci_epf_type_add_cfs() does not return error pointers currently.  Which
> > > is fine.  Presumably it will start returning them later.  But could you
> > > add some comments next to the pci_epf_type_add_cfs() to explain what a
> > > NULL return means vs an error pointer return?
> > > 
> > 
> > pci_epf_type_add_cfs() may return ERR_PTR from add_cfs() callback.
> > 
> 
> Right, we presumably will add new implementations of ->add_cfs in the
> future which return error pointers.  Currently in linux-next there are
> only two and neither of them fail.  (Smatch looks at the returns from
> ->add_cfs when it says that these don't return error pointers.  Of
> course, it depends on your .config as well.  But a quick grep confirms
> that both implementations are included in my ARM allmodconfig).
> 

Ah okay. I never thought Smatch would look into callback definitions. Good to
know!

- Mani

> > Regarding comments, it should be added as a part of kdoc for
> > pci_epf_type_add_cfs(). It already does for NULL part but not for ERR_PTR.
> 
> Excelent thanks.
> 
> regards,
> dan carpenter
> 

-- 
மணிவண்ணன் சதாசிவம்
