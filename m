Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6B99F6D7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 01:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfH0XZE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 19:25:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37875 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfH0XZD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 19:25:03 -0400
Received: by mail-io1-f66.google.com with SMTP id q12so1487372iog.4;
        Tue, 27 Aug 2019 16:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AZp/zzBtS0EBiyMSUURJW6iNqR0pfIGhZlkgvULPVEo=;
        b=BFSqj6OUgdwftYzzYXGPwUNHC8vNVsa9r2ChznpC7RkSDp2KTGdC7fe9DguD1V+tVQ
         K8cBTkp5rHqDqGdxqDjclgASr4iyEILJq6x3Ke3xuU2apjbZ8fOLTtx5sl1GHS/8Syj9
         pbjqo0PJE1BJaEOmruxYMsyErKfh0xuWO6kS/8smjDMKCiC1lQPC2Q44cBw5HBlau/3p
         34bbDWG/ezWukZfefTBGNZ0qbiHF75LLsmHOiT/44ZTZ/aVNHXUAYlrmhThjmq98uqJo
         Y/gEb7LzkZ9gOLIDhtDLPjAGApXtQrYV+df0XvyjjDp3Sj/jZUKO6RbpORLBDdMICg9d
         lkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AZp/zzBtS0EBiyMSUURJW6iNqR0pfIGhZlkgvULPVEo=;
        b=o8Kg8cGM9SEyCDkNeNPhjf0dmXUrbFlCxvdCtUvdEoxdvBiJ+ypadx4bCvojbhjeYh
         CNuJS2dhQoUCBgp4xs0ptu7JiWb9bHhZ2em7tqNW7c9c/LIZIyzsosG7yu93AL51bMmy
         OLqhk69ThwbtQ5O2M/ULL/EwmkJnae5opPoLvEP55MUEIMxIUwjcxH/SNbWvs1jizO68
         6EYuhmRVH9WxwFwsrfV2L9+cnGeqLCkxu0RC2cUNz6kuLesUypThW2Xb853XkLbA9Qax
         pcZly/+Oqm8GnC5gUcgU1rmEAGMwo/gPpqHDQGeFWfaBDzWdvGhwBw1lq96TxDrO/KnI
         Iy9A==
X-Gm-Message-State: APjAAAXE0f/0lw7ywwLtwyusQ64Rdqj0s8fNu4sPWmdLgetA5vCE87wk
        Z/i7edZFIwCb/PeI6tjwTpqZK0EMTUX1wu++BVA=
X-Google-Smtp-Source: APXvYqyqSKNPjI3RqbHeyiPci/pb0qWE5PUDPxcELs94FqcSKNQOerajwYEUx+YZEhYXfNcva0enU+Mb4DAGP/p0KKs=
X-Received: by 2002:a5d:9b02:: with SMTP id y2mr1072981ion.146.1566948302443;
 Tue, 27 Aug 2019 16:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190819160643.27998-1-efremov@linux.com> <20190819160643.27998-2-efremov@linux.com>
 <9cbb34b0-d6be-fbba-9992-9b6939018e5d@linux.com>
In-Reply-To: <9cbb34b0-d6be-fbba-9992-9b6939018e5d@linux.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 28 Aug 2019 09:24:51 +1000
Message-ID: <CAOSf1CH7KHmViRQUYBvEtTQz0vMV5oE4SXOHp_E_a69Xew90gw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] PCI: pciehp: Add pciehp_set_indicators() to
 jointly set LED indicators
To:     efremov@linux.com
Cc:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 2:17 AM Denis Efremov <efremov@linux.com> wrote:
>
> Hi,
>
> On 8/19/19 7:06 PM, Denis Efremov wrote:
> On 8/12/19 11:25 AM, sathyanarayanan kuppuswamy wrote:
> > Do we need to switch case here ? if (pwr > 0) {} should work right ?
>
> I saved the switch here from v2. I think switch makes the inputs check more
> precise and filters-out all non-valid values. Maybe this check is too strict?

Sounds like you're overthinking it tbh. If want to catch programming
errors then a WARN_ON_ONCE() in the default case would be better than
silently ignoring invalid values, but it's pretty hard to care.

> We could use mask here ON|OFF|BLINK for the check, but I don't know how hardware
> will handle a case, for example, pwr == ON|BLINK.

ON|BLINK is the same as OFF
