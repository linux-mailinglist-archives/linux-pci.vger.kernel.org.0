Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B7E57286C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiGLVVB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 17:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiGLVVA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 17:21:00 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1952BE0E4
        for <linux-pci@vger.kernel.org>; Tue, 12 Jul 2022 14:20:59 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id m14so5624629iln.10
        for <linux-pci@vger.kernel.org>; Tue, 12 Jul 2022 14:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oN+PnrpImRr83fapsEh2XTJmU59JYHB3bffToNIUqeE=;
        b=DWzCGXIHTB9AKYsk4ACS5kbXpt1fGKzZVTDa9lFMBp73kOoYamNJu48tclZu7BTjfU
         kryZiW1kwaWhj9wyAXGjgjLFCJTvNYDss+9sl5jZSQZVhFiAyrU6Gk0WrueFBRQFY7Lq
         7oFrbiGDtgAvkwDHRVQNUpR1LISK2w9fGDwO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oN+PnrpImRr83fapsEh2XTJmU59JYHB3bffToNIUqeE=;
        b=EQnLcigRCJLa/0Iq4WFD+zH28fSPJ65NeW4RqYUApeIdAWQr6Mm6EQyZ4JgSH4Uobd
         HLIWWSD9FRTrg5pNxcnG+lLbvk5j5KuyW6fGsnsVsc5icJGgDtujjJpFvltrPrgOM+rZ
         cKHAOCr6zUbAxVsbTQtvKz0Ff4ER0U60uL6UgHMHkovPF/SHB/tAC8Z/H5zGkD6iKIC/
         MXIz8sw3/ho1oDH9cTlzg2I8IPjY3e+z6lzzi6v0kiGmCxPVx6zvBm7SuMGzwUBmUlCM
         Feye80VFb44I/uh77Ta5wFF33XxEeMjXT7ydjG4J5Tk34RYRhErzbx1SKCfqblH5gHZ9
         /MyA==
X-Gm-Message-State: AJIora/o/aJrh25WO7ZXW2Kd6Z3xvR1h0OE0mtm2p2oajrFKYDWjJ+QL
        IyC6HJ+3PjzS+LtGNWQF09f9gw==
X-Google-Smtp-Source: AGRyM1tpjBU+Ay8SKYCP9IICT3V0RoFnA7tVo2wPCLumGhPRLs1NIYbetHvJnLR1N3G8/2l2FNCThg==
X-Received: by 2002:a92:da4e:0:b0:2d6:6554:a33b with SMTP id p14-20020a92da4e000000b002d66554a33bmr108100ilq.10.1657660859021;
        Tue, 12 Jul 2022 14:20:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d66-20020a026245000000b00339e158bd3esm4415557jac.38.2022.07.12.14.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 14:20:58 -0700 (PDT)
Subject: Re: [PATCH] MMIO should have more priority then IO
To:     Matthew Wilcox <willy@infradead.org>, Nadav Amit <namit@vmware.com>
Cc:     Ajay Kaher <akaher@vmware.com>, Bjorn Helgaas <helgaas@kernel.org>,
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0fac9918-2848-d01c-ee19-96a0cfd7b370@linuxfoundation.org>
Date:   Tue, 12 Jul 2022 15:20:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Ysh63kRVGMFJMNfG@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Matthew,

On 7/8/22 12:43 PM, Matthew Wilcox wrote:
> On Fri, Jul 08, 2022 at 06:35:48PM +0000, Nadav Amit wrote:
>> On Jul 8, 2022, at 10:55 AM, Matthew Wilcox <willy@infradead.org> wrote:
>>
> 
> Just because I don't use your terminology, you think I have
> "misconceptions"?  Fuck you, you condescending piece of shit.
> 

This is clearly unacceptable and violates the Code of Conduct.

Others including the person this was directed at already called out
the violation:

https://lore.kernel.org/all/85071FE5-E37A-44CF-9EF7-CB80C116A876@vmware.com/
https://lore.kernel.org/all/880aac01-9c78-34f7-8a11-d48179e1635c@redhat.com/

You should be well aware that this type of language and personal attack is a
clear violation of the Linux kernel Contributor Covenant Code of Conduct as
outlined in the following:

https://www.kernel.org/doc/html/latest/process/code-of-conduct.html

Refer to the Code of Conduct and refrain from violating the Code of Conduct
in the future.

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)

