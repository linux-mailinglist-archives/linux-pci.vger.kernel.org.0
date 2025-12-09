Return-Path: <linux-pci+bounces-42848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C4BCB036C
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 15:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E5AA3019AF8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 14:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC15F2D979F;
	Tue,  9 Dec 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="epEFCiLb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail108.out.titan.email (mail108.out.titan.email [44.210.203.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAC42DC78F
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.210.203.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765289374; cv=none; b=AUeebe9ruJDM1W8QtiABeu2CE6lszjEuKh77NEjsHXuwOE6aNZPCeMbh450wRn9uah7SxL82rILQ/qFBPvYxtLIxrkOwI3ceKPkZzOl9q5JRJ8bQa+68L2/rRwD4sMGYpTQADpKwOGxRPlqJgCrDsNOb22VehkAbOZXujhF0GQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765289374; c=relaxed/simple;
	bh=nyTQZgxqbzgEgJc5dsLmfDOLr351cJZa7XNqltO7PjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ClQ0XHJO+Ogienh1YZNGTRVBF11lb7sbIqMA7OnQDlKkBahjkQSL4DEDPf7hCjGDQNKGqKuRwEdSEuXxB0KQg/TaGG5S4XlHzNgrobFNWKJfHOMVETGs1AHh3vXfV2it29zoW6gQgKWNFtIhqLY1aZhMSYJOXX4LXn59p5qtFiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=epEFCiLb; arc=none smtp.client-ip=44.210.203.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dQgV36FPbz9rx4;
	Tue,  9 Dec 2025 14:00:27 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=R4nibh5JRSMMO3gyGOy//Kvj4/C4x07Pa4snNO8+7VU=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=from:cc:date:message-id:to:subject:mime-version:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
	q=dns/txt; s=titan1; t=1765288827; v=1;
	b=epEFCiLb++LLFhADULTWg7i2/dR+maFgQX+VcAwTe5YWnXX0aoOcHr9B3mlZ8vHDRxpSrrE4
	ES1RH9+2n4gTPo1aUCEnIcoe5NPFlbGEIO5zezfHCbhp98zrdkrpmptHBzI0LbH3TzYv1Sj+k4u
	wo+oXwfRN7Fx4BbfrAVP4qwo=
Received: from ketchup (unknown [117.171.66.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dQgTw4Gb9z9rxS;
	Tue,  9 Dec 2025 14:00:19 +0000 (UTC)
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH 0/2] Fix LoongArch dtbs_check warnings
Date: Tue,  9 Dec 2025 14:00:04 +0000
Message-ID: <20251209140006.54821-1-me@ziyao.cc>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765288827551596737.21635.3562549596523812257@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=69382b7b
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10 a=gEfo2CItAAAA:8
	a=gG2v9l9OlLWBpoMu9D0A:9 a=sptkURWiP4Gy88Gu7hUp:22
	a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22

Running dtbs_check with ARCH=loongarch emits a lot of warnings, most
about describing sideband interrupts for PCI devices through interrupts
property, and usage of undocumented msi-parent property in pcie
controller in loongson-2k2000.dtsi.

Patch 1 solves the former problem by using interrupts-extended property
for these devices. I don't have LS2K1000/2000 devices on hand, so
helping in testing it will be appreciated. msi-parent property is
documented in the second patch for Loongson PCI controllers.

After applying the series, the only two warnings left are about naming
of I2C controllers,

/builder/repo/linux/arch/loongarch/boot/dts/loongson-2k1000-ref.dtb: i2c-gpio-0 (i2c-gpio): $nodename:0: 'i2c-gpio-0' does not match '^i2c(@.+|-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
/builder/repo/linux/arch/loongarch/boot/dts/loongson-2k1000-ref.dtb: i2c-gpio-1 (i2c-gpio): $nodename:0: 'i2c-gpio-1' does not match '^i2c(@.+|-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#

which IMHO is a regression caused by dt-schema commit 57138f5b8c92
("schemas: i2c: Avoid extra characters in i2c nodename pattern"). Commit
647181a1f8ff ("schemas: i2c: Allow for 'i2c-.*' node names") fails to
fix the case, as it doesn't take nodenames with multiple hyphens in
account. I'll start a separate series for this.

Thanks for your time and review.

Yao Zi (2):
  LoongArch: dts: Describe PCI sideband IRQ through interrupt-extended
  dt-bindings: PCI: loongson: Document msi-parent property

 .../devicetree/bindings/pci/loongson.yaml     |  2 ++
 arch/loongarch/boot/dts/loongson-2k1000.dtsi  | 25 ++++++---------
 arch/loongarch/boot/dts/loongson-2k2000.dtsi  | 32 +++++++------------
 3 files changed, 23 insertions(+), 36 deletions(-)

-- 
2.51.2


