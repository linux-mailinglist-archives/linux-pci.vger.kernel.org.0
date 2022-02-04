Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90634AA3E0
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 00:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359332AbiBDXBi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 18:01:38 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36726
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354934AbiBDXBi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 18:01:38 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3021C3F1A1
        for <linux-pci@vger.kernel.org>; Fri,  4 Feb 2022 23:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644015697;
        bh=9lqnKWWeY7ck0N4RCu24NCmh00+Npqj5crjtpsswZLI=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=YQOGrUxS3azwsK86LknBbwZr/FoM2ZdPovhc6WIp4MFXhZJQ7tKH4zNMLJPb7oXcX
         FGu3snd0JlKe0vCy+pnAzLDwQlvsZklLkIRloeduYKfuzEqhDUJvCU2RuoVqoe6hJU
         n3Kbe+NEUf+ksTE7YwaDTWrUZsDmsv086ujo6fadRAaQMb5o0vf1twLWadQnC9Ay74
         1wo/d5e38sBN5IAefhW3OS0qi3MjlGWczXpqH62PkgE26OTFNu6L/691uffCkzkB3Y
         vyEHnztKdMCeqItY6c6521X6Y69IYuiJ3ra+egFPyKOdB4oe/PzMP587cd8fsxwJx4
         WGKbmKfMCFenA==
Received: by mail-il1-f199.google.com with SMTP id t18-20020a92ca92000000b002b952c60bfbso5043028ilo.15
        for <linux-pci@vger.kernel.org>; Fri, 04 Feb 2022 15:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9lqnKWWeY7ck0N4RCu24NCmh00+Npqj5crjtpsswZLI=;
        b=GTLms20i5czTWu5MR7bRHyZafBRc0W6unIFZB8t0nd0OlQZEXsLvFwUGMZYOWMqGe2
         TPA0dUMFidNLxCPkjOcMbHuUCC6AIFHJ4yuVRBNONzJEUnWEewb4K2TZwP3ysurxz2Xh
         zEDZH3E1/Wf2PJjRtJNwnIhcqtp01rdx7GTLIG7dAcdQUOHuqVOVSolFMkHJCKjzShLA
         l1PsDAJqckALkA4//lY5ulEN1o2BEikLiR2ckwm6wjG4NhI0tJMihXsZ1PacYb/2CxdQ
         a/vi4ovR0OQCXY4VkUpY8+9BNeRGBKtFtyGml+ssSzrI7G9RIMIygesrX2YQEvBcQ5Tg
         R2KA==
X-Gm-Message-State: AOAM530HeD0EyooUE6GIsddyqOtZmT5cJardnFJp88m5oMoMmJGfdhi6
        /ZrzSo1V+YKTE3+e67myk67HmgyEUWpbIx6TMKX+bhcJzT+Awcx8so0whMPmTRvf6PrEmQwMUUt
        FLLcNjupH/qJhxgl76Amk9OGQ8HvZkKsZstff5A==
X-Received: by 2002:a05:6638:3399:: with SMTP id h25mr650200jav.166.1644015696040;
        Fri, 04 Feb 2022 15:01:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTuofHZlwZ1cYjHU/l2TfOuPfjBnS6ABivT4GOI8HYntDU6F/03yNCBtDFBIhUSTXue1rNcA==
X-Received: by 2002:a05:6638:3399:: with SMTP id h25mr650188jav.166.1644015695820;
        Fri, 04 Feb 2022 15:01:35 -0800 (PST)
Received: from xps13.dannf (c-71-196-238-11.hsd1.co.comcast.net. [71.196.238.11])
        by smtp.gmail.com with ESMTPSA id l13sm1624266ilj.24.2022.02.04.15.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:01:34 -0800 (PST)
Date:   Fri, 4 Feb 2022 16:01:32 -0700
From:   dann frazier <dann.frazier@canonical.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        stable@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene: Fix IB window setup
Message-ID: <Yf2wTLjmcRj+AbDv@xps13.dannf>
References: <20211129173637.303201-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211129173637.303201-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 11:36:37AM -0600, Rob Herring wrote:
> Commit 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup")
> broke PCI support on XGene. The cause is the IB resources are now sorted
> in address order instead of being in DT dma-ranges order. The result is
> which inbound registers are used for each region are swapped. I don't
> know the details about this h/w, but it appears that IB region 0
> registers can't handle a size greater than 4GB. In any case, limiting
> the size for region 0 is enough to get back to the original assignment
> of dma-ranges to regions.

hey Rob!

I've been seeing a panic on HP Moonshoot m400 cartridges (X-Gene1) -
only during network installs - that I also bisected down to commit
6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup"). I was
hoping that this patch that fixed the issue on Stéphane's X-Gene2
system would also fix my issue, but no luck. In fact, it seems to just
makes it fail differently. Reverting both patches is required to get a
v5.17-rc kernel to boot.

I've collected the following logs - let me know if anything else would
be useful.

1) v5.17-rc2+ (unmodified):
   http://dannf.org/bugs/m400-no-reverts.log
   Note that the mlx4 driver fails initialization.

2) v5.17-rc2+, w/o the commit that fixed Stéphane's system:
   http://dannf.org/bugs/m400-xgene2-fix-reverted.log
   Note the mlx4 MSI-X timeout, and later panic.

3) v5.17-rc2+, w/ both commits reverted (works)
   http://dannf.org/bugs/m400-both-reverted.log

   -dann
