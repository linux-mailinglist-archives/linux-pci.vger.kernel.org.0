Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A613B7022E2
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 06:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjEOEVH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 00:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbjEOEVG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 00:21:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B3B1FE7
        for <linux-pci@vger.kernel.org>; Sun, 14 May 2023 21:21:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643aad3bc41so11649382b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 14 May 2023 21:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684124465; x=1686716465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hFiqWrT8ohAd+6zV9q2BcCyZiPPe470zAju0ZGry5nE=;
        b=gShWANL7r+IOgDdkCbjr/zdAg/2+7ExtX4GkXJ2Xa1nEEQIe4y22mozkG1gJ4WOEKD
         1cA1ANAPO0Iw0/aWQSh3kWXMunZF3hqjcWZEnXdtDZ8Sm+RZaE2P8ZgIxy1HiSONvDoP
         Khaj3vHWTBCIXhKm/yXHj5kTXC+WCnYcKjJyIY2kwxyV9FwQ8WXbgDviauBQ9tLWYC4M
         zRh4vBqPrSeVIr7PaldI9ZluNhyQsEy5TEb6JAamWfbVETgPBX2/rsj6mjJnlVjSy1/T
         1EB7MiXDFI7fcHD+KjtFe9yjK5BuWuY5bmtOt46UMbeX3imk7/3KuQFqBJD5eG0iWTye
         S1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684124465; x=1686716465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFiqWrT8ohAd+6zV9q2BcCyZiPPe470zAju0ZGry5nE=;
        b=ILRRx5CX9+XArtRi2kLqTA3RYIgc2tRIpWOTapScs28pqLO+nhHqP4ZZv7TKy7A6nA
         OU8+qFQ351RjgwAzOficfy7yWwxMgNFsY7nlYp7e1bvWTs9wX6ZmJEAasjk/gN+5y1p0
         0phSed49bWueoZdZ3BVyqpcZLKqt5Xge2cyTZqRn2kYinzQ/sxQgz1PjQwUgAUgpx3M0
         63mhK+YW1wlqQpLL5p08N2Bv3TCSToX3WDSDD453iNY2NnDX66kGRB30nwCb+V1w7tU/
         33JEv0r/G4f/ZFQKNQk6frx0B/DSwD060qi77h7ScyU5wvXE7oyEEuNdueFOt0O0zfMw
         Igvw==
X-Gm-Message-State: AC+VfDyp2EW+ClBP+Qptdwhc/YSWO9DKOS3gNKFoN3UA6QLMx1YnDRFl
        RHh99xJnggabUDN7tyd0ZituLLY9ECu3Ltu2KQ==
X-Google-Smtp-Source: ACHHUZ51inWz2sFn+RQ60WfJi1a0Tc7/HcKwOWnSlU4C9SnMI8V39QkKekr7wrfDrwqk+LOpPoLayQ==
X-Received: by 2002:a05:6a00:1343:b0:646:9232:df6 with SMTP id k3-20020a056a00134300b0064692320df6mr31318505pfu.33.1684124464666;
        Sun, 14 May 2023 21:21:04 -0700 (PDT)
Received: from thinkpad ([103.28.246.73])
        by smtp.gmail.com with ESMTPSA id p15-20020a63fe0f000000b00514256c05c2sm10459495pgh.7.2023.05.14.21.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 21:21:03 -0700 (PDT)
Date:   Mon, 15 May 2023 09:51:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>, linux-pci@vger.kernel.org
Subject: Re: [bug report] PCI: endpoint: Automatically create a function
 specific attributes group
Message-ID: <20230515042100.GA5143@thinkpad>
References: <95d23290-496a-462c-87c5-944df1e20ba1@kili.mountain>
 <20230514133652.GA116991@thinkpad>
 <f215967c-a01f-2aee-ed72-d9c2098613f8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f215967c-a01f-2aee-ed72-d9c2098613f8@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 15, 2023 at 11:14:07AM +0900, Damien Le Moal wrote:
> On 5/14/23 22:36, Manivannan Sadhasivam wrote:
> > On Thu, May 11, 2023 at 10:06:40AM +0300, Dan Carpenter wrote:
> >> Hello Damien Le Moal,
> >>
> >> The patch 01c68988addf: "PCI: endpoint: Automatically create a
> >> function specific attributes group" from Apr 15, 2023, leads to the
> >> following Smatch static checker warning:
> >>
> >> 	drivers/pci/endpoint/pci-ep-cfs.c:540 pci_ep_cfs_add_type_group()
> >> 	warn: 'group' isn't an ERR_PTR
> >>
> >> drivers/pci/endpoint/pci-ep-cfs.c
> >>     532 static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
> >>     533 {
> >>     534         struct config_group *group;
> >>     535 
> >>     536         group = pci_epf_type_add_cfs(epf_group->epf, &epf_group->group);
> >>     537         if (!group)
> >>     538                 return;
> >>     539 
> >> --> 540         if (IS_ERR(group)) {
> >>
> >> pci_epf_type_add_cfs() does not return error pointers currently.  Which
> >> is fine.  Presumably it will start returning them later.  But could you
> >> add some comments next to the pci_epf_type_add_cfs() to explain what a
> >> NULL return means vs an error pointer return?
> >>
> > 
> > pci_epf_type_add_cfs() may return ERR_PTR from add_cfs() callback.
> > 
> > Regarding comments, it should be added as a part of kdoc for
> > pci_epf_type_add_cfs(). It already does for NULL part but not for ERR_PTR.
> 
> What do you mean with "It already does for NULL part" ? There is no kdoc for
> pci_epf_type_add_cfs() that I can see in pci/next. But I am preparing one patch
> to add that. Sending soon.
> 

Heh, I was looking at 6.4-rc1 and in -next, your patch removed the kdoc while
moving the function to pci-ep-cfs.c :/

So yeah, please add it back with ERR_PTR info.

- Mani

> > 
> > - Mani
> > 
> >>     541                 dev_err(&epf_group->epf->dev,
> >>     542                         "failed to create epf type specific attributes\n");
> >>     543                 return;
> >>     544         }
> >>     545 
> >>     546         configfs_register_group(&epf_group->group, group);
> >>     547 }
> >>
> >> regards,
> >> dan carpenter
> > 
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 

-- 
மணிவண்ணன் சதாசிவம்
