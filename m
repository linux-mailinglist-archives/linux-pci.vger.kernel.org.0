Return-Path: <linux-pci+bounces-29613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FB9AD7C9D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 22:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B831767A8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 20:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D04E1F12F6;
	Thu, 12 Jun 2025 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+mXMN/9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D121B4F1F;
	Thu, 12 Jun 2025 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749761221; cv=none; b=uhzKly7rpLO2X7Fw9yaO8Zg500QEPjswM6TXNW6Rh/xK9onVYicqZhSfP9UakmC/Bpn5y1KjfN1Pyf8oNRsddb2u5bQxClcV34gX5GG2V4D3yX8RkiMBkQDP1NiuibNMbZokoHXjKIx9eGn6Noj0Ta6KiF++tGOpayuZnsJ5UFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749761221; c=relaxed/simple;
	bh=O3+xFnBWba41Et0B2Fwfa+WsL68zmh90ddIlEpOkDtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Us82K6vFfuoOYQVbBHJ4MRYbGytKZUFxhZQSNYEJBl4Smwq6D2f1yCtbkC07QuTKBCQTX3pSQnmjJ6kHYyR6ORs4c3Gf3O0J9Lh9gDUe6uUkfureTds2niNzVqE8rDDBmEOndJulxlgDcgYd9HnlrOrM35B8a+favgN4cnB9K6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+mXMN/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DF6C4CEEA;
	Thu, 12 Jun 2025 20:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749761220;
	bh=O3+xFnBWba41Et0B2Fwfa+WsL68zmh90ddIlEpOkDtI=;
	h=Date:From:To:Cc:Subject:From;
	b=U+mXMN/91W85CUD0Sekr9crOser7JYlZErcNXh7GJ7NMhS2Bo+BjoIHYGZP1he2pr
	 cbTQVq1uKPm76qQW7ED6QRCHoXegOj0tjb/6J6UBGJw85IB6eAqe2Xs5j6DNnYXl8f
	 flPymIS9EteF4/vRFdme0sr3byzK/VsezEaEoom995vUSw7yx4X84ANbOb3DdLOrpT
	 terjUgHD6EE5040OuV9aqcTnYCgspoo8/YUYdRrsnNeYW/O5gi4KSmyKJeZzoVlIDm
	 ILuAKB1AooEKfHbWKVFe7dpwE3lrE4TFG/BUpMzv6+vdfSaX7zV+Sd4KTIW3pBHJNi
	 ZHbnBCzPaxXeA==
Date: Thu, 12 Jun 2025 15:46:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Mario Limonciello <superm1@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: [bugzilla-daemon@kernel.org: [Bug 220216] New: Intel Corporation
 JHL7440 Thunderbolt 3 Bridge: Unable to change power state from D3hot to D0,
 device inaccessible]
Message-ID: <20250612204659.GA928209@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[+cc Mario, Lukas, Rafael, thunderbolt folks; submitter in bcc
Possibly related to
https://lore.kernel.org/linux-pci/20250609020223.269407-1-superm1@kernel.org/?]

Laurent, you mentioned that you see this on 6.15.1.  Is this a new
problem that you didn't see on older kernels?

----- Forwarded message from bugzilla-daemon@kernel.org -----

https://bugzilla.kernel.org/show_bug.cgi?id=220216

            Bug ID: 220216
           Summary: Intel Corporation JHL7440 Thunderbolt 3 Bridge: Unable
                    to change power state from D3hot to D0, device
                    inaccessible
        Regression: No

Created attachment 308224
  --> https://bugzilla.kernel.org/attachment.cgi?id=308224&action=edit
Full dmesg

Hello,

On debian with kernel 6.15.1, I get the following messages in dmesg:

[    0.453279] pci 0000:02:04.0: [8086:15ef] type 01 class 0x060400 PCIe Switch
Downstream Port
[    0.453327] pci 0000:02:04.0: PCI bridge to [bus 04-38]
[    0.453342] pci 0000:02:04.0:   bridge window [mem 0x8a000000-0x9fcfffff]
[    0.453360] pci 0000:02:04.0:   bridge window [mem 0x6000000000-0x6021ffffff
64bit pref]
[    0.453383] pci 0000:02:04.0: enabling Extended Tags
[    0.453569] pci 0000:02:04.0: supports D1 D2
[    0.453569] pci 0000:02:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.454686] pci 0000:02:04.0: PCI bridge to [bus 04-38]
[    0.863766] pci 0000:02:04.0: bridge window [io  0x4000-0x4fff]: assigned
[    0.863788] pci 0000:02:04.0: PCI bridge to [bus 04-38]
[    0.863791] pci 0000:02:04.0:   bridge window [io  0x4000-0x4fff]
[    0.863797] pci 0000:02:04.0:   bridge window [mem 0x8a000000-0x9fcfffff]
[    0.863802] pci 0000:02:04.0:   bridge window [mem 0x6000000000-0x6021ffffff
64bit pref]
[    0.865332] pci 0000:02:04.0: Adding to iommu group 18
[    1.044101] pcieport 0000:02:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL-
AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.885142] pcieport 0000:02:04.0: Unable to change power state from D3hot
to D0, device inaccessible
[    1.885352] pcieport 0000:02:04.0: Runtime PM usage count underflow!
[   18.615343] pci 0000:02:04.0: [8086:15ef] type 01 class 0x060400 PCIe Switch
Downstream Port
[   18.615392] pci 0000:02:04.0: PCI bridge to [bus 00]
[   18.615404] pci 0000:02:04.0:   bridge window [io  0x0000-0x0fff]
[   18.615409] pci 0000:02:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   18.615429] pci 0000:02:04.0:   bridge window [mem 0x00000000-0x000fffff
64bit pref]
[   18.615453] pci 0000:02:04.0: enabling Extended Tags
[   18.615649] pci 0000:02:04.0: supports D1 D2
[   18.615650] pci 0000:02:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   18.615903] pci 0000:02:04.0: Adding to iommu group 18
[   18.616047] pci 0000:02:04.0: bridge configuration invalid ([bus 00-00]),
reconfiguring
[   18.617062] pci 0000:02:04.0: PCI bridge to [bus 04-38]
[   18.617099] pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff 64bit
pref] to [bus 04-38] add_size 100000 add_align 100000
[   18.617102] pci 0000:02:04.0: bridge window [mem 0x00100000-0x001fffff] to
[bus 04-38] add_size 100000 add_align 100000
[   18.617119] pci 0000:02:04.0: bridge window [mem 0x8a100000-0x9fdfffff]:
assigned
[   18.617120] pci 0000:02:04.0: bridge window [mem 0x6000100000-0x6021ffffff
64bit pref]: assigned
[   18.617122] pci 0000:02:04.0: bridge window [io  0x5000-0x5fff]: assigned
[   18.617157] pci 0000:02:04.0: PCI bridge to [bus 04-38]
[   18.617160] pci 0000:02:04.0:   bridge window [io  0x5000-0x5fff]
[   18.617167] pci 0000:02:04.0:   bridge window [mem 0x8a100000-0x9fdfffff]
[   18.617172] pci 0000:02:04.0:   bridge window [mem 0x6000100000-0x6021ffffff
64bit pref]
[   18.617803] pcieport 0000:02:04.0: enabling device (0000 -> 0003)
[   18.617969] pcieport 0000:02:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL-
AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+


Note the "Unable to change power state from D3hot to D0, device inaccessible"
and "Runtime PM usage count underflow!"

Laptop is a Dell latitude 5530

-- 

