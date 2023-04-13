Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F276E143D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 20:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDMSkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Apr 2023 14:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMSkQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Apr 2023 14:40:16 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331B240FD;
        Thu, 13 Apr 2023 11:40:15 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id cm23so7113246qtb.3;
        Thu, 13 Apr 2023 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681411214; x=1684003214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQtEpZle81hoaqTdpulwOdpw8KqXnAar/PVE+B9TICc=;
        b=P474q5oP2LI987/DecEQ3/p0SMtL1fQBQYFgk1hLlcvQfcEkyPCwiuFQgKQJlJ8cv0
         5RSQfJi4CHGciKswyoG/HMwMgJ1SnD9UG0/O/PZXmSvBnGFVniVUlFQhDN0mOpjLn3Xq
         TFNkGhPUpB1JKX9bEzyx81ERg0NVLJGJ0q9LwENMjpqs0SB8Y+M5T+ZayRasX+2+62Bx
         EKI7b/XXyjUDkQ2SazxkmzrgNIIePmygmmSiOMVk23108Qfzz8Jy6DtjDFwgvhA4DVGp
         mOUvp5WnEzyh0hyRfkCSsVTEtQ3W46F3I8Nj3xReqXRyp/KCLnImi658/TiORcHtHbmL
         gQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681411214; x=1684003214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQtEpZle81hoaqTdpulwOdpw8KqXnAar/PVE+B9TICc=;
        b=hrmJKC4hykmzuWcIemENb1jn4Arq3w5837iokm93plTxH8G8ptb1PQHMMIJK3dw0Ly
         YEXeUH7NMm7DWfYaMFU9axG7C33yzqCbqcXAl/QEoZLRKw/0ex60oHOiy2aEyqsrZniz
         4di0RYkVNstOw0KOFhWCFylL1eFr+8iJo7tZvBZAXlwsx0ZnuNawyIfDbblXZJSWhfmu
         1owAZaDg48vrD0lM3CAQXLZWTk0ehP3P8cqV12Y1J5zvw5ZXt28Csdr+iZSImxEDlNz9
         2CkvGzJkquVDJgBenSPN+NCgYcPgygu2njjI1B8stlc67BwmZ/t3B3XsvJDo1ZgzIvrr
         jqpQ==
X-Gm-Message-State: AAQBX9f5cReqsZCJFfCJt7Kw5cTFl4bwNCUkpuNYI/zw+jpiOwSOyr0I
        MBBkURBiEo7vXMI2yqD+fnQ=
X-Google-Smtp-Source: AKy350YwqLvGxuXkbQqYKS2m5/KfU0SKlQOgBQRBuWiZ05fsd0xL8BIuH7TjtWiwcrVwrdcZm5ozVw==
X-Received: by 2002:ac8:5b87:0:b0:3ea:1206:b812 with SMTP id a7-20020ac85b87000000b003ea1206b812mr3703163qta.38.1681411214235;
        Thu, 13 Apr 2023 11:40:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h18-20020a05620a285200b007425ef4cbc2sm654336qkp.100.2023.04.13.11.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 11:40:13 -0700 (PDT)
Message-ID: <d53c10d6-6a9c-c941-a7ff-70d4b4172960@gmail.com>
Date:   Thu, 13 Apr 2023 11:40:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/3] PCI: brcmstb: CLKREQ# accomodations of downstream
 device
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
References: <20230411165919.23955-1-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230411165919.23955-1-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/11/23 09:59, Jim Quinlan wrote:
> v2 -- Changed binding property 'brcm,completion-timeout-msec' to
>        'brcm,completion-timeout-us'.  (StefanW for standard suffix).
>     -- Warn when clamping timeout value, and include clamped
>        region in message. Also add min and max in YAML. (StefanW)
>     -- Qualify description of "brcm,completion-timeout-us" so that
>        it refers to PCIe transactions. (StefanW)
>     -- Remvove mention of Linux specifics in binding description. (StefanW)
>     -- s/clkreq#/CLKREQ#/g (Bjorn)
>     -- Refactor completion-timeout-us code to compare max and min to
>        value given by the property (as opposed to the computed value).
> 
> v1 -- The current driver assumes the downstream devices can
>        provide CLKREQ# for ASPM.  These commits accomodate devices
>        w/ or w/o clkreq# and also handle L1SS-capable devices.
> 
>     -- The Raspian Linux folks have already been using a PCIe RC
>        property "brcm,enable-l1ss".  These commits use the same
>        property, in a backward-compatible manner, and the implementaion
>        adds more detail and also automatically identifies devices w/o
>        a clkreq# signal, i.e. most devices plugged into an RPi CM4
>        IO board.
> 
> Jim Quinlan (3):
>    PCI: brcmstb: CLKREQ# accomodations of downstream device
>    PCI: brcmstb: Set PCIe transaction completion timeout
>    blah blah

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

On a 7216 system test with:

01:00.0 Network controller: Intel Corporation Wireless 7260 (rev 73)

and on the CM4 I/O board with:

01:00.0 Network controller: Intel Corporation Wireless 7260 (rev 73)

01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network 
Connection

01:00.0 Network controller: Broadcom Inc. and subsidiaries BCM43224 
802.11a/b/g/n (rev 01)

01:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9125 PCIe 
SATA 6.0 Gb/s controller (rev 11) (prog-if 01 [AHCI 1.0])

01:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme 
BCM5751 Gigabit Ethernet PCI Express (rev 21)

01:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI 
Express-to-PCI Bridge (rev aa)
02:00.0 Multiport serial controller: Pepperl+Fuchs RocketPort EXPRESS 
8-port w/Octa Cable

01:00.0 Ethernet controller: Qualcomm Atheros AR5008 Wireless Network 
Adapter (rev 01)

01:00.0 Network controller: Broadcom Inc. and subsidiaries BCM4311 
802.11a/b/g (rev 01)

01:00.0 Network controller: Broadcom Inc. and subsidiaries BCM4322 
802.11a/b/g/n Wireless LAN Controller (rev 01)

01:00.0 Network controller: Broadcom Inc. and subsidiaries BCM43602 
802.11ac Wireless LAN SoC (rev 01)

and finally with a 4 port switch:

-[0000:00]---00.0-[01-07]----00.0-[02-07]--+-01.0-[03]----00.0  Intel 
Corporation 82574L Gigabit Network Connection
 
+-03.0-[04-05]----00.0-[05]----00.0  Pepperl+Fuchs RocketPort EXPRESS 
8-port w/Octa Cable
                                            +-05.0-[06]----00.0 
Broadcom Inc. and subsidiaries NetXtreme BCM5751 Gigabit Ethernet PCI 
Express
                                            \-07.0-[07]----00.0  Intel 
Corporation 82574L Gigabit Network Connection

And than I ran out of devices that I could plug, the others were x4, x8 
or x16.

Most (all?) would previously fail, so definitively an improvement!

Thanks!
-- 
-- 
Florian

