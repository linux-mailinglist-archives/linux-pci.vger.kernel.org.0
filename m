Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918F445381E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 17:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhKPQ4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 11:56:17 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:44906 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbhKPQ4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 11:56:15 -0500
Received: by mail-pl1-f176.google.com with SMTP id q17so17907856plr.11
        for <linux-pci@vger.kernel.org>; Tue, 16 Nov 2021 08:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S5jeIDmEr/lxcjxypH08zgI6IjZqvC5MOF3oAqkEHqo=;
        b=0ZuS+aq0rKG1BbAowHZmJGK0xa1zQkXIvnxoAq4ywu4AeXh/OnB8gc25F3RNxiYyPL
         dorYPqm4pxd1HDIVVpXk3y8x2c4yx38BqM7X6TAssw66PsDPudS+jbpGtru28lEJBruX
         HLaqoQXnbv7t4GS6SkPXcU6MEl5Tkhpr8yHNLfpb68idfJbhGT7XgLH6u/3cu7GgCXd6
         /ahOgngcOjWg5cjkD7lxG6sVzh66j9X67qrhUflZiccdan4X5Rnw2D1PTFY0cTy0qHAE
         1AxD/pLUL9j2rD0RSC9PqCwPPvTI/whtp3FPeD1FsNEMrnj/n/qdR1kKEw+ATfSEpNlQ
         xWoQ==
X-Gm-Message-State: AOAM530+RO7R5KKG9hz8wXGdJ9eJPS7Dq5oQkReo+DtCDZikoZg+W58u
        lZQvM1BXYI4ayIUGv6A+lEo=
X-Google-Smtp-Source: ABdhPJy2TBr2RPQjNuY5izr4c/t9GDXtd/4GPHjfV9ukE7//MFhxpupKAn1hNGTkFh/SO3a+9jXwqA==
X-Received: by 2002:a17:902:b718:b0:143:72b7:409e with SMTP id d24-20020a170902b71800b0014372b7409emr46499203pls.28.1637081598151;
        Tue, 16 Nov 2021 08:53:18 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id ot18sm3286005pjb.14.2021.11.16.08.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 08:53:17 -0800 (PST)
Date:   Tue, 16 Nov 2021 17:53:06 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, nicolarevelant44@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org, linux-pci@vger.kernel.org
Subject: Re: [Bug 214995] New: Sof audio didn't recognize Intel Smart Sound
 (SST) speakers, microphone and headphone jack
Message-ID: <YZPh8rnetEltL/v5@rocinante>
References: <20211112222432.GA1423380@bhelgaas>
 <4cf00ae5-f3d7-ecb5-7dae-f8629becc0d2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4cf00ae5-f3d7-ecb5-7dae-f8629becc0d2@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> That seems like a known issue already tracked at
> https://github.com/thesofproject/linux/issues/3248
> 
> There's a set of devices based on the ES8316/36 I2S audio codec which
> needs dedicated quirks. In the existing reports the Huawei Matebook D15
> is listed as using that codec.
> 
> The latest experimental code we have is here:
> https://github.com/thesofproject/linux/pull/3107/commits
> 
> If confirmed, can we track this on GitHub so that all results for this
> sort of devices are collected in one place? Thanks!

Collecting details is definitely a good idea, however if possible, we
should open a new issue (if there isn't one about this already) using
Kernel's Bugzilla, and track it there.

A lot more users looks there (including kernel maintainers and driver
developers) for bug reports and such.

This is just a suggestion, though.

	Krzysztof
