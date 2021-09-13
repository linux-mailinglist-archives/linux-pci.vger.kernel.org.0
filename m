Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A38409E15
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhIMUYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 16:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhIMUYY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 16:24:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E649C061574;
        Mon, 13 Sep 2021 13:23:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so16575499wrn.5;
        Mon, 13 Sep 2021 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=X9M+5nYuImwwgN6RwjS7S9PGt5x+r/IWNh8zaeo7AdI=;
        b=L3XpBLsRGf4JZoGcAu4TNPUFa3aWJlW1bHxM8NVF9OmqPLo4pNXnOKEuCn9ozYnY1Z
         AfVC3m3fvaGAsmrlMadyklLtBjqyoGPh3GwQkinR+3bFjsAWmyTOfMAKMg0U+skEkYCg
         mFqhDOb2+eXj0ozdFScOE7DsBvyn25fZZ8yCS7D8qBOnbf28GxigupsblBH5/AWxlc0Y
         bfqUyEoIx14wajpWrd2zeXeHW+uPCvnSEsNKExOPzpkMT1X0VHeyRyXR0gbxMbS/Q8/+
         Q1HgXRvm43DrQB1sZ7Rlhj110Yof3VQOCuaqpFq8RCSxrTLcrKh5veLVKuyGz7tvZkBz
         ljaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X9M+5nYuImwwgN6RwjS7S9PGt5x+r/IWNh8zaeo7AdI=;
        b=ii6YmKnE2mGUzqWQRfcYeshFwEuWMm4QxbNsaBmloVJOPeDF/A7sKqVdm1KndH0pOP
         KhiGogCo51mqNlYlwymhZ8tGgHzsGuruaT3enYVOWqQZjzNtjzzS/Mh4RYIePm7cXLNh
         DpYNfhcAlN3T0VjejRMpGCn/YmpfjlN36Akt819WlAAkcMWyFf1hhoS1QWIrYEEMbGkT
         3S5u2Xpezjq5EaIQPEJpuqyFS3JGbRHtbxxJA1Yqu0ZdIOQpjDRCgbFfIyF4QD5tYuMC
         /rLOvSHcdabBSkNm9Wv3IM1Bq53y++99c5cEGwIIkusy1VKHkzDE7tEKID+igWtYySD6
         WbxQ==
X-Gm-Message-State: AOAM5331PZOfeexjbsuOop3BNeuT1WBhiDFyx+qIbzti7LLehicxX8kJ
        yKeYBxpt36U/AzdJNe03UF+fFVtqMhM=
X-Google-Smtp-Source: ABdhPJwCRz81L4W7m/M+7yElATtk3nRpta3wj6aJMlAD9n+0hUHPH6w5dgWt84Vrkik9Xu7le/024w==
X-Received: by 2002:adf:e8c7:: with SMTP id k7mr9587420wrn.47.1631564585953;
        Mon, 13 Sep 2021 13:23:05 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:2517:8cca:49d8:dcdc? (p200300ea8f08450025178cca49d8dcdc.dip0.t-ipconnect.de. [2003:ea:8f08:4500:2517:8cca:49d8:dcdc])
        by smtp.googlemail.com with ESMTPSA id z7sm10453978wre.72.2021.09.13.13.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:23:05 -0700 (PDT)
Subject: Re: Linux 5.15-rc1
To:     Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk>
 <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <20210913201519.GA15726@codemonkey.org.uk>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
Date:   Mon, 13 Sep 2021 22:22:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210913201519.GA15726@codemonkey.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.09.2021 22:15, Dave Jones wrote:
> On Mon, Sep 13, 2021 at 08:59:49PM +0200, Heiner Kallweit wrote:
>  > On 13.09.2021 16:18, Dave Jones wrote:
>  > > [  186.595296] pci 0000:02:00.0: [144d:a800] type 00 class 0x010601
>  > > [  186.595351] pci 0000:02:00.0: reg 0x24: [mem 0xdfc10000-0xdfc11fff]
>  > > [  186.595361] pci 0000:02:00.0: reg 0x30: [mem 0xdfc00000-0xdfc0ffff pref]
>  > > [  186.595425] pci 0000:02:00.0: PME# supported from D3hot D3cold
>  > > [  186.735107] pci 0000:02:00.0: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update
>  > 
>  > Thanks for the report! The stalls may be related to this one. Device is:
>  > 02:00.0 SATA controller: Samsung Electronics Co Ltd XP941 PCIe SSD (rev 01)
>  > 
>  > With an older kernel you may experience the stall when accessing the vpd
>  > attribute of this device in sysfs.
>  > 
>  > Maybe the device indicates VPD capability but doesn't actually support it.
>  > Could you please provide the "lspci -vv" output for this device?
> 
> 02:00.0 SATA controller: Samsung Electronics Co Ltd XP941 PCIe SSD (rev 01) (prog-if 01 [AHCI 1.0])
>         Subsystem: Samsung Electronics Co Ltd XP941 PCIe SSD
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 16
>         Region 5: Memory at dfc10000 (32-bit, non-prefetchable) [size=8K]
>         Expansion ROM at dfc00000 [disabled] [size=64K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [70] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 25.000W
>                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 5GT/s (ok), Width x2 (downgraded)
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis+ NROPrPrP- LTR+
>                          10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>                          FRS- TPHComp- ExtTPHComp-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
>                          AtomicOpsCtl: ReqEn-
>                 LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
>                          EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported
>         Capabilities: [d0] Vital Product Data
>                 Not readable
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Capabilities: [140 v1] Device Serial Number 00-00-00-00-00-00-00-00
>         Capabilities: [150 v1] Power Budgeting <?>
>         Capabilities: [160 v1] Latency Tolerance Reporting
>                 Max snoop latency: 71680ns
>                 Max no snoop latency: 71680ns
>         Kernel driver in use: ahci
> 
> 
>  > And could you please test with the following applied to verify the
>  > assumption? It disables VPD access for this device.
>  > 
>  > ---
>  >  drivers/pci/vpd.c | 1 +
>  >  1 file changed, 1 insertion(+)
>  > 
>  > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>  > index 517789205..fc92e880e 100644
>  > --- a/drivers/pci/vpd.c
>  > +++ b/drivers/pci/vpd.c
>  > @@ -540,6 +540,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
>  >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
>  >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
>  >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
>  > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SAMSUNG, 0xa800, quirk_blacklist_vpd);
>  >  /*
>  >   * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
>  >   * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
> 
> 
> This didn't help I'm afraid :(
> It changed the VPD warning, but that's about it...
> 
> [  184.235496] pci 0000:02:00.0: calling  quirk_blacklist_vpd+0x0/0x22 @ 1
> [  184.235499] pci 0000:02:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)                                                                                           
> [  184.235501] pci 0000:02:00.0: quirk_blacklist_vpd+0x0/0x22 took 0 usecs
> 
With this patch there's no VPD access to this device any longer. So this can't be
the root cause. Do you have any other PCI device that has VPD capability?
-> Capabilities: [...] Vital Product Data

> 
> 	Dave
> 
Heiner
