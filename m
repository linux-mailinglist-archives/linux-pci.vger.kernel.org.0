Return-Path: <linux-pci+bounces-12987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1E973B6D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C4E1F24CF8
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579061A00CF;
	Tue, 10 Sep 2024 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EQlzWIm7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c4JQPPMV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EQlzWIm7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c4JQPPMV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4A19A281;
	Tue, 10 Sep 2024 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981555; cv=none; b=DvVRaHLzy/1TldRp6hh5UG1MA8mCaB7j78CgMn+CTQqlFpaLTpUW+nrUQQkwV+HkNFWnlogJwGP2wap7lT7eF8ta2Dp9lYfKCawyYiPJUHSDXAaUUMzglxNnFN3NshhzqRE7S1ku+IG/xNtPyQnhVlS1MMmtXwxCL7A6h5Gs0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981555; c=relaxed/simple;
	bh=tnmAHraBz7DXql2Dep8p38gxiS23TG/acX3oHeeHkUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMmbFec+Dar/2zOU/ayitjOGn82d2z46g5OOJW6XcdTdo6pDLr0u9prLpPShNwSDi5Yz1r69KBO1ehOUTKlKy5rzXK37tmmvYaoo9E2GNjYXXZH5GkWD9nUfoJglMohPqktoV/efAXd+Ulhv32BhgPc6K7OUPRJvPO4TaWP03YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EQlzWIm7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c4JQPPMV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EQlzWIm7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c4JQPPMV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6BFD21A6B;
	Tue, 10 Sep 2024 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Efz77gXm529lOs44OVX4rlEWpjKnY8UZXJfvqeInf1I=;
	b=EQlzWIm7eqMXMcynOZO9Tt0Ofp8E+hwJy5IYLnWhczjn2F5Hat9aunxC27s/XWFSO3CjWU
	0eA8KRoNme3BfVOpK7DvBUwfgwPYmX40exMRqLkZsuupH8ycIi5NKeNsMaZ6B+Os/TuzUx
	4Jh55cxXamAGfev8VKV29ImfpjFS8ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Efz77gXm529lOs44OVX4rlEWpjKnY8UZXJfvqeInf1I=;
	b=c4JQPPMVYIyAKUAhicop1mVx6RZ3zKA2sDz8aCugjEFxOicLXsgtnNuE9Uvvo1fC15dgzB
	iRE0eH65g8GIJtDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Efz77gXm529lOs44OVX4rlEWpjKnY8UZXJfvqeInf1I=;
	b=EQlzWIm7eqMXMcynOZO9Tt0Ofp8E+hwJy5IYLnWhczjn2F5Hat9aunxC27s/XWFSO3CjWU
	0eA8KRoNme3BfVOpK7DvBUwfgwPYmX40exMRqLkZsuupH8ycIi5NKeNsMaZ6B+Os/TuzUx
	4Jh55cxXamAGfev8VKV29ImfpjFS8ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Efz77gXm529lOs44OVX4rlEWpjKnY8UZXJfvqeInf1I=;
	b=c4JQPPMVYIyAKUAhicop1mVx6RZ3zKA2sDz8aCugjEFxOicLXsgtnNuE9Uvvo1fC15dgzB
	iRE0eH65g8GIJtDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF52513A3A;
	Tue, 10 Sep 2024 15:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iCTsL25j4GaxQgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 10 Sep 2024 15:19:10 +0000
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
Subject: [PATCH v2 -next 02/11] dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
Date: Tue, 10 Sep 2024 18:18:36 +0300
Message-ID: <20240910151845.17308-3-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910151845.17308-1-svarbanov@suse.de>
References: <20240910151845.17308-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.30
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

Update brcmstb PCIe controller bindings with bcm2712 compatible
and add new resets.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 0925c520195a..8517dd9510ef 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - brcm,bcm2711-pcie # The Raspberry Pi 4
+          - brcm,bcm2712-pcie # Raspberry Pi 5
           - brcm,bcm4908-pcie
           - brcm,bcm7211-pcie # Broadcom STB version of RPi4
           - brcm,bcm7216-pcie # Broadcom 7216 Arm
@@ -158,7 +159,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: brcm,bcm7712-pcie
+            enum:
+              - brcm,bcm7712-pcie
+              - brcm,bcm2712-pcie
     then:
       properties:
         resets:
-- 
2.35.3


