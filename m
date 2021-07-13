Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8286D3C7129
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 15:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhGMN2A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 09:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbhGMN17 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 09:27:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C32C0613DD;
        Tue, 13 Jul 2021 06:25:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p9so12125074pjl.3;
        Tue, 13 Jul 2021 06:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=jgImV5lDtzOU/4Ozn0Pepwsu6kVjkzMXFrQpmXM9B/Y=;
        b=p1mvoMvp4mvqswdbZNS5xjzN1dpNtfUKbZQjX3d36BDJIX063CJDSWMGynLk32Dpcl
         HzxaCudHVV6YCXcu7sOe4FwtSu/cGO2/z/W7OdON9BmfHuK498X1sUuKbw3Xu54zSLX7
         1ISKiWufCV41WlFLzyJdcdybJqi+/oTO5UADMY3rkujHRDJmN5pOJL7ZkDJaFg4bd0GD
         U6wuEEtlQwVf54TCTt5Z0/R8RN+G9Xq7626CFHsjoMWgTIWLZ7DjiI9JMMBYUpfkd9LY
         xxKFEkqYVa3SxO/4hCt+BUtVCQYkDK3NXlLnXDGyhN0S2bS/fiQ0XJMe89nOxxoFF4/E
         Q5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=jgImV5lDtzOU/4Ozn0Pepwsu6kVjkzMXFrQpmXM9B/Y=;
        b=NomjAphcQqFXoeEFW3jDNcUroGmhgS/Sq71RQX2qPhiZgSA9Byyy/vAxdMoN81z0Ad
         WVSkPSIgwrsK4IPzyEburiq1Dw8DGCtDFC/dS/RWIh9QohX+/p/BY/twdrOr7PWGxqUJ
         pu3JCKy5OVb2izr4rZjR8iCxO3ambtueapvl3NSTh4F+rqHcEHdrTlo70U+SlMb6xuZv
         EQ//iSNQwzA8E8JZjvLp7RcPFMgch8v/S+55h+znHs+Uq0XahHpymGM9EGqlNgauph6C
         ElPcxyV7S/gghk/Tsf/SNBB7D3J3O1evgaH0xeC7FaHxjZ4PbR2cSlv6pFCvgnspqpU3
         UXzw==
X-Gm-Message-State: AOAM531PFA7MnnltR7PEx8bwpwNSM8Vw7nPKHbcQxjZdy5acfSy3uj+4
        bCzaCwAgeoDECIQFrH38qGDFZ0RSDg7Q
X-Google-Smtp-Source: ABdhPJxYO9Wb5G4T+kKf2OoQ0BLxKzEmh9t+Ma12OzfNi+1rVxQ4yBBqBfcODWuPuJDc4unpXBpXMQ==
X-Received: by 2002:a17:90a:5a4d:: with SMTP id m13mr4222530pji.7.1626182708070;
        Tue, 13 Jul 2021 06:25:08 -0700 (PDT)
Received: from [10.109.0.6] ([45.145.248.64])
        by smtp.gmail.com with ESMTPSA id m19sm9631952pfa.135.2021.07.13.06.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 06:25:07 -0700 (PDT)
Subject: Re: [PATCH] tools: PCI: Zero-initialize param
To:     Leon Romanovsky <leon@kernel.org>
Cc:     bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210627003937.6249-1-yang.shunyong@gmail.com>
 <d4c250af-aa50-0ec0-c66a-104092646e15@gmail.com> <YOrcUcx2PdaBxRQi@unreal>
From:   Shunyong Yang <yang.shunyong@gmail.com>
Message-ID: <26dbd10a-3d4e-032a-ec56-3eddac5eb4aa@gmail.com>
Date:   Tue, 13 Jul 2021 21:24:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOrcUcx2PdaBxRQi@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,  Romanovsky,

On 2021/7/11 19:56, Leon Romanovsky wrote:
> On Sun, Jul 11, 2021 at 09:48:17AM +0800, Shunyong Yang wrote:
>> Hi, Bjorn and Kishon,
>>
>>    Gentle ping. Would you please help to review and merge this tiny change?
>>
>> Thansk.
>>
>> Shunyong.
>>
>> On 2021/6/27 8:39, Shunyong Yang wrote:
>>> The values in param may be random if they are not initialized, which
>>> may cause use_dma flag set even when "-d" option is not provided
>>> in command line. Initializing all members to 0 to solve this.
>>>
>>> Signed-off-by: Shunyong Yang <yang.shunyong@gmail.com>
>>> ---
>>>    tools/pci/pcitest.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
>>> index 0a1344c45213..59bcd6220a58 100644
>>> --- a/tools/pci/pcitest.c
>>> +++ b/tools/pci/pcitest.c
>>> @@ -40,7 +40,7 @@ struct pci_test {
>>>    static int run_test(struct pci_test *test)
>>>    {
>>> -	struct pci_endpoint_test_xfer_param param;
>>> +	struct pci_endpoint_test_xfer_param param = {0};
> You can simply write {} instead of {0} - zero is not needed.
>
> Thanks

    Will change as you said.

Thanks.

Shunyong.

>>>    	int ret = -EINVAL;
>>>    	int fd;
