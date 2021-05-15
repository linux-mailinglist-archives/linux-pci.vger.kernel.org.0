Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA9E381883
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 13:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhEOLxy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 07:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhEOLxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 07:53:51 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC94C061573
        for <linux-pci@vger.kernel.org>; Sat, 15 May 2021 04:52:37 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id y12so1504007qtx.11
        for <linux-pci@vger.kernel.org>; Sat, 15 May 2021 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uhyjK5EblgN3XT6g+3+3yQHVLnaCK/jzddHztEMx14M=;
        b=S2PVs85b6ArvHNMSBbFHXeX3fcRH++XgcbYwuae3FHe8cxfT5/2CZvDbulcbST7W+4
         5N0NoNCCMcg0C88Tvu4ASNbXfUuJqB+YfNNpmTwwGY8Ush49qooQiqLbz/UdgpjtTHw0
         Q8d5+dnyn3kbjk4j3i3dPYNjA1IhbQ5C+GPsP27BMQhZ2SoPfPZa+fPVANMfS1laeKEl
         BgS3JXI5Ru6xUiVm0+StlKjEny+axPr/vvRnCEfRR+ZMtGwEL2iWxflS782pJlruhlot
         loACJnyaGvvnkqIb3XjTlZgcWAR/b9+xMZY0WlMBhs98JUl7ykQ4StnSCkeRBmgpZgPI
         qdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhyjK5EblgN3XT6g+3+3yQHVLnaCK/jzddHztEMx14M=;
        b=qKBs1vEgeqiEjPd9tx+RRd/pODYg2DWePIrLf8S+Pu1M0JXcSalbvJnAhAqbIftO75
         bzt9u8fiETE2X0AQ+kPi87Wak6e2/2OBX3fD7qndJRf/cIdRGZcIgkNy/EYTWoabhtLH
         iE2YO57/jQVzXMvWGiNgVSKP7j/mt2lgHpVWXzdwyUA5qL1sfsrDnj26PoYKzR5dOkgz
         CUr82UDQBWwXST5LM3cY69FmPGJvXNsoajTllro5FKzEYIxPhm8k6FGHXSEZbrUn6zhT
         SWAfHdjtdgH8gRWmSSQ7r4u+kJF2vcbcTZySoTQjgjSQDD5r+zdzy+b7+fo4QhFaYi+D
         jp4w==
X-Gm-Message-State: AOAM532Pq2XaOxEgH4eROgZVkX3nUoPD0vXqUJN5E3M3b3SEQ5G6e7uG
        hp3nSM7rRZWqrY8NI9TBDtwTfQBYhrFRBQ7ZSFU=
X-Google-Smtp-Source: ABdhPJwZYTNVAhABEd4xaM3BNBHOTdZ2bZNdpQQM9q9T+HkE2VQ4VNrXcCm5g+ya+kWa54jAXaxv0BYgrkY7NLnVsBw=
X-Received: by 2002:ac8:7191:: with SMTP id w17mr39956120qto.45.1621079556326;
 Sat, 15 May 2021 04:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZvZ2o5EXK+yM2JBy5wnLb9NL6sfdFyzvqRjq_ZvO8P-aw@mail.gmail.com>
 <20210428211518.GA432124@bjorn-Precision-5520>
In-Reply-To: <20210428211518.GA432124@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sat, 15 May 2021 13:52:25 +0200
Message-ID: <CAA85sZtGZHXb5eM2iJ8Hpgwxitc3jCT-qQ_do2KsMkUjVw2QJg@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI/ASPM: Use the path max in L1 ASPM latency check
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 28, 2021 at 11:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Apr 26, 2021 at 04:36:24PM +0200, Ian Kumlien wrote:
> > On Thu, Feb 25, 2021 at 11:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Wed, Feb 24, 2021 at 11:19:55PM +0100, Ian Kumlien wrote:
> >
> > [... 8<...]
> >
> > > I think the most useful information would be the ASPM configuration of
> > > the tree rooted at 00:01.2 under Windows, since there the NIC should
> > > be supported and have good performance.
> >
> > So the AMD bios patches to fix USB issues seems to have fixed this
> > issue as well!
>
> Really?  That's amazing!  I assume they did this by changing the exit
> or acceptable latency values?
>
> It would be really interesting to see the "lspci -vv" output after the
> BIOS update.

First time I looked there was no difference...

for x in 00:01.2 01:00.0 02:03.0 03:00.0 ; do lspci -vvvv -s $x |grep
Latency ; done
Latency: 0, Cache Line Size: 64 bytes
LnkCap: Port #0, Speed 16GT/s, Width x8, ASPM L1, Exit Latency L1 <32us
Latency: 0, Cache Line Size: 64 bytes
LnkCap: Port #0, Speed 16GT/s, Width x8, ASPM L1, Exit Latency L1 <32us
Latency: 0, Cache Line Size: 64 bytes
LnkCap: Port #3, Speed 16GT/s, Width x1, ASPM L1, Exit Latency L1 <32us
Latency: 0, Cache Line Size: 64 bytes
DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
LnkCap: Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <2us, L1 <16us

I think they actually fixed a issue behind the scenes

> Thanks a lot for following up on this!

Sorry about the delay - work + looking at a switch with a dodgy lldp bug :/

> Bjorn
