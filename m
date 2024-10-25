Return-Path: <linux-pci+bounces-15291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA699B02C1
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 14:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5221D1F22E98
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 12:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F2E1632FB;
	Fri, 25 Oct 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jFM+yOK5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cUfbopWQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jFM+yOK5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cUfbopWQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD681632E9;
	Fri, 25 Oct 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860331; cv=none; b=bYvHMYinzfZz1docyyztr1OdgFMHNib/wCU76Miwh66M8vglXROg/faIIvaDVmQbJ0m2X1IDPwyuDaHXsNbPCUYeksIhHhuoxnjPvk6MJdkRAO2F3sX6N3PmA9UxIBFScKbKRvh1oXccuVmyb9Zi+dil/Kzu/+MsZy36qxvR9GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860331; c=relaxed/simple;
	bh=gEoL41SjEGxO1+nYDZAHohK4Dg3X1gGNXGTb4JwhhI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2o9+OqZoxPp9m4o42Uh1g6M6u6X+JckRVxrfhbHpp7xjKOlUGRsOU5YG7Z+AtZcdDMMtEhiQkI+mNnLu1vlr2BqajHHbp9TiUMhozWBUPzbzHeiXu3mOEaHbO6cRw3ijBcg6h/w4W7De5xKrcAr5bYu9iBrP+yVuwAd55KMsaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jFM+yOK5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cUfbopWQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jFM+yOK5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cUfbopWQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 333B71FE09;
	Fri, 25 Oct 2024 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729860327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rclpcy2NkA/OAPsZkEcyTD0lijx7zaXfQCNiyX9YvLk=;
	b=jFM+yOK5EJjTWFCAL+Z3ISc2gAV14qb7ccNVMhjUnbQjKsYcX+L3/MfKyQjpyahPrmZibJ
	hQYqvtqYeY9Xbz5dXlSyZnOQPIrFL6QtE2DlLTDA8kr3Ch0WeCdOGw+Tu30a3DloDJK592
	B1i+7MjC4nYhEt9UUdIE0qwnR3sRx04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729860327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rclpcy2NkA/OAPsZkEcyTD0lijx7zaXfQCNiyX9YvLk=;
	b=cUfbopWQlb22h8/EF7J59kKeWUDzOrRxjaHRNHX7qV1bdjeqhPdI2f5BiJF/2XRv6QXlYt
	OyToeE4v93dAkNBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729860327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rclpcy2NkA/OAPsZkEcyTD0lijx7zaXfQCNiyX9YvLk=;
	b=jFM+yOK5EJjTWFCAL+Z3ISc2gAV14qb7ccNVMhjUnbQjKsYcX+L3/MfKyQjpyahPrmZibJ
	hQYqvtqYeY9Xbz5dXlSyZnOQPIrFL6QtE2DlLTDA8kr3Ch0WeCdOGw+Tu30a3DloDJK592
	B1i+7MjC4nYhEt9UUdIE0qwnR3sRx04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729860327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rclpcy2NkA/OAPsZkEcyTD0lijx7zaXfQCNiyX9YvLk=;
	b=cUfbopWQlb22h8/EF7J59kKeWUDzOrRxjaHRNHX7qV1bdjeqhPdI2f5BiJF/2XRv6QXlYt
	OyToeE4v93dAkNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1918E136F5;
	Fri, 25 Oct 2024 12:45:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id puKXA+aSG2fzOAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 25 Oct 2024 12:45:26 +0000
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
Subject: [PATCH v4 00/10] Add PCIe support for bcm2712
Date: Fri, 25 Oct 2024 15:45:05 +0300
Message-ID: <20241025124515.14066-1-svarbanov@suse.de>
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

Here is v4 of the series which aims to add support for PCIe on bcm2712 SoC
used by RPi5. Previous v3 can be found at [1].

v3 -> v4 changes include:
 - Addressed comments on the interrupt-controller driver (Thomas)
 - Moved "Reuse config structure" patch earlier in the series (Bjorn)
 - Merged "Avoid turn off of bridge reset" into "Add bcm2712 support" (Bjorn)
 - Fixed DTB warnings on broadcom/bcm2712-rpi-5-b.dtb 

For more detailed info check patches.

Comments are welcome!
~Stan

[1] https://patchwork.kernel.org/project/linux-pci/list/?series=898891

Stanimir Varbanov (10):
  dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
  dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
  irqchip: Add Broadcom bcm2712 MSI-X interrupt controller
  PCI: brcmstb: Reuse config structure
  PCI: brcmstb: Expand inbound window size up to 64GB
  PCI: brcmstb: Enable external MSI-X if available
  PCI: brcmstb: Add bcm2712 support
  PCI: brcmstb: Adjust PHY PLL setup to use a 54MHz input refclk
  arm64: dts: broadcom: bcm2712: Add PCIe DT nodes
  arm64: dts: broadcom: bcm2712-rpi-5-b: Enable PCIe DT nodes

 .../brcm,bcm2712-msix.yaml                    |  60 ++++
 .../bindings/pci/brcm,stb-pcie.yaml           |  21 ++
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |   8 +
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 162 +++++++++
 drivers/irqchip/Kconfig                       |  16 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-bcm2712-mip.c             | 310 ++++++++++++++++++
 drivers/pci/controller/pcie-brcmstb.c         | 204 +++++++++---
 8 files changed, 735 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
 create mode 100644 drivers/irqchip/irq-bcm2712-mip.c

-- 
2.43.0


