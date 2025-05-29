Return-Path: <linux-pci+bounces-28639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130B2AC7E12
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 14:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469D1A254BC
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 12:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1A522F778;
	Thu, 29 May 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZS5zncOf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276ED22D789
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522570; cv=none; b=eNEnV2y6bwTeLCf18TiBfEJkxUmW3xWliLBaPh0ovqMsAixoAKnlktSBCNAxhf6GUGAZ4bNEPbUyunfZwWx25Fq6RG6PaYDwNhZVy5ytY1GhCBvq7tSNQCJ0iF4lQidyOQe2K9bvV6H5gcGc7SNvByYpgTuWnx7tSWkWp8uP9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522570; c=relaxed/simple;
	bh=Cxv3DdNSTbG6mkWW+XlQDzM5M3k//FCq7uG/9MGjWvM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGpP02HGy/ycZjf/GtDKKf9uLQU+IQj9+q/0c3d8OhamVX194ctbMOcABZCfvZOq4iKCp3vOcUh+DRU2VYaNenqaitP6gHHBG6grBt+1XoGg7ebwMSoiFSDORoAKPyAUMlG/vRwdc1tHQL7zGygf7CoSJHJ2GZaoBHoZD03rOBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZS5zncOf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60461fc88d7so1627740a12.0
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748522565; x=1749127365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8LMEHYmovrRN8zYWQwYy5+2ddqvSDMDQcnZraZcEHI=;
        b=ZS5zncOfC+K7c9w1dnbJRv6ieLVSoQAPrRkjhVg60LhgyGuVHQ7FO+jREy4JVcZsZf
         wUaohrPRRPCxex9EznSVNEWLE297C90KV73nVMKFqMaUoXwzqB8HYsvLOM2oQnZ42N0y
         6VvAp4BryHzZQRTqOPHh6aIIX/Kuue8Sx7e/m3GEhZrkHVMg4ABmRKtP8g20NBD8F1MG
         NmGmMZBi2Lc4wyI0g4kMyB3Z5QaVpDoORuJbmrAxi8lMGmRhAcjcyAzE91gPRfXIHVFE
         a7IMY9I+Z0xXgbWV5YLC3bWMRrX65sl2KAtNegTxnaabqfoVoM/fCPEjzxbOzP0NP+NR
         iR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748522565; x=1749127365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8LMEHYmovrRN8zYWQwYy5+2ddqvSDMDQcnZraZcEHI=;
        b=pD4Dj+VAaXyKLOt997Xynjl2Re7euSuch0UjKGW+fYc54NNXxpt2aGIU5WMZEiaWkB
         /TpM3ZpXpmsr1hJUZZPfyT6dDAOl4aaUzfOvmEHNR1IiKs0Ovq5DNXfHPrSS9Nn7uLtu
         xn4I4DqQ8Rb0MRfh2RQxdR0MTn8RobQRGFeTbaqZEVjAmky8ncF3FnZqNlFm9TTpINnf
         dqR1oecfaEdzhNZTW1g0tUb2HOlUSKp5FZSeHttTRuFN/NsALQiiaIvujVXevxdEvrPL
         Q8SCbO17ZOXDWLWs/JgfOpQ9tCX5b3X4dunBsyrERdKFHHnbSnzpR286l1pFALEzZMEa
         qZXg==
X-Forwarded-Encrypted: i=1; AJvYcCXrQkld6khpKHu7ObcpU/jDvkBzWqVLGfm9A+Y3iuW4vxopf/W5yVoND0CjAuz3W8dZ7hw0xv1Bj78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSwMTH2GrHuCMChMrhmwkmgvymM2D5e97YyckwEOWV5RoX0bY
	5yakHQSb4HtarqJnzAHN+7/nK1o+TV8KsJIRUMCNSBHuHE7R6MWfw5Aw/nHlMi6rZdw=
X-Gm-Gg: ASbGncsps3kMVbRjxubllL5z985Y94wLknOKFUstH3Ur4bpLfP42phmyep4pO5zeMqn
	jcb3DFxupbs7iDUGzw3SGgDomhvS+FpC/uXkTZBtF5tmJVta3MimwP99aAUVcI613A0CTI5JmAD
	T7LohXNc8cY/Z017E1lnKMVwUa3dGuQ2ApJb3/0Jd/T+oHHwdDMVRcZ7JLqKjL3kD0auAfzJgp2
	56bEQiISOLUXxMC1ZzeNgfGqqriFCIWnkHKivTGFoT19b6ZaqkAeLTnrGAzQbv+qT9BQIrMbUZQ
	cyxpQ2N+huak6y/YdV9InAe4K0+82bYbnmSUmwZOa288UohT9vww8hEK8kQdDpmJr95kpIkwkJQ
	up695QDfKR6E9nzBKAgPXicpTxkn9ksve
X-Google-Smtp-Source: AGHT+IGSKPwPkYLca5xt4DTsp41XrvIAXEH42/7GBMAHBHwSDsKU5tUb2elBTXwGWSigWuI5ixWpNw==
X-Received: by 2002:a17:907:72cb:b0:ad8:9909:20a3 with SMTP id a640c23a62f3a-ad8a1fcd782mr609032066b.43.1748522564992;
        Thu, 29 May 2025 05:42:44 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fed3dsm139572166b.12.2025.05.29.05.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 05:42:44 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com,
	Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v11 13/13] MAINTAINERS: add Raspberry Pi RP1 section
Date: Thu, 29 May 2025 14:44:02 +0200
Message-ID: <20250529124412.26311-8-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1748522349.git.andrea.porta@suse.com>
References: <cover.1748522349.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Raspberry Pi RP1 is a southbridge PCIe device which embeds several
peripherals.
Add a new section to cover the main RP1 driver, DTS and specific
subperipherals (such as clock and pinconf/pinmux/gpio controller).

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b16ba4eb1ce..2add073f5bdf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20197,6 +20197,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
 F:	drivers/media/platform/raspberrypi/rp1-cfe/
 
+RASPBERRY PI RP1 PCI DRIVER
+M:	Andrea della Porta <andrea.porta@suse.com>
+S:	Maintained
+F:	arch/arm64/boot/dts/broadcom/rp1*.dts*
+F:	drivers/clk/clk-rp1.c
+F:	drivers/misc/rp1/
+F:	drivers/pinctrl/pinctrl-rp1.c
+
 RC-CORE / LIRC FRAMEWORK
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
-- 
2.35.3


