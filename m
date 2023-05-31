Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7DD7189EA
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 21:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjEaTOH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 15:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEaTOH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 15:14:07 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1DB123
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2023 12:14:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f82c0cdd02so22822661cf.3
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2023 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685560445; x=1688152445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0tywlLlHZmN2sb1VXP3e/xTGJtBP4rtM1yXFljfO7I=;
        b=ElUCH1LpTJHtkSCpamXz3jwnnOkpxNLsLN8nx7oiDLy9hx53VnFli4EjzZz8Sav69f
         MrDWZ36frz2K016iKV8291YRTmkXZCNs79ckPQyRyoChIgIhmxHW+D3Hg+md/5ppcSHm
         iAMO+RW6Jx1og9XK9MG7FWd7cnLfQHmzHcl0//gxK9723wd9H3sKnKj3K9m7lU1oCu0R
         UsGTQ1MBGXAd5tErFLFtSd3nibLDOJ42dlDpIe+pKGP4oTYGfLOQGbLRu34ISc2Uun3Q
         XC/ny8h6vpNuAxaB5By8r6QfSq17hNwjt8mP7u7zugPHZWfTDGD/mxj6NDjdmFepDREk
         z9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685560445; x=1688152445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0tywlLlHZmN2sb1VXP3e/xTGJtBP4rtM1yXFljfO7I=;
        b=UrY5L66KYMtQftle07LeLYzEfmN0aD8ThSdWThy118T3q10W9oseRIE/tyvYqAxUbu
         FTgC3GY/RZo93OGU4amVIYOZRxVxulF1s3FATpXRbF6Pc1votCNzJXVMc0yTypjPu14h
         npohNx8/R7aVhwNNah16UrizRwfzIZ4aFfKP3/DhENYrOrfIUMUun3Z6T1xJC2XESm3m
         +Oq6B/VzzGoXSchpypda1JOtS3GYWueLTxmXt398a0J5Rc3mj3SqIgM3QQUTijiwNgTr
         +/jBHI/zl0B771TXEOwQ+AgGZ5cJhZATE4P/WeNf3HHVDxcJXyhoqu91/a2lillvSG3e
         ax7A==
X-Gm-Message-State: AC+VfDzqXPpJattnV5OTWlpPf9F0SECqbrKB2BwyqgnQTooQ4JkMvkdP
        OAaI+y2a8FXc0E6OHqaMdIvtsA==
X-Google-Smtp-Source: ACHHUZ6cpQLrHNwS+2SmmQFahiElKqp1WZDxoi2ZVEf2d22+YdLH0Lu2HdHD64oOTK+T40VqBdI0Pw==
X-Received: by 2002:ac8:7c4d:0:b0:3f4:ff4e:c5ed with SMTP id o13-20020ac87c4d000000b003f4ff4ec5edmr7340582qtv.47.1685560444973;
        Wed, 31 May 2023 12:14:04 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id cp10-20020a05622a420a00b003f4a76d4981sm6296426qtb.66.2023.05.31.12.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 12:14:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q4RGl-0017ZO-JH;
        Wed, 31 May 2023 16:14:03 -0300
Date:   Wed, 31 May 2023 16:14:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S . Darwish" <darwi@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>, linux-pci@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongson-kernel@lists.loongnix.cn,
        Juxin Gao <gaojuxin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: irq: Add an early parameter to limit pci irq numbers
Message-ID: <ZHeceyZ9eUC27WcE@ziepe.ca>
References: <20230524093623.3698134-1-chenhuacai@loongson.cn>
 <ZG4rZYBKaWrsctuH@bhelgaas>
 <CAAhV-H5u8qtXpr-mY+pKq7UfmyBgr3USRTQpo9-w28w8pHX8QQ@mail.gmail.com>
 <20230528165738.GF2814@thinkpad>
 <CAAhV-H5u0ibghgwbfJT1V_oWUWi0rie0NHWTSkpCVat3_ARvKw@mail.gmail.com>
 <20230529053919.GB2856@thinkpad>
 <CAAhV-H6EPkGJchA4pg=zctmmt=9LboaFqKhFgQxZKNxJxQVT7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6EPkGJchA4pg=zctmmt=9LboaFqKhFgQxZKNxJxQVT7g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 29, 2023 at 02:52:29PM +0800, Huacai Chen wrote:

> > But IMO what you are proposing seems like usecase driven and may not work all
> > the time due to architecture limitation. This again proves that the existing
> > solution is sufficient enough.

> Yes, it's a usecase driven solution, so I provide a cmdline parameter
> to let the user decide.

The NIC drivers should be consuming interrupts based on the number of
queues they are using, and that is something you can control from the
command line, eg ethtool IIRC. Usually it defaults to the number of
CPUs.

Basically, you want to enable the user to configure the system with a
user specified reduced number of NIC queues, and we already have way
to do that.

Jason
