Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0932EEC8D4
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 20:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfKATEj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 15:04:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37616 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfKATEi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Nov 2019 15:04:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id g50so14277309qtb.4
        for <linux-pci@vger.kernel.org>; Fri, 01 Nov 2019 12:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XhqExbZh5kPvj3K4NZnoOcF081VOsziHuz7IlqtxrcQ=;
        b=pZeGw3P0RHdQki9K0gEObnP8OHglDuZpmvPq+OFKsU6xgeQL13BnAHlulP/AXJaNhH
         ZwTok1P9GNkau5IjixzgvwHoRsMHZDO4mQHl58gONYUVmICu+ICmGAtlNEveE0COrV9y
         /Xa/uFFqFErQaCPkaMjXEPyOF3xZXKviJzxY5RswiEk3RU1cFRsNAAq86vhLr+M4iejN
         DUSzb9XHpmVLLc2pvB9NkEKqyofyX55556V+I2ArroDUo1pUEBLty4g6IEse0WyTjh8w
         PDU5nOG+jTcNTKTvoqF9nxDfT1BF6OsABjs+f7dv3bSZ1ICuWpkn9uNUWSuindYPhE30
         ehAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhqExbZh5kPvj3K4NZnoOcF081VOsziHuz7IlqtxrcQ=;
        b=nqk/WY+j99ineIVjKz435ji7scssG+4jEHP6SWeJPavH5mCkVgDpEqUJx5eggx70lV
         iPhr10oFGSey9bbW1NZ7DTAQxcFicTJ9dr/Jnkvx3kOLy1yvlS9RnDVPl1B7NYvMav8b
         jbQ+UY4OWa1bXm6xm+mvHs2d0W2Yhhp+fRwxxEOi+KKX/R2CHbV/MsNPpnsf3blnOGYq
         DlcXpAp1ddo9lhdw9+RMDtt7NIv/tIQ4jGNKVdQmJQd67YD5J3RLvUyogY7bY/+NOxVj
         sBYi+L8QcKz3M5Z+bzEUU/CGsIpql/enKe0nFK77bO2QLaGYB30LuE6wMRdMha2tVDPc
         +X+Q==
X-Gm-Message-State: APjAAAXpwPUoCHJlXTkWaGNszAx8k5ozyDCocWBIuHTBc0TQtYBzSawW
        8j1AuUd8Qur8kZm9wUb1mCqsVJasPvtLy5N/uEaimaOlmMJNgA==
X-Google-Smtp-Source: APXvYqzaVfaVFf4/E1qtu06OCKxRakja8j6eb7eFWaPT90bJMEaqpKJybo0BQto3pfGWV02Havz8W/MP/51N1VZFBBk=
X-Received: by 2002:a0c:c392:: with SMTP id o18mr11435117qvi.75.1572635077831;
 Fri, 01 Nov 2019 12:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=yYwmQHyp62qKDoiM091iXKs5iP8rNBLs9kc7Wi_PDCgMrbw@mail.gmail.com>
In-Reply-To: <CAG=yYwmQHyp62qKDoiM091iXKs5iP8rNBLs9kc7Wi_PDCgMrbw@mail.gmail.com>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Sat, 2 Nov 2019 00:34:01 +0530
Message-ID: <CAG=yYwmYCLOktQxhsyjarybbR+aF2Z3RuXVj4hfE5wD_6nJjNA@mail.gmail.com>
Subject: Re: PROBLEM: PCIe Bus Error atleast
To:     ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 2, 2019 at 12:15 AM Jeffrin Thalakkottoor
<jeffrin@rajagiritech.edu.in> wrote:

> But i think when i tried again today i could not reprodu....
i do not know why, but now iam able to reproduce the error

more details follows
---------------------x------x------------------------------------------
GNU Make            4.2.1
Binutils            2.33.1
Util-linux          2.33.1
Mount                2.33.1
Linux C Library      2.29
Dynamic linker (ldd) 2.29
Procps              3.3.15
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils            8.30
Udev                241
------------------------x-----------------x---------------------------

$gcc --version
gcc (Debian 9.2.1-14) 9.2.1 20191025
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

---------------------x----------x----------------------------------

-- 
software engineer
rajagiri school of engineering and technology
