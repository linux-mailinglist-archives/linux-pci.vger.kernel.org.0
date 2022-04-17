Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542425048A6
	for <lists+linux-pci@lfdr.de>; Sun, 17 Apr 2022 19:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiDQRzB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Apr 2022 13:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiDQRy6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2022 13:54:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2201A7;
        Sun, 17 Apr 2022 10:52:22 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id n17so9769718ljc.11;
        Sun, 17 Apr 2022 10:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IZcS1862k/wOZXv/1MDZH2jzk4RBMFR/rIwyADVF1tM=;
        b=c5wBxrs+myyz+cehvr7adR+iHhrVPmrSAcQyhSuI0tCfIFBHr+kQonM7ZapnzMu6hK
         VTepduyqYRCgvQKVn4wBxhxqzSaF85Q5pP0FwjV5d7pGN0ALfpOrkLIwu5uFfcDb/P6F
         2ec/AuOPy4bIQmp+9lLXtGHfUVig5HzpLTsbg3ZrSTwi0Gye0Ccc640hT4YQZM3RSg5s
         T5AZJvPH8lXNcP77vH/DQS5FfZdPDkMTXPWvAwJKdut1xLeddN67TMHbCkk7sZMBpLui
         XA8i6tvGiFeCOZiPcMWz36iRsim34kNW7g1mQTf32htOwDsORlFu/OurBu3fZ8yG4OCg
         ht9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IZcS1862k/wOZXv/1MDZH2jzk4RBMFR/rIwyADVF1tM=;
        b=w9C5lX4sFWWzy+8yyEeMBEORDdOqy6vhuBu/Rpgx3rNUR+zluJJMrYZWRGe53WYJS1
         1QuPbZcjKvC/bN+yvEaAPZwIwK9z8zNwQwEpjbQIW+SPTAhbipyv5WQQK96HtnujZVGo
         TGqw2+JKwdYfr2h0V2HImL+U1y38FHWKe7f6Ls0e2P3WCX5gV3KuDHjVZNjN5DdSgFeJ
         krTvKiYFI6CGD4NutYh9h14E1kwJkpfPHlKuwMIJkL5Cz7FokFHrU3KLIlPwOUfbc6DU
         qs6tQdq3Lz25AAMFlu+uy+hrpqouTtUpVp5bwRh8v9pZRVpAMsLkr+ueO+ZFvEdFFOHm
         F2Uw==
X-Gm-Message-State: AOAM530r9VdelNmH+ixA5GzYsVbWAZuV8HbtcHBsyvtQSTa6O+aB6gHq
        QnKUuCv1Sfk0/6oHDrZhYSo=
X-Google-Smtp-Source: ABdhPJwl+zeVHdLsYsIQO9j/HfEbk61S41aUMvo2tIXvVDXpxCbV5pZ2B4dJP/52nbkfTRVemrlkNg==
X-Received: by 2002:a05:651c:b29:b0:24b:6aaf:f200 with SMTP id b41-20020a05651c0b2900b0024b6aaff200mr5226345ljr.168.1650217940142;
        Sun, 17 Apr 2022 10:52:20 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id v4-20020a2e7a04000000b0024db637f51bsm330973ljc.84.2022.04.17.10.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:52:19 -0700 (PDT)
Date:   Sun, 17 Apr 2022 20:52:17 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] PCI: dwc: Drop iATU regions enumeration -
 dw_pcie_region_type
Message-ID: <20220417175217.zho6vzovfkoypo7q@mobilestation>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-11-Sergey.Semin@baikalelectronics.ru>
 <YkMmRrF0e7WyvKsO@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkMmRrF0e7WyvKsO@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 29, 2022 at 10:31:18AM -0500, Rob Herring wrote:
> On Thu, Mar 24, 2022 at 04:37:28AM +0300, Serge Semin wrote:
> > There is no point in having the dw_pcie_region_type enumeration for almost
> > the same reasons as it was stated for dw_pcie_as_type. First of all it's
> > redundant since the driver already has a set of macro declared which
> > describe the possible inbound and outbound iATU regions. Having an
> > addition abstraction just needlessly complicates the code. Secondly
> > checking the region index passed to the dw_pcie_disable_atu() method for
> > validity is pointless since the erroneous situation will be just
> > ignored in the current code implementation. So to speak let's drop the
> > redundant dw_pcie_region_type enumeration replacing it with the direct
> > iATU direction macro usage.
> > 
> > While at it we suggest to convert the dw_pcie_disable_atu() method to
> > being more consistent with the dw_pcie_readl_atu{_ib}() and
> > dw_pcie_readl_atu{_ob}() functions by having the direction parameter
> > specified ahead of the region index. Thus the code will be a little bit
> > more pleasant to read.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c  |  4 ++--
> >  .../pci/controller/dwc/pcie-designware-host.c    |  2 +-
> >  drivers/pci/controller/dwc/pcie-designware.c     | 16 +---------------
> >  drivers/pci/controller/dwc/pcie-designware.h     |  9 +--------
> >  4 files changed, 5 insertions(+), 26 deletions(-)
> 

> This answers my question. I would have expected this to come before the 
> previous patch, but if it's easier to do it this way it's fine.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

I thought about placing this patch before the previous one, but it
turned a bit easier for me to split the changes in the reverse order.
It has made this patch a bit smaller and more coherent. But seeing you
weren't happy with too many changes in the previous patch I'll do as
you suggest and change the patches order. Since the patch content will
be changed I won't add your reviewed-by tag there on v2. So please
consider re-reviewing it one more time.

-Sergey

