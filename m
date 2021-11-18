Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92950455319
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 04:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbhKRDNM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 22:13:12 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:43962 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbhKRDNL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 22:13:11 -0500
Received: by mail-pf1-f182.google.com with SMTP id n85so4508430pfd.10;
        Wed, 17 Nov 2021 19:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iLgCNUyb8NGuiYdHuDlLexQMxlzYniMn3q1v3S6TySI=;
        b=sWRrX/vVSGotqqTMNJaqIGkzt2eYEQb/CA+inRTNMWn1VjWQ9l63Ob8YEYf4+rJMZ1
         5cTJkizSVhYTlNxqfJSGkqv2lh3Oj6uvV7znyT94A55QptspN/0Ys3D3nzQxY59N4HF8
         mPepMeFdTf2Wa5NeR4vYJFL4F3hChARDLcCiCRsujFrrtrZ10bJXYZMIyrYwFNJCn3rX
         XIxwzIza9MQBhTmoSEKjfv+zZg9/DT5TIuxKOVaIuIIsrLckp49zujbNMRtCCa7WCR5K
         fFN+4T0QbCmCBFxSP/50fI2p/fRryxEznoD0qXMN2gyJcdAIJtkjvp2U0Hfgs7IJxgTv
         egCw==
X-Gm-Message-State: AOAM531VSOt0bK4ZeDQmGVng1FaZ3P31tlNq5hC7bBak1b7uxkJgluif
        o7GGVgAvU6W8+6YSOIoX1Ac=
X-Google-Smtp-Source: ABdhPJzLGfuHo2t780Ehis9jQV9qoy9eyQe1E3PyYi4uVvr/BBpeqwQckdrASL/2LRVUCZX8hYZe1g==
X-Received: by 2002:a05:6a00:1248:b0:4a2:5cba:89cb with SMTP id u8-20020a056a00124800b004a25cba89cbmr48695256pfi.12.1637205011656;
        Wed, 17 Nov 2021 19:10:11 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w1sm1044783pfg.11.2021.11.17.19.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 19:10:10 -0800 (PST)
Date:   Thu, 18 Nov 2021 04:09:57 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Dexuan-Linux Cui <dexuan.linux@gmail.com>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Koen Vandeputte <koen.vandeputte@citymesh.com>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Yinghai Lu <yinghai@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
Message-ID: <YZXEBXVc03uA904k@rocinante>
References: <20200909112850.hbtgkvwqy2rlixst@pali>
 <20201006222222.GA3221382@bjorn-Precision-5520>
 <20201007081227.d6f6otfsnmlgvegi@pali>
 <20210407142538.GA12387@meh.true.cz>
 <20210407145147.bvtubdmz4k6nulf7@pali>
 <20210407153041.GA17046@meh.true.cz>
 <cd4812f0-1de3-0582-936c-ba30906595af@citymesh.com>
 <20210625115402.jwga35xmknmo4vdk@pali>
 <CAA42JLZCE0CFUJHVZLT77YvPap49_cGiAMMt2E-B7X0tzST6jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA42JLZCE0CFUJHVZLT77YvPap49_cGiAMMt2E-B7X0tzST6jg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+CC Adding Sasha for visibility]

Hello,

I am terribly sorry for a very late reply!

[...]
> I think we're seeing the same issue with a Linux VM on Hyper-V.

Are you still seeing this issue happen?  If so, does it happen often?

We haven't had a report from a system that runs as a hypervisor guest
before.  I also assume this is x86 or x86_64 platform, correct?

> Here the kernel is
> https://git.launchpad.net/~canonical-kernel/ubuntu/+source/linux-azure/+git/bionic/tree/?h=Ubuntu-azure-5.4-5.4.0-1061.64_18.04.1

This is quite an old kernel, however the 5.4 is a long-term kernel, and
therefore we need to make sure that it would also work properly.

> '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:07/VMBUS:01/47505500-0003-0000-3130-444531334632/pci0003:00/0003:00:00.0/config'

Following the commit e1d3f3268b0e ("PCI/sysfs: Convert "config" to static
attribute"), the issue particularly with the "config" attribute should be
resolved, thus more modern kernel versions are no long suffer from the race
condition related to this specific and some other problematic attributes.

We quite likely have to back-port these changes to a number of older
long-term kernels.  I am going to look into it.

Hopefully, once the patches land in upstream long-term kernels, then
distributions would be able to cherry-pick them and apply to their kernels
releases.

	Krzysztof
