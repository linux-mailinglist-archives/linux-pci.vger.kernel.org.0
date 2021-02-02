Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E9430CC63
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 20:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbhBBTyv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 14:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhBBTvD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 14:51:03 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5A6C061573;
        Tue,  2 Feb 2021 11:50:23 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 123so2162924ooi.13;
        Tue, 02 Feb 2021 11:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l3bsSzSp5VFqJIviHqqruclp18d3rcb4uTg/z6V+Z3A=;
        b=ODYlHNCeEe/cG3cQxKDYb/NJZwWt6FOZimZ7in65vObeMzVZXaWndyvS3tQ3FBs+VH
         A5iV6JUTBzSmQ4d7feYAHllXZKEMbcORob89eXXtiPmJmQdm/7Pk83XC9IOPc21j+loF
         LxCVcSgx7scu2EiyTZQnsi68C/lE0VMgLPVO1vGsJBBr4t61/Dl41N6Kk76AA6AbWtNo
         3fmT2bbYYgtpugpDO4qnVpIHF+2ct3b1v7KSs7WXMYJro1UzBJhD9v1qRR6XWrpTU3Gu
         NbZ2URFGClHOWKDlGjt3QMQoljUtZIKBllUMpGhcTi37YEDV0OD5VRYaBGF2x3QAiFFO
         berQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l3bsSzSp5VFqJIviHqqruclp18d3rcb4uTg/z6V+Z3A=;
        b=g1+ExHUCGLi2jiIG4g6WqBbIYhg9Zwg4JjzHWQRiE49nJ8h3Ngig9FrXF/yBfUXFoo
         6XDVInOqyPFBjskn4iHN7i+VOLFYdXig9bC4NBmGBHy411PvaJ4WBZq53qzrWL1Bs/t7
         Sbbp2OR4bSPdIC+unIw5L6sM1RyfNmm8AcV6BQWoQY0GNJy9Lp1ihVbwogJtRRdORp3o
         gURQoBOuFjMRIqvviPfk3Nv3keNSn1PDbLIPHSPpN80ttkfJFiNhyLMJ2vtJ8fvs8mIF
         FWor8+CnSIM3qAMt+0xKSoxWR2vslUNhbTWnfN97hptGt0hhmU2A97rPhdVN77hJaCBY
         HvLg==
X-Gm-Message-State: AOAM533QjLObS6csG/EvLA8YvRC9rw2XO2HZHSQDYe9XHSOPHrNfROHS
        uIpTZfltEsu2NjfxE76mt6Q=
X-Google-Smtp-Source: ABdhPJw7CaYcN6bnL3pW4O5g2lV2p6UuzwG2E9UF38Aus8EuuCjrecKbq3jCr+VoE07kdXl/b+tcfQ==
X-Received: by 2002:a4a:decb:: with SMTP id w11mr16562987oou.32.1612295422834;
        Tue, 02 Feb 2021 11:50:22 -0800 (PST)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id g13sm4731663otl.60.2021.02.02.11.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 11:50:22 -0800 (PST)
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sinan Kaya <okaya@kernel.org>, Keith Busch <keith.busch@intel.com>,
        Jan Vesely <jano.vesely@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dave Airlie <airlied@gmail.com>,
        Ben Skeggs <skeggsb@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "A. Vladimirov" <vladimirov.atanas@gmail.com>
References: <20210129215619.GA114790@bjorn-Precision-5520>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <1d07f39d-1f8c-e545-c5e7-8f21aa0e94f3@gmail.com>
Date:   Tue, 2 Feb 2021 13:50:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210129215619.GA114790@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/29/21 3:56 PM, Bjorn Helgaas wrote:
> On Thu, Jan 28, 2021 at 06:07:36PM -0600, Alex G. wrote:
>> On 1/28/21 5:51 PM, Sinan Kaya wrote:
>>> On 1/28/2021 6:39 PM, Bjorn Helgaas wrote:
>>>> AFAICT, this thread petered out with no resolution.
>>>>
>>>> If the bandwidth change notifications are important to somebody,
>>>> please speak up, preferably with a patch that makes the notifications
>>>> disabled by default and adds a parameter to enable them (or some other
>>>> strategy that makes sense).
>>>>
>>>> I think these are potentially useful, so I don't really want to just
>>>> revert them, but if nobody thinks these are important enough to fix,
>>>> that's a possibility.
>>>
>>> Hide behind debug or expert option by default? or even mark it as BROKEN
>>> until someone fixes it?
>>>
>> Instead of making it a config option, wouldn't it be better as a kernel
>> parameter? People encountering this seem quite competent in passing kernel
>> arguments, so having a "pcie_bw_notification=off" would solve their
>> problems.
> 
> I don't want people to have to discover a parameter to solve issues.
> If there's a parameter, notification should default to off, and people
> who want notification should supply a parameter to enable it.  Same
> thing for the sysfs idea.

I can imagine cases where a per-port flag would be useful. For example, 
a machine with a NIC and a couple of PCIe storage drives. In this 
example, the PCIe drives donwtrain willie-nillie, so it's useful to turn 
off their notifications, but the NIC absolutely must not downtrain. It's 
debatable whether it should be default on or default off.

> I think we really just need to figure out what's going on.  Then it
> should be clearer how to handle it.  I'm not really in a position to
> debug the root cause since I don't have the hardware or the time.

I wonder
(a) if some PCIe devices are downtraining willie-nillie to save power
(b) if this willie-nillie downtraining somehow violates PCIe spec
(c) what is the official behavior when downtraining is intentional

My theory is: YES, YES, ASPM. But I don't know how to figure this out 
without having the problem hardware in hand.


> If nobody can figure out what's going on, I think we'll have to make it
> disabled by default.

I think most distros do "CONFIG_PCIE_BW is not set". Is that not true?

Alex
