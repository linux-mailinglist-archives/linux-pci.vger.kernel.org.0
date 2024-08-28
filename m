Return-Path: <linux-pci+bounces-12392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49B396340F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 23:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038D51C21861
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 21:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C059167D97;
	Wed, 28 Aug 2024 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="fk7ne8jk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE8815ADB3
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724881250; cv=none; b=kFA4u3sKRrVA6n4X+OkdgNK7qTBEicUsj58+NIlXyJVconwpQzU1CXRT3wsvqKAeJWPCr5oYrPdJosxqyXO7rWc3MTa2jyyut4q7mQBaOfHUHxadVUV/7lLe9orI1cleGCyF4pOCCp27tC7KNzW21jRHy2g1E1heTNwC754+wao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724881250; c=relaxed/simple;
	bh=Q5vt2lRYknOiO5WwmmBEHpfQwSJ6ie94dKuvRYWOpaU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ThrbpZindrNLPT/sHMjy/+Mu85XnuDs0KL44O03oS4fILyPOmT489gNoNBsJGgXBc01P2GwhAI3/ySTeXaymHn8TxlntsZa354ZsC/JgzJ/G+p5f7Zzo1vf7cwjjZqRu+xvY28DQqMPXsRShxgRBPxfQrMY1d1XaXIZXXbgpBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=fk7ne8jk; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5334b0e1a8eso9431179e87.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1724881245; x=1725486045; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2X3roa5chx4luM9bkYl+SqKxlmwe71OedtuNu3j22GE=;
        b=fk7ne8jkGXRFldD9bews7mbu6GGi0FuVwvXv0KXBASyIEIrjS51Iwf0Oa9yd/HdnSb
         ZJBk0Z1Ix05XJpoZEU1Tgi+E5GZ3tlG2Rdmsd2+3pzUIzytDTSSXTdHXbBa7ydOW9m0i
         OP+/lTYDOqmi43LhCVVEJ7oWpYWuttHjkA5R6JtGg0DZ/iWR7vxenMKZI+TXIYHoWtei
         GhtrpwkE80Q9FleIUdWegC8OBXBAFjVaT8iZR8n/+Vl1iXMZdhW+kdF8lweCty3QTsm1
         za19c1fb90v2U3mLa3V5e8Dr6YSR/ZyJ/2uUbRLsICK5jEI5YqBRQFKe/KTZZ8pGyaCg
         frBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724881245; x=1725486045;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2X3roa5chx4luM9bkYl+SqKxlmwe71OedtuNu3j22GE=;
        b=Z89Cfq4yo154V6dE0i/pL02664Hi0B/1ebq1JZmXAiJCSG9D4cwJHhufkLtmVvsWpP
         uPRVAQ4VLmOTHk1Z57Jf8WPXNDpwmVhePG4ZlJMnX8NTqk3wqJQRLsU76OE1MJOuhD8D
         7oEVlH6Ti7NYwIQCB22LWQAYjl5VWjse8fwkqx4g8kaoE05ZuC8ajHbfqosYLuqv+HMf
         FZsWMGI6uyB/zd22hrsuXLtALwmm6mn7ry4jJTG7yh2qw24RvsW6U1EX7Ji5b1BiVYTm
         1ljrWJQchJHhaQbBKG5AdnWUrvyy2129gCuPgxWJujlU3nNIhU5UhFfAWC1h8r7eyfvM
         zhMA==
X-Gm-Message-State: AOJu0YxDZsNA7if6gBnpSJxEB7ahcSv2MpVfAvnGLp5o+dOeNcX+i0M0
	OHlp4L2gnppOfo6oMXKwMX02s4Rj1YQRRin4zAidmB39cFIMqs+ZoQrEpflLkoi3/EdHJMeJyCT
	B1yBGdiobtjYIbCo4Ry9VzEqBUMQTL2eo1l4T7xWO+3q8qhAqYLQ=
X-Google-Smtp-Source: AGHT+IEMcI12zvFnbLjpoL8O/vm2pVIsX+Is/g4NkBMtGE4gFMElRHR7bl4Ip/8PUZfBeP6vx0BbM1PabNKJCa264kE=
X-Received: by 2002:a05:6512:ea1:b0:52e:9b68:d2da with SMTP id
 2adb3069b0e04-5353e549b97mr327767e87.9.1724881244671; Wed, 28 Aug 2024
 14:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 28 Aug 2024 14:40:33 -0700
Message-ID: <CAJ+vNU2YVpQ=csr-O65L_pcNFWbFMvHK4XO44cbfUfPKwuw6vg@mail.gmail.com>
Subject: legacy PCI device behind a bridge not getting a valid IRQ on imx host controller
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greetings,

I have a user that is using an IMX8MM SoC (dwc controller) with a
miniPCIe card that has a PEX8112 PCI-to-PCIe bridge to a legacy PCI
device and the device is not getting a valid interrupt.

The PCI bus looks like this:
00.00.0: 16c3:abcd (rev 01)
01:00.0: 10b5:8112
^^^ PEX8112 x1 Lane PCI bridge
02:00.0: 4ddc:1a00
02:01.0: 4ddc:1a00
^^^ PCI devices

lspci -vvv -s 02:00.0:
02:00.0 Communication controller: ILC Data Device Corp Device 1a00 (rev 10)
        Subsystem: ILC Data Device Corp Device 1a00
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 18100000 (32-bit, non-prefetchable)
[disabled] [size=256K]
        Region 1: Memory at 18180000 (32-bit, non-prefetchable)
[disabled] [size=4K]
^^^ 'Interrupt: pin A routed to IRQ 0' is wrong

I found an old thread from 2019 on an NVidia forum [1] where the same
thing occurred and Nvidia's solution was a patch to the dwc driver to
call pci_fixup_irqs():
diff --git a/drivers/pci/dwc/pcie-designware-host.c
b/drivers/pci/dwc/pcie-designware-host.c
index ec2e4a61aa4e..a72ba177a5fd 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -477,6 +477,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
        if (pp->ops->scan_bus)
                pp->ops->scan_bus(pp);

+       pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+
        pci_bus_size_bridges(bus);
        pci_bus_assign_resources(bus);

Since that time the pci/dwc drivers have changed quite a bit;
pci_fixup_irqs() was changed to pci_assign_irq() called now from
pcie_device_probe() and dw_pcie_host_init() calls commit init
functions.

While I don't have the particular card in hand described above yet to
test with, I did manage to reproduce this on an imx6dl soc (same dwc
controller and driver) connected to a TI XIO2001 with an Intel I210
behind it and see the exact same issue.

Does anyone understand why legacy PCI interrupt mapping behind a
bridge isn't working here?

Best regards,

Tim
[1] https://forums.developer.nvidia.com/t/xavier-not-routing-pci-interrupts-across-pex8112-bridge/78556

