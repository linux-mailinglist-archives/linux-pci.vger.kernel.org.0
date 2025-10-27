Return-Path: <linux-pci+bounces-39424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B60C0DB23
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E021893D5E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 12:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8515D23D7E0;
	Mon, 27 Oct 2025 12:53:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60A18DB26
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569603; cv=none; b=oeLr89az3lBAubrpQSaavofRhrlQpB0ejiexVbsAD3wKOi03vGcOG1gGIS6LrLN8FjUKoikxj/Z716eX1gLgbuYSyHuj9+wpDZJAfnWgyy3ejMBN97P6YSElbATE9sIEhaZQmC8kTQlVWB+HCQ18ZcYdF4KTwmuFtX4qdGynEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569603; c=relaxed/simple;
	bh=WyAT0cZ419zJS6+qhbXvxzs+CR/2BDzu0Df1ltpBvxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKsigZ06h/cQFgjo+BML4BqW/WyjlXPNnowisFTxdZmmYLq2j2g/5TeB+A5vpz8Xip4qF71U1NG5RYU872b4j9YhwHre6QFy8yzaqTCqPZURJwBI18LktiyhP0Tc9amNFvsBlXNjx4tebJuuinQLBYXL1NQx3+JmBNTkz9rTQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1761569517tb53347eb
