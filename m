Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD6228CEB
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 01:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbgGUXzs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 19:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgGUXzr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 19:55:47 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8060FC061794;
        Tue, 21 Jul 2020 16:55:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j187so354952qke.11;
        Tue, 21 Jul 2020 16:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/TusodCOkVvaPIPRv3/TkFGT0iZF4+jcIUhNwbLLts=;
        b=XxDZjzBQX/JypgQFpbGMt9JBp3QupSQRR2l2cqBFlIY126M0k9476dLpAHG1P7qEBZ
         q1de1ebTx1al4LolnfC1S/b6auhINY2jVYQJjmSXu19eyyUp/5a9SQ+fgHyH+WiX3JuP
         XqZcWQDVyfT0nK8Jpt4fLDN/LUuqRhGPaOK9hvK3WWqXMk42p0zGDgf5w8pU10OjnFQH
         8w59ktLw/pEIg/UODZJcH4qQyZFsb2Hl7yNfcnlbd1ytqUEKFQo1IBOv1tOpjdr6kZui
         gVJAnmlLvHBhuCETxutU5NF4b/WUSTBfsq04EvBwv8YkOe1kNT0Fn0KtPE/Rh9i1w4FW
         hbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/TusodCOkVvaPIPRv3/TkFGT0iZF4+jcIUhNwbLLts=;
        b=HBSJVWYyHiuMyXYpjWZ7ky8y7XOoUW6SmbocI1cRU2zuAlPKEBleB7QB0XFzibbWp7
         JJoqOdlSfguuab8qmXY9qR3gWOOUC4XFdqk3wT8Bw/oZYw79p80bqPOjD3EUpMyNv1v/
         v2fMk8o6Z0jUV7M2JBhQjqxWxqMAZiYxRXiQDadq7v0fKsA+iy041hwtQuT/wivE89c2
         XaUPTr/p3H7EGpzX6tgeWAY0140vrpA9UfiYIlEhokWs7EwLau7iHi+klXOT/Sh9UxIW
         +lcf6A8eSUKcd3BNHSEvolDOSAgfsN1enWh6c85bsi11AhQEkwileWhDsMcCBsVv8pTc
         +WRA==
X-Gm-Message-State: AOAM532hQEiUq8Wuy7tc7uTJ9W/2nKffRiKt1KpoYI7xF8DzhN7kaC68
        2gqM4BkBE435e5a4UqsbWpWXzHIe2XVi0ZfRAVBeXKeyLCE=
X-Google-Smtp-Source: ABdhPJxwtExxUtytMeHyp1UWtmHIBO9JaJr6FDY7LSyCMpfDoQr3XDzM72FMj/39m8VxWHTo/XeVcK9/3lLCjqLH5J0=
X-Received: by 2002:a37:9fcc:: with SMTP id i195mr30330309qke.415.1595375746474;
 Tue, 21 Jul 2020 16:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <CADLC3L20DuXw8WbS=SApmu2m49mkxxWKZrMJS_GBHDX7Vh0TvQ@mail.gmail.com>
 <CADLC3L2ZnGTQJ+fwCy42dpxhHLpAFzFkjMRG3ZS=z7R4WK08og@mail.gmail.com>
In-Reply-To: <CADLC3L2ZnGTQJ+fwCy42dpxhHLpAFzFkjMRG3ZS=z7R4WK08og@mail.gmail.com>
From:   Robert Hancock <hancockrwd@gmail.com>
Date:   Tue, 21 Jul 2020 17:55:35 -0600
Message-ID: <CADLC3L1R2hssRjxHJv9yhdN_7-hGw58rXSfNp-FraZh0Tw+gRw@mail.gmail.com>
Subject: Re: 5.7 regression: Lots of PCIe AER errors and suspend failure
 without pcie=noaer
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 10, 2020 at 6:28 PM Robert Hancock <hancockrwd@gmail.com> wrote:
>
> On Fri, Jul 10, 2020 at 6:23 PM Robert Hancock <hancockrwd@gmail.com> wrote:
> >
> > Noticed a problem on my desktop with an Asus PRIME H270-PRO
> > motherboard after Fedora 32 upgraded to the 5.7 kernel (now on 5.7.8):
> > periodically there are PCIe AER errors getting spewed in dmesg that
> > weren't happening before, and this also seems to causes suspend to
> > fail - the system just wakes back up again right away, I am assuming
> > due to some AER errors interrupting the process. 5.6 kernels didn't
> > have this problem. Setting "pcie=noaer" on the kernel command line
> > works around the issue, but I'm not sure what would have changed to
> > trigger this to occur?
>
> Correction: the workaround option is "pci=noaer".

As a follow-up, from some more experimentation, it appears that
disabling PCIe ASPM with setpci on both the ASMedia PCIe-PCI bridge as
well as the PCIe root port it is connected to seems to silence the AER
errors and allow suspend/resume to work again:

setpci -s 00:1c.0 0x50.B=0x00
setpci -s 02:00.0 0x90.B=0x00

It appears the behavior changed as a result of this patch (which went
into the stable tree for 5.7.6 and so affects 5.7 kernels as well):

commit 66ff14e59e8a30690755b08bc3042359703fb07a
Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed May 6 01:34:21 2020 +0800

    PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges

    7d715a6c1ae5 ("PCI: add PCI Express ASPM support") added the ability for
    Linux to enable ASPM, but for some undocumented reason, it didn't enable
    ASPM on links where the downstream component is a PCIe-to-PCI/PCI-X Bridge.

    Remove this exclusion so we can enable ASPM on these links.

    The Dell OptiPlex 7080 mentioned in the bugzilla has a TI XIO2001
    PCIe-to-PCI Bridge.  Enabling ASPM on the link leading to it allows the
    Intel SoC to enter deeper Package C-states, which is a significant power
    savings.

    [bhelgaas: commit log]
    Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
    Link: https://lore.kernel.org/r/20200505173423.26968-1-kai.heng.feng@canonical.com
    Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Unfortunately it appears that this ASMedia PCIe-PCI bridge:

02:00.0 PCI bridge [0604]: ASMedia Technology Inc. ASM1083/1085 PCIe
to PCI Bridge [1b21:1080] (rev 04)

doesn't cope with ASPM properly and causes a bunch of PCIe link
errors. (This is in addition to some broken-ness known as far back as
2012 with these ASM1083/1085 chips with regard to PCI interrupts
getting stuck, but this ASPM problem causes issues even if no devices
are connected to the PCI side of the bridge, as is the case on my
system.)

Might need a quirk to disable ASPM on this device?
