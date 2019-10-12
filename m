Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE4DDD4DFE
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2019 09:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfJLHet (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Oct 2019 03:34:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38312 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfJLHet (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Oct 2019 03:34:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so167631pgt.5;
        Sat, 12 Oct 2019 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zqQxbggLDLgvUgrs/8xb+vZbp9BeRehGvstEP4vmcU=;
        b=llaxfXY8WP09S7WoyOdiqe5wZ7iEb5yrB0ES1XuXYGPOxBd0r+PvyP68XLLA43cc4S
         NkFu5QhcFXMdRGCvJ2WyIKsk+6NEUvFUYjfFe/KYwwyVn20zd1RsWwJp5Mn7Ww1MQCK6
         8eooj4hVKn7Cyfw4hUgfYxEymGVwcmhp0H1XhsPHqnmEDr2CCdLAFQ79ggbY95mjJNTg
         21Fw8n3PNbshoe12zpEhEzEtpQ/UecnYtNS0wX6D52X9ShKhvT2Q6gRyAKtyEt7CjFV+
         MIO7VZiAQitmBRWqfWcqidryoyT8RGoJDz5OK2Btg6BIWMOZSHUKqT+Uvr9onyYCDztH
         XAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zqQxbggLDLgvUgrs/8xb+vZbp9BeRehGvstEP4vmcU=;
        b=QeOe4C7Omxfj2U1c2zcwMpFi8+f8U6UWy/MvmkjyG+UWt0KWkM02huotZIJgUXF60V
         wImTKhK2rD5+/oKUHz4kp6/FBmc9oU5eQxzU/3Pgz1xED4j4iZKfnEd4jt7DTTEflzTa
         D1R4uN9741m423gFI7/RMlCdUvDlTOReHnDNx7sflbS74vEod0tWUNA0VAmwD/tHMaPt
         Xp1vZDlMULf7c4unMq08T68f9456F79AOBz/xsVkWkleZr2S+SUUCTws0VxkyIhL53U0
         3dvkYMSE6HbIjRGWJkgXSoo4FkDgg9vIxG6oKgVPcWd4hbmAc90YbFo1Pqo0muynJPJv
         pfCg==
X-Gm-Message-State: APjAAAWBMkfD+N8BxviGitMq/knmgWhYEGgVD3g5SLbxPxXh4T2yikxc
        sMsFfpCwdh3oQCTIA+qrOztIw4SC8qbDVpYw9D93udB+CN8=
X-Google-Smtp-Source: APXvYqzZnbEGMH9gV50C2RabJ7R6ZHJ0OCK+mTD8SKiOqAQHC+yBrGcwJpzPM5BR1fvEwBlXLpaCLVuo/SuJVLxm25g=
X-Received: by 2002:a62:e80b:: with SMTP id c11mr20351462pfi.241.1570865688320;
 Sat, 12 Oct 2019 00:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191011205127.4884-1-stuart.w.hayes@gmail.com> <20191011205127.4884-3-stuart.w.hayes@gmail.com>
In-Reply-To: <20191011205127.4884-3-stuart.w.hayes@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 12 Oct 2019 10:34:35 +0300
Message-ID: <CAHp75VdDWQ=t=JiMei5bJGE59P70yxbfx48j6ufp32aHz2mM3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: pciehp: Wait for PDS if in-band presence is disabled
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 11, 2019 at 11:51 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>
> From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>
> When inband presence is disabled, PDS may come up at any time, or not
> at all. PDS being low may indicate that the card is still mating, and
> we could expect contact bounce to bring down the link as well.
>
> It is reasonable to assume that most cards will mate in a hotplug slot
> in about a second. Thus, when we know PDS only reflects out-of-band
> presence, it's worthwhile to wait the extra second or so to make sure
> the card is properly mated before loading the driver, and to prevent
> the hotplug code from disabling a device if the presence detect change
> goes active after the device is enabled.

Thank you!
My comments below.

> +static void pcie_wait_for_presence(struct pci_dev *pdev)
> +{
> +       int timeout = 1250;

> +       bool pds;

make W=1 will issue a warning. Just remove the line.

> +       u16 slot_status;
> +
> +       do {
> +               pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> +               if (!!(slot_status & PCI_EXP_SLTSTA_PDS))
> +                       return;
> +               msleep(10);
> +               timeout -= 10;
> +       } while (timeout > 0);
> +

> +       pci_info(pdev, "Presence Detect state not set in 1250 msec\n");

Perhaps ("%d", timeout) ?

> +}

-- 
With Best Regards,
Andy Shevchenko
