Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9459B3303EA
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 19:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhCGS11 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Mar 2021 13:27:27 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:42986 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhCGS1R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Mar 2021 13:27:17 -0500
Received: by mail-lj1-f180.google.com with SMTP id k12so12115079ljg.9
        for <linux-pci@vger.kernel.org>; Sun, 07 Mar 2021 10:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EM3WO/cpA2xTKyEmRtrPyl3CA+LFNIT0kx7gSLinBwM=;
        b=h1SbLf3OyQ1MauR2sczTRfc0evjHAOSIQafFo1iAWjDMJZWXdnU9z591cIgD3vl0Wa
         pb51DKyB1Z76Hci8R5H8OjShP2nT0693L6oAGQY3Aq8JBqI4LzavwLSnyVDansKkm8W2
         Zb1a289+i9j0xUrsPgexbCUK9SKycF52VRIMReTipmi66i5kiEfj7svCDDYLuCOgRGmg
         hf3qTKbIZgSFNf8bL5dyoaaxT86x+/baMmFNcd6dnSwC/Qx3kESnj8xQ6i8+RHE9LV9F
         1bmj2qLrRHm/h/S6N4qQ68eomR+RkJAVAHUM4fM0xwYniC+rieLKWQX8hq4tF6tqhO5m
         ZJuQ==
X-Gm-Message-State: AOAM533ORqd7/qHUdo0Ppjs5uInFjF2aPb0/7XaEQxDJfYujylb25ZwG
        nj4Ey7d6e7VBJ1CLElxk7Zo=
X-Google-Smtp-Source: ABdhPJxGe2Av7cNlU0FPlMUKnUApEQ/zYGaOf7nK00KS/tFS/ZK7PuOGQ/JTimwH3zwxC1zzEJpHcA==
X-Received: by 2002:a2e:910a:: with SMTP id m10mr11202698ljg.421.1615141636266;
        Sun, 07 Mar 2021 10:27:16 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w8sm682364ljh.131.2021.03.07.10.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 10:27:15 -0800 (PST)
Date:   Sun, 7 Mar 2021 19:27:14 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/VPD: Silence warning if optional VPD PROM is missing
Message-ID: <YEUbAi8jV6mzKvp4@rocinante>
References: <b04a0e46-0b97-da3d-aa77-b05c9b37d21f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b04a0e46-0b97-da3d-aa77-b05c9b37d21f@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Heiner,

> Realtek RTL8169/8168/8125 NIC families indicate VPD capability and an
> optional VPD EEPROM can be connected via I2C/SPI. However I haven't
> seen any card or system with such a VPD EEPROM yet. The missing EEPROM
> causes the following warning whenever e.g. lscpi -vv is executed.
> 
> invalid short VPD tag 00 at offset 01
> 
> The warning confuses users, I think we should handle the situation more
> gentle. Therefore, if first VPD byte is read as 0x00, assume a missing
> optional VPD PROM as and silently set the VPD length to 0.
[...]

True.  I saw people on different forum and IRC asking for clarification
assuming their NIC broke, or that something is wrong, so this would
indeed save them some worry, nice!

Having said that, I also saw this particular warning showing up for some
storage controllers (often some SAS cards), so a question here: would it
warrant adding a pci_dbg() with an appropriate message rather than just
returning 0?  I wonder if this might be useful for someone who is trying
to troubleshoot and/or debug some issues with their device.

What do you think?

Krzysztof
