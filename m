Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F01D377CED
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 09:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEJHKP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 03:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhEJHKO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 03:10:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956F8C061573
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 00:09:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z6so15404692wrm.4
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 00:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GviCxizU8MAUq4BsmVs+vwODzzoFDedx2IBplXZauj8=;
        b=M1dx8zr/gHnHQOlhsZKbOn9pC3BP5EHGiY9bp2yqwjdhLXlThan2OqesRnPMFRzQzc
         FxDnP4HWljQ7GDtAaOm47NflUAT7CaNaChoCsdy/cRtfiZuM6PxgA51VmaQSSa98DGbn
         Yxiuc89vDHab3Bc508aRM0ETESFutlbyct5FxeahhBigBBl8dv2WJLBn9+Y+B0XECSza
         XoGWwzjFmqvrbmv3RZSuIiEsh8PowcgaiNGyCed308pD7vSBtorDpP5lH0+oxEuXkdAS
         sXAt6rEzs5IxZH0O0hvsciIl7rZ6yazVdYhaaM9CKTzNUNDunQ9f7/Sno11wCpOs7C87
         /FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GviCxizU8MAUq4BsmVs+vwODzzoFDedx2IBplXZauj8=;
        b=qvET4lAq7KQHR8njLtY1RtOLOP0bksmVnh8YmQLMqw0KIWRwXqFex1u/8WafkzROoY
         1l7HK1xJZF34ox5z/GqFgATQISeGkd69CZc52ZsC6USjhqzShlbpI5IBaX+E0d7HdHof
         AFjriCW2m2ePytbK3DxRKGmg/vBMKK4uRK5osz6aKQoUV3EbJ0ep2EhpwKgTz+OHxgaH
         RbgX6XDxgFBkNaolrcZcXbYEEziw48qTOlDYevta5Yzhp2zJyKdZx7mOG/La7nJ0eq5E
         4XwoXSJ2jMxigP1p6+m7SDXQmvvOfpTQFSuovYrdp0sWW28QmHRlWYsSnpeZHmtrWSpN
         O3Eg==
X-Gm-Message-State: AOAM53159EIG4vL6fKGfoyQWEKD1u6T2FExxFnaJqfz/LZ7Qcct4HJPO
        TAfilsDQ2gPWDpYvAp8IF3U=
X-Google-Smtp-Source: ABdhPJywCcT+i2PYTAikddPCzFdrhEdSc43GQBrxr7GDcoWsvQ5Y3PUWGvZ6RqOr5KPBAZSnQOwvpQ==
X-Received: by 2002:adf:efca:: with SMTP id i10mr28999537wrp.284.1620630549410;
        Mon, 10 May 2021 00:09:09 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:7d85:535b:ab9d:c06e? (p200300ea8f3846007d85535bab9dc06e.dip0.t-ipconnect.de. [2003:ea:8f38:4600:7d85:535b:ab9d:c06e])
        by smtp.googlemail.com with ESMTPSA id n2sm21717904wmb.32.2021.05.10.00.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 00:09:09 -0700 (PDT)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <5719b91c-9f91-0029-0a28-386f1cb29d31@gmail.com>
 <YJjUWulw8vkscdwg@infradead.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2] PCI/VPD: Use unaligned access helpers in pci_vpd_read
Message-ID: <26a9b3ec-07dc-c474-25ad-d7082060d305@gmail.com>
Date:   Mon, 10 May 2021 09:09:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJjUWulw8vkscdwg@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10.05.2021 08:36, Christoph Hellwig wrote:
> On Sat, May 08, 2021 at 12:29:15AM +0200, Heiner Kallweit wrote:
>> +
>> +		if (len == 4)  {
>> +			put_unaligned_le32(val, buf);
>> +		} else {
>> +			cpu_to_le32s(&val);
>> +			memcpy(buf, (u8 *)&val + skip, len);
> 
> cpu_to_le32s is a horrible API that breaks endianess annotations.
> 
The endian-adjusted value is used just in the next line, so I think
there's no risk of wrong usage.
But yes, this function converts to le32 w/o using __bitwise.
Therefore I understand the concern.

> Is the intent of this code to only put 16 bits in?  Why not something
> like:
> 
> 		switch (len) {
> 		case 4:
> 			put_unaligned_le32(val, buf);
> 			break;
> 		case 2:
> 			put_unaligned_le16(val, buf + 2);
> 			break;
> 		case 1:
> 			buf[3] = val;
> 			break;
>   		}
> 
len can have any value 1 .. 4. Also the proposal doesn't consider
the skip value.
