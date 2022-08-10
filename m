Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DE258E72A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 08:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiHJGNr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 02:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiHJGNp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 02:13:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B80647FA
        for <linux-pci@vger.kernel.org>; Tue,  9 Aug 2022 23:13:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z6so12407010lfu.9
        for <linux-pci@vger.kernel.org>; Tue, 09 Aug 2022 23:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=i2gdhC2rvffRFn6QLbsSeXxxD0KZvfsj4PfnDV5evx8=;
        b=b8C+B3uEVgdnTcwAksQm0gbtOcmyA1OEwrGay4Rek4sgd0pJK12dIGk2YSm0MeupVG
         eBHbzLS8mBKS4Hwo0QTRuEHkChMhQsw/852H9Ww4sggXrT0KrRsHoJbt9U3zyYQLePFD
         /E10+cd5jHiD0Z76BzMXcStnyqeQJjyEIu2PiwW+KDiRCFSQ1E4bwsyDCtTeo6zuk6uP
         l4WSpNoNkLTapxhzSQbWXp6l9bOOduvmUMOjPlC/QTLz2oidn8OqNxatwR0XVHxCoHrG
         Vf/PFaymUoAiKrxfcV3OQdcZQ3tT2G9dV/gH9mdQxzBcH+285riOMycB6Txr9rNmaDq3
         DBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=i2gdhC2rvffRFn6QLbsSeXxxD0KZvfsj4PfnDV5evx8=;
        b=P6gUYQOVnk6kfil6CCAyxRL+E1nYMHLrWN7XEtiwNGvw7qdXEjUOwXBY3DGKHOXql1
         CB3hmU0bYksxSMU1dshSYxJ0+gCEzxFmj8YCrsTpCJQ9tYnY9wNtzvkRmvgQ34OCi4ob
         jIHl6lAavc3NpT8zQrxB1gNHozkhwZcVYTN/BUAncVxaadfoq+dRQIUiHrFOh+Qi2YnE
         8iDuocO6QJgrb7+Cjtn4LrY2hP4R2WiImX4g2sgERs3h7RQhi1GwBMKO9nBu+P1pD5Qe
         icxu5DCaEi+AXO4jwevaZSM3FfmTeFGJJpro3wbHXGa8jdspwNBzkDO1CDM0/c3aMAG7
         KLjw==
X-Gm-Message-State: ACgBeo1MO2BV4P4374G+1WUMp+4hibP5vpXH7wI8c+jX1a4NIsehMEyp
        YM3ukQhmkNAcJs2FhNUBodxO8Q==
X-Google-Smtp-Source: AA6agR4qu+3Sz3tifCu8c4Zy550No4zrXM4kHyQBskFrpvpiKh43LgFdchUEg3JlJmjwYjLT8GhqxQ==
X-Received: by 2002:a05:6512:3501:b0:48b:205f:91a2 with SMTP id h1-20020a056512350100b0048b205f91a2mr8947820lfs.83.1660112022262;
        Tue, 09 Aug 2022 23:13:42 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9dc1000000b0025df5f38da8sm268641ljj.119.2022.08.09.23.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 23:13:41 -0700 (PDT)
Message-ID: <28388e27-e562-65cd-4663-977ea4ad51a0@linaro.org>
Date:   Wed, 10 Aug 2022 09:13:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [REGRESSION] changes to driver_override parsing broke DPDK script
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     bhelgaas@google.com, gregkh@linuxfoundation.org,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev
References: <20220809192102.GA1331186@bhelgaas>
 <af880c1a-cedd-181f-9b4d-2f1766312fc0@linaro.org>
In-Reply-To: <af880c1a-cedd-181f-9b4d-2f1766312fc0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/08/2022 08:54, Krzysztof Kozlowski wrote:
> On 09/08/2022 22:21, Bjorn Helgaas wrote:
>> [+cc regressions list]
>>
>> 23d99baf9d72 appeared in v5.19-rc1.
>>
>> On Tue, Aug 09, 2022 at 11:29:43AM -0700, Stephen Hemminger wrote:
>>> This commit broke the driver override script in DPDK.
>>> This is an API/ABI breakage, please revert or fix the commit.
>>>
>>> Report of problem:
>>> http://mails.dpdk.org/archives/dev/2022-August/247794.html
> 
> Thanks for the report. I'll take a look.
> 

I could not find in the report (neither here) steps to reproduce it. Can
you provide me some short description (what kernel options are required,
what commands to run)?

I tried to run:
$ usertools/dpdk-devbind.py --status
$ usertools/dpdk-devbind.py --bind '0000:00:03.0'
Error: No devices specified.


Best regards,
Krzysztof
