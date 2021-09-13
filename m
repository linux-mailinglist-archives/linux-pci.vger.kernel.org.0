Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DEB409E31
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhIMUeX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 16:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239327AbhIMUeW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 16:34:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513AFC061574;
        Mon, 13 Sep 2021 13:33:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so333839wmc.0;
        Mon, 13 Sep 2021 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bgZFNsK13aDrr5zCZ3ERQpLyyoZz6vA39iMXGcyLKqo=;
        b=kKQVm6aKeX9xVatg5ABdcZZLJeQW89UY3TvIzdM/CrnYUusrzQ/cHDYSHdKrjn6STA
         vRJV5aCiZklclIMluc0CdrpPk15y4q4Xl+i+mEJ84+IV+BB4DL+uX0KX/tZk+52jZ0sw
         zLg8MdC/4djo9BgIjt+YeTe9YxapBIsUQbBjurEq0eAKk2ciOOWQV4m0DZRSzzS9U8aw
         WWkqC3nUQOIhUtRe+ki+LnWv54OB5fvJPSLBBwTKMm6snaJzP4lcYbIvSwEPYeaJ81Jb
         gmSsH5vfmg/R+fQMtSmMStC4XzXcRvIhcsDG3ITEY6Nq11XCTdJKLRuGCs7gFRJgPCaH
         GFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bgZFNsK13aDrr5zCZ3ERQpLyyoZz6vA39iMXGcyLKqo=;
        b=G8bVn53ib9ZxKEHWHSLxka6NmYop+S4gZusVTtOzrR8gteLvr6ePb2oMp8oCFiNqBR
         EcBS/4hP8WDbPZpXx/JqmxBGTccUFIREu89V/O8CH1l2D+wFEIZnDH0v2erZKFARZELw
         nJDrW8zIpUtOCZ8SklCF2sn+LrAKay4dfKk+s2Us4aXZKV9cBxQ1xn0vJP0zBuioDylN
         L3nRXhJCoUvooiZ6OB0A6SXcG+VedLN711hiumI9KvLtWXBmhD16DlUjx/y/FbszMY5h
         0WszeA7nf+UXnituGXJN3QOFmr+gvOyf6WuDnGKSsILaEFEIK2XenmVDst7yg3z4qiw3
         w7hQ==
X-Gm-Message-State: AOAM531nI1IgqbxcY2N1dbItQdIr95DJgsr8CJ9ozA7DlojrgTx9xxtn
        9CZxqWE2h2Pi88oNAlLC61hHk+Yshy4=
X-Google-Smtp-Source: ABdhPJwHHlJzuzRJAswq1k55Dc8mZAR/JYxv37l/wymvP7aheKGbjq5dtxlXCqaXHnp8lrfYjFTqjQ==
X-Received: by 2002:a1c:f308:: with SMTP id q8mr4007969wmq.153.1631565184705;
        Mon, 13 Sep 2021 13:33:04 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:2517:8cca:49d8:dcdc? (p200300ea8f08450025178cca49d8dcdc.dip0.t-ipconnect.de. [2003:ea:8f08:4500:2517:8cca:49d8:dcdc])
        by smtp.googlemail.com with ESMTPSA id z19sm9175061wma.0.2021.09.13.13.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:33:04 -0700 (PDT)
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
Message-ID: <72507051-9608-9502-790b-c49dd46a843d@gmail.com>
Date:   Mon, 13 Sep 2021 22:32:56 +0200
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

OK, so this device is buggy too but not the root cause. After checking again the
stalls happen for VPD access to both ports of the Intel network adapter.

01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
01:00.1 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)

I modified the test patch accordingly, could you please test again?

---
 drivers/pci/vpd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 517789205..fc92e880e 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -540,6 +540,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10fb, quirk_blacklist_vpd);
 /*
  * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
  * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
-- 
2.33.0

