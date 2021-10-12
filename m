Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50FE42A516
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 15:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbhJLNJs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 09:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhJLNJr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 09:09:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F80C061570;
        Tue, 12 Oct 2021 06:07:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j5so87625794lfg.8;
        Tue, 12 Oct 2021 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYG56F/pmgMHv1mArUcA8EEq00+Sgti/K9FJa+oQWXk=;
        b=M9NkcejAIFMD9Vvc5kH26nk2yLKGRqy48zBmflcT4XDcmuPtHMkFigWJykHZGApZMz
         Rttt21COCUYuUewkdNzceE0E1cZRcP/I/h/jk9Z5N0Kt0wxFe62o1brCdWPBjot0/dfh
         HZyA92CLwzWKsdJHcJsJERPPlRLvQrp8cd4+Lonjq8MU/PbI7gg6Mb2+1gF3NqVn10M+
         tCPNLBDxFH6bxB2LOSouw8rn6om3JPZdKlhDfgvQZP8CEDZyrvS3xbSqVzHboJdRATkZ
         +bAaEvn+ifst8AyUGQPhfb5/ntK+cPpCrSs1f6VRJoO7c5PDY0+LL5MqT4R5YeChV07B
         t/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYG56F/pmgMHv1mArUcA8EEq00+Sgti/K9FJa+oQWXk=;
        b=GAwnReglIJRxGPYxY9mMSBMq8KDmYz9GkKe5ugwUcQt9BBdl8ug/FGHbwPj4HQgjgv
         2p4UT1fG6dBxOnEr14LRMTLioGlFaHU2Whsw0maqwAeQ7hVfHE2nYKOlpPdOaA/Enwv1
         XswSCMMmy3EOQc632N8TNf+HkUT/7Iwy2/WoY34PaTUJEjCsO7TkkKY7OvY1WrX1TAql
         FQEsXGc5Lyy72xkeFS1xdesvajImysV9buopEYJgsmPwu57ambSx74IfANVFjPC0eg3E
         QcN+SPrupuaqe+/7tyCaCUftCDtUCCq/3vkDdWoBbxFRdsg452IIVmBtG4P6+ADL3uFP
         bW2Q==
X-Gm-Message-State: AOAM531JZIKMaVlM+Q/2u6vOtQwPZ+KnrNYYDxOnkj+BdPXTIIzkolmh
        s1Zz7HdFQA/7mrL8Ov/1pgfJkbf85ktzAvcmHCRtMS3Cr3U=
X-Google-Smtp-Source: ABdhPJz61t07almgu0IAokxTxZ7zlkSBd1avA5oFDY7xmLI1j3ABt4rWihEiEMk01DF+Cr5t5BcjWjuAZsMbGht60Es=
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr28669547ljk.168.1634044063520;
 Tue, 12 Oct 2021 06:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
 <b023adf9-e21c-59ac-de49-57915c8cede8@oderland.se> <c9218eb4-9fc1-28f4-d053-895bab0473d4@oderland.se>
 <ef163327-f965-09f8-4396-2c1c4e689a6d@oderland.se>
In-Reply-To: <ef163327-f965-09f8-4396-2c1c4e689a6d@oderland.se>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Tue, 12 Oct 2021 09:07:31 -0400
Message-ID: <CAKf6xpvGyCKVHsvauP54=0j10fxis4XiiqBNWH+1cpkbtt_QJw@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
To:     Josef Johansson <josef@oderland.se>
Cc:     Thomas Gleixner <tglx@linutronix.de>, maz@kernel.org,
        linux-pci@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 12, 2021 at 2:09 AM Josef Johansson <josef@oderland.se> wrote:
>
> On 10/11/21 21:34, Josef Johansson wrote:
> > On 10/11/21 20:47, Josef Johansson wrote:
> >> More can be read over at freedesktop:
> >> https://gitlab.freedesktop.org/drm/amd/-/issues/1715

Hi, Josef,

If you compare
commit fcacdfbef5a1633211ebfac1b669a7739f5b553e "PCI/MSI: Provide a
new set of mask and unmask functions"
and
commit 446a98b19fd6da97a1fb148abb1766ad89c9b767 "PCI/MSI: Use new
mask/unmask functions" some of the replacement functions in 446198b1
no longer exit early for the pci_msi_ignore_mask flag.

Josef, I'd recommend you try adding pci_msi_ignore_mask checks to the
new functions in fcacdfbef5a to see if that helps.

There was already a pci_msi_ignore_mask fixup in commit
1a519dc7a73c977547d8b5108d98c6e769c89f4b "PCI/MSI: Skip masking MSI-X
on Xen PV" though the kernel was crashing in that case.

Regards,
Jason
