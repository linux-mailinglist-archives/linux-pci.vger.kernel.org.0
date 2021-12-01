Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C146465871
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 22:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343511AbhLAVlm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhLAVll (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 16:41:41 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF44C061574;
        Wed,  1 Dec 2021 13:38:20 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 188so17129947vku.8;
        Wed, 01 Dec 2021 13:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=heor8kZW9sVqwSMK/B3YJ5KdTWgzxzpDeFGrlIuZQyg=;
        b=D7lRHlMdfjNVkrkjVbMapYNHNDm0A0FLPKwhdLhpWKOn2LLDAkuaQyqFuGx2gtxROe
         uK1xXeb34r5ejjW4ldaXJEWqR+uvQ3oxlrmxPEg5bXzaYg8TAphwAi9tXAGjyMkjdlQw
         iCkDu44qdN9YsYC6gpcybEu0lUtsrN9dCzZcJWhjWSlMohhgEofaqFu4jraGMaUvo0BR
         5y1ENtJajB40dKtBZ2mTkR0fNeh2Irshhnoi3+HiJxTZjELL3dUafmgH/J79a1K6QyD2
         00Sr3irT6MHYA+Lj0R8y1bAZOWVPZ0mDuYdDz4U4AtwN/absq1p6hAOpYAmGO8gHa6/J
         4jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heor8kZW9sVqwSMK/B3YJ5KdTWgzxzpDeFGrlIuZQyg=;
        b=SW4ifahNP4NvOysMUl4XUTp8YYuR2Cd3FAEbDTwaRkUPSzr9gMGkCUxKm8qaMzx2HQ
         AYjKLy7EgrQwz0FGx/mMWUQfZtaYFc0FIpzw9yXhAVEqv8x8FsUf9Ll1PgeHBLHy/XT+
         dX0w6VFXq8d4Qnvub6ONNgx8GkfkQQ+Bjbs2jS2UwKwDMJzuie/QhE45vpo3XxFBsKnh
         p/iSAqZNwwzMIZjFVb8hQ91XyHX+akBqKVQENKJ4ZizWqdm2/ob0UCM0rFoVqgyNkwfd
         3HDBpAqQwygtYvElypNf8JgdTEIDTtY6y1BJDyq44TUgD7MCXTPd3Z+S24+AeWiMuGW1
         zdlg==
X-Gm-Message-State: AOAM533HST4jtnHaDOuSANCGmT0JDUDp74rRK6DCIy6KsSQHN+Bi4rFi
        s+hSBQWoJZYZrf9xcczyBVkrWBACmpm6sd3wgF/cLDNQ9hM=
X-Google-Smtp-Source: ABdhPJzGq/bHi7nDmJxq2bghX2ymo3nmMuCJSgh67zWNL3HzURBoa1HPp4zxvKiM71Yo1qrlhcd0TdBxn9WtSeXFz8s=
X-Received: by 2002:a05:6122:2158:: with SMTP id m24mr11339880vkd.1.1638394699483;
 Wed, 01 Dec 2021 13:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20211201203822.GA2840039@bhelgaas> <542e38c7-afed-ebf5-5254-8aa6ee22b01a@roeck-us.net>
In-Reply-To: <542e38c7-afed-ebf5-5254-8aa6ee22b01a@roeck-us.net>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 1 Dec 2021 22:38:08 +0100
Message-ID: <CAMhs-H_drYWiiJVbLQYPqfEHF=DM-yCg1bwVZMCqdqHOUACyWQ@mail.gmail.com>
Subject: Re: Linux 5.16-rc3
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 1, 2021 at 9:50 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/1/21 12:38 PM, Bjorn Helgaas wrote:
> > [+cc linux-pci]
> >
> > On Mon, Nov 29, 2021 at 01:18:12PM +0100, Sergio Paracuellos wrote:
> >> On Mon, Nov 29, 2021 at 5:17 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >>> On 11/28/21 7:07 PM, Randy Dunlap wrote:
> >>>> On 11/28/21 17:59, Guenter Roeck wrote:
> >>>>> ...
> >>>>> Build results:
> >>>>>      total: 153 pass: 152 fail: 1
> >>>>> Failed builds:
> >>>>>      mips:allmodconfig
> >>>>> Qemu test results:
> >>>>>      total: 482 pass: 482 fail: 0
> >>>>>
> >>>>> Building mips:allmodconfig ... failed
> >>>>> --------------
> >>>>> Error log:
> >>>>> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
> >>>>> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> >>>>> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> >>>>> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> >>>>> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> >>>>> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> >>>>>
> >>>>> There is still no fix for the mips:allmodconfig build problem as far
> >>>>> as I can see. It is a bit odd, because the fix would be as simple as
> >>>>>
> >>>>>    config PCIE_MT7621
> >>>>> -    tristate "MediaTek MT7621 PCIe Controller"
> >>>>> -    depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
> >>>>> +    bool "MediaTek MT7621 PCIe Controller"
> >>>>> +    depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
> >>>>>        select PHY_MT7621_PCI
> >>>>>        default SOC_MT7621
> >>>>>        help
> >>>>>
> >>>>> Context: tristate doesn't make sense here because both RALINK and
> >>>>> SOC_MT7621 are bool. Also, RALINK is redundant because SOC_MT7621
> >>>>> already depends on it. The compile failure is due to missing exported
> >>>>> symbols, and it is only seen if PCIE_MT7621=m - which is only possible
> >>>>> if COMPILE_TEST=y. In other words, the dependencies above are set such
> >>>>> that test builds, and only test builds, fail.
> >>>>>
> >>>>> The problem was introduced with commit 2bdd5238e756 ("PCI: mt7621:
> >>>>> Add MediaTek MT7621 PCIe host controller driver"). Copying some of
> >>>>> those responsible to see if we can expect a solution sometime soon.
> >
> > Can we do a minimal patch along the lines of the above for v5.16?
> >
>
> I would suggest to either do that or, if module support is mandatory,
> revert the patch and re-apply it if and when it can be built as module.

Understood. Let's apply a simple fix for 5.16 and a real fix for 5.17.

I have just sent:
https://lore.kernel.org/linux-pci/20211201213402.22802-1-sergio.paracuellos@gmail.com/T/#u

Best regards,
    Sergio Paracuellos
>
> Guenter
