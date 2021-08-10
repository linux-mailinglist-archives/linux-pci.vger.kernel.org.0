Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60D33E587D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 12:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbhHJKlQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 06:41:16 -0400
Received: from ni.piap.pl ([195.187.100.5]:57204 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239884AbhHJKlQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 06:41:16 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 99935C369550
        for <linux-pci@vger.kernel.org>; Tue, 10 Aug 2021 12:40:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 99935C369550
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1628592048; bh=zfujDMcxyu6TyvFHQiwCJhCNFAk1LFud6MBKsw0lWLU=;
        h=From:To:Subject:Date:From;
        b=WQuqcwjTIxSsCrC2rH6ZLWEa6jBQPcAIBZhsQ6Mnsp/VCO5X54xgv/rsY1u0AijAe
         x0nqUCTRocNHcqF3BLBz7ZSXfzYchxpNCFOi5xxH76B40k7au+CK9G6c5gFgilGRVl
         Gh1Bw22gENRUPA8CykSxY65gkOuWBtlp5/S6In8g=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     linux-pci@vger.kernel.org
Subject: ARM Max Read Req Size and PCIE_BUS_PERFORMANCE stories
Sender: khalasa@piap.pl
Date:   Tue, 10 Aug 2021 12:40:48 +0200
Message-ID: <m3zgtp8tvz.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 165491 [Aug 10 2021]
X-KLMS-AntiSpam-Version: 5.9.20.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c, {Tracking_marketers, three}, {Tracking_from_domain_doesnt_match_to}, piap.pl:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;t19.piap.pl:7.1.1
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2021/08/10 08:09:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2021/08/10 03:45:00 #17007547
X-KLMS-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Background: I'm using an ARMv7 (i.MX6) system with an RTL8111 (aka
RTL8169) network interface. By default, the system is using
PCIE_BUS_DEFAULT:

config PCIE_BUS_DEFAULT
          Default choice; ensure that the MPS matches upstream bridge.

and the r8169 driver doesn't work - the RTL chip requests PCIe read
longer than 512 bytes, and the CPU rejects the request.

I've traced the problem to this: (r8169_main.c: rtl_jumbo_config())
	int readrq =3D 4096;
...
	if (pci_is_pcie(tp->pci_dev) && tp->supports_gmii)
		pcie_set_readrq(tp->pci_dev, readrq);

I've verified that changing the value back to 512 (after r8168 driver
set it to 4096) makes it work again.


We have several PCIE_BUS_* modes, all guarded by CONFIG_EXPERT. I've
verified that PCIE_BUS_PERFORMANCE also fixes the problem. It sets
MaxReadReqSize to MaxPayloadSize which is equal to 128 on i.MX6.
This is, most probably, suboptimal (despite "performance" in the name).


Now, how should it be fixed (so it works by default)?
1. should the drivers be banned from using pcie_set_readrq() etc?
   I believe some chips may require MRRS adjustment by the driver,
   though.
2. should the PCI code limit MRRS to MPS by default?
3. should the PCI code limit MRRS to the maximum safe value (512 on
   this CPU)?

Does hardware like common x86 have a "maximum safe value" (lower than
4096)?

Any other ideas?

i.MX6 details:
There is mysterious CX_REMOTE_RD_REQ_SIZE (CPU design time constant)
and the Remote_Read_Request_Size, a part of PCIE_PL_MRCCR0 register:

"Remote Read Request Size specifies the largest amount of data (bytes)
that will ever be requested (via an inbound MemRd TLP) by a remote
device. Must never be programmed with a value that exceeds the value
represented by the configuration parameter CX_REMOTE_RD_REQ_SIZE as the
Master Response Composer RAM in the AXI bridge is sized using
CX_REMOTE_RD_REQ_SIZE."

Default value is 512 bytes (and works) and while I think it may be
possible to set it to 1024 or even 2048 bytes, it doesn't seem to work.
The "Remote Max Bridge Tag" (which is calculated automatically by the
CPU based on "Remote Read Request Size" changes from 3 to 1 (which may
make sense):

"Remote Read Request Size" vs. "Remote Max Bridge Tag"
 128 13 <<< does that mean 14 simultaneous requests? Or 13?
 256  6
 512  3
1024  1
2048  0 <<< a single request? No requests?
4096 31 <<< apparently some internal logic failure

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
