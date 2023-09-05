Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF79792FEC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 22:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbjIEUY7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 16:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbjIEUY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 16:24:58 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5468BDF;
        Tue,  5 Sep 2023 13:24:53 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34df30f4658so9438195ab.1;
        Tue, 05 Sep 2023 13:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693945492; x=1694550292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08DpSgAh/jTClvDWsjidQLphCdIBOm2Eff+k7NiTmyU=;
        b=FNFsXDmgJnszJslM1LDscGAhEIAKpG7hwhhUTKnmmXIPoNlYe7skGzlJIAcnARe6oC
         8X6nZYWLbCzTzPcd4eQCf50QTrkW8qn9ZZZx+yLMWiUyceFlTgn1CbpylJVgr1Rk2XsB
         KF9yedQIqncV2c6qMNIFRD/XjT5HarOGV3regRVrOoytnFoR2h8yxwiCmr4+8BviE8UA
         vZc2P/3XXaqBQMfYq8F3vh38lyteZKCmk2yIzV0UXfoxsKyZ3UxL2otzJ0MChdHzSypG
         SJ3I4CD2jn1nVpElsxwE90Abdr/f3TPwjgc8zlDFFFg82MCvIU0/lrIGDd/+hoM2L4Pg
         EZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945492; x=1694550292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08DpSgAh/jTClvDWsjidQLphCdIBOm2Eff+k7NiTmyU=;
        b=E/p0/QNh60kM/kpBTPdk+ZBdi7PCabpegdjRSbzozetf+00xs8ESYUCQ939/CeckmH
         EaptnZwcOt2dBV3ViPsGrEQO3yVnwuN1on+BLEIZz68kAfHVs/et0AB/7Fp97m6gth4E
         eDALBsJiXw2ReTjaD9PhNhpsVKT6yKOFijB5vU+RY/lJdSZU59xprLVHVZHVTZL3AtY6
         rBEY4jo9u6WxFLckluO012ySwUkUuIwXVPTwacqCRbrUd7nv/V7wJ8f8Jz11FKC8U1zu
         BbmFdgvPu/hHLCcxWrHpldSGAFApAL///fMzh2mZ8iBa5emIx+WzvKzlV1rNqLOhxauf
         no5g==
X-Gm-Message-State: AOJu0Yw7i2S9yEmmB4lktQ39H7VTn6+pNLe5+eKHkMddwt1lbyzOw6c3
        lk/Op9L76/qoubgMYveAeh90p1pcUjSDQg==
X-Google-Smtp-Source: AGHT+IHC9u63FZwrqSCm9qQe3sU/mvtOD4gaH4iamZlnwz8ZUOE+FWd+7z2owwLW/HieKdYbqbRT3A==
X-Received: by 2002:a05:6e02:1152:b0:349:48eb:4e2f with SMTP id o18-20020a056e02115200b0034948eb4e2fmr15373008ill.22.1693945492637;
        Tue, 05 Sep 2023 13:24:52 -0700 (PDT)
Received: from ?IPV6:2001:470:42c4:101:428a:c1ef:eb45:32d8? ([2001:470:42c4:101:428a:c1ef:eb45:32d8])
        by smtp.gmail.com with ESMTPSA id m10-20020a92caca000000b003426356a35asm4354941ilq.0.2023.09.05.13.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:24:52 -0700 (PDT)
Message-ID: <74c93380-2f2a-f42d-027a-8c827e794812@gmail.com>
Date:   Tue, 5 Sep 2023 14:24:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 2/5] PCI: brcmstb: Configure HW CLKREQ# mode
 appropriate for downstream device
Content-Language: en-US
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230623144100.34196-1-james.quinlan@broadcom.com>
 <20230623144100.34196-3-james.quinlan@broadcom.com>
From:   Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20230623144100.34196-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/23/23 08:40, Jim Quinlan wrote:

Hi Jim,

As I understand, the issue that this patch fixes can be difficult to 
trigger reliably. So I'll report that the abort occurs 100% of the time 
on a Compute Module 4, installed in slot 3 of a Turing Pi 2 cluster 
board, when a bootloader (U-Boot, in my case) is in the boot path. The 
third slot of the TP2 board connects to an ASM1061 chip with the CLKREQ# 
line left floating. I do not know why the bootloader is necessary for 
the crash to occur; I suspect it's timing-related.

With this patch applied to my kernel, my observed crash rate goes from 
100% to 0%, so:

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> Tested-by: Cyril Brulebois <cyril@debamax.com>
Tested-by: Sam Edwards <CFSworks@gmail.com>

Many thanks,
Sam
