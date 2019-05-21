Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06E9258AA
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 22:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfEUUL6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 16:11:58 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:37686 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfEUUL6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 16:11:58 -0400
Received: by mail-wm1-f46.google.com with SMTP id 7so4134449wmo.2
        for <linux-pci@vger.kernel.org>; Tue, 21 May 2019 13:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kbK0pia+ZUDJFT5WiIJjh6XhzKexwGnWuOXpHluHwUM=;
        b=r1FyPMSyCECwO0EflXzfCEbOTpQIWVJEEdxo8Oafi8OnP4T7BNuPXG/QHCzjAi4GyN
         3JtGpbbHqo8oU9ODKSdq8MjehLFHWhU+Eq25y7z/s3T/zjO1yNntwI9djMr6RkOQ1W3v
         QlfZKHlW4ANn2rcgEGLtuuRYK68c1vHpRb5cmaiIohlhNYd+bqEeziTjUCv6r8DWmE5G
         KOLCqtm9R+Ah+PiQEgL5E1Dg6lsy0+rtiIpyEqAytJQSbAnEaaQ/AIhuFQtvqOHU4K/E
         naSqKZScOk/PoOVxCdYGexWED+GKIhEigvlO4kd+A8awmMquPBNF9U7LjExEYZJEucvM
         MiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kbK0pia+ZUDJFT5WiIJjh6XhzKexwGnWuOXpHluHwUM=;
        b=j7/0YPG7a/QhsXmj2JgDtA6trsMMI5ewaoSToaYPsyIfXbVK46gIcXC4MgGJ8atq7I
         mIUciqLGB3AVFCPdpZoPVS6um8thHcXD/1435qnBqzOhACj0gMi+DzKJi5IUBNCr4srn
         L06Hw4KsVyneqoAlxsc8rOsFdxd83BDzt5Fi278DAhkOmJUHtswQWvV+llUlIg4MCOfL
         V7wdpIXBv7IEncV2AFjnqeXTYJG06MXIf4PwJ22JsUcssMbl4UDY6q7GvCG38vNoJE31
         dxF/5GeBZGFXUB9C37Fi/frwGONMCTQyw2bipx9IUtGqvjU+JFmhctr2o5Q1gmqxuMjH
         T6rA==
X-Gm-Message-State: APjAAAUCTzjT0q0MoAJKAuDWLMSaln6hxGwmAvK/tOFk/8YUFtYxIHPA
        qsF4ioL3XoLfbn1SFkTx0w79hauLPXT5Q7rZ3bvc
X-Google-Smtp-Source: APXvYqxXgW9AEuNY3PScwG3i6Igm4s1VJZ3ih1j4Bn0tLG5lLgcp3KibUfFsx8CkCdUPOkoYknfbe3pZtTK4SzI7J94=
X-Received: by 2002:a1c:c1c8:: with SMTP id r191mr4228057wmf.99.1558469514761;
 Tue, 21 May 2019 13:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <B5B745A3-96B4-46ED-8F3F-D3636A96057F@marvell.com> <CAErSpo5qy6WuUe9cz1vTBBnc5P_uZaPzc-Yqbag2eBBxzi+ENg@mail.gmail.com>
In-Reply-To: <CAErSpo5qy6WuUe9cz1vTBBnc5P_uZaPzc-Yqbag2eBBxzi+ENg@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 21 May 2019 15:11:38 -0500
Message-ID: <CAErSpo45bCV7geSPAwBjy5fdQqzDcX61Ybksk65c=intfTWFZQ@mail.gmail.com>
Subject: Re: VPD access Blocked by commit 0d5370d1d85251e5893ab7c90a429464de2e140b
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     Andrew Vasquez <andrewv@marvell.com>,
        Girish Basrur <gbasrur@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>,
        Myron Stowe <mstowe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quinn Tran <quinn.tran@qlogic.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[fix linux-pci, remove ethan.zhao (bounces)]

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, May 21, 2019 at 3:02 PM
To: Himanshu Madhani
Cc: ethan.zhao@oracle.com, Andrew Vasquez, Girish Basrur, Giridhar
Malavali, Myron Stowe, <linux-pci@kernel.org>, Linux Kernel Mailing
List, Quinn Tran

