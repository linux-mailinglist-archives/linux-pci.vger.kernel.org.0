Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0239D3995C0
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 00:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFBWMn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 18:12:43 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:37560 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFBWMm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 18:12:42 -0400
Received: by mail-ua1-f42.google.com with SMTP id w28so2191407uae.4
        for <linux-pci@vger.kernel.org>; Wed, 02 Jun 2021 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tM4Et0IRPINCmI/KWk7/ASNqZUXJXeskhbuRGxD6XM=;
        b=aFz3EhG2Uvmn395vAjHexGoj+aWH9YyAhfycpUpjLvxPKSqzAj9CfedQjlS1otVpna
         wCoTct78JKET0ugSEhAr3JZbBebPZwPKQ3ORUDgVJZ6H2p5kCshGSSs/lOmARnZRqLvv
         HtTWC4dv87MTOjCx9ActAcZZCyP8P59/xaUNK20O7scRusvPl7BEvpJEI/FpWySu0VL0
         Di49ZhuMBUWEykWTwWeoB76MpWIM9F6iKMDT88CvR3UDKi5mFb45v5yIBBfR2U6P5Yfq
         JfdPPqzbph72wmOcmYDV34h7eXbA0AdudtCEvdanFcfoTTPOyKJ5CG3Obqq2hc6GsbLM
         F5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tM4Et0IRPINCmI/KWk7/ASNqZUXJXeskhbuRGxD6XM=;
        b=npL4cs9FWO8AmMP7+fBS6pdmTcWttejmP7EfjlefVkDnDKQXWUiawpK6qLUawtf95w
         PNSs+6JW6jVKHjpA5E2Bw0mIEHSB+ipoWScBbulJpxf7AaB4HQgeC3Pjml/Bs1Ru0snm
         a9QvNzQAhM22AJfvz1AoBjzAeyt3XmJKOzTh1K9RtPx8TbKZMSTSQcdmgQ5LMj97kO/J
         VvBz7xLiAsnUJ3eT4FUUkwm65CBnnVsiKaAYVj0EqDUCN4qpXCW9Ixb2bgNdS+BLeeX8
         nDSz6X/jjVqex+827tZl6K9AU8+OUgejqcrnRsbEH/OJsvLfGTKPoWypnIdXnIujWOBQ
         yzWA==
X-Gm-Message-State: AOAM533X60QgrKnAyt3BpU9YOm8U6UJyzgqXmj8odBkaAwymTwqFZwuw
        1ApT47YoJZuUlQz6Rn9ImxzECjq4P3ZXtok5lsz7
X-Google-Smtp-Source: ABdhPJzJeXBJXVmkiHuV1cIzWTR5JVdNMIJMRR/wxnSZrPhOD++Bki4qb0B3BD04w0PrfpV25LcB/ttHnjjhCqs5tT8=
X-Received: by 2002:a1f:9b0c:: with SMTP id d12mr13114242vke.13.1622671787024;
 Wed, 02 Jun 2021 15:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <c82b61f5-00d4-182f-2bb7-3518adf2ca75@quicinc.com>
In-Reply-To: <c82b61f5-00d4-182f-2bb7-3518adf2ca75@quicinc.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 2 Jun 2021 17:09:35 -0500
Message-ID: <CAErSpo4=uspbvScDzfEw+NjsVJKYf6=DyrC=Gasw2Qdt1gwXYg@mail.gmail.com>
Subject: Re: Arm64 double PCI ECAM reservations in acpi_resource_consumer()
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Wed, Jun 2, 2021 at 4:49 PM Qian Cai <quic_qiancai@quicinc.com> wrote:
>
> Bjorn, I noticed PCI ECAM could be reserved twice on arm64. Firs time through,
>
> [   19.087790][    T1]  acpi_ns_walk_namespace+0xc0/0x390
> [   19.092927][    T1]  acpi_get_devices+0x160/0x1a4
> [   19.097629][    T1]  acpi_resource_consumer+0x8c/0xc0
> [   19.102680][    T1]  pci_acpi_scan_root+0x158/0x4c8
> [   19.107555][    T1]  acpi_pci_root_add+0x450/0x8e8
> [   19.112345][    T1]  acpi_bus_attach+0x300/0x7d0
> [   19.116960][    T1]  acpi_bus_attach+0x178/0x7d0
> [   19.121576][    T1]  acpi_bus_attach+0x178/0x7d0
> [   19.126190][    T1]  acpi_bus_scan+0xa8/0x170
> [   19.130545][    T1]  acpi_scan_init+0x220/0x558
> [   19.135074][    T1]  acpi_init+0x1f4/0x270
>
> where pci_acpi_setup_ecam_mapping() confirmed all reservations are succeed. Then,
>
> [   19.880588][    T1]  acpi_ns_walk_namespace+0xc0/0x390
> [   19.885725][    T1]  acpi_get_devices+0x160/0x1a4
> [   19.890426][    T1]  pnpacpi_init+0xa0/0x10
>
> As the results, those messages are showed up during the boot in pnpacpi_init().
>
> [ 17.763968] system 00:00: [mem 0x10000000000-0x1000fffffff window] could not be reserved
> [ 17.772900] system 00:00: [mem 0x7800000000-0x780fffffff window] could not be reserved
> [ 17.781627] system 00:00: [mem 0x7000000000-0x700fffffff window] could not be reserved
> [ 17.790350] system 00:00: [mem 0x6000000000-0x600fffffff window] could not be reserved
> [ 17.799073] system 00:00: [mem 0x5800000000-0x580fffffff window] could not be reserved
> [ 17.808155] system 00:00: [mem 0x1000000000-0x100fffffff window] could not be reserved
> [ 17.816862] system 00:00: [mem 0x600000000-0x60fffffff window] could not be reserved
> [ 17.825417] system 00:00: [mem 0x400000000-0x40fffffff window] could not be reserved
>
> Looking through the x86's version of pci_acpi_scan_root(), it won't call acpi_resource_consumer(), so I suppose this bug is only affecting arm64?

This might be related to
https://lore.kernel.org/linux-acpi/20210510234020.1330087-1-luzmaximilian@gmail.com/T/#u

Can you try applying that patch to see if it is related?

Bjorn
