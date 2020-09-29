Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C740627D9B9
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 23:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgI2VEd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 17:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgI2VEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 17:04:32 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B45C061755;
        Tue, 29 Sep 2020 14:04:32 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k6so4098335ior.2;
        Tue, 29 Sep 2020 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=a0NkXAOfz/tCmoqwRSNwwLFhEObgDZyv1aGRYsN3A58=;
        b=TeS19AGYCf3rt3zZCs54zjW1ptgIGEl3q1296IzjUYomFm/qDGvxkkapB5cfsT6TsK
         n10pzh/dE+mtOpk0sjG9QQhvLxDtcjBpDd2ySFdfU5xGRmdn3VbU1coeYLNqrpz9M+3N
         jsZNqR6JhuGleXROuWpm8bJNtiiZUWhvUdjSwmJon/vKVG4jQgr0HmFco26wzG0/uDk9
         7FqTufKk58VzGNGLwnYe0EXupMLEyENg8b9tRMvOh7VYIJcG+QxHXA6YN4eKvyjs1BhY
         Nuj0rANjzFjBVNVURmjrYmqOwEb4gyo1XaVHqDLOnYhdzb+JuXhtpZ2nnWDoqWQ8m2CO
         iSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=a0NkXAOfz/tCmoqwRSNwwLFhEObgDZyv1aGRYsN3A58=;
        b=ACMsA0FtwewR19kT6qzwM2pdZ87cvXluEyKJignl1Vs+BSV1DDafUnY7CaZL1vZh8l
         VeB0msqL9KRYcXuxJocOZjTeCOQbwyXM0FH6Qb6/g8ssb1Vq4S4qTJcKO4d8TbFIZ/5x
         ruVtrdeKI7U2DFyAqgQVS8VYWrgcrU39NEYy27uXyiF/WvBngsuiexYX1Yzeqy1omu0V
         ZPSsqK16uf9BPPvkJm1FWoF9EPsY+fgXuwzVJ0bk55x4UywR9VNr6NTfs8+JzApGCjTP
         ry9ZAHkgh0uyGsTLZNdapGO6QkN78i/i1pEMAJtVJeXVC3MRqVpI6qPbedz0XjX4aBfJ
         3hpA==
X-Gm-Message-State: AOAM53332uwuRyaiIo6A1Y5ISKLsIBfdjh9aGJnayN6W+xziTcBAsH4e
        viHen34rT/zrX6r5ApVh13miUUf446OE6qlJ68lcJ25u9jg=
X-Google-Smtp-Source: ABdhPJw9R4hpdBEcsERF5nvqenBU3lc4J0Oq7b72lcUX6fVXHUqz5rtyubnWtQBdKHPjJIZzjwgcjhnA/I/AE9lyWsY=
X-Received: by 2002:a02:6995:: with SMTP id e143mr4442633jac.78.1601413471150;
 Tue, 29 Sep 2020 14:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com> <b88d3549-717c-8208-0900-c85db8788618@linux.intel.com>
In-Reply-To: <b88d3549-717c-8208-0900-c85db8788618@linux.intel.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Tue, 29 Sep 2020 16:04:19 -0500
Message-ID: <CABhMZUUBGuQjP5cBsFNxv3UGNPDVNPjjTm5CQfD9YnYBk9yVnA@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] Simplify PCIe native ownership detection logic
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.nkuppuswamy@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 4:00 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi Bjorn,
>
> On 9/27/20 6:11 PM, Kuppuswamy Sathyanarayanan wrote:
> > Currently, PCIe capabilities ownership status is detected by
> > verifying the status of pcie_ports_native, pcie_ports_dpc_native
> > and _OSC negotiated results (cached in  struct pci_host_bridge
> > ->native_* members). But this logic can be simplified, and we can
> > use only struct pci_host_bridge ->native_* members to detect it.
> >
> Did you get this patch set or do I need to send it again?

I got it, thanks.  More importantly, it looks like linux-pci got it, too :)

$ b4 am -om/ https://lore.kernel.org/r/a640e9043db50f5adee8e38f5c60ff8423f3f598.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com
Looking up https://lore.kernel.org/r/a640e9043db50f5adee8e38f5c60ff8423f3f598.1600457297.git.sathyanarayanan.kuppuswamy%40linux.intel.com
Grabbing thread from lore.kernel.org/linux-pci
Reduced thread to strict matches only (18->10)
Analyzing 10 messages in the thread
---
Writing m/v9_20200922_sathyanarayanan_kuppuswamy_simplify_pcie_native_ownership_detection_logic.mbx
  [PATCH v9 1/5] PCI: Conditionally initialize host bridge native_* members
  [PATCH v9 2/5] ACPI/PCI: Ignore _OSC negotiation result if
pcie_ports_native is set.
  [PATCH v9 3/5] ACPI/PCI: Ignore _OSC DPC negotiation result if
pcie_ports_dpc_native is set.
  [PATCH v9 4/5] PCI/portdrv: Remove redundant pci_aer_available()
check in DPC enable logic
  [PATCH v9 5/5] PCI/DPC: Move AER/DPC dependency checks out of DPC driver
---
Total patches: 5
---
Cover: m/v9_20200922_sathyanarayanan_kuppuswamy_simplify_pcie_native_ownership_detection_logic.cover
 Link: https://lore.kernel.org/r/cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com
 Base: not found (applies clean to current tree)
       git am m/v9_20200922_sathyanarayanan_kuppuswamy_simplify_pcie_native_ownership_detection_logic.mbx
