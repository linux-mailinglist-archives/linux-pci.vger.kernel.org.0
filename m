Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332A822C805
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 16:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGXOcQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 24 Jul 2020 10:32:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38353 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGXOcQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2020 10:32:16 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jyykA-00059X-Ew
        for linux-pci@vger.kernel.org; Fri, 24 Jul 2020 14:32:14 +0000
Received: by mail-pf1-f198.google.com with SMTP id v11so3326023pfu.16
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2020 07:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OY6zbYqXoDNfg1vkCWS7IkbQH43ot9XbU/fDyuAMUME=;
        b=FOeoqyP9ggb1U6H3x/71S/3+xxBLPh8xoSNDdXFdLhayrTxpJWy2UUZLC2T3LoyubQ
         LUBy5CAa8yaQw7uhV1D5iQGOkeh3nHxiOPPC8NQvsCl3QZl5cPeV/037hdPCjYRtI9CZ
         hJr4RWdtqGJ0CJ/JlpElFs0PVwaT0NsdCQObAKK/oqiP33RDTXqJmF+BCWplda21bzJw
         LL0989i5qjUGKCBSNcWgyOmXY2DRW3cFTgtSbqnmz6icZ841YMkEJi5lpFH4vnffU+Yz
         nU4b8jAEY8tyaSCPC5UGAxoj3laK0iC94Joe3HTN4D7YMe7OX6vRnxMvNapwo/e4NfjI
         39pw==
X-Gm-Message-State: AOAM5333Dl4xpTnUMspoVdMo9L2wRNP3yRwMNUav2yoUycho+pMu7zpk
        EXL68L66H/nP2czffd3460ajKsiw6RqR3nEFL3rfsIDVVl62Aa/YD40TH3aaOhNPbsGxSUCxfB3
        TktbYN7JIcSCkzpYkY5OzYxN71EPRJa9l9HYubg==
X-Received: by 2002:aa7:8e90:: with SMTP id a16mr8853493pfr.84.1595601128059;
        Fri, 24 Jul 2020 07:32:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxls24L4v3wXph7gJpHH17hnDV5EVagwMFk9LHOOndi8kMi4J1ZA6VFcG1xMEeuLd3MRmpN7Q==
X-Received: by 2002:aa7:8e90:: with SMTP id a16mr8853466pfr.84.1595601127681;
        Fri, 24 Jul 2020 07:32:07 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id n9sm6136816pjo.53.2020.07.24.07.32.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 07:32:07 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: 5.7 regression: Lots of PCIe AER errors and suspend failure
 without pcie=noaer
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CADLC3L1R2hssRjxHJv9yhdN_7-hGw58rXSfNp-FraZh0Tw+gRw@mail.gmail.com>
Date:   Fri, 24 Jul 2020 22:32:05 +0800
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <87CA0F2C-5CEB-4CE7-8399-534CABE5ADD8@canonical.com>
References: <CADLC3L20DuXw8WbS=SApmu2m49mkxxWKZrMJS_GBHDX7Vh0TvQ@mail.gmail.com>
 <CADLC3L2ZnGTQJ+fwCy42dpxhHLpAFzFkjMRG3ZS=z7R4WK08og@mail.gmail.com>
 <CADLC3L1R2hssRjxHJv9yhdN_7-hGw58rXSfNp-FraZh0Tw+gRw@mail.gmail.com>
To:     Robert Hancock <hancockrwd@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robert,

> On Jul 22, 2020, at 07:55, Robert Hancock <hancockrwd@gmail.com> wrote:
> 
> On Fri, Jul 10, 2020 at 6:28 PM Robert Hancock <hancockrwd@gmail.com> wrote:
>> 
>> On Fri, Jul 10, 2020 at 6:23 PM Robert Hancock <hancockrwd@gmail.com> wrote:
>>> 
>>> Noticed a problem on my desktop with an Asus PRIME H270-PRO
>>> motherboard after Fedora 32 upgraded to the 5.7 kernel (now on 5.7.8):
>>> periodically there are PCIe AER errors getting spewed in dmesg that
>>> weren't happening before, and this also seems to causes suspend to
>>> fail - the system just wakes back up again right away, I am assuming
>>> due to some AER errors interrupting the process. 5.6 kernels didn't
>>> have this problem. Setting "pcie=noaer" on the kernel command line
>>> works around the issue, but I'm not sure what would have changed to
>>> trigger this to occur?
>> 
>> Correction: the workaround option is "pci=noaer".
> 
> As a follow-up, from some more experimentation, it appears that
> disabling PCIe ASPM with setpci on both the ASMedia PCIe-PCI bridge as
> well as the PCIe root port it is connected to seems to silence the AER
> errors and allow suspend/resume to work again:
> 
> setpci -s 00:1c.0 0x50.B=0x00
> setpci -s 02:00.0 0x90.B=0x00
> 
> It appears the behavior changed as a result of this patch (which went
> into the stable tree for 5.7.6 and so affects 5.7 kernels as well):
> 
> commit 66ff14e59e8a30690755b08bc3042359703fb07a
> Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Date:   Wed May 6 01:34:21 2020 +0800
> 
>    PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges
> 
>    7d715a6c1ae5 ("PCI: add PCI Express ASPM support") added the ability for
>    Linux to enable ASPM, but for some undocumented reason, it didn't enable
>    ASPM on links where the downstream component is a PCIe-to-PCI/PCI-X Bridge.
> 
>    Remove this exclusion so we can enable ASPM on these links.
> 
>    The Dell OptiPlex 7080 mentioned in the bugzilla has a TI XIO2001
>    PCIe-to-PCI Bridge.  Enabling ASPM on the link leading to it allows the
>    Intel SoC to enter deeper Package C-states, which is a significant power
>    savings.
> 
>    [bhelgaas: commit log]
>    Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
>    Link: https://lore.kernel.org/r/20200505173423.26968-1-kai.heng.feng@canonical.com
>    Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>    Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Unfortunately it appears that this ASMedia PCIe-PCI bridge:
> 
> 02:00.0 PCI bridge [0604]: ASMedia Technology Inc. ASM1083/1085 PCIe
> to PCI Bridge [1b21:1080] (rev 04)
> 
> doesn't cope with ASPM properly and causes a bunch of PCIe link
> errors. (This is in addition to some broken-ness known as far back as
> 2012 with these ASM1083/1085 chips with regard to PCI interrupts
> getting stuck, but this ASPM problem causes issues even if no devices
> are connected to the PCI side of the bridge, as is the case on my
> system.)
> 
> Might need a quirk to disable ASPM on this device?

Yes I think it's a great idea to do it.

Can you please file a bug on [1] and we can continue our discussion there.

[1] https://bugzilla.kernel.org

Kai-Heng
