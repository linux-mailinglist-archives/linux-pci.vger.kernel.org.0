Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A249FE9AF
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2019 01:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKPAfS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Nov 2019 19:35:18 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:40463 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKPAfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2019 19:35:18 -0500
Received: by mail-oi1-f169.google.com with SMTP id d22so3292349oic.7;
        Fri, 15 Nov 2019 16:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EzhG1s5x1zWYdDfVp9nxZxgReVaQvCkE5fAuqO5ManM=;
        b=a3WWyKAlUcxoQsAGO0n13cSMLVC7EY+aJ7XJNFMWtiZ1mv2drmzJbn1xtld5IrFa8f
         7w9+A/W+Cj/3c9No6NshT7Gy5XfwKebW6Y07ODff3r9Ez2m5+LtUt8OpRNoZUwlhQF/q
         akEcDUynjm1kVdsS1FpzrEIX+irwjyryotfo/Rco6iDaTrSMnHcUJjO4/puO26UDd5F9
         xHW35KP/zXflpXoWxiLIsZ6NUOA8G57EyRCETBmuAAXoVvEK1fYwUDNqLNeMzAgVU6gI
         zkzHb/yshqwei9HnPONzla/jJbLQFup/xXI1zZlqtCFKkndlQYKM2Q4hCAIf4hCdTo86
         C11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EzhG1s5x1zWYdDfVp9nxZxgReVaQvCkE5fAuqO5ManM=;
        b=BO8mkeaayd/LJl+WBdBbmjJLQI2fNSabg41p2IfwAlgyIYbtW2aUcmiJe3d0UxkxyU
         Z8lFXZ3HgAxGY9vG5AcV0slm9igmwmAOlr32HcEUeSkvHqgEr+uxCSjWlNMGN9Efi3kn
         cC3D1xgFGKjn8rBTsK3AhqhnkgLB7q+yQAfYufzMuHffV3wWUuYFYXdFl2Ul82MZOpAQ
         YeKTZM/6a3zvvOtH4i7tL5VLTXiaGMepmIq+hCwAtLzpBSEDX9n+gY1sihRNYvXy1EBQ
         BYQCzshXQL7LyquETVKkuWMktq40C3hMNnwXiGh6Rmy8GHU3iZk4mZBCqpxuyTwZrjbe
         EGpQ==
X-Gm-Message-State: APjAAAWWsIySgTNrjM3gZ0ZGCWaW6T7cXhSGsxlXXTDLh1COAhGhTmRc
        1UAKW7mSlZQgqYtjP/fLTJYGXQ6+i5I3vSb+h101K/Wpu0s=
X-Google-Smtp-Source: APXvYqyaVIpj3rZaJGWNFPUT0on4a8j5LlAGze3PomO0emp+jRZbKHBWJ+Xyaq8MTvjMBwcIrT8I6m8b+Je9YgobrBc=
X-Received: by 2002:aca:39d7:: with SMTP id g206mr9625385oia.101.1573864516558;
 Fri, 15 Nov 2019 16:35:16 -0800 (PST)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Sat, 16 Nov 2019 06:05:05 +0530
Message-ID: <CAHhAz+h6SuGKWn0qNqsCdNjDks_vHuJW-KfiQja_b3x8x=vq_A@mail.gmail.com>
Subject: watchdog: how to enable?
To:     linux-watchdog@vger.kernel.org, linux-pci@vger.kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ Please keep me in CC as I'm not subscribed to the list]

Hi All,

My kernel is built with the following options:

$ cat /boot/config-5.0.1 | grep NO_HZ
CONFIG_NO_HZ_COMMON=y
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
CONFIG_RCU_FAST_NO_HZ=y

I booted with watchdog enabled(nmi_watchdog=1) as given below:

BOOT_IMAGE=/boot/vmlinuz-5.0.1
root=UUID=f65454ae-3f1d-4b9e-b4be-74a29becbe1e ro debug
ignore_loglevel console=ttyUSB0,115200 console=tty0 console=tty1
console=ttyS2,115200 memmap=1M!1023M nmi_watchdog=1
crashkernel=384M-:128M

When the system is frozen or the kernel is locked up(I noticed that in
this state kernel is not responding for ALT-SysRq-<command key>) but
watchdog is not triggered. So I want to understand how to enable the
watchdog timer and how to verify the basic watchdog functionality
behavior?

Any pointers on this will be greatly appreciated.

--
Thanks,
Sekhar
