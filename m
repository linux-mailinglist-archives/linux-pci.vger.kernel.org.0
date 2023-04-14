Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F133A6E2336
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 14:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjDNM1K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 08:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjDNM1I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 08:27:08 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62FEA5DE;
        Fri, 14 Apr 2023 05:27:06 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id l11so19161449qtj.4;
        Fri, 14 Apr 2023 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681475226; x=1684067226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lOLnLUyWsueTcuj2HNW2KGjMx5SMzfhFbviIP3xXYOo=;
        b=OrBfzxeofaBx3S6TatIutjwAt0TpdUSnm9rchMg3fvcJeOVr4wCpnKFvlgST5vx7Kr
         +EMNAPLBYF1RlDljKKQ+bKtK4QZ65wZgZNhnJQKk+a5/nievSQPdWLl61pDPxV8P33zL
         JmXXiklPMqcDIH1vqM7noklxBajEsV40yzCEdLoqZTWogyPy8Q03tKrFrIClPfMju5rd
         M1sQrBUk3ntc4hpp4VOYoiHBMH3qeZjb6ShTCDjqyHsVHiV1mgAtkqyl9MzyM5h7zk0l
         VzI/sORklNb8YHNqAiS+9ffJl9uJ9GfFnUgG8IFZ+lC6jg7UFHETPftqVuc0PN/5pz+i
         4iEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681475226; x=1684067226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOLnLUyWsueTcuj2HNW2KGjMx5SMzfhFbviIP3xXYOo=;
        b=DYgi+xQXlgunH/fUkF7fuiQO/wMtAAe4jBKv1Vv1q5NI8CDwwS9uS3G6c3pMPIo/J/
         ilJ6ElaEfH9vagm5EjmbCS3njfRgpgevOLwZ37CjNnqFXchf2nYMUDQEZwVbnN/oH4dl
         dAElE8ey7t4uZ4IX3V3ci1Qgvi48p1y/vPKPrn0vbVHI0IEMCG5PzShfgQkZvFrPNs/v
         vm3g9JAey215D4/oFfUwDj0qeuLe60for62ixVBhUvX14wLfcFfn2AWs8LMUTATzhOj7
         JwUiY3ypXJfzFhygJe4mhYtvFERVS2SVnDyci9V2UHbCxxE8MtKkIUVbNQ+RQwSbAd2+
         9xZg==
X-Gm-Message-State: AAQBX9dtJ3aNIBBux0MzPv8Ep2s5SN0wvIArUAualVCGH9GXoopaaDMb
        7hVQ2y5RiRI3Q1K942DWVmfkr3Xz+vWpFQ==
X-Google-Smtp-Source: AKy350aqZ8F8Upq3pSjo9kCKeDEwex0PMvg1Zgjwk2kanisFlrJRxt9NGtqdtNpjhAWYlLIvYUIfpw==
X-Received: by 2002:a05:622a:1114:b0:3ea:abb2:23c8 with SMTP id e20-20020a05622a111400b003eaabb223c8mr4893335qty.42.1681475225750;
        Fri, 14 Apr 2023 05:27:05 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id q11-20020a05620a2a4b00b0074a3c282c7dsm1183844qkp.97.2023.04.14.05.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 05:27:05 -0700 (PDT)
Message-ID: <85a1cca1-f59b-6a0c-dee3-9d9ed5d6b6d1@gmail.com>
Date:   Fri, 14 Apr 2023 05:27:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/3] PCI: brcmstb: CLKREQ# accomodations of downstream
 device
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>,
        Cyril Brulebois <kibi@debian.org>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230411165919.23955-1-jim2101024@gmail.com>
 <20230411165919.23955-3-jim2101024@gmail.com>
 <20230413143935.pmbyjk2boxl3rwne@mraw.org>
 <CANCKTBtXKAYf1LxR4qN+dVyxsWgyDztUVB4EdG=xhHbuhNCq5w@mail.gmail.com>
 <20230413200646.ddgsoqgmaae343nl@mraw.org>
 <CANCKTBuZ=Hxy9WgnjbauhHqXGx4QU_t8pgX=3che2K89=2BT9A@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CANCKTBuZ=Hxy9WgnjbauhHqXGx4QU_t8pgX=3che2K89=2BT9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/14/2023 5:14 AM, Jim Quinlan wrote:
> On Thu, Apr 13, 2023 at 4:06 PM Cyril Brulebois <kibi@debian.org> wrote:
>>
>> Hi Jim,
>>
>> Jim Quinlan <jim2101024@gmail.com> (2023-04-13):
>>> Can you provide (a) the full boot log prior to applying the patch
>>> series and (b) full boot log after applying the series, using an
>>> IDENTICAL setup. If it fails on both then it has little to do with my
>>> patch series.
>>
>> Just to be clear, the issue I reported was with:
>>   - Raspberry Pi Compute Module 4 (Rev 1.1, 4G RAM, 32G storage)
>>   - Raspberry Pi Compute Module 4 IO Board
>>   - SupaHub PCIe-to-multiple-USB adapter, reference PCE6U1C-R02, VER 006S
>>
>> This was my minimal reproducer for the kernel panic at boot-up, which
>> goes away with either v1 or v2. When I realized I didn't actually check
>> whether the SupaHub board was working correctly, I plugged 2 devices to
>> obtain this setup:
>>   - Raspberry Pi Compute Module 4 (Rev 1.1, 4G RAM, 32G storage)
>>   - Raspberry Pi Compute Module 4 IO Board
>>   - SupaHub PCIe-to-multiple-USB adapter, reference PCE6U1C-R02, VER 006S
>>   - Kingston DataTraveler G4 32GB on USB-A port #1 of the SupaHub board.
>>   - Logitech K120 keyboard on USB-A port #2 of the SupaHub board.
>>
>> It turns out that this particular revision of the SupaHub board isn't
>> supported by xhci_hcd directly (failing to probe with error -110) and
>> one needs to enable CONFIG_USB_XHCI_PCI_RENESAS=m and also ship its
>> accompanying firmware (/lib/firmware/renesas_usb_fw.mem). With this
>> updated kernel config, I'm able to use the keyboard and to read data
>> from the memory stick without problems (70 MB/s).
>>
>>> In my last series your testing somehow conflated the effect of an
>>> unrelated MMC interrupt issue so please be precise.
>>
>> I wish things would be simpler and didn't involve combinatorics, let
>> alone other bugs/regressions at times, but I'm really trying my best to
>> navigate and report issues and test patches when I can spare some time…
> 
> Hi Cyril,
> 
> I want to encourage you and others doing testing and bug reporting:
> everyone wins when a bug or issue is reported, fixed, and tested.
> I'm just asking that when you have negative results, that you provide
> information on the "before" and "after" test results of
> the patch series, and run both on the same test environment.

Cyril, based upon the table and logs you provided whereby you have used 
the following:

- Raspberry Pi Compute Module 4 (Rev 1.0, 8G RAM, 32G storage)
- Raspberry Pi Compute Module 4 IO Board
- SupaHub PCIe-to-multiple-USB adapter, reference PCE6U1C-R02, VER 006S

in the before/unpatched case we have a PCIe link down and in the 
after/patched we have a PCIe link up but a kernel panic. Neither are 
great nor resulting in a fully functional PCIe device.

Looking at:

https://www.amazon.co.uk/SupaHub-Express-BandWidth-Capable-Expanding/dp/B092ZQWG5B

it would appear that it can accept an external power supply, do you have 
one connected to that USB expansion card by any chance? Are you able to 
boot the kernel before/after if you disconnect any USB peripheral?

This looks like a broader electrical problem than the scope of this 
patch, though it would be neat if we could find a combination that 
works. At least with Jim's patch we have a PCIe link with 
uni-directional CLKREQ# so we could try a variety of things.

Does that SupaHub board plugged to the CM4 1.0 system work fine in the 
Raspberry Pi kernel tree?
-- 
Florian
