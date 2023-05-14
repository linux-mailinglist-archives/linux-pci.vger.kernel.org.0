Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2308B701D9B
	for <lists+linux-pci@lfdr.de>; Sun, 14 May 2023 15:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjENNhA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 May 2023 09:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjENNg7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 May 2023 09:36:59 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082FBE78
        for <linux-pci@vger.kernel.org>; Sun, 14 May 2023 06:36:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ab0c697c2bso108226685ad.1
        for <linux-pci@vger.kernel.org>; Sun, 14 May 2023 06:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684071417; x=1686663417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YunAsxB0preFd2Aglri80o56LhPHmcI0QVuqcP66y/g=;
        b=V8vXrQUtSQeoctGj74qhO/gfaf3wUmaow7G0SBLx/KI6X/FnixQebCDQplpyuKgnwf
         Zakc2Kl+OmrUFi7nwy5LoxOtZIcTTijGVFCON0k1tnUT4B1e1cFJuaxaalNKKfi6l63C
         EubvtRLj7YCDG787tIdU8wAhJIIgYAC1h85h1gJYKPx8J3jz0brDi/4th0kAq1trLzaY
         40l7qQWCUfslhAhBp+Z+/c5ordSX0kFf6+V3PE46UvtibwEgkES8jhKR4G12FNlFJ7Ph
         63BiHiMsUST6Q5WLf9dDTus51XUAkscVL3PPwRDCjMZBfEDTcU86awJubNQRZQSyTYZg
         9EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684071417; x=1686663417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YunAsxB0preFd2Aglri80o56LhPHmcI0QVuqcP66y/g=;
        b=LcrNWbddSar62m1bgS2zW+kou7O/uOWPziiP1D4Q5dNAmU5+9T+rc1knWITQuerTHs
         LQx8vPLZ8+nHbly06OYTN2n46Zso4IUGfFTUBRXrEQPgY04MwJiDKV6lTW57lL5/kVDF
         0Up0iTbreAonqlhty2zZP5TzpqfVfmj7FJ6w2DcD2pVU9P/OltL8rUXK77lsk9TNHFMH
         26R9GMKLyNPrSlXyVtQRHaHQsV9PB9DLmRlJk8TNlVenyo+2j9L3Sfhxm10RpVvPOPa2
         hlaCOb8PIX9HMNq7srHIpfMTCSNsvj0ZMQ5umNrVGO1zIv3xP80AFcW+D6ezLKD7EsHl
         sLDw==
X-Gm-Message-State: AC+VfDzdvhWzIAEJfHaEltGf4bNxo2Y31hfcgUYVbNZi01krehUs6Gj3
        OsYlNLWe50iXHoVH7aeT2wTa
X-Google-Smtp-Source: ACHHUZ7Tfut5t8Afgt+tjg1zjeYnhNrhRYCoFy5lPsgM8aR/36bafmGbARNRYIqo9BXf6Q3icsONBw==
X-Received: by 2002:a17:902:788d:b0:1ac:8215:623d with SMTP id q13-20020a170902788d00b001ac8215623dmr21572554pll.0.1684071417435;
        Sun, 14 May 2023 06:36:57 -0700 (PDT)
Received: from thinkpad ([120.138.12.96])
        by smtp.gmail.com with ESMTPSA id gb12-20020a17090b060c00b00250334d97dasm15977448pjb.31.2023.05.14.06.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 06:36:56 -0700 (PDT)
Date:   Sun, 14 May 2023 19:06:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     dlemoal@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [bug report] PCI: endpoint: Automatically create a function
 specific attributes group
Message-ID: <20230514133652.GA116991@thinkpad>
References: <95d23290-496a-462c-87c5-944df1e20ba1@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95d23290-496a-462c-87c5-944df1e20ba1@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 11, 2023 at 10:06:40AM +0300, Dan Carpenter wrote:
> Hello Damien Le Moal,
> 
> The patch 01c68988addf: "PCI: endpoint: Automatically create a
> function specific attributes group" from Apr 15, 2023, leads to the
> following Smatch static checker warning:
> 
> 	drivers/pci/endpoint/pci-ep-cfs.c:540 pci_ep_cfs_add_type_group()
> 	warn: 'group' isn't an ERR_PTR
> 
> drivers/pci/endpoint/pci-ep-cfs.c
>     532 static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
>     533 {
>     534         struct config_group *group;
>     535 
>     536         group = pci_epf_type_add_cfs(epf_group->epf, &epf_group->group);
>     537         if (!group)
>     538                 return;
>     539 
> --> 540         if (IS_ERR(group)) {
> 
> pci_epf_type_add_cfs() does not return error pointers currently.  Which
> is fine.  Presumably it will start returning them later.  But could you
> add some comments next to the pci_epf_type_add_cfs() to explain what a
> NULL return means vs an error pointer return?
> 

pci_epf_type_add_cfs() may return ERR_PTR from add_cfs() callback.

Regarding comments, it should be added as a part of kdoc for
pci_epf_type_add_cfs(). It already does for NULL part but not for ERR_PTR.

- Mani

>     541                 dev_err(&epf_group->epf->dev,
>     542                         "failed to create epf type specific attributes\n");
>     543                 return;
>     544         }
>     545 
>     546         configfs_register_group(&epf_group->group, group);
>     547 }
> 
> regards,
> dan carpenter

-- 
மணிவண்ணன் சதாசிவம்
