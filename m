Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA26A5A88F3
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 00:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiHaWXl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 18:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiHaWXk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 18:23:40 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84F5EC4F9
        for <linux-pci@vger.kernel.org>; Wed, 31 Aug 2022 15:23:39 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b142so13142031iof.10
        for <linux-pci@vger.kernel.org>; Wed, 31 Aug 2022 15:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=miyRcNC1y0vsniVUl0NgdGeT8nnjBL8mxk5ecu0uiXU=;
        b=hv+6GSBKI3wwu2uR92+VMzS7/dU65vaLiW7YKmAui3USy1O/iIk//DsW1NrzY/VWGT
         BzLKQN5G5Q/pRR5i8RB15pBuPDDOil7zrqyJQ3mLkLUHj3pJ2hmgbMSx60yX137enyRn
         x3mYiD+saBudosvlMU4kTaPkfEYhuGabZeDv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=miyRcNC1y0vsniVUl0NgdGeT8nnjBL8mxk5ecu0uiXU=;
        b=PZNInbJrWvYCAp64N3hTFnDp/xPoESUlWL2Ii0v7Vpmn0s8BPJCZWFS8gpr2zVdxPM
         ecBo1Djy9p2SeOyYPUxUpz9BDxGiAaEk21qmoUA5ausXOxOFooABTsSsz3dp1OYeXYvG
         merfrbaZxcOsSkVG8cJ6DGiXBdY097TjcPM8gObhQj/k7YvTFOGAfRjzCbzz/veesM/2
         97NASU0wu379IkZrTraoptLKo5Em+QaOSU++tvb24SQOtdm22bZiggZGeIIjoVltQrSt
         kTv0rGEkIGVeZCiHlQUq3s7reZSBzBLDKEmWJYm1vLT1/CZXFysEMj7wB7KdCb2svdG+
         ptzw==
X-Gm-Message-State: ACgBeo1GV2VIK0qNhUoGRjrNlhV+YC7V0yWnyBpGfcFrjLy+VIq99sVT
        Omh6dAyLfZY6K5WnKSx23KR6NA==
X-Google-Smtp-Source: AA6agR4IzhnlQh9eX0jCUyN9bQz/kfTXE0uYI2WjqTR+88fGxzUFu/xfWvMr2he+aWV7pqrWGsaMLQ==
X-Received: by 2002:a05:6638:16cf:b0:34a:263f:966d with SMTP id g15-20020a05663816cf00b0034a263f966dmr12940861jat.124.1661984619022;
        Wed, 31 Aug 2022 15:23:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 6-20020a056e0220c600b002eadb40f2a0sm5102905ilq.23.2022.08.31.15.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 15:23:38 -0700 (PDT)
Message-ID: <7c2eaf26-ce54-b008-2f77-b7fe9989bf51@linuxfoundation.org>
Date:   Wed, 31 Aug 2022 16:23:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MMIO should have more priority then IO
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Nadav Amit <namit@vmware.com>, Ajay Kaher <akaher@vmware.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "conduct@kernel.org" <conduct@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com>
 <20220628180919.GA1850423@bhelgaas>
 <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
 <YsgplrrJnk5Ly19z@casper.infradead.org>
 <96D533E5-F3AF-4062-B095-8C143C307E37@vmware.com>
 <YshvnodeqmJV6uIJ@casper.infradead.org>
 <1A0FA5B7-39E8-4CAE-90DD-E260937F14E1@vmware.com>
 <Ysh63kRVGMFJMNfG@casper.infradead.org>
 <0fac9918-2848-d01c-ee19-96a0cfd7b370@linuxfoundation.org>
 <Yw/WKo69Re0g3zLl@casper.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Yw/WKo69Re0g3zLl@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/31/22 15:44, Matthew Wilcox wrote:
> On Tue, Jul 12, 2022 at 03:20:57PM -0600, Shuah Khan wrote:
>> Hi Matthew,
>>
>> On 7/8/22 12:43 PM, Matthew Wilcox wrote:
>>> On Fri, Jul 08, 2022 at 06:35:48PM +0000, Nadav Amit wrote:
>>>> On Jul 8, 2022, at 10:55 AM, Matthew Wilcox <willy@infradead.org> wrote:
>>>>
>>>
>>> Just because I don't use your terminology, you think I have
>>> "misconceptions"?  Fuck you, you condescending piece of shit.
>>>
>>
>> This is clearly unacceptable and violates the Code of Conduct.
> 
> In a message I sent to this mailing list on July 8, I used language
> which offended some readers.  I would like to apologise for my choice of
> words.  I remain committed to fostering a community where disagreements
> can be handled respectfully and will do my best to uphold these important
> principles in the future.  I would like to thank the Code of Conduct
> committee for their diligence in overseeing these matters.
> 

Thank you Matthew for taking this important step to show your commitment
to keeping our community a welcoming place that fosters respectful and
productive technical discourse.

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)
