Return-Path: <linux-pci+bounces-22170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1838CA41773
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 09:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8C516A30D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8864119259E;
	Mon, 24 Feb 2025 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uwFcHTc/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w4lkTbXw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uwFcHTc/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w4lkTbXw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B18C11
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386194; cv=none; b=YV4JA7OkTkuVN3cy6XCaf6D/JskCmWXXFm7FQ+F9rqBBlxn31mIhzvc0s6Eym0Q2Rts/Gg+WudLeUpzMxZ42o4QEDHmI6QpjX8PPEcUw7p8DTGO1pmgGVFhe37feA1YankYDyeK7QaJhUIFly/RBKsHUbtuTLfbSD0zx4HFqKps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386194; c=relaxed/simple;
	bh=kZRwcmfGy2m7oH9gUrAguuyEMXKNlnK9rQaFGw/638g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CoCWbflU5U/jOWSBnFz2Pry+35ToYCqxO1am4/aoMWfABYHKSNwHMJznmwWJvM8c6Y4HFMPU42BrE5VDK4MtR8LCTeG8p/XlfkM+6ht28/RD0+g1FrEhPUXvkZoOScpRUN6LKIIZqvO5LJfwEBhpyELv1t957FJVtSidbocVhLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uwFcHTc/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w4lkTbXw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uwFcHTc/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w4lkTbXw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43D0C21180;
	Mon, 24 Feb 2025 08:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740386190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gUzxlfop69b1dDrCQAZ0orgLMQmh6UkeuP2YTL3zP5E=;
	b=uwFcHTc/LFTskg1mfIT56B9t7NITPFmDdC9KTKprw4CwVsuJho0g+bL5YgD46jhVz5BTnl
	xouXnK8DEInulO7FpZuIc9mhXlXXNcv8yPD8i6tVPONOL6Mopcq13xYusISC/VQtNMWeRi
	Rhe4NpKgWnNlda14UYl6YC8On1AevNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740386190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gUzxlfop69b1dDrCQAZ0orgLMQmh6UkeuP2YTL3zP5E=;
	b=w4lkTbXwT+2e2RiYx9OrFOWNW5fTGPBTG4PGphGgHcmGvOq8RzyZPKu31c0C8km0zBxYMW
	JtqiSHrACf3O/tCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740386190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gUzxlfop69b1dDrCQAZ0orgLMQmh6UkeuP2YTL3zP5E=;
	b=uwFcHTc/LFTskg1mfIT56B9t7NITPFmDdC9KTKprw4CwVsuJho0g+bL5YgD46jhVz5BTnl
	xouXnK8DEInulO7FpZuIc9mhXlXXNcv8yPD8i6tVPONOL6Mopcq13xYusISC/VQtNMWeRi
	Rhe4NpKgWnNlda14UYl6YC8On1AevNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740386190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gUzxlfop69b1dDrCQAZ0orgLMQmh6UkeuP2YTL3zP5E=;
	b=w4lkTbXwT+2e2RiYx9OrFOWNW5fTGPBTG4PGphGgHcmGvOq8RzyZPKu31c0C8km0zBxYMW
	JtqiSHrACf3O/tCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13C1A13332;
	Mon, 24 Feb 2025 08:36:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RvcVAo0vvGeJVAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 24 Feb 2025 08:36:29 +0000
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
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH v6 0/7] Add PCIe support for bcm2712
Date: Mon, 24 Feb 2025 10:35:52 +0200
Message-ID: <20250224083559.47645-1-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hello, v6 is re-based version of controller/brcmstb branch of pci tree.

v5 could be found at [1].

v5 -> v6 changes include:
 - Fix a build error in 04/11 (Jim).
 - Address a comment from Bjorn about bisect-ability by squash
   07/11 in 06/11 (Bjorn).
 - Move 08/11 right after irqchip patch (Bjorn).

Regards,
~Stan

[1] https://lore.kernel.org/lkml/20250120130119.671119-1-svarbanov@suse.de/

Stanimir Varbanov (7):
  dt-bindings: interrupt-controller: Add BCM2712 MSI-X DT bindings
  dt-bindings: PCI: brcmstb: Update bindings for PCIe on BCM2712
  irqchip: Add Broadcom BCM2712 MSI-X interrupt controller
  PCI: brcmstb: Adding a softdep to MIP MSI-X driver
  PCI: brcmstb: Reuse pcie_cfg_data structure
  PCI: brcmstb: Expand inbound window size up to 64GB
  PCI: brcmstb: Add BCM2712 support

 .../brcm,bcm2712-msix.yaml                    |  60 ++++
 .../bindings/pci/brcm,stb-pcie.yaml           |   6 +-
 drivers/irqchip/Kconfig                       |  16 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-bcm2712-mip.c             | 292 ++++++++++++++++++
 drivers/pci/controller/pcie-brcmstb.c         | 144 ++++++---
 6 files changed, 475 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
 create mode 100644 drivers/irqchip/irq-bcm2712-mip.c

-- 
2.47.0


