Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3BC26BC18
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 08:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgIPGCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 02:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgIPGCd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 02:02:33 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D3CC061788
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2020 23:02:32 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nw23so8594961ejb.4
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2020 23:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNkpn8knUQRf75ccabZQOR+WL+blOBg465I1jkNznx4=;
        b=MnrTjTd684v+kA7TytUzDqVOH0AP94KL/aLIrgUj3A3/KfbidtssnPAsfSSFiKd6aF
         47QNG4fEM/pIwRDzN408QnMz0ldbVrIko5qCRG+nkjqstl1olW4cDNI+4xkeHhn6dynZ
         kjSxaRoKpyQ5Aln0Qc5Tn+Mr4ec/lyDFgEt+bhsObGpbZFUYlZsmA8lAsCnxBcbLF3fl
         sln4d2QoQ1nAZQnVFwKwYnPDaedMIW+3KFz5ChD4emRLNIIBxadiVJv9E+jsgNPhqQhI
         bASmtew/QwgiXuUoIy4MKJNu9l+DOO7hyDkB67Tef7nV4amtIaY/26cqlwrclT14XsXd
         Mbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNkpn8knUQRf75ccabZQOR+WL+blOBg465I1jkNznx4=;
        b=Jas+2QKDUE4HzSXe+ZK9F7RCXsqN/Sosvi/dB79I18RTnFYOfqqqUyltB6/rU8yo4b
         Iph7htV/wqr5k642o9rDU1XrqhtkNCLfFIIkA0iRQ1S6Qo9g2JuobbbPpFZN/B9KAOEu
         PEUGp6VoUm6qtlz2l9UCLRX7ktILxF/mHASoitEHXR6vmcdCJZGfuXXMnuGbrpNnDX9T
         8xqdSe0Xn+X52a+E1GhSVsOBhg6VXy28DHwU0SxRfXZVqQC1EHfP5Y8kIMPEzkmrjvTn
         AJ6HJz/nBU0RbEs5oYILy4K+q/heHsqa1RIjBMa2+W08aMSNlms6uQUHK/qeDxRCrlvz
         mabw==
X-Gm-Message-State: AOAM533ftMe5RVxZqWSqopyJsIdl9rEAj1TjDWK3Ym26SP6cj30EHMLE
        uJxQSvui4n+nvWF3Fd/sQWZ8FPl/25UcvSlThJNFJCTHuaUC/XZE
X-Google-Smtp-Source: ABdhPJw7SwSnrOhnHZOUUAB1XtgCMK4ilwlzw6vSX3Wm/NM7HGgn82Za9OcbTn+kybAvmYREp6CU3P9b4z+IpVpEoPc=
X-Received: by 2002:a17:906:c154:: with SMTP id dp20mr23280220ejc.115.1600236150808;
 Tue, 15 Sep 2020 23:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEmrP21e_sgE8C49och1QEABTK4Fh8aVgH8qsyT9t8EJ4w@mail.gmail.com>
 <20200916054820.GA853@wunner.de>
In-Reply-To: <20200916054820.GA853@wunner.de>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 16 Sep 2020 08:02:20 +0200
Message-ID: <CAMGffE=rCcDxeQUk2GY+MHn+07Sn6S=Q6Gssu+RX_BB084uJsg@mail.gmail.com>
Subject: Re: [RFC] pcie hotplug doesn't work with kernel 4.19
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

see reply below
On Wed, Sep 16, 2020 at 7:48 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, Sep 15, 2020 at 04:15:15PM +0200, Jinpu Wang wrote:
> > We are testing PCIe nvme SSD hotplug, it works out of box with kernel 5.4.62,
> > dmesg during the hotplug:
> [...]
> > But with kernel 4.19.133, pcieport core doesn't print anything, is
> > there known problem with kernel 4.19 support for pcie hotplug, do we
> > need to backport some fixes from newer kernel to make it work?
>
> No known problem.  Please open a bug on bugzilla.kernel.org and attach
> full dmesg output for 5.4.62 and 4.19.133, as well as lspci -vv output.
> You may want to add the following to the kernel command line:
>
> ignore_loglevel log_bug_len=10M "dyndbg=file drivers/pci/* +p"
> pciehp.pciehp_debug=1
https://bugzilla.kernel.org/show_bug.cgi?id=209283
I added you as cc.
I will gather other logs as suggested, and upload them to bugzilla.
>
>
> > [  683.218554] pcieport 0000:16:00.0: pciehp: Slot(0-3): Card present
> > [  683.218555] pcieport 0000:16:00.0: pciehp: Slot(0-3): Link Up
> > [  683.271702] pcieport 0000:16:00.0: pciehp: Timeout on hotplug
> > command 0x17e1 (issued 73280 msec ago)
> > [  686.301874] pcieport 0000:16:00.0: pciehp: Timeout on hotplug
> > command 0x13e1 (issued 3030 msec ago)
> > [  686.361894] pcieport 0000:16:00.0: pciehp: Timeout on hotplug
> > command 0x13e1 (issued 3090 msec ago)
>
> Those timeouts look suspicious.  Perhaps the hotplug controller
> claims to support Command Completed Support, but in reality does not?
>
>
> > CONFIG_HOTPLUG_PCI=y
> > CONFIG_HOTPLUG_PCI_ACPI=y
> > CONFIG_HOTPLUG_PCI_ACPI_IBM=m
> > CONFIG_HOTPLUG_PCI_CPCI=y
> > CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
> > CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
> > CONFIG_HOTPLUG_PCI_SHPC=y
> > CONFIG_HOTPLUG_PCI_PCIE=y
>
> You may not need ACPI_IBM, CPCI, SHPC.
will consider this.
>
> Thanks,
>
> Lukas
Thanks!
Jinpu
