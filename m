Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD630CD14
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 21:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhBBU21 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 15:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbhBBU0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 15:26:33 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1A3C06178A;
        Tue,  2 Feb 2021 12:25:17 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id d1so21120289otl.13;
        Tue, 02 Feb 2021 12:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K4Ci0dOt6mDbLixIdBD74oSiNIzdo5UPoGTbCfJND84=;
        b=FEr8xY+tWDPQbmtxA9wld9tkyQE13zFClR7bivzyaLre57PAOOSlZ7EnC2s4+9+FJb
         IKbioFBba3yedubTp4z12JUgcaAjB/rg++0DgBtNk8JSSDxW9bkeCVHTv9RB9xHwYBk1
         f7VpremtYhuBot9yR8F0ybFR5iPTHKVlAFtwmadA/K88mMT/jvzPqpTblcvcUJnqGLQp
         bmGKLRnUOT/HcAm8AqON+4EpXdDvUGuz/or160bnmzewUK+daYzQbxK58KYcgr543TRW
         hozdwYlgT0cfg03qljGe3viPEdw9U8PDeu2O9+SZlNjINyZtN1r6ZTNcxjdE0NiCrL8l
         5ANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K4Ci0dOt6mDbLixIdBD74oSiNIzdo5UPoGTbCfJND84=;
        b=c5+d90828VOZT64BPC749sOaAc9VTgCyQU+MGd/XmOESuC3zuMdeJD4xt8dRndhvfG
         8qmhOV9eQOiJV2NW8+8QHyY69hT31aToAgIBRLQptvVE/VTOPhPu5iQiiZCTWR7RxEJa
         8IAZG0r6FJgn36dAGErAQCEKA1/WWZp8k9g5EQCiLHFTTOOo/XCTXnSfa7jy2oVWOakl
         c01A5oIm+X9Q391F/LDoiB6lWsovFLCLuu88+I2diH/esXa0GE4rGFRnxah2pJkR4ai6
         2UQPLss3e6x0tQaUon8tGGJJ+cPZr/eEdFEo923OfFeS1emAUrcoMA2CLw81QAtyWN6U
         soMA==
X-Gm-Message-State: AOAM533GOGOVrLS7lHRthzrEB9VIG/DGBi8KbS8MzZjT1BzW8Z7h42Hv
        /ni5KIFaZ9HMjZL1d708t7s=
X-Google-Smtp-Source: ABdhPJxM1hVSd/NdQdOg6m0MfCKRSnV3Kac8fIEQp8dREvh0JLr2N1xtMY/tF/UrTru31B59RvaFCg==
X-Received: by 2002:a9d:1b2c:: with SMTP id l41mr4509428otl.215.1612297516514;
        Tue, 02 Feb 2021 12:25:16 -0800 (PST)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id u25sm957699otg.40.2021.02.02.12.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 12:25:15 -0800 (PST)
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
References: <20210202201621.GA127455@bjorn-Precision-5520>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <4c610757-d402-6da7-ff35-916887ce86a3@gmail.com>
Date:   Tue, 2 Feb 2021 14:25:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210202201621.GA127455@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/2/21 2:16 PM, Bjorn Helgaas wrote:
> On Tue, Feb 02, 2021 at 01:50:20PM -0600, Alex G. wrote:
>> On 1/29/21 3:56 PM, Bjorn Helgaas wrote:
>>> On Thu, Jan 28, 2021 at 06:07:36PM -0600, Alex G. wrote:
>>>> On 1/28/21 5:51 PM, Sinan Kaya wrote:
>>>>> On 1/28/2021 6:39 PM, Bjorn Helgaas wrote:
>>>>>> AFAICT, this thread petered out with no resolution.
>>>>>>
>>>>>> If the bandwidth change notifications are important to somebody,
>>>>>> please speak up, preferably with a patch that makes the notifications
>>>>>> disabled by default and adds a parameter to enable them (or some other
>>>>>> strategy that makes sense).
>>>>>>
>>>>>> I think these are potentially useful, so I don't really want to just
>>>>>> revert them, but if nobody thinks these are important enough to fix,
>>>>>> that's a possibility.
>>>>>
>>>>> Hide behind debug or expert option by default? or even mark it as BROKEN
>>>>> until someone fixes it?
>>>>>
>>>> Instead of making it a config option, wouldn't it be better as a kernel
>>>> parameter? People encountering this seem quite competent in passing kernel
>>>> arguments, so having a "pcie_bw_notification=off" would solve their
>>>> problems.
>>>
>>> I don't want people to have to discover a parameter to solve issues.
>>> If there's a parameter, notification should default to off, and people
>>> who want notification should supply a parameter to enable it.  Same
>>> thing for the sysfs idea.
>>
>> I can imagine cases where a per-port flag would be useful. For example, a
>> machine with a NIC and a couple of PCIe storage drives. In this example, the
>> PCIe drives downtrain willie-nillie, so it's useful to turn off their
>> notifications, but the NIC absolutely must not downtrain. It's debatable
>> whether it should be default on or default off.
>>
>>> I think we really just need to figure out what's going on.  Then it
>>> should be clearer how to handle it.  I'm not really in a position to
>>> debug the root cause since I don't have the hardware or the time.
>>
>> I wonder
>> (a) if some PCIe devices are downtraining willie-nillie to save power
>> (b) if this willie-nillie downtraining somehow violates PCIe spec
>> (c) what is the official behavior when downtraining is intentional
>>
>> My theory is: YES, YES, ASPM. But I don't know how to figure this out
>> without having the problem hardware in hand.
>>
>>> If nobody can figure out what's going on, I think we'll have to make it
>>> disabled by default.
>>
>> I think most distros do "CONFIG_PCIE_BW is not set". Is that not true?
> 
> I think it *is* true that distros do not enable CONFIG_PCIE_BW.
> 
> But it's perfectly reasonable for people building their own kernels to
> enable it.  It should be safe to enable all config options.  If they
> do enable CONFIG_PCIE_BW, I don't want them to waste time debugging
> messages they don't expect.
> 
> If we understood why these happen and could filter out the expected
> ones, that would be great.  But we don't.  We've already wasted quite
> a bit of Jan's and Atanas' time, and no doubt others who haven't
> bothered to file bug reports.
> 
> So I think I'll queue up a patch to remove the functionality for now.
> It's easily restored if somebody debugs the problem or adds a
> command-line switch or something.

I think it's best we make it a module (or kernel) parameter, default=off 
for the time being.

Alex
