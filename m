Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889CD65FBC2
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 08:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjAFHOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Jan 2023 02:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjAFHOI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2023 02:14:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB761C93F
        for <linux-pci@vger.kernel.org>; Thu,  5 Jan 2023 23:14:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g1so1148121edj.8
        for <linux-pci@vger.kernel.org>; Thu, 05 Jan 2023 23:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GfS4/KXKGQsPO432hXwHidKTEwL2frnKcJ42qRrZ2f0=;
        b=RO7SlAKa6aEUrRYWCH5NFQ++68VKB8sUxprEulYvXkWiAKAJG10tqszXYo++4jR0b5
         z0yZXjRK23f8BOsEGtIDkn6vYgGhl4hNpG0T9ssutDXfUcCLSeOv+VDTCQXIPNk0S+Uy
         P+lHZ5kT0iWW1HEebeodEr08pfR/ZWDgw77xkcTXdg5iilcI14qxO/Sh+3w8CL1c2nnz
         Dujk1JWwpXJYqwevEv7PbxGCoEmu7DzAWAXDBb7ckB63/FN3PT9F3S89vqHL4EaGokbU
         FJ9NMdcAUQ9DMPh5UfPgRPIFyWQVM8GvUoS6313oLXHVM/d6bMtcVQl4iV6cWJHZ6PO0
         POsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfS4/KXKGQsPO432hXwHidKTEwL2frnKcJ42qRrZ2f0=;
        b=tNf1jY0++8K4vL8K0C3QTk+hDsuLOArc/qeA4j5HuRO3rInnItNSIXJInh1S9IF4fK
         MKjxBlV51uAF7NSBAzuuO7rMhopkktyiu5Obi9Nm0rWRBX7ufXb/uLNPZnsrliRvcCFa
         SuHf+uKi116hIC7IgDBkjXX3JjpjXWML3QSEcnyb1Drb7qFCpbwm9me/j8mekCcNLlH2
         efGGodX5CdQg3/Isv7lU8vBIoOlzD5k4GPpBQe9oc3Nx7nutS3/3nrcVemBluI+Tj9er
         OJJAI0yMbJATZkC2HoJbVjJlSwdE4/G/ghIGMA/ijIxM2Aisq6iH8Es80kQJYcvQ13am
         EWYA==
X-Gm-Message-State: AFqh2krG+iPeZo9yK/LaM5QTyW2ze1yIAIeLpF76sySNEYY4eJk3ZgRD
        Ku4ZgBQ74/uuCZdPjIHXRh0UnvahKOpe5a5ZNXNGxTIilD+PBg==
X-Google-Smtp-Source: AMrXdXti1oiS95Q5fqon9BPiWtROmLXCFWPFDs9YRpbF9wep3zIAKSXQsX94aQxFgO15Sb9WCskzFA/0gFCUxtDDSgM=
X-Received: by 2002:aa7:d895:0:b0:486:3d22:5685 with SMTP id
 u21-20020aa7d895000000b004863d225685mr4301472edq.106.1672989245880; Thu, 05
 Jan 2023 23:14:05 -0800 (PST)
MIME-Version: 1.0
References: <CAAhV-H5muGHQ=awDckP2Fv6kg_-Mrcpre2ng52yKrTnhpqrVOA@mail.gmail.com>
 <20230105040114.GA1115282@bhelgaas>
In-Reply-To: <20230105040114.GA1115282@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 6 Jan 2023 15:13:54 +0800
Message-ID: <CAAhV-H6jRDfLWJK7pCH4xsD=8cNYB0UNx89G0=uFkzfBeBgbKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Add quirk for LS7A to avoid reboot failure
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 5, 2023 at 12:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jan 05, 2023 at 10:49:53AM +0800, Huacai Chen wrote:
> > On Thu, Jan 5, 2023 at 2:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Jan 03, 2023 at 03:34:01PM +0800, Huacai Chen wrote:
> > > > cc27b735ad3a7557 ("PCI/portdrv: Turn off PCIe services during shutdown")
> > > > causes poweroff/reboot failure on systems with LS7A chipset. We found
> > > > that if we remove "pci_command &= ~PCI_COMMAND_MASTER" in do_pci_disable
> > > > _device(), it can work well. The hardware engineer says that the root
> > > > cause is that CPU is still accessing PCIe devices while poweroff/reboot,
> > >
> > > Did you ever figure out what these CPU accesses are?  If we call the
> > > Root Port .shutdown() method, and later access a downstream device,
> > > that seems like a problem in itself.  At least, we should understand
> > > exactly *why* we access that downstream device.
> >
> > Maybe I failed to get the key point, but from my point of view, the
> > root cause is clear in previous discussions:
> > https://lore.kernel.org/linux-pci/CAAhV-H5uT+wDRkVbW_o1hG2u0rtv6FFABTymL1VdjMMD_UEN+Q@mail.gmail.com/
> > https://lore.kernel.org/linux-pci/20220617113708.GA1177054@bhelgaas/
> > https://lore.kernel.org/linux-pci/CAAhV-H6raQnXZ4ZZRq19cugew26wXYONctcFO0392gZ00LC6bw@mail.gmail.com/
>
> That's great, but the root cause should be summarized here in the
> commit log.
OK, I will update the commit log.

>
> > > To be clear, cc27b735ad3a does not cause the failure.  IIUC, the cause
> > > is:
> >
> > cc27b735ad3a is not a bug, we refer to it just because we observe
> > problems after it.
>
> Right.  But you said "cc27b735ad3a ... causes failure," which is not
> quite true.  cc27b735ad3a may *expose* an LS7A hardware defect that
> previously didn't cause a problem, but I don't want to blame
> cc27b735ad3a for that hardware issue.
OK, got it.

Huacai
>
> Bjorn
