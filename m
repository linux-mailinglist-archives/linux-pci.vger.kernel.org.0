Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 150E5D2012
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 07:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbfJJFhP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 01:37:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40758 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfJJFhP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2019 01:37:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id d26so2917141pgl.7;
        Wed, 09 Oct 2019 22:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ld57m95bHJQBRxDnF5FnlK1Sfbx3W7UXVC5v8g98wR4=;
        b=iXJ5vQVG3nQIDNvzt3AWLSYveRStNbcXZccXNXLBr55Dpz2RUwVzLtlrPVLOTmwc9O
         JTYO5JlumlbzUVivQqGlauVQBPQmkENIAGljV/VSXMzW3pjS2HvTtNlxSwnVsKKVeFfY
         VHE1lMB5NNAxqJa3oxlmSN/fYXLpyXeCTtjb5WPFY6CcakSNS8PwIfCFutTz5NWilk1V
         GuMORY7w/6cTzTHoPQnYrSgaGwxu8a0TRvo4fr5qhlT0rshAgkJwzIRA0EAHdE5UEvpB
         OV4edPzJeSxrAiF0+6teKeZ+pYqgHG03zZUBeUYVSEngfKvaAw8zQta/AyxumcMc3lkL
         RpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ld57m95bHJQBRxDnF5FnlK1Sfbx3W7UXVC5v8g98wR4=;
        b=krizwEZJNDEFu0evJX6bqjVhtYx3L09DxPCQqE/YT/o713kksM4hMKjcnwHu0hPJ9M
         FRBYli+ieCNJICHbrX3PCGCZALhqLvd8dmHOz4ZdC5smAdctOddEcfR0RSqa5rP+TTn0
         jOirKervrboE00UAzuiSeN4cSmwG/zTxOJVsWUoy4AgTG+yr21iXhget+O2MAyM8zcBs
         fIWeUMSXhsz4Ng3hMhN9zYiTDsrJYOJmKkcogAi+6jm9M+B/sR30uitZxYaMGyPT4ZF/
         tOduRghtU1iU9u1GMSns9SBoen6aDd5WemfoOTm1i4kKa1x09THnwego/Oybj+FA6A9p
         JRhg==
X-Gm-Message-State: APjAAAX7WsXoq29cnqUYKj9eskaMczQIR/6ycxIoZkqeDHEyh/YB/6LC
        VyAeKmus9Gtockx6pMo/P5abf92DoEbOC39/3gA=
X-Google-Smtp-Source: APXvYqxH7326Yo5t32GMAyp5NmRX5IOI23GOLXR6jw0wZX0o300BEZOjtWXdIVqF/sN+W8nIFTIlo9LnKM8FVo6N8nw=
X-Received: by 2002:a63:d0a:: with SMTP id c10mr6760026pgl.203.1570685834587;
 Wed, 09 Oct 2019 22:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191009200523.8436-1-stuart.w.hayes@gmail.com> <20191009200523.8436-3-stuart.w.hayes@gmail.com>
In-Reply-To: <20191009200523.8436-3-stuart.w.hayes@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Oct 2019 08:37:02 +0300
Message-ID: <CAHp75Vc1mZ7qxKPGaqDVAQ9d_UjNq9LJDEPWHQHaYCfw7vGrmA@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: pciehp: Wait for PDS if in-band presence is disabled
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

On Wed, Oct 9, 2019 at 11:05 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
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

> +static void pcie_wait_for_presence(struct pci_dev *pdev)
> +{
> +       int timeout = 1250;
> +       bool pds;
> +       u16 slot_status;
> +
> +       while (true) {
> +               pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> +               pds = !!(slot_status & PCI_EXP_SLTSTA_PDS);
> +               if (pds || timeout <= 0)
> +                       break;
> +               msleep(10);
> +               timeout -= 10;
> +       }

Can we avoid infinite loops? They are hard to parse (in most cases,
and especially when it's a timeout loop)

unsigned int retries = 125; // 1250 ms

do {
 ...
} while (--retries);

> +
> +       if (!pds)
> +               pci_info(pdev, "Presence Detect state not set in 1250 msec\n");
> +}

-- 
With Best Regards,
Andy Shevchenko