> [+cc Myron, Quinn, linux-pci, linux-kernel]
>
> From: Himanshu Madhani <hmadhani@marvell.com>
> Date: Fri, May 17, 2019 at 5:21 PM
> To: ethan.zhao@oracle.com, bhelgaas@google.com
> Cc: Andrew Vasquez, Girish Basrur, Giridhar Malavali
>
> > Hi Ethan,
> >
> > Our OEM partners reported to us that VPD access with latest distros wer=
e returning I/O error for them. They indicated this to be issue only with n=
ewer kernels.
> >
> > One of the distro vendor pointed out patch posted by you to be reason f=
or IO error trying to VPD. The patch looks like blocks access to VPD by bla=
cklisting ISP.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D0d5370d1d85251e5893ab7c90a429464de2e140b=EF=BB=BF
> >
> > I setup PCIe analyzer to reproduce this in our lab to root cause it and=
 discovered that after reverting the patch.  I am able to get VPD data okay=
 with upstream 5.1.0 and I used RHEL8.
> >
> > I also used  "lspci" and "cat" to dump out VPD data and do not see any =
issue.
> >
> > # lspci -vvv -s 03:00.0
> > 03:00.0 Fibre Channel: QLogic Corp. ISP2722-based 16/32Gb Fibre Channel=
 to PCIe Adapter (rev 01)
> >                 Subsystem: QLogic Corp. QLE2742 Dual Port 32Gb Fibre Ch=
annel to PCIe Adapter
> >                 Physical Slot: 15
> >                 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASn=
oop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
> >                 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast=
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >                 Latency: 0, Cache Line Size: 64 bytes
> >                 Interrupt: pin A routed to IRQ 67
> >                 NUMA node: 0
> >                 Region 0: Memory at fbe05000 (64-bit, prefetchable) [si=
ze=3D4K]
> >                 Region 2: Memory at fbe02000 (64-bit, prefetchable) [si=
ze=3D8K]
> >                 Region 4: Memory at fbd00000 (64-bit, prefetchable) [si=
ze=3D1M]
> >                 Expansion ROM at fb540000 [disabled] [size=3D256K]
> >                 Capabilities: [44] Power Management version 3
> >                                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=
=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                                 Status: D0 NoSoftRst+ PME-Enable- DSel=
=3D0 DScale=3D0 PME-
> >                 Capabilities: [4c] Express (v2) Endpoint, MSI 00
> >                                 DevCap:                MaxPayload 2048 =
bytes, PhantFunc 0, Latency L0s <4us, L1 <1us
> >                                                 ExtTag- AttnBtn- AttnIn=
d- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
> >                                 DevCtl:  Report errors: Correctable+ No=
n-Fatal+ Fatal+ Unsupported+
> >                                                 RlxdOrd- ExtTag- PhantF=
unc- AuxPwr- NoSnoop+ FLReset-
> >                                                 MaxPayload 256 bytes, M=
axReadReq 4096 bytes
> >                                 DevSta: CorrErr+ UncorrErr- FatalErr- U=
nsuppReq+ AuxPwr- TransPend-
> >                                 LnkCap: Port #0, Speed 8GT/s, Width x8,=
 ASPM L0s L1, Exit Latency L0s <512ns, L1 <2us
> >                                                 ClockPM- Surprise- LLAc=
tRep- BwNot- ASPMOptComp+
> >                                 LnkCtl:  ASPM Disabled; RCB 64 bytes Di=
sabled- CommClk+
> >                                                 ExtSynch- ClockPM- AutW=
idDis- BWInt- AutBWInt-
> >                                 LnkSta:  Speed 8GT/s, Width x8, TrErr- =
Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> >                                 DevCap2: Completion Timeout: Range B, T=
imeoutDis+, LTR-, OBFF Not Supported
> >                                                 AtomicOpsCap: 32bit- 64=
bit- 128bitCAS-
> >                                 DevCtl2: Completion Timeout: 50us to 50=
ms, TimeoutDis-, LTR-, OBFF Disabled
> >                                                 AtomicOpsCtl: ReqEn-
> >                                 LnkCtl2: Target Link Speed: 8GT/s, Ente=
rCompliance- SpeedDis-
> >                                                 Transmit Margin: Normal=
 Operating Range, EnterModifiedCompliance- ComplianceSOS-