X-QQ-Originating-IP: nmsWUsXJgs/BC/zm7wCdDP8DQicwbQiZNInWOC/bbaA=
Received: from [IPV6:240f:10b:7440:1:8944:4301 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 20:51:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 80477086532345862
Message-ID: <665677F9F810B6C1+af6c83fd-f262-4721-b544-4336aaa83bfe@radxa.com>
Date: Mon, 27 Oct 2025 21:51:52 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
To: Linnaea Lavia <linnaea-von-lavia@live.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20251023164205.GA1299816@bhelgaas>
 <DM4PR05MB102709E0A9C0CF0D62AEC3524C7F1A@DM4PR05MB10270.namprd05.prod.outlook.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <DM4PR05MB102709E0A9C0CF0D62AEC3524C7F1A@DM4PR05MB10270.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N1sMhKjDsQuaqa0m7xhvUK7v3oLjS2bPiDUXypa/wpV4ag9cXplh6GcG
	RoayluD7PfKAUg0W9ABZJbsyYolfuwY2IWR0dyfeF5/Bxt3RfvX5uVCepeTg3dHJqQ8rL+n
	dTWA04C11/GJjB0WfhoWkUOBJHByDn5R8Wou5mL+8ymzD3LlLdasGpei+r+LnZ9yzM2xcvn
	PmSZM0xNu1sOkIp9QzFg1SIw7dOqVMZzSJGeTGl0m8F9xthvusrb2RK2uPQN5gRCU/8lhmn
	+diIc+1kl3ltpiMaZbXMiSzVYIT+orhZNcEFm2ltL1P3Qwgs7HQt5bFibRFV8NbH05GQqxp
	iJ53Rv5Gsk+kgzDTsG7c6vwA1kFYtjWvEKE7k46PTyCOYKQ74jKwJWJuw6GDKg0yibbK8Cs
	9I1A5APBr4vBJ0X5pTGYV000b9QqDWjSAbi1N8ebowf3Y+UN67Z60xhpao7/MjdLYhcfBBq
	swomhUjqfX8kzubG7O8rcQIOEk4/3bYe9IETi+vFeV/QeJsbK/L4K52SyH8CRCrxDAl8gLE
	tp8N5jgmz70iyabTlZwMQDqthFwCUruErAOsXJqzgK39/m/j5z8HtS5HZh7po2S5j/bW4m0
	MCuGT5AIQnpyirMAgMEX/P3xJgLhDvCur7uISulhlypn+2chfq/0zeeVoaQRr3S0JVbMcvW
	qdub8XQDAr5jOr6jFe0o6ADMYHuZsr5jiFmHDepJRfIQNRgSk1Sq3oM95bgb8IzzGuJg964
	UupDr9AvK+Di5jAN3DBsS+lT+XMDGMnmyNGkN7t6mZa7yX6nqnidpYcw9YadPZG0LLC4keq
	JHyDaItP6ilcCBBOqVVyxm5ehUtGFysCe8oD6WrDgCGA8DcrpNt/vl+VGt2FuIMNbFrrufN
	LgzCkC2CJiIRl2DvURBjCY2IVELIAOZYRb5CN1naz7CWK8hF6ZRHbCWuemZrH3KfGdUBlZN
	9FjiyNj1zAWTc0nsWGOaoiXgfR9kSCYsf2ImnIGOUGqgBWvSTjRjTYSEq
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi Linnaea,

On 10/24/25 12:27, Linnaea Lavia wrote:
(snip)> With the patch on 6.18-rc2 it fails later with ASPM.
> 
> [    5.362080] [     T50] dw-pcie fc000000.pcie: error -ENXIO: IRQ index 
> 1 not found
> [    5.400163] [     T50] meson-pcie fc000000.pcie: host bridge /soc/ 
> pcie@fc000000 ranges:
> [    5.421350] [     T50] meson-pcie fc000000.pcie:       IO 
> 0x00fc600000..0x00fc6fffff -> 0x0000000000
> [    5.428902] [     T50] meson-pcie fc000000.pcie:      MEM 
> 0x00fc700000..0x00fdffffff -> 0x00fc700000
> [    5.436367] [     T50] meson-pcie fc000000.pcie: iATU: unroll T, 4 
> ob, 4 ib, align 64K, limit 4G
> [    5.485658] [     T50] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [    5.491449] [     T50] meson-pcie fc000000.pcie: PCIe Gen.2 x1 link up
> [    5.512122] [     T50] meson-pcie fc000000.pcie: PCI host bridge to 
> bus 0000:00
> [    5.515375] [     T50] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    5.521523] [     T50] pci_bus 0000:00: root bus resource [io  
> 0x0000-0xfffff]
> [    5.528847] [     T50] pci_bus 0000:00: root bus resource [mem 
> 0xfc700000-0xfdffffff]
> [    5.536237] [     T50] pci 0000:00:00.0: [16c3:abcd] type 01 class 
> 0x060400 PCIe Root Port
> [    5.543415] [     T50] pci 0000:00:00.0: ROM [mem 
> 0x00000000-0x0000ffff pref]
> [    5.543432] [     T50] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    5.543441] [     T50] pci 0000:00:00.0:   bridge window [io  
> 0x0000-0x0fff]
> [    5.543448] [     T50] pci 0000:00:00.0:   bridge window [mem 
> 0x00000000-0x000fffff]
> [    5.569461] [     T50] pci 0000:00:00.0:   bridge window [mem 
> 0x00000000-0x000fffff pref]
> [    5.587641] [     T50] pci 0000:00:00.0: supports D1
> [    5.591578] [     T50] pci 0000:00:00.0: PME# supported from D0 D1 
> D3hot D3cold
> [    5.603775] [     T50] pci 0000:01:00.0: [8086:2725] type 00 class 
> 0x028000 PCIe Endpoint
> [    5.614373] [     T50] pci 0000:01:00.0: BAR 0 [mem 
> 0x00000000-0x00003fff 64bit]
> [    5.621353] [     T50] pci 0000:01:00.0: Upstream bridge's Max 
> Payload Size set to 128 (was 256, max 256)
> [    5.621374] [     T50] pci 0000:01:00.0: Max Payload Size set to 128 
> (was 128, max 128)
> [    5.623252] [     T50] pci 0000:01:00.0: PME# supported from D0 D3hot 
> D3cold
> [    5.651205] [     T50] pci 0000:01:00.0: ASPM: DT platform, enabling 
> L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
> [    5.664912] [     T50] pci 0000:01:00.0: ASPM: DT platform, enabling 
> ClockPM
> [    5.706596] [     T50] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [    5.748181] [     T50] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [    5.796864] [     T50] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [    5.798178] [     T50] pci 0000:00:00.0: bridge window [mem 
> 0xfc700000-0xfc7fffff]: assigned
> [    5.806100] [     T50] pci 0000:00:00.0: ROM [mem 
> 0xfc800000-0xfc80ffff pref]: assigned
> [    5.806382] [     T50] pci 0000:01:00.0: BAR 0 [mem 
> 0xfc700000-0xfc703fff 64bit]: assigned
> [    5.863079] [     T50] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [    5.904553] [     T50] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [    5.946013] [     T50] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [    5.987492] [     T50] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [    5.987517] [     T50] pci 0000:01:00.0: BAR 0: error updating 
> (0xfc700004 != 0xffffffff)
> [    6.028979] [     T50] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [    6.080320] [     T50] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [    6.081421] [     T50] pci 0000:01:00.0: BAR 0: error updating (high 
> 0x00000000 != 0xffffffff)
> [    6.131210] [     T50] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [    6.132324] [     T50] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    6.138215] [     T50] pci 0000:00:00.0:   bridge window [mem 
> 0xfc700000-0xfc7fffff]
> [    6.145683] [     T50] pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
> [    6.151953] [     T50] pci_bus 0000:00: resource 5 [mem 
> 0xfc700000-0xfdffffff]
> [    6.165037] [     T50] pci_bus 0000:01: resource 1 [mem 
> 0xfc700000-0xfc7fffff]
> [    6.165782] [     T50] pcieport 0000:00:00.0: PME: Signaling with IRQ 25
> [    6.181556] [     T50] pcieport 0000:00:00.0: AER: enabled with IRQ 25
> [   11.500464] [    T491] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [   11.543334] [    T491] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [   11.544875] [    T491] iwlwifi 0000:01:00.0: of_irq_parse_pci: failed 
> with rc=134
> [   11.593524] [    T491] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [   11.636355] [    T491] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [   11.680033] [    T491] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [   11.721230] [    T491] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [   11.722728] [    T491] iwlwifi 0000:01:00.0: Unable to change power 
> state from D3cold to D0, device inaccessible
> [   11.773976] [    T491] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [   11.816771] [    T491] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [   11.859334] [    T491] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [   11.901868] [    T491] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [   11.944393] [    T491] meson-pcie fc000000.pcie: error: wait linkup 
> timeout
> [   11.945931] [    T491] iwlwifi 0000:01:00.0: HW_REV=0xFFFFFFFF, PCI 
> issues?
> [   11.952685] [    T491] iwlwifi 0000:01:00.0: probe with driver 
> iwlwifi failed with error -5
> 
> Booting with the patch and pcie_aspm=off made the PCIe card work again.(snip)

Regarding the ASPM issue, could you try v6.18-rc3 (in addition to your 
changes)?

https://patchwork.kernel.org/project/linux-pci/patch/20251023180645.1304701-1-helgaas@kernel.org/

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

