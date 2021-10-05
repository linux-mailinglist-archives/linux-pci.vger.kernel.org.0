Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B616421F71
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 09:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhJEHe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 03:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEHe0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 03:34:26 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0E5C061745
        for <linux-pci@vger.kernel.org>; Tue,  5 Oct 2021 00:32:36 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id e66-20020a9d2ac8000000b0054da8bdf2aeso22572575otb.12
        for <linux-pci@vger.kernel.org>; Tue, 05 Oct 2021 00:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qGJhAWxXMi/6Si5zd/PBNABwqJkv9/Vi5nIv6mXI6k=;
        b=ZVFjrU2JVb43qCjvMcytBd0UgrcoWBdb6t31F5TE29hmdCpEk+pex3Eb/oZKXDd3pG
         hc3KN8L3HIAcZFv49fO6QU82W1pSUlZQSOprXPuJHZWh4c+m1cGQevE6U1OTnRDcGJmc
         jQg08W7K6aBHrMC2vpI5r1xo4HmnJxLR0aDwtDiWBtVdOoC4zyJlv/muUXkcNsTDPu7A
         K0FzOQvaNLpubqkealU/jGzNR6GB/X3d2gfxZJtwToLNmXtcUTsJqLby2kdbafqK/bYV
         gl0m/bVKXjlF20bK9JpwV+o1qd4WsqJwoWXCgJdefOsSOi2gFHk7EX+QAH6JeN8mA6r3
         kCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qGJhAWxXMi/6Si5zd/PBNABwqJkv9/Vi5nIv6mXI6k=;
        b=GuHNgpqaZcG0lxApgo+o/pCT3DfEw2tucSpXr4w+HdyZRg/CdDjtykSA4kGUloy0pQ
         w2W9ktX1rVWim5xieq6aGfNELoTD9s/gNSLxKGXNcCYVFmCYn9pxUpTkjIbL83qNHY21
         I+QGWNl3mapRWQeBQHpElHk1SFD9t5e6w2gF/48sCRsLa5eU7pMtC7/oVnjkaqe172bz
         A/0qHaeaIze+1zgdyd0+Z7K4hyMF85z8Ojxcg4MGyN9yc/3u4Yu6jCIpokImWcGM0xiD
         K+fF03pvMkxWYbj/xtxjb6OZlxVzPsbQvoPCP619Ubr+fDf74KTRohRFMf6qktteFhnz
         H3Zw==
X-Gm-Message-State: AOAM5312a/H7cvR4MRaOapTkc46+5h+GJIdaSfqz3JrbzrhGyD8xrkDv
        abW0D64Y835gwx2lZxkp1+NJuzAopGIO9nRVWG/5BMKY3xaOKg==
X-Google-Smtp-Source: ABdhPJxc73zYoonyJIwfOtK0DSjKPgAqkN2U60kQjaim1WEf4enTS16/dzRj1OVimGVZ8oj5oWPKMUYo1qh0AqnMXLw=
X-Received: by 2002:a05:6830:2816:: with SMTP id w22mr12891592otu.351.1633419155337;
 Tue, 05 Oct 2021 00:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHP4M8XzZCwKk3TGmHKVMdf5mkWKfafE75DEKBs6-t4ZPw-kaw@mail.gmail.com>
 <20211003170510.GA982214@bhelgaas>
In-Reply-To: <20211003170510.GA982214@bhelgaas>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Tue, 5 Oct 2021 13:02:23 +0530
Message-ID: <CAHP4M8UC-rrW5iff-6iYYMC=k85D-M1WYW44aXXECSFaJ=22kA@mail.gmail.com>
Subject: Re: None of the virtual/physical/bus address matches the (base) BAR-0 register
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn.

I tried enabling and dumping the kernel-page-tables (via
/sys/kernel/debug/kernel_page_tables), but there we only have the
kernel-virtual-addresses :-\

So, I tried navigating the code (beginning from
arch/x86/mm/debug_pagetables.c), and stumbled upon
slow_virt_to_phys(), and hit the jackpot !
Even the code there looks as simple as the procedure - we fetch the
pte for the vpn, get the mapped pfn, and return the physical-address
after adding offset.

#####################################################################
So, now, the following :

    {
        phys_addr_t mmu_mapped_address;

        printk("original (kernel-virtual) address \t= [%lx]\n",
bar0_ptr);

        mmu_mapped_address = slow_virt_to_phys(bar0_ptr);
        printk("mapped address (via MMU) \t\t= [%lx]\n", mmu_mapped_address);
    }
#####################################################################



gives :

#####################################################################
original (kernel-virtual) address     = [ffffa11040217000]
mapped address (via MMU)         = [e2c20000]
#####################################################################



Thanks a ton Bjorn, this could not have been possible without you !


Thanks and Regards,
Ajay
