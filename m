Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02BDAFEFE5
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2019 17:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfKPQBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Nov 2019 11:01:45 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:38921 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731665AbfKPQBh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Nov 2019 11:01:37 -0500
Received: by mail-pf1-f176.google.com with SMTP id x28so8136899pfo.6;
        Sat, 16 Nov 2019 08:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ImMHYp4zTlOUHYAqsqImkf8coYQfcp0IIx0sbh2J3bw=;
        b=SAsKMweYXW0CCqvNkzFbjLnjCqujIpHB2VzDgxC6936OxxZlIjOZAvekgWC4vv9CJb
         or+5CRAMBxvnTIZ+/R2OrPLuPJiZKRKxVUNWewKwm/TPwiZwgjP7f6Lo3bK7+p5YuERP
         vAJEg9Y78IK0J8I0qN3NXDDgNDxRt0aBxYJ1pIKrzVMsi84HfucHlztiwzZiaKE74ftl
         2RMHPkrIRzLHue+EjgMlOVy4HVSGwLTHNXIgXdRCQ5q7mgWRvWwesvr0pnN2doypF3a/
         DdAJbVQ/tdocF5VulM93T3r8/VKC7Oxq6Kd850mmeHPwEaPDXkz/8NpKJaJmctyq0xNZ
         /yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ImMHYp4zTlOUHYAqsqImkf8coYQfcp0IIx0sbh2J3bw=;
        b=Nhx3onMGXemR4ip3yAw4QUUSG/EDQaG2zCtFvMf52qL7LlVDMynbxkmb1o4xHQVR84
         7JfDcy56J8ts2rJrwoNKq2naYo5A6UYsmDlZUlJbMA4qChJsE1O9BpmzkYziqUWsNSnV
         ArrUPDa3deCUdm6W/xzuteKmbGSTv2JyHrXpYmWXTzAgDqVeNfrlFg47F5hgYu7GcL08
         Twj1qU/y3Em+g9xxoLTLzjQESrXUPmnBr5k8tYpJqePlC7KSzTyAJYpHbtW+6hX6V5CK
         w77jdc8ppfOoC4cAE7E+/0hDtP/FRHp1/9kJO/9E23I+O9ghJKT1UtkLy7RuPm/j03B/
         Ax7A==
X-Gm-Message-State: APjAAAUf6+qldNteV+GBNMvJairEojyX4i2KSyzQPmEOSUSAo43JpbKn
        f8FVXalatzfaA/KAXN0z2HI=
X-Google-Smtp-Source: APXvYqzyJg08yhSqb2Fi0yAPx4xYveG1rHUfokzUkXpSa+mg1Y1pmVoa49gBm/3xJzZlH4PWsYl5BQ==
X-Received: by 2002:aa7:980c:: with SMTP id e12mr24474265pfl.165.1573920096947;
        Sat, 16 Nov 2019 08:01:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x21sm13814389pfi.122.2019.11.16.08.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2019 08:01:36 -0800 (PST)
Subject: Re: watchdog: how to enable?
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, linux-pci@vger.kernel.org,
        wim@linux-watchdog.org
References: <CAHhAz+h6SuGKWn0qNqsCdNjDks_vHuJW-KfiQja_b3x8x=vq_A@mail.gmail.com>
 <0d5c20b1-6b0f-430b-17b0-d3624062020d@roeck-us.net>
 <CAHhAz+iSXZSY012-jNx_wmNmgx_UiHZ4rjxkCUcHk3CjLc9gDg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e5b24949-5215-9d3d-ca45-cab221d4f58a@roeck-us.net>
Date:   Sat, 16 Nov 2019 08:01:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHhAz+iSXZSY012-jNx_wmNmgx_UiHZ4rjxkCUcHk3CjLc9gDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/15/19 7:03 PM, Muni Sekhar wrote:
[ ... ]
>>
>> Another possibility, of course, might be to enable a hardware watchdog
>> in your system (assuming it supports one). I personally would not trust
>> the NMI watchdog because to detect a system hang, after all, there are
>> situations where even NMIs no longer work.
> 
>>From dmesg , Is it possible to know whether my system supports
> hardware watchdog or not?
> I assume that my system supports the hardware watchdog , then how to
> enable the hardware watchdog to debug the system freeze issues?
> 

Hardware watchdog support really depends on the board type. Most PC
mainboards support a watchdog in the Super-IO chip, but on some it is
not wired correctly. On embedded boards it is often built into the SoC.
The easiest way to see if you have a watchdog would be to check for the
existence of /dev/watchdog. However, on a PC that would most likely
not be there because the necessary module is not auto-loaded.
If you tell us your board type, or better the Super-IO chip on the board,
we might be able to help.

Note though that this won't help to debug the problem. A hardware
watchdog resets the system. It helps to recover, but it is not intended
to help with debugging.

Guenter
