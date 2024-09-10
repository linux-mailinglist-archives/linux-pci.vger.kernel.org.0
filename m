Return-Path: <linux-pci+bounces-12985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33636973B65
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581B21C24EDC
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A328195980;
	Tue, 10 Sep 2024 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K2LaU84u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mWrUL8Gw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K2LaU84u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mWrUL8Gw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415E199FDD;
	Tue, 10 Sep 2024 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981553; cv=none; b=Y/UC8zanJG095AF2+G/0Jeuv1OSOFZt1fA1cDE40qeMR0VWVANO+7tpGPdTbiCe+6MyRr0efg2S3WTUkeO+WHhiLxhEoSGqawHZ9tFX1AtXTUVR32Zhw/OXqu3VMEVdKMSYez9Yjl/ElF9YBoWtF1CFAPDNUnXogi2LRekeJ/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981553; c=relaxed/simple;
	bh=E/lw+a9kSP7yktF8C21tBDc7gdoZhpLYXziDfOrPvYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPggyx1Cytfn6M4+8cU0ukF6vQpoKZzq8hI/zTaem3agL8qkFvGiZFwldDnay9I2fFp+Z5G/sd0Q/2l9lq7RsG+x8QYzwsvPbtBaW2P3H7SmGMlMh10QRXzYsOWGqAZ3LIRkYivYc8uLzJpTGsr2aryOj0mG7WnUeioJYAhaXDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K2LaU84u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mWrUL8Gw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K2LaU84u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mWrUL8Gw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AFA2921A5D;
	Tue, 10 Sep 2024 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KpOWZ4SVS+1k1ckgM9I/FM7qrwGXuDWWDPkuX5kqTn0=;
	b=K2LaU84uSG5PdA0H2MRL9PjPjjQ+3Fn97aW1MOmUxSkoVhrYpGxGOdiGxgTSoz/Ef+Gyac
	eSQg3s+Oc/yk/JRnfJlSFoWLyzVy+sB+CrtMor6cqD4S+Kf0jchrSNffIzPnqVgkLzZkQF
	Jb4Jgc4Sz35dOlZfXvMp9NfFRY74qgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KpOWZ4SVS+1k1ckgM9I/FM7qrwGXuDWWDPkuX5kqTn0=;
	b=mWrUL8GwiF7gxSSGyHUAg4Lnn5iMA6APFaBYPR3urg4W8qbqypQaHM9XlWBVn55h7x2gSU
	6o523biriDw9lUDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KpOWZ4SVS+1k1ckgM9I/FM7qrwGXuDWWDPkuX5kqTn0=;
	b=K2LaU84uSG5PdA0H2MRL9PjPjjQ+3Fn97aW1MOmUxSkoVhrYpGxGOdiGxgTSoz/Ef+Gyac
	eSQg3s+Oc/yk/JRnfJlSFoWLyzVy+sB+CrtMor6cqD4S+Kf0jchrSNffIzPnqVgkLzZkQF
	Jb4Jgc4Sz35dOlZfXvMp9NfFRY74qgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KpOWZ4SVS+1k1ckgM9I/FM7qrwGXuDWWDPkuX5kqTn0=;
	b=mWrUL8GwiF7gxSSGyHUAg4Lnn5iMA6APFaBYPR3urg4W8qbqypQaHM9XlWBVn55h7x2gSU
	6o523biriDw9lUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3928813A3A;
	Tue, 10 Sep 2024 15:19:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kxNCC2xj4GaxQgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 10 Sep 2024 15:19:08 +0000
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
Subject: [PATCH v2 -next 00/11] Add PCIe support for bcm2712
Date: Tue, 10 Sep 2024 18:18:34 +0300
Message-ID: <20240910151845.17308-1-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.30
X-Spam-Flag: NO

Hello,

Here is a v2 of adding PCIe support for bcm2712 (RPi5), the fisrt
version can be found at [1].

v2 is based on linux-next plus latest changes in pcie-brcmstb driver
[2]. The changes recently made by Jim leaded to a simplified patchset
for bcm2712 enablement coparing with previous version of this series.

Noticeable changes are:

 - Use of msi-range property in the MIP MSI-X controller and DT which
 make possible to avoid few private DT properties. The other noticeable
 change is moving of msi-pci-addr private property to a second 'reg'
 region. I'll appreciate comments on this.

 - Now the PCIe DT nodes are on separate axi{} simple-bus because adding
 it on soc{} adds too much churn in the node (Florian).

 - Added 'quirks' field in pcie_cfg_data to work around an issue (hw bug?)
 with bridge_reset on bcm2712 SoC.

regards,
~Stan

[1] https://patchwork.kernel.org/project/linux-pci/cover/20240626104544.14233-1-svarbanov@suse.de/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/brcmstb

Stanimir Varbanov (11):
  dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
  dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
  irqchip: mip: Add Broadcom bcm2712 MSI-X interrupt controller
  PCI: brcmstb: Expand inbound size calculation helper
  PCI: brcmstb: Restore CRS in RootCtl after prstn_n
  PCI: brcmstb: Enable external MSI-X if available
  PCI: brcmstb: Avoid turn off of bridge reset
  PCI: brcmstb: Add bcm2712 support
  PCI: brcmstb: Reuse config structure
  arm64: dts: broadcom: bcm2712: Add PCIe DT nodes
  arm64: dts: broadcom: bcm2712-rpi-5-b: Enable PCIe DT nodes

 .../brcm,bcm2712-msix.yaml                    |  69 ++++
 .../bindings/pci/brcm,stb-pcie.yaml           |   5 +-
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |   8 +
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 166 ++++++++++
 drivers/irqchip/Kconfig                       |  12 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-bcm2712-mip.c             | 310 ++++++++++++++++++
 drivers/pci/controller/pcie-brcmstb.c         | 172 +++++++---
 8 files changed, 694 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
 create mode 100644 drivers/irqchip/irq-bcm2712-mip.c

-- 
2.35.3


