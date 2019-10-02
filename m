Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9682C46FC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2019 07:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfJBFcQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 2 Oct 2019 01:32:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58416 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfJBFcQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Oct 2019 01:32:16 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iFXFF-0006DW-Ln
        for linux-pci@vger.kernel.org; Wed, 02 Oct 2019 05:32:13 +0000
Received: by mail-pf1-f198.google.com with SMTP id t65so11886218pfd.14
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2019 22:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FM86P/+AN+RXTJsYYQ73c7ZCJoHKprIDdtGMVy8EoOQ=;
        b=tSDyAYFUMs1nd7O5uENGL8+ONnywjEy2IL7tNSrfzdWxVufZlIf15yx9av6ZpUsCOW
         IgSIxK8BZA0CMiqPBGib6AdV/SCW71B/RhJuWHGJN6zyHmLZxTyw/cxmpQl9K0BCGBc5
         fA7LbkElsLoNxMlCVSXi4Ywf1qBKrF+EhcqvH39MgS2CoFA2e1PPMGoxZMMZlMqW/D6a
         IF4c4JpMD81RA5e+2ZXWchyfW+TWaa9Op3sB0ryIqOTirmfIS/nL6t0ypfI9usgN4UVk
         FYPEcc9MNwsT5k9eE1CZFk0uy54EhHez4XIvdJ4RfBWZbRMVHspaH6ltI6spmc2F3hc3
         9cLg==
X-Gm-Message-State: APjAAAVNpXuGimDHIVhZP3A9DiGO339GTGdF/I/dzUjEcd5dIl2vUPoe
        3IVBeO8KHrgYqOxG6Nf9lXtvhv3ms3fGR7jOPELrYw0dYWepTlk5O3qF4IQKlXEPs/MdPTXRF9c
        +p/HMjwDqZ1yhSA/j/Yvq54QvcvXZuJILLuXBMw==
X-Received: by 2002:a62:7d81:: with SMTP id y123mr2540116pfc.133.1569994332383;
        Tue, 01 Oct 2019 22:32:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYHwD4Uyb38pK0wCeINuN3HWwKgb0pv+fggC6FjvrAblND9zofbq+jfCSONBKwG/U8SEI2Jg==
X-Received: by 2002:a62:7d81:: with SMTP id y123mr2540085pfc.133.1569994331988;
        Tue, 01 Oct 2019 22:32:11 -0700 (PDT)
Received: from 2001-b011-380f-3c42-1844-8b0c-6a55-1ec2.dynamic-ip6.hinet.net (2001-b011-380f-3c42-1844-8b0c-6a55-1ec2.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:1844:8b0c:6a55:1ec2])
        by smtp.gmail.com with ESMTPSA id n66sm17179740pfn.90.2019.10.01.22.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 22:32:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.18\))
Subject: Re: [PATCH] x86/PCI: Remove D0 PME capability on AMD FCH xHCI
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20191002000718.GA100544@google.com>
Date:   Wed, 2 Oct 2019 13:32:07 +0800
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>
Content-Transfer-Encoding: 8BIT
Message-Id: <30975CE5-7731-4777-B091-1F15F388D5C7@canonical.com>
References: <20191002000718.GA100544@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3594.4.18)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Oct 2, 2019, at 08:07, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> [+cc Alan, Mathias, Rafael, Lukas]
> 
> On Mon, Sep 02, 2019 at 10:52:52PM +0800, Kai-Heng Feng wrote:
>> There's an xHCI device that doesn't wake when a USB 2.0 device gets
>> plugged to its USB 3.0 port. The driver's own runtime suspend callback
>> was called, PME# signaling was enabled, but it stays at PCI D0:
>> 
>> 00:10.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI Controller [1022:7914] (rev 20) (prog-if 30 [XHCI])
>>        Subsystem: Dell FCH USB XHCI Controller [1028:087e]
>>        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>        Interrupt: pin A routed to IRQ 18
>>        Region 0: Memory at f0b68000 (64-bit, non-prefetchable) [size=8K]
>>        Capabilities: [50] Power Management version 3
>>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>                Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
>> 
>> A PCI device can be runtime suspended while still stays at D0 when it
>> supports D0 PME# and its ACPI _S0W method reports D0. Though plugging
>> USB 3.0 devices can wakeup the xHCI, it doesn't respond to USB 2.0
>> devices.
> 
> I don't think _S0W and runtime suspend are relevant here.  What *is*
> relevant is that the device advertises that it can generate PME from
> D0, and it apparently does not do so.

Yes that's the case. It doesn't generate PME when USB2.0 or USB1.1 device gets plugged.

> 
> Table 10 in the xHCI spec r1.0, sec 4.15.2.3, says the xHC should
> assert PME# if enabled and the port's WCE bit is set.  Did you ever
> confirm that WCE is set?

How do I check WCE when xHCI is suspended?
If I want to read WCE then I have the resume the device, but after resuming all USB devices get enumerated, and checking WCE doesn't matter anymore.

> 
> I assume WCE *is* set because plugging in a USB3 device *does*
> generate a PME#, and I don't see anything in Table 10 that says it
> would work for USB3 but not USB2.

It should work on all USB speeds, but it didn't.
That's why the OEM/ODM use the _S0W workaround on Windows.

Kai-Heng

> 
>> So let's disable D0 PME capability on this device to avoid the issue.
>> 
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203673
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> arch/x86/pci/fixup.c | 11 +++++++++++
>> 1 file changed, 11 insertions(+)
>> 
>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>> index 527e69b12002..0851a05d092f 100644
>> --- a/arch/x86/pci/fixup.c
>> +++ b/arch/x86/pci/fixup.c
>> @@ -588,6 +588,17 @@ static void pci_fixup_amd_ehci_pme(struct pci_dev *dev)
>> }
>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x7808, pci_fixup_amd_ehci_pme);
>> 
>> +/*
>> + * Device [1022:7914]
>> + * D0 PME# doesn't get asserted when plugging USB 2.0 device.
>> + */
>> +static void pci_fixup_amd_fch_xhci_pme(struct pci_dev *dev)
>> +{
>> +	dev_info(&dev->dev, "PME# does not work under D0, disabling it\n");
> 
> Use pci_info() as in the rest of the file.
> 
>> +	dev->pme_support &= ~(PCI_PM_CAP_PME_D0 >> PCI_PM_CAP_PME_SHIFT);
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x7914, pci_fixup_amd_fch_xhci_pme);
>> +
>> /*
>>  * Apple MacBook Pro: Avoid [mem 0x7fa00000-0x7fbfffff]
>>  *
>> -- 
>> 2.17.1

