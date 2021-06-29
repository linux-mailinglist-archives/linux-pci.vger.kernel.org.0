Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D8E3B6C5E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 04:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhF2CC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 22:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhF2CC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 22:02:59 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B59C061574
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 19:00:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id v3so24673772ioq.9
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 19:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Un2GHf85jp25g9aePsl5RLIayJkGbjLEZfr5tgDKBmM=;
        b=EFl2Nj829OVY8NQHhtELaUdkN9oP5MvMRjBXObIYGX8t1DxN96EiW4RR2U27c8Z5yG
         0hLlSKnCkSzJ0cuMwnf7/P+t9o/cA1rCOoySbiXU1uwb9/TG7kzNvBNXWUnwtg8iknHA
         tN0b6beWewMhpiK8Daiq20ChP1qYFllx4nNU396PordB0T+j36Mcqtvs1pX/mmtJydOY
         eHOedfRS0Tn2w1edmeoJn6gLmPZh5LMrtLnkjUDnBtpOzssoDzmNJ//FXpSXoTsb70zN
         ep6cGZ6F1OaMxO7TPRqHZA7Mo//LgMea2V8Hklr9+ocKEWuVJH6APb2+WXI8YZBFclNQ
         r6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Un2GHf85jp25g9aePsl5RLIayJkGbjLEZfr5tgDKBmM=;
        b=NaytPZisdO7aYuRvcCgHEsB58FV+1ZqAg7UmhbkIBTG355SBtTvtaml5mju+UKoLvJ
         O0x/75Sq2M/xbIzKbr4XO7zZWIkhZSRrQddBsBLZn4hCsYfUaFd+kr9uDIp4x+FesYvi
         ge8J2oskvPTk02UlrS6P+NAy5tPgbMbx5XYxUcUG3SC/HVtlio6VgoF/rz8pOq5xk/in
         uwzn+NYCle8D6r61DZ3JMK1a2siQiTorX7dS1VVi2L134z3j03SiuK+qeAPe+SAslMXk
         12OZuGmc2UUE9rmPoJbUsAeIzZEagQz99GWI6tG9sV421IpwC/PNF7ckGm9fzh4hl+Ex
         y+1Q==
X-Gm-Message-State: AOAM532eciMGNLqy4UYXLnO7/Lx731eUrfyc8pI1zIqWaZQsMz8Wfd8y
        F6ijOP+XDssTHXglzhtaCFNWlmx5At8duTuZTxI=
X-Google-Smtp-Source: ABdhPJwaA4fa9ifbUlEI8V6DKlttn/ruagsOo7+b8/XAQqWKfp2/KBAyFIWfF96Wn+BSXvfuEUJOWECnYa9LAQmrUNE=
X-Received: by 2002:a05:6638:614:: with SMTP id g20mr2104291jar.135.1624932031463;
 Mon, 28 Jun 2021 19:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H68tBbTxoy-qOP4F3KDWEjunZMC-v3dAPWfU==NCMBbyA@mail.gmail.com>
 <20210628205143.GA3955911@bjorn-Precision-5520>
In-Reply-To: <20210628205143.GA3955911@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 29 Jun 2021 10:00:20 +0800
Message-ID: <CAAhV-H6rmQjfeOhoLDUu_rCBGLUrL_Vi4wRAgNzSjEdOjSjUmg@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] PCI: Improve the MRRS quirk for LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Tue, Jun 29, 2021 at 4:51 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Jun 27, 2021 at 06:25:04PM +0800, Huacai Chen wrote:
> > On Sat, Jun 26, 2021 at 6:22 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Jun 25, 2021 at 05:30:29PM +0800, Huacai Chen wrote:
> > > > In new revision of LS7A, some PCIe ports support larger value than 256,
> > > > but their maximum supported MRRS values are not detectable. Moreover,
> > > > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > > > MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> > > > will actually set a big value in its driver. So the only possible way is
> > > > configure MRRS of all devices in BIOS, and add a PCI device flag (i.e.,
> > > > PCI_DEV_FLAGS_NO_INCREASE_MRRS) to stop the increasing MRRS operations.
> > > >
> > > > However, according to PCIe Spec, it is legal for an OS to program any
> > > > value for MRRS, and it is also legal for an endpoint to generate a Read
> > > > Request with any size up to its MRRS. As the hardware engineers says,
> > > > the root cause here is LS7A doesn't break up large read requests (Yes,
> > > > that is a problem in the LS7A design).
> > >
> > > "LS7A doesn't break up large read requests" claims to be a root cause,
> > > but you haven't yet said what the actual *problem* is.
> > >
> > > Is the problem that an endpoint reports a malformed TLP because it
> > > received a completion bigger than it can handle?  Is it that the LS7A
> > > root port reports some kind of error if it receives a Memory Read
> > > request with a size that's "too big"?  Maybe the LS7A doesn't know
> > > what to do when it receives a Memory Read request with MRRS > MPS?
> > > What exactly happens when the problem occurs?
> >
> > The hardware engineer said that the problem is: LS7A PCIe port reports
> > CA (Completer Abort) if it receives a Memory Read
> > request with a size that's "too big".
>
> What is "too big"?
>
"Too big" means bigger than the port can handle, PCIe SPEC allows any
MRRS value, but, but, LS7A surely violates the protocol here.

Huacai

> I'm trying to figure out how to make this work with hot-added devices.
> Per spec (PCIe r5.0, sec 7.5.3.4), devices should power up with
> MRRS=010b (512 bytes).
>
> If Linux does not touch MRRS at all in hierarchices under LS7A, will a
> hot-added device with MRRS=010b work?  Or does Linux need to actively
> write MRRS to 000b (128 bytes) or 001b (256 bytes)?
>
> Bjorn
