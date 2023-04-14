Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A26F6E2B24
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 22:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDNUdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 16:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDNUdf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 16:33:35 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDA15B93;
        Fri, 14 Apr 2023 13:33:33 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id qh25so9270027qvb.1;
        Fri, 14 Apr 2023 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681504412; x=1684096412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdK48rxG4KzEvjeD5gYO8w9ZQkzGlmyxMjxEd3WM8Ds=;
        b=RU4Wt/rZ/iVY6X8bgz7G6eH5EGXYINrl+Fe2IqRIBdpeGETIkmw0oWqFPq9tSvatW9
         QLP0WcU6FVa6XrRsBWd3EF3KjVlc4ZwXFw/rDi/vQd3wmrkKNqcDC+lax8OnQuVQvg8n
         ZLToWWojLfbH1KVrSQZUuFYT72RgmAUqajcirkYTdABfX85XJ/pwJFbVjY5guIe7VtPm
         1rY3h84Ys17p/m9Qewtx6F64kK/qSPZ+2WhkVDL3UDWrDGF3PyJrB0hadf7S5ZUEgEnL
         WsblOVRX1mgrW6OALrKMqe45Y8iHzvGq9gdhy6pUFmxJjqAbqJjaYnEXuIoVFjf4PfFJ
         dYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681504412; x=1684096412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdK48rxG4KzEvjeD5gYO8w9ZQkzGlmyxMjxEd3WM8Ds=;
        b=aOtQuOEgLmbW2hlEMKUbm7p5IaRM0bNi6oG641wkDHtPQnowgb7bQ5iIH5/dVaDOTA
         qNyTSvwnAOWuN8Z8pGk6+c7moy6cGTVjx7VCapFf9fdVPtzU3bqKzPLPoSC8mTD4NdtC
         Sw7ywRvMHdoJKlBY+od2zhijej5i7YcrFr2csB7GYyL/zAewrtPJjjRblfBXkp91y78t
         3L8SI0zsi2r3j55476ciD/Hy5yLJ1uhn46Nu9ZSQaLoE8opahU7gtvewaKrtmGAr9D3l
         hJi8yTIjjVMmUlzAWxbMh8KRef1l4KkOYQ6C9pmbo+KB+l3KwYXcq7/455MdbMCcp7tp
         IJdQ==
X-Gm-Message-State: AAQBX9d92APcVfldYUzDl9z95vs7YKrFkX1zq4u2U0Z9+REZTMI8oa3v
        6A07qlk8NSz6FAMbsHYdcUBgLT/LUx5jNA==
X-Google-Smtp-Source: AKy350ZiIPEt9O0PhLwBNN2FE+DwAu7PHpzVSX93modZ5Ct8O98kggmWIhZi585f9U5I40R3pH1m+g==
X-Received: by 2002:a05:6214:21e5:b0:5e9:752:766b with SMTP id p5-20020a05621421e500b005e90752766bmr6120380qvj.47.1681504412627;
        Fri, 14 Apr 2023 13:33:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ei18-20020ad45a12000000b005eac706d223sm1337386qvb.124.2023.04.14.13.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 13:33:32 -0700 (PDT)
Message-ID: <c3a1271b-3faf-0900-d8e4-2ded0230f461@gmail.com>
Date:   Fri, 14 Apr 2023 13:33:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/3] PCI: brcmstb: CLKREQ# accomodations of downstream
 device
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
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
References: <20230414202720.GA215111@bhelgaas>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230414202720.GA215111@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/14/23 13:27, Bjorn Helgaas wrote:
> This subject line no verb.  Can you add a leading verb to suggest what
> this patch does?
> 
> s/accomodations/accommodations/
> 
> On Tue, Apr 11, 2023 at 12:59:17PM -0400, Jim Quinlan wrote:
>> The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, must be
>> deliberately set by the probe() into one of three mutually exclusive modes:
>>
>>    (a) No CLKREQ# expected or required, refclk is always available.
>>    (b) CLKREQ# is expected to be driven by downstream device when needed.
>>    (c) Bidirectional CLKREQ# for L1SS capable devices.
>>
>> Previously, only (b) was supported by the driver, as almost all STB/CM
>> boards operate in this mode.  But now there is interest in activating L1SS
>> power savings from STB/CM customers, and also interest in accomodating mode
>> (a) for designs such as the RPi CM4 with IO board.
> 
> accommodating
> 
>> The HW+driver is able to tell us when mode (a) mode is needed.  But there
>> is no easy way to tell if L1SS mode should be configured.  In certain
>> situations, getting this wrong may cause a panic during boot time.  So we
>> rely on the DT prop "brcm,enable-l1ss" to tell us when mode (c) is desired.
>> Using this mode only makes sense when the downstream device is L1SS-capable
>> and the OS has been configured to activate L1SS
>> (e.g. policy==powersupersave).
> 
> I'm really concerned about the user experience here.  I assume users
> do not want to edit the DT based on what device they plug in.  They
> shouldn't need to (and probably won't) know whether the device
> supports L1SS.
> 
> I hate kernel/module parameters, but I think even that would be better
> then having to edit the DT.

The problem I see with kernel/module parameters is that it is really 
hard to differentiate whether they should be applied across all 
instances of the device/drivers or just for one in particular.

The Raspberry Pi 4 is a single pcie-brcmstb instance, but we have other 
systems supported by that driver on Set-top-box and Cable Modem chips 
for instance where we may have different types of end-points being 
connected, some of which could be Multi-chip-module (MCM) where 
everything is known ahead of time, and sometimes cards that are plugged 
to full-sized PCIe or mini-PCIe connectors, where some amount of runtime 
discoverability is involved.

Without inventing some custom modular parameter syntax, it may not work 
that well. The Device Tree properties at least easily allow for 
per-instance configuration.

> 
> There's obviously a period of time when L1SS is supported but not yet
> enabled, so I'm *guessing* the "OS has been configured to activate
> L1SS" is not actually a requirement, and choosing (c) really just
> opens the possibility that L1SS can be used?
> 
> Would be nice to have a hint (maybe a line or two of the panic
> message) to help users find the fix for a problem they're seeing.
> 
> Obviously the ideal would be if we could use (c) in all cases, so I
> assume that's where a panic might happen.  What situation would that
> be?  An endpoint that doesn't support L1SS?  One that supports L1SS
> but it's not enabled?  Maybe if L1SS isn't configured correctly, e.g.,
> LTR values programmed wrong?
> 
> Bjorn

-- 
Florian

