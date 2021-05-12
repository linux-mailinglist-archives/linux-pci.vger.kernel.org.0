Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4467937B73F
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 09:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhELH5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 03:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhELH5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 03:57:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128E7C061574
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 00:56:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id j26so22274003edf.9
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 00:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tIBHfSJt9kDWB5fCXcJV0FO2S7gfHZLiFYQOHuDU0Og=;
        b=Nis+IReHAW6dADb7bLao60ZV0WivRqj8XtjrJEpjdJ15ukXyR8eT92+IXXy1dnePJJ
         LibTm4A8kTzDyY7CSjqk9k5ue4el88XEW3TM3xP50lsFxGa/z4zWX2tZHFkQVhKbjKz7
         1kX9RWjy5HG4L9g6G47AfdfHW/YJtMQ6SDw9jNn2wqZ8bRdN9wbaB1ibufEe7WmGAJw+
         pIwwSNMjJfa4qI8zuz5vZwG4kkpn/DtEoSlHYu+TRLsW+bT5JoOQG0LzgkxH68dFI+i9
         hxw3iDW9ugqjEnHbCYhjfcjMMpSZUce1xsVHoBSBwciZ+gZeK4HgcyoxpmoqJRnJ6Ap/
         D0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tIBHfSJt9kDWB5fCXcJV0FO2S7gfHZLiFYQOHuDU0Og=;
        b=SoKbsClo1+7Io65riTILCPerxNAWi0nq1C3iCk/9mJw9eXDUdkCYgruN2ISKnhQpI5
         V3egJyRw92sIDoHaeSghVypEr1+yF/x9qg8KaU3Q2K2Lqhbu4uNHnW8UaUCjp6AxJMkR
         0BA+zWgwygJ+qoB6hID+0ZXNybH4cTCsdLGdt3EqmYRU6SazU/rwlpR1CQllenha24Pr
         PCxchqZ+r6u0rJpr15vo9tOnnJghvG8DdkFgzedXIN1SVR0x7noPjA+soRTqAUfBT/8j
         izWQ5v8zZN6tSZdS5a+wmwo27y06LyOJTAyA4Pk6j1BggZekiRiNrdWtb9WA715V4GYv
         rzsg==
X-Gm-Message-State: AOAM530HWsWDl+PzEZOA+sjTHfkfVjgb+bVvlTbIpAY2b7KKy5nhnaat
        SNinW5eNnhKBGCV74cLLU3E=
X-Google-Smtp-Source: ABdhPJw5uI+GpRcxLqjLWYzqk0IzYcwTFaB3dOX6XNrpX44yMNzb6W+5LI0ZJtpXjULrf2ubfzut+w==
X-Received: by 2002:a50:eb94:: with SMTP id y20mr3466247edr.85.1620806201841;
        Wed, 12 May 2021 00:56:41 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8f6:6731:68b8:1f62? (p200300ea8f38460008f6673168b81f62.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8f6:6731:68b8:1f62])
        by smtp.googlemail.com with ESMTPSA id y21sm15959554edv.77.2021.05.12.00.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 00:56:41 -0700 (PDT)
Subject: Re: [PATCH v2] PCI/VPD: Use unaligned access helpers in pci_vpd_read
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <5719b91c-9f91-0029-0a28-386f1cb29d31@gmail.com>
 <YJjUWulw8vkscdwg@infradead.org>
 <26a9b3ec-07dc-c474-25ad-d7082060d305@gmail.com>
 <YJuCD9WCpV+rViys@infradead.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <fa73ec3d-55d5-b430-39fc-fab7938b18bd@gmail.com>
Date:   Wed, 12 May 2021 09:56:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJuCD9WCpV+rViys@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12.05.2021 09:21, Christoph Hellwig wrote:
> On Mon, May 10, 2021 at 09:09:02AM +0200, Heiner Kallweit wrote:
>> len can have any value 1 .. 4. Also the proposal doesn't consider
>> the skip value.
> 
> So what about just keeping the code as-is then?  The existing version
> is much easier to read than the new one, has less branching and doesn't
> use an obscure API thast should not generally be used in driver code.
> 
Which version is easier to read may be a question of personal taste.
Using the unaligned access helper in pci_vpd_read() was asked for by
Bjorn to complement a use of get_unaligned_le32() in pci_vpd_write().
So I leave it up to him. Functionally it's the same anyway.
