Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D3641E912
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 10:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352729AbhJAI1w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 04:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352723AbhJAI1v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 04:27:51 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB488C061775
        for <linux-pci@vger.kernel.org>; Fri,  1 Oct 2021 01:26:06 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id e66-20020a9d2ac8000000b0054da8bdf2aeso8382255otb.12
        for <linux-pci@vger.kernel.org>; Fri, 01 Oct 2021 01:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Q5NKyK/hHd+thwf2IuC0mb/EIbqzwR+oDaAazocO9y0=;
        b=K0a747/pyYakwgAkDrJTP/tVtrui8Hv3q7M6ki2WWc6YZahYIbAri0jIDUyrLoDZKi
         k+diF0a0UC+WD7vN2ODTRfBNjtof1Gspp3AkaPeLJDVGFYa8sCIckiU0HsMvpz3Io4pp
         nhL5Ni93g4x6Q0SME8V4S5tWpgrM0Jq9vhFKNVAKjxCLS+JhMlB9YxOesrdO+hUB3q2I
         hKPw6zZKVrKST+bhVssSGGygqjEYjSO2vy6qqd5oHpA9B0bid10Cme6diOEZY5wa1E3B
         1T7/Vr9deMqN44rfLN0Vk/DytX9JLLP8uW4r2WypuIkRbsSVzda9R3PpD7oZVT5JmZVW
         9hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Q5NKyK/hHd+thwf2IuC0mb/EIbqzwR+oDaAazocO9y0=;
        b=H9rQOHDTHw8C/hEsJrgZo7efpUAjkxCjzZRu4DvUczirjLi2dr6fRw03wtJdpQMqbs
         SgWOh4q++ZVHIFJ6Su4QvLxRnjWvzf74cn5SqJVY+Whipt2k/Lcxf16If3eq7djcA5J4
         qGjsafRpCUDL5lgPEcHB/aTfEZGaejYsZpyx3j4yU0ey5PcZl5yJe5nrsFGTjeb5CohP
         P6IvwXIrW5w/qfF7e6k73K/YxNHdEuOvKXYvI087cqtDEchRcpzI2s5X3Y8+xbiyB4/t
         pVzMgZQ+cl/60JAy2wmKtsPW0KczLvVdLb0lqwNAbH4W/bSypc06To4YxgUaJMZTOj1b
         P2YA==
X-Gm-Message-State: AOAM5316XxXLYB6ytIxl0AJTdlTRCmAvYCH3n+HPkaopbgEf4qN86ucm
        1zGKU8n6fZdiROQXbgJ3RsEUZpzWD7Rp9BNGK9HF/1zFlLM=
X-Google-Smtp-Source: ABdhPJyk67A0a0d75XawMq3i6UQGBc+O3QG3/R0y1xMm43fmDAmbj6e8m3zPiosE/cqZvYqHBB2NpjMNyyLjfgOIDao=
X-Received: by 2002:a05:6830:793:: with SMTP id w19mr8991168ots.23.1633076765836;
 Fri, 01 Oct 2021 01:26:05 -0700 (PDT)
MIME-Version: 1.0
From:   Pierre Le Magourou <lemagoup@gmail.com>
Date:   Fri, 1 Oct 2021 10:25:55 +0200
Message-ID: <CAEz4NHpCJDBGkicfZ8YvJOCKRWDsmEe-hWoairnejQmUkm=sGA@mail.gmail.com>
Subject: pcie-qcom legacy interrupt support
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I am trying to use a PI7C9X440SL PCIe/USB adapter on Qualcomm sdm845 platform.
This PCIe device does not support MSI interrupts.

On 5.10 kernel, the pci device is detected but EHCI driver probe fails
with this message "Found HC with no IRQ. Check BIOS/PCI".

lspci shows that legacy interrupt cannot be found:
 #lspci -vv -nk -s 0000:03:00.2
 0000:03:00.2 0c03: 12d8:400f (rev 01) (prog-if 20 [EHCI])
        Subsystem: 12d8:400f
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 0
        Region 0: Memory at 60302000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s,
Exit Latency L0s <512ns
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
                        TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-


It is not clear to me if legacy interrupts are supported by the
pcie-qcom driver.
Do I need to add the PCIe/USB device description in the device tree
for this to work ?

Thank you.

Pierre Le Magourou
