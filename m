Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83374BAF53
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 02:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiBRBx6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 20:53:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiBRBx6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 20:53:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCBA5BD0F;
        Thu, 17 Feb 2022 17:53:42 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e3so12048215wra.0;
        Thu, 17 Feb 2022 17:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jMEIB15THGTxtNXLOvB466sh/1SDcuyPpBuIlzUH6sE=;
        b=DVh/7EC0rBfu1PWqJnTyj5IlsTMU+JwhkX6owWjwQXdzBr5Jd32NOuELM/sS94At7P
         +nfcIYp61cE0E5gR8D0KQoDYq9KiSGARZR7n0Ga63c/4j/u//U8iYkZIQfJiMsVmhOV6
         ydqeKEjqikiJSS9Fm8wRb3ED/Q7zarhTabOsoNdcvy1prKX80FKDYvLP8yYxt6Y+T+nA
         gQ1QdDea/0bMRHsIULjbtO6LjFqLUNVprRHyWtgsEYU0alFFpKb9U1HEw4BjFI9zcebh
         /2REfg5cRUS0iuDGmlrDwv6sauXIr3RdxIgrd4jO8cxxD1W0kAXwSlu4Xl85zcyH1S5Q
         Xuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jMEIB15THGTxtNXLOvB466sh/1SDcuyPpBuIlzUH6sE=;
        b=MIjVYGmnj1eYUTGAahEmT9cDdUd/UqklR28KBN2ct3mnXryBJmSCbZV1bqkVN3pdbB
         d804ihaKEbl6FJygf5nwkhLypxCorJmvprqck8Sbi/+77S1nOI9O1DowxuwZTHiis/Fd
         MDrmtY8XVIF9DgOG8ifGCdzXXnnpvuvZ0a8Wr1wFUlZSl96lLGiHVw31GIFDS8c9KKvn
         UQdYIMqR7hbgtDKldnfGvbyJm+o95xfZpvM8tKVgLOTBWi89dHQJcTyuEGZYRJ0pwnv8
         WW48cLUAw3rULPXcY+b/3qE2qCei/GPkz642Q/u0Ouj6BwnjC5f2Y4KUBDpqCmuCnDle
         xtwA==
X-Gm-Message-State: AOAM532fbV40bW46YCaXR0QFB2tIleS/fjfXUgIgcmAcovbR++vq6DSG
        NLGlQV6NldSpW2nSmOFGvnU=
X-Google-Smtp-Source: ABdhPJxip/MqSLYCf9Rtf8qtzSgp0RnKlCaTUlOAI84HK18JFRL0tF7UrWAVeYNrBefRrWY0E4jl4Q==
X-Received: by 2002:a5d:64e3:0:b0:1e4:a380:bb6f with SMTP id g3-20020a5d64e3000000b001e4a380bb6fmr4358992wri.463.1645149221050;
        Thu, 17 Feb 2022 17:53:41 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id m8sm2941228wms.4.2022.02.17.17.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 17:53:40 -0800 (PST)
Message-ID: <4901fe69-5bf2-0083-d890-bfaee467f57d@gmail.com>
Date:   Fri, 18 Feb 2022 02:53:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 2/2] PCI: rcar: Return all Fs from read which triggered
 an exception
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20220122221554.196311-2-marek.vasut@gmail.com>
 <20220123153147.sv6eoayxqvqbaa66@pali>
 <7ced7370-1853-b52d-7e04-062d1bf3334c@gmail.com>
 <20220123164936.cmzvkkkuw5chz3ek@pali>
 <9d89314c-8757-8965-0f5d-14fd95669320@gmail.com>
 <20220124093752.l2kpenot6wj76753@pali>
 <65a09af0-f09d-cf46-3d04-d7c9d2750227@gmail.com>
 <20220131125341.7jzckjihz3cwrxg3@pali> <20220217112949.xt6saomde47prbom@pali>
 <ae4dcb09-98d0-64e8-79a8-1bff16505abc@gmail.com>
 <20220217130405.xq73bqshvldy2vn2@pali>
From:   Marek Vasut <marek.vasut@gmail.com>
In-Reply-To: <20220217130405.xq73bqshvldy2vn2@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/17/22 14:04, Pali Rohár wrote:

[...]

>>>>> Flipping either bit makes no difference, suspend/resume behaves the same and
>>>>> the link always recovers.
>>>>
>>>> Ok, perfect! And what happens without suspend/resume (just in normal
>>>> conditions)? E.g. during active usage of some PCIe card (wifi, sata, etc..).
>>>
>>> PING? Also what lspci see for the root port and card itself during hot reset?
>>
>> If I recall, lspci showed the root port and card.
> 
> This is suspicious. Card should not respond to config read requests when
> is in hot reset state. Could you send output of lspci -vvxx of the root
> port and also card during this test? Maybe it is possible that root port
> has broken BRIDGE_CONTROL register and did not put card into Hot Reset
> state?

Yes, I could set the hardware up again and run more tests, it will take 
some time, but I can still do that.

But before I spend any more time running tests for you here, I have to 
admit, it seems to me running all those tests is completely off-topic in 
context of these two bugfixes here.

So maybe it would make sense to stop the discussion here and move it to 
separate thread ?

I have to admit, I also don't quite understand what it is that you're 
trying to find out with all those tests.
