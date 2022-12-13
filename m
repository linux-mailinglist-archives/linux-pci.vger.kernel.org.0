Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D164B7F5
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 16:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiLMPAr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 10:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLMPAp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 10:00:45 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9872C209B6
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 07:00:44 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id pp21so9805315qvb.5
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 07:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VAVmORDgKncNGjHxnbVLXs4S1HZPM6MzY9k7CtvlbV8=;
        b=HxZO9IEofuwWsy1yIAmZJ6e/xOrdI46OAAksmhcr1UbSBVDZNMeelWrNaL2PeL4/W2
         o4z5ELlGk2dePy9heI34I45yD4qkx9zO0bsEL6XVmJZhjTIZP3ADhA4LrdalHUgEyvRB
         KesYRYh82wG0lMnYFe0b0Jgr9EXH2wO5JZ6OhI8iaySahTfUhu5hSpfmBckUMvf+pXcA
         7ESoHYIr+N4yyP1YmNXHR2f7gn2Z273jPZu/CUxKculJB27fAFVl5UlhVmV6o2AEXee1
         WdMh453aMnRPZfC9aPOHpjKIFk9XTlvttZTTQXJqCd4pFFYLLvD4Kq6uyNy/Td80qFjt
         fuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAVmORDgKncNGjHxnbVLXs4S1HZPM6MzY9k7CtvlbV8=;
        b=f+IiCC4X0yn4zh1+Adw8pwyZfNrEIN6Y5JcrJ6AZ8cgkMwlNjf+Z2SBS/4E8nZ3I15
         4U8Fznuc0nD8Kz3Lt8SqVisqGBGKCn68WNRMcx6k0MhVBu8nBV5LbpJpz8o2UhJpvvjo
         u9c+c48kAA+nTP3MbaR1+8kiWrfCmzv92+kvPsxE0ltP2F3CYuiUcoJ0Gg0NuZmFC5ke
         ClqgefGK2yDDShpRcj94VzDsz+xt/hpqRNZubRl82kO63m/HUcl7b4GWZb5Z7ODFXRWY
         R7x8XbIZj7BjajJKTUGT2EBmsadDkp40n18vanmz05sZY2SCOsvWnnq+3PcHeVl4AM7C
         riiw==
X-Gm-Message-State: ANoB5pkoL9UkHLQkXidZ5PehDoBvx2VcsvSFAopFktPbxYn0khMcWyB+
        2qGN1GVmyHLTsaCT11FKNU/Wig==
X-Google-Smtp-Source: AA0mqf4buabfPZA+O8n0E0wlnNqgocLpocLa64Vgixdm50vCs/BCZzzgUpdGZCG38HTYVzaYvoKURA==
X-Received: by 2002:a05:6214:14ec:b0:4c6:ff2d:29b1 with SMTP id k12-20020a05621414ec00b004c6ff2d29b1mr27771041qvw.1.1670943643466;
        Tue, 13 Dec 2022 07:00:43 -0800 (PST)
Received: from [10.230.45.5] ([38.32.73.2])
        by smtp.gmail.com with ESMTPSA id bi35-20020a05620a31a300b006faa88ba2b5sm6568066qkb.7.2022.12.13.07.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 07:00:43 -0800 (PST)
Message-ID: <2f49eee1-7c72-8281-50c1-debaccd43c81@ixsystems.com>
Date:   Tue, 13 Dec 2022 10:00:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: pci_bus_distribute_available_resources() is wrong?
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Nick Wolff <nwolff@ixsystems.com>,
        Bjorn Helgaas <bjorn@helgaas.com>, linux-pci@vger.kernel.org
References: <2ec11223-edb3-5f5c-62cd-3532d92de0a4@ixsystems.com>
 <CAErSpo7WrAg5D4xyv0SycoDc1etSspU_TL6XMAK4STYrXDrGNQ@mail.gmail.com>
 <6053736d-1923-41e7-def9-7585ce1772d9@ixsystems.com>
 <Y5gSfJd0H4rKXe9H@black.fi.intel.com>
 <35208ffe-0aee-b055-0ed7-99b6414af6da@ixsystems.com>
 <Y5iQtaNgr0nMWjAI@black.fi.intel.com>
From:   Alexander Motin <mav@ixsystems.com>
In-Reply-To: <Y5iQtaNgr0nMWjAI@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.12.2022 09:48, Mika Westerberg wrote:
> On Tue, Dec 13, 2022 at 09:11:12AM -0500, Alexander Motin wrote:
>>> I'm also more than happy to test any patches regarding this if someone
>>> else wants to work on it ;-)
>>
>> I was kind of ready to dive in, I hate hacks and tunables to workaround
>> bugs.  But as I have told, I see this code first time, so my solutions may
>> appear not right.  But I'll help as I can, if needed.
> 
> That's good to hear :) Okay feel free to use any of my previous patches
> as base if needed. I can test the Thunderbolt/USB4 and the QEMU PCI/PCIe
> topologies so please keep me in the loop when submitting.

It is quite a quick change of roles, don't you find?  It is you created 
the problem.  It is your email includes "@linux.intel.com" here.  Don't 
you feel some responsibility? ;)

Where are the current result of "I'm working on a new version of the 
patch series that should take these into consideration"?

-- 
Alexander Motin
