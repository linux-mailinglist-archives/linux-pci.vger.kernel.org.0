Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE924C535C
	for <lists+linux-pci@lfdr.de>; Sat, 26 Feb 2022 03:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiBZCNL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 21:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBZCNL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 21:13:11 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C29179265;
        Fri, 25 Feb 2022 18:12:38 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id j12so2502209vkr.0;
        Fri, 25 Feb 2022 18:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDWpy2NuIsQN7E/0B1NasChFwKSZ7ta4TFaRo3f/J1c=;
        b=RRvEInhRxEBzutgK0TBld7VqkdgO2eExoA/SoRpxe/FJJ0U3LL31c1DPAVhHdIazw+
         riRIH3qQo6YW79G0JeW4MO3oAmr///O+zV2uOJzW4dwjqhLSS/a25Y9iibdTseuz7VXX
         LfK38vfc0uld1ZG+YldAS1ZsQURnnZuLFN0AnE0f950yiaFDjnNAFZqlN4o5Q1jAH32E
         R69V7NIBYDmTxrtLFYvc3pNY2rZhy1UDw0IyEuml6cgH3JKhfqsovSK0N+GXdBxdyj/m
         Ja8yq5rw5xqYlJbl2f2GNPx+pBW8T0DjIvsZ2dJXADPS9usSYVcD+Rf1Ql1UggKZ7vUs
         L/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDWpy2NuIsQN7E/0B1NasChFwKSZ7ta4TFaRo3f/J1c=;
        b=BkMtMBl7qpZRP7TMLtXCvrFvs6gnmyUGjSmt4kAqSr4urBRIuofIXzGVgemMd4lhM0
         kD6Eq4f4xXPodjIbbw2vwLd6CXQfkDrNymZ2YhSMGnA1C0hBfdlHiMJFldSPmjK0BwPb
         HiaqG43uvq5vEnRhJyM1SIvfrJ9wIrvoPAKOjtSbRGQOphPGUsNn6hP4Y9ioW5843JNN
         vZcWLiFzNxjsM6MpaEIomp4kjgIGJjkk03GtmjdNFcf3GQYbm5VKp3E+agmbdWn/r3a5
         NDeIH8sbDOr4iK1lPa3BAfDtnvFXtzJMfcbkMuwDD5bDy3p+GTlT4A7RObtVZm5jxqzm
         cFdg==
X-Gm-Message-State: AOAM531Ff3r8Nn33D84I8QXA3+0g4dWOCactgoszFj/V0tOllYwC2BSH
        84c9sZUpZZleL8cHVrtxnQUJl8jKrByYLyrwtlw=
X-Google-Smtp-Source: ABdhPJzsUE+TqICcXLNuL+ZS/uvjE53/+EGUyjFKuVTi339MEgMzrXx6N86iaeg/mC2K5UwwLFGYsT3W6YgRtSbD0mM=
X-Received: by 2002:a05:6122:d0f:b0:330:c206:d46e with SMTP id
 az15-20020a0561220d0f00b00330c206d46emr4846192vkb.41.1645841557409; Fri, 25
 Feb 2022 18:12:37 -0800 (PST)
MIME-Version: 1.0
References: <CAJoG2+9Tp4ZW4tqTVSgp7wukduEFKHiqOXJO-Yn17OwTvn+a+w@mail.gmail.com>
 <20220225182004.GA369816@bhelgaas>
In-Reply-To: <20220225182004.GA369816@bhelgaas>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Fri, 25 Feb 2022 18:12:26 -0800
Message-ID: <CAJoG2+9p4jC1aSybosd_+pkEzGDv=44D_VshrJzbgpk++Nr8Ng@mail.gmail.com>
Subject: Re: [PATCH] Removed some usages of the deprecated "pci-dma-compat.h" KPI
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        tiwai@suse.com, perex@perex.cz, alex.bou9@gmail.com,
        mporter@kernel.crashing.org, logang@deltatee.com,
        kurt.schwemmer@microsemi.com, Bjorn Helgaas <bhelgaas@google.com>,
        kw@linux.com, robh@kernel.org, lorenzo.pieralisi@arm.com,
        jonathan.derrick@linux.dev, nirmal.patel@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

sorry....

On Fri, Feb 25, 2022 at 10:20 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Feb 23, 2022 at 01:54:54AM -0800, Yusuf Khan wrote:
> > See https://lkml.org/lkml/2022/2/23/11 Before you think of this commit!
>
> Use links to https://lore.kernel.org/r/ whenever you can, instead of
> lkml.org, etc.