> >                                                 Compliance De-emphasis:=
 -6dB
> >                                 LnkSta2: Current De-emphasis Level: -6d=
B, EqualizationComplete+, EqualizationPhase1+
> >                                                 EqualizationPhase2+, Eq=
ualizationPhase3+, LinkEqualizationRequest-
> >                 Capabilities: [88] Vital Product Data
> >                                 Product Name: QLogic 32Gb 2-port FC to =
PCIe Gen3 x8 Adapter
> >                                 Read-only fields:
> >                                                 [PN] Part number: QLE27=
42
> >                                                 [SN] Serial number: RFD=
1706R22611
> >                                                 [EC] Engineering change=
s: BK3210408-05 04
> >                                                 [V9] Vendor specific: 0=
10189
> >                                                 [RV] Reserved: checksum=
 good, 0 byte(s) reserved
> >                                 End
> >                 Capabilities: [90] MSI-X: Enable+ Count=3D16 Masked-
> >                                 Vector table: BAR=3D2 offset=3D00000000
> >                                 PBA: BAR=3D2 offset=3D00001000
> >                 Capabilities: [9c] Vendor Specific Information: Len=3D0=
c <?>
> >                 Capabilities: [100 v1] Advanced Error Reporting
> >                                 UESta:   DLP- SDES- TLP- FCP- CmpltTO- =
CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> >                                 UEMsk: DLP- SDES- TLP- FCP- CmpltTO- Cm=
pltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> >                                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- C=
mpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> >                                 CESta:   RxErr- BadTLP- BadDLLP- Rollov=
er- Timeout- NonFatalErr-
> >                                 CEMsk: RxErr- BadTLP- BadDLLP- Rollover=
- Timeout- NonFatalErr+
> >                                 AERCap:               First Error Point=
er: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> >                                                 MultHdrRecCap- MultHdrR=
ecEn- TLPPfxPres- HdrLogCap-
> >                                 HeaderLog: 00000000 00000000 00000000 0=
0000000
> >                 Capabilities: [154 v1] Alternative Routing-ID Interpret=
ation (ARI)
> >                                 ARICap: MFVC- ACS-, Next Function: 1
> >                                 ARICtl:   MFVC- ACS-, Function Group: 0
> >                 Capabilities: [1c0 v1] #19
> >                 Capabilities: [1f4 v1] Vendor Specific Information: ID=
=3D0001 Rev=3D1 Len=3D014 <?>
> >                 Kernel driver in use: qla2xxx
> >                 Kernel modules: qla2xxx
> >
> > # cat /sys/bus/pci/devices/0000\:03\:00.0/vpd
> > RFD1706R22611ECBK3210408-05 04V9010189RV=EF=BF=BDx
> >
> > Can you share some more insight into where you encountered issue? I am =
in process of reverting this patch from upstream kernel but wanted to reach=
 out and find out if you still have setup to provide more context.
>
> 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722") prevented
> a panic while reading VPD, so we can't simply revert it.
>
> Since you don't see a panic while reading VPD from that device, it's
> possible that a QLogic firmware change fixed the VPD format so Linux
> no longer reads the area that caused the problem.  Or possibly your
> system doesn't handle the config read error the same way Ethan's HP
> DL380 does.  Unfortunately we don't have an actual PCIe analyzer trace
> from Ethan's system, so we don't know exactly what happened on PCIe.
>
> I suggest that you capture the entire VPD area and hexdump it, e.g.,
> with "xxd", and look at its structure.  pci_vpd_size() parses it and
> computes the valid size based on a PCI_VPD_STIN_END tag, and
> pci_vpd_read() should not read past that size.
>
> And you *do* have an analyzer trace.  If new QLogic firmware fixed the
> VPD format, the trace should show that Linux read only the valid part
> of VPD, and there should be no errors in the trace.  Then it might
> just be a question of tweaking the quirk so it allows VPD reads if the
> firmware is new enough.
>
> But if the trace does show config reads with errors, then it might be
> that your system just tolerates the errors while the DL380 did not.
> Then we'd have to figure out exactly what the error was and how to
> deal with it so things work on both your system and Ethan's.
>
> Bjorn
