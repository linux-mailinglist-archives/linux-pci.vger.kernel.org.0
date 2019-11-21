Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 837DC10565C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 17:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKUQCp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 11:02:45 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43249 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUQCp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 11:02:45 -0500
Received: by mail-qt1-f196.google.com with SMTP id q8so1573697qtr.10;
        Thu, 21 Nov 2019 08:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=mE34HvIkFQ+UgbkASFO7S/nFumlkTnQYdQQ/f+X935Q=;
        b=s6yXvWitpd5pKoLT/Tg1eBB0QkjnZGQRjT0gOd7RQ6CofwtVsTz6ugTdDFl3iglhbK
         IxuV2GaesMYpSbbpJ901tw0p57Q0ZYZFKKGGcgY4ZqlKvM5NMqVF+kDbB+8Bu7eC/Us8
         IqJmoD2DDsBm9+LBxtD2gjCcut66VldrGsOwLyHfk9LQB+EFvLKR91amOqxApseWZ4X/
         sTz8Nkhe1BuOuzY21mOJiPId50aN6onc0vw3lcJCcv/Z132bLpJBY85QtbJcx+BBKa/D
         MDxVzRUf1T0HHlM6nZi02qad/su/27WJp3ynGL5K+w4lJOAvjagsujpyClNdTn9UUulu
         PSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mE34HvIkFQ+UgbkASFO7S/nFumlkTnQYdQQ/f+X935Q=;
        b=Tojt66sjslExJmwY4y+JJZsvLFExI1ihXQMLmQIWUEgUuFVgNVcnMk4AoM4Z1sqVZ7
         nY3mnytvjJ7SXepwLs5lGhncCT01uaKEZAIAmbtnHaMOObna0acjz4Ff7YaZx5I+x3Zb
         WPg7zigZriGEz6/7lGJ8f0S3biutdnRuMSMSEPczng7zWtCz2BbE06Wrg3+L6pGxY1Ij
         52yIs/MVWbVVZ0JoQOAD1w3HA76jM3K58gDMp2uA/oYLbvXS1zHNuTj4uilOKNe8v2OG
         cXp1fvU8n9tXuS5AZoZCBGKcxjsuLbZeM7m0rMrAzmGO/W27xyEbeiD7MO2x+siSk398
         42UA==
X-Gm-Message-State: APjAAAU4ki5euOvEsvCe8BROE4vxyu6WCZutyaWk4/TZZleOhQj1vkbx
        exstM6/6bqIEXtuV8DoZIGsnSt82y+htyFfKH7hI2LC0
X-Google-Smtp-Source: APXvYqzroYq2uGEuG2ACur7bwmJI5oJWicpf2H2z0vDphJHssj2SJqong0SOqLUYErUFpma60QAh/5hquo1g8GLEE5A=
X-Received: by 2002:aed:3fc4:: with SMTP id w4mr9369284qth.120.1574352163885;
 Thu, 21 Nov 2019 08:02:43 -0800 (PST)
MIME-Version: 1.0
From:   Ranran <ranshalit@gmail.com>
Date:   Thu, 21 Nov 2019 18:02:33 +0200
Message-ID: <CAJ2oMhLLaguZMMaescENDUOmNm=WmZLjsO0BjK1-g_ro5AOOMQ@mail.gmail.com>
Subject: crash on getting interrupt from uio_generic_pci
To:     linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I use FPGA with PCIe, and we try to simulate interrupt.
uio_generic_pci is the kernel pci driver.

On receiving interrupt there is a crash:

I get the following exception:
What do you want to do today ? [  384.696015] irq 23: nobody cared
(try booting with the "irqpoll" option)
[  384.703048] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G           OE
  4.18.16 #3
[  384.710799] Hardware name:  /conga-MA5, BIOS MA50R000 10/30/2019
[  384.717083] Call Trace:
[  384.719643]  <IRQ>
[  384.721761]  dump_stack+0x5c/0x80
[  384.725224]  __report_bad_irq+0x35/0xaf
[  384.729234]  note_interrupt.cold.9+0xa/0x63
[  384.733612]  handle_irq_event_percpu+0x68/0x70
[  384.738239]  handle_irq_event+0x37/0x57
[  384.742262]  handle_fasteoi_irq+0x97/0x150
[  384.746560]  handle_irq+0x1a/0x30
[  384.750021]  do_IRQ+0x44/0xd0
[  384.753132]  common_interrupt+0xf/0xf
[  384.756979]  </IRQ>
[  384.759181] RIP: 0010:cpuidle_enter_state+0x7d/0x220
[  384.764368] Code: e8 d8 19 45 00 41 89 c4 e8 30 50 b1 ff 65 8b 3d
99 db 85 7e e8 a4 4e b1 ff 31 ff 48 89 c3 e8 4a 61 b1 ff fb 66 0f 1f
44 00 00 <48> b8 ff ff ff ff f3 01 00 00 4c 29 eb ba ff ff ff 7f 48 89
d9 48
[  384.784119] RSP: 0018:ffffb068c06afea8 EFLAGS: 00000286 ORIG_RAX:
ffffffffffffffda
[  384.792032] RAX: ffff96977fca14c0 RBX: 0000005991ab33dd RCX: 000000000000001f
[  384.799495] RDX: 0000005991ab33dd RSI: 0000000000000000 RDI: 0000000000000000
[  384.806955] RBP: ffff96977fcab300 R08: 000000977b372895 R09: 0000000000000006
[  384.814446] R10: 00000000ffffffff R11: ffff96977fca05a8 R12: 0000000000000001
[  384.821900] R13: 0000005991ab220e R14: 0000000000000001 R15: 0000000000000000
[  384.829346]  ? cpuidle_enter_state+0x76/0x220
[  384.833886]  do_idle+0x221/0x260
[  384.837258]  cpu_startup_entry+0x6a/0x70
[  384.841366]  start_secondary+0x1a4/0x1f0
[  384.845465]  secondary_startup_64+0xb7/0xc0
[  384.849849] handlers:
[  384.852233] [<000000007a5bed83>] uio_interrupt
[  384.856892] Disabling IRQ #23

kernel version:
