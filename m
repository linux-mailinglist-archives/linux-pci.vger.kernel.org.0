Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F061ADEF1
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbgDQOEQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730563AbgDQOEQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2020 10:04:16 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5F2C061A0C
        for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2020 07:04:16 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b18so2237478ilf.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2020 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4PtYCRRGMjCHyUoR/ZC/d46oKq8RduBjto5rW6+7ao=;
        b=aMOSDDGw4jRUBWTYPDPLybYUIdgXhyMsB6U3tCOoQkdRcGW0bZdc3PfzG26H4ufX8/
         biSquO+yL5Jk75LKGTNdz9HFnkRvKB2tIX6ZL5srXR3cJaOYeDblGFRdUSlA9QU5WS8e
         6JR85+BP1eyV9WWIvU7chq8E4fIJZSb9vgVlfRIikZw3UkkH1ck0OxMOU+gpybFQeJ4E
         FgOzw21jvPWSRrK6jiC1/5qdXrSqRPKN15sXCbHOirSQAdAAvnIdsrG65An0Soslfq/b
         kNOQLkMdh+QCZwZSG5RHdPHZkXG+/YYFShRMwbWCtbtXCXcWdBQiHAXSJx4hx/MV9G80
         LWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4PtYCRRGMjCHyUoR/ZC/d46oKq8RduBjto5rW6+7ao=;
        b=L4lEqA/55JWF1ikYVGe+by9rz3TgFYqSq607jO4y+SuS9UefVsPNB2yJMOYy3Q+EwF
         SUI+55T2rloY16h4dMbX6wreOaYT5rKPRQMWr9RY+Fs5ddvm67e1UWkL7DBRp+rq517E
         xE2ccba+uENh21S4V5f2q1Gq0j9s+GbFHSxlFLRjfhkI+PTcQ40cy8J4O9jmpDxW5Tac
         RmsUgBP04w4TSU6uUVpRwUIkqVn/pWE3SInhJc8GdwtmIN5VaAY/iMRm0j5uMb3BwxA/
         QNePWx6S4QIrrKLqd858pvcq2jw9EKToLRIDKgUJqo/VG4nZJsE+pEpNW2bcuEteBKxw
         1/6Q==
X-Gm-Message-State: AGi0PuaT27JK+/kLh+E6jkeGSXP5znAc8ffq14BmM4btNkuj6p0JWAbf
        mqO1Wbp8NLkrBPaIwMElfV09ghdoWuVuJ9WxyTk=
X-Google-Smtp-Source: APiQypKMep5b3CfGNz96ChZdXyrA/PH4HyqxxVUUz38S5QLVqoUXaolJnn9BjpGM84wOsLlndV4kBwqgqzRR8EuWaIo=
X-Received: by 2002:a05:6e02:dc3:: with SMTP id l3mr2973276ilj.149.1587132255465;
 Fri, 17 Apr 2020 07:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200416165725.206741-1-maxg@mellanox.com> <20200416165725.206741-2-maxg@mellanox.com>
 <20200417070238.GC18880@lst.de> <7255b11a-4ea0-3bac-2cc3-7fff0b56c9ac@mellanox.com>
In-Reply-To: <7255b11a-4ea0-3bac-2cc3-7fff0b56c9ac@mellanox.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Sat, 18 Apr 2020 00:04:04 +1000
Message-ID: <CAOSf1CHdepTVZUE0=H0P3vLTY820wyiLGuKM_qOjv9kguS3Zww@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/powernv: Enable and setup PCI P2P
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Carol L Soto <clsoto@us.ibm.com>, idanw@mellanox.com,
        aneela@mellanox.com, shlomin@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 17, 2020 at 9:17 PM Max Gurtovoy <maxg@mellanox.com> wrote:
>
> > The enable and disable path shares almost no code, why not split it into
> > two functions?
>
> how about also changing the defines OPAL_PCI_P2P_* to an enum ?
>
> /* PCI p2p operation descriptors */
> enum opal_pci_p2p {
>
>          OPAL_PCI_P2P_DISABLE    = 0,
>
>          OPAL_PCI_P2P_ENABLE     = (1 << 0),
>          OPAL_PCI_P2P_LOAD       = (1 << 1),
>          OPAL_PCI_P2P_STORE      = (1 << 2),
> };
>
> Fred ?

I'd rather you didn't. We try to keep the definitions in opal-api.h
the same as the skiboot's opal-api.h since the skiboot version is
canonical.

Also, generally patches to anything PowerNV related go through the
powerpc tree rather than the pci tree even if they're PCI related. Can
you make sure you have linuxppc-dev CCed when you post v2.

Oliver
