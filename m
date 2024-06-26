Return-Path: <linux-pci+bounces-9285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C8917EAB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5675C28025C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9CC16F0DC;
	Wed, 26 Jun 2024 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gd507zXd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kg/CM1CG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e7+KCXzS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R6lIPqGW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524113A26F;
	Wed, 26 Jun 2024 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398805; cv=none; b=XwOGaiykWQ1O7Hxe/ht/B/0zYJq/zfN8d578f19ydbbh1NCyZdIcHuqYuDaekVp6POvRKi4iCq6xJ1GcRRunCQ53UaEXGByPSctXOj5EW8z/xUO4SVwTY2vKrlVkDKBthThWzhTAF8IsMoMgAdbBTk5OWUpos4e+F8t9YCj7MTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398805; c=relaxed/simple;
	bh=12cKuQ+zRvobmODA4op7ItxgMeiU50RQfcgDGX/gsYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbxgCdSJlnofkgTFdr5bFQ4t5lsPiKAZeextMznXRvtDgq5qA8+5NpstJ7R0PmEUFau83u04+atP4RGMUTXuQIamwoRzCSro6sCEYHtxp9HvpitEFYJNwFRyxR/hCQgKWDN0QKOcPVeoqYmu3+Jywxtz0WyOynQYO6HlKggMEWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gd507zXd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kg/CM1CG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e7+KCXzS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R6lIPqGW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 135EF1FB4C;
	Wed, 26 Jun 2024 10:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YojtZiArRHb8JKphs/qX6maCDdsDI0fte/sTccK0ELU=;
	b=Gd507zXdcc0PYjIWCHABMw8L8HNBiy9FfJBVj3pA0Zvi1/OR6/ny7CDrIKQi86j4EgsRax
	gd57kTyANcCxU8OBxKwLx+m72/FSpysP7WLa1dpKP0LzLhOPxcXJDGAS18upl+aYPlxWDb
	3Ox8ffgQ8BR426DRrepO7VG2RT0Q1jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YojtZiArRHb8JKphs/qX6maCDdsDI0fte/sTccK0ELU=;
	b=Kg/CM1CGhzbiP8GXWne53MUp/CIhe+xSBQ/6tS3FNDl3/IPb0IuFxWmffkDeWusLTlwQ6t
	cb2Z4c5ZwAiTIfCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e7+KCXzS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=R6lIPqGW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YojtZiArRHb8JKphs/qX6maCDdsDI0fte/sTccK0ELU=;
	b=e7+KCXzSmS7VlJnfXszGUfOHpANhnfMsXlmcHdWQoZsRYBqGE/a+DXiQspbbquYXzlNwVh
	Aimn45dhzKUofuV4t0y4NZ1hdNZt/r1usCacaewIQAQCRTXeOnhwyVc4CYbTs+DfJpEqWp
	4YI+apYx+3Ops+3AqbsprAVrZdOIjAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YojtZiArRHb8JKphs/qX6maCDdsDI0fte/sTccK0ELU=;
	b=R6lIPqGWAJiVrPSPuup4LX4ehc8kY8CsCTToNUEjBVeFlnyJlm61lu21iQ4/UVa+nGp73z
	JAl1lmyrPCFDgbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE113139C2;
	Wed, 26 Jun 2024 10:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tQ1AN47xe2ZuDQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 26 Jun 2024 10:46:38 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH 0/7] Add PCIe support for bcm2712
Date: Wed, 26 Jun 2024 13:45:37 +0300
Message-ID: <20240626104544.14233-1-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	TAGGED_RCPT(0.00)[dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 135EF1FB4C
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 

This patchset aims to add bare minimum support for bcm2712
in brcmstb PCIe driver needed to support the peripherals from
RP1 south-bridge found in RPi5. In order to support RP1
PCIe endpoint peripherals a new interrupt controller is added.
The interrupt controller supports 64 interrupt sources which
are enough to handle 61 RP1 peripherals.

Patch 1 is adding DT binding schema for the MIP interrupt
controller, patch 2 is adding relevant changes for PCIe
bcm2712 in yaml. Patch 3 adds MIP intterrupt cotroller driver.
Patches 4 and 5 are preparations for adding bcm2712 support in 6.
The last patch updates bcm2712 .dsti by adding pcie DT nodes.

Few concerns about the implementation:
 - the connection between MIP interrupt-controller and PCIe RC is 
   done through BAR1. The PCIe driver is parsing the msi_parent
   DT property in order to obtain few private DT properties like 
   "brcm,msi-pci-addr" and "reg". IMO this looks hackish but I failed
   to find something better. Ideas? 

 - in downstream RPi kernel "ranges" and "dma-ranges" DT properties 
   are under an axi {} simple-bus node even that PCIe block is on CPU
   MMIO bus. I tried to merge axi {} in soc {} and the result could be
   seen on the last patch in this series, but I'm still not sure that
   it looks good enough.

This series has been functionally tested on OpenSUSE Tumbleweed with
downstream RP1 south-bridge PCIe endpoint driver implementation as
MFD by using ethernet which is part of it. 

The series is based on Andrea's "Add minimal boot support for Raspberry Pi 5"
series.

Comments are welcome!

regards,
~Stan

Stanimir Varbanov (7):
  dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
  dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
  irqchip: Add Broadcom bcm2712 MSI-X interrupt controller
  PCI: brcmstb: Reuse config structure
  PCI: brcmstb: add phy_controllable flag
  PCI: brcmstb: Add bcm2712 support
  arm64: dts: broadcom: bcm2712: Add PCIe DT nodes

 .../brcm,bcm2712-msix.yaml                    |  74 +++++
 .../bindings/pci/brcm,stb-pcie.yaml           |  17 +
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 218 +++++++++++-
 drivers/irqchip/Kconfig                       |  12 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-bcm2712-mip.c             | 287 ++++++++++++++++
 drivers/pci/controller/pcie-brcmstb.c         | 314 ++++++++++++++++--
 7 files changed, 876 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
 create mode 100644 drivers/irqchip/irq-bcm2712-mip.c

-- 
2.43.0


