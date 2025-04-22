Return-Path: <linux-pci+bounces-26433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9864A974E7
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 20:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC093189AFC6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 18:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5838929C347;
	Tue, 22 Apr 2025 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KuDvxyHy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C5929A3D3
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347940; cv=none; b=P3c3tICK/r791KZZGj31gr+PQi0Iac4r8unwH59Rin65h1tbljUR4N/EK5gjpsubCS8W3bF75J51BXQbHSWMJLrq/dMYw7Z2+ySxGMgMGMlC8qsxD5pY9aua5cocFmxdomQZo0m1vct/ODZeD6VMIcLt4X3yxdxp9mmXNWGVhdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347940; c=relaxed/simple;
	bh=1k1unQkkbNJWyNIqqzpizkZc3aIKLdvvcUxlVK4aZEM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1qrOZ6oFtwMkdIxVr+6hw9ikPLr57CZUTHsG7myJl/rPPPhwtQopj4NQbqWye6yonyX1ycSopu/B2BSyDHu3KNw8tySvGtk459D47+LpSuXswpirWmi996+u9ni6t7mEt2NrcAnu7Nqalw8ACJydHmPqL886HmHeKScOtsllmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KuDvxyHy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so3716489f8f.2
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745347935; x=1745952735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADsz4nM5zt5mk0SaIqSNaWehe790A/IESs0jsUHL+uk=;
        b=KuDvxyHyGrC25lEjuJl0sHhcCvZF/pF3czD68drf8To7cQccp2Y8qxi3RM0ChZwcqX
         NbVxTb518ACxsReOslqkprpiBHaHOsJ8IdMQTCRFEV963Ovpcki1WXdbPdsJohoN2OaC
         DdHN2FholbvCNcoeBTvuMjkjOshdifxbF5wOtUb4xrs4i7LW5nrDHyYm3+H8uo/1UK3R
         t0mskDWsLu/XNkDzlLEQfHxAoLRN8rqABMX3JXLWx81j8DkSdtZVUAXKY/eYCtcAODTV
         Na/ivldAIglcA0uzm1Yo6rn9BUBgEVJ6BV7RqnMUXGgkFTqOb49hZ6SdHUNbe0dfMVTC
         M5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745347935; x=1745952735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADsz4nM5zt5mk0SaIqSNaWehe790A/IESs0jsUHL+uk=;
        b=N5ApmS7hKurQh5omn3mMPECyLizbGIUkUqRw/w7ROqBF+v0l9BjcKe4lhiSENRBChJ
         wCe4HEBrfW1T7szCLvNJV/hY/GkuCL9+bPx5SB7+KaOxZ+h7xuSKCQABFL47rRmuk3Dq
         eROkar5NQzK6RulWwTUIfYWwxPxiqa1cqHQ6tiotlOyRrD6z9ZPdXq7aANHPWBr7rNGD
         Vbo9HpVK5e3t3GgQTX/QeqChqPoYWvQCVs1D4L0vvdsnXdwL2SKqyUVMrQVZ3atitFsO
         PFnnCM6iph7x/z7lbBthJTk+yGDO1EEUShTElmIQ7L42nIOjHeW8iTYnqpL9YeVulUsS
         R2eA==
X-Forwarded-Encrypted: i=1; AJvYcCWYY2DHGQczivihaClkaDJdqBFQy9rNOXQ1xOF4HLzfDeXlJ57+2iZmX4lztznsFBmRys7iH9c9u1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcgwRQqtyk92S26f2hQQZUFl9/wJVw/T4pinl51dLAAS5iiyhy
	DLZdSbJhfjp2AUDJQqgJulFpfOnMn19IdGCwlWNevaGTcAmc/6fqsdoxBPwOIHA=
X-Gm-Gg: ASbGncs8ep9zq916V1mj10t+q+jG0LvHIvOZbKtNAkWgHN4Cpo5M6eVlu/lag3QnhFN
	XncJ+A2zbdE2CzPCiBV7Aqn1LtGCrYRNvNAVrI4k2KycR7Zfp/Y8eHjpq9Kw5k3NUbBNnQQFmcb
	DK0JPccpdoc3oJj9lgTccXJmJuR/LI4JXyGXVX/KWUfKSjwsUIz/TGr1LV3E7yTI6wwkweGKxlc
	qKjBDgt6vKQzMdlPDeXdkGFUlIVbONEMLYOn56CN9svd6zG1ZgVda4BTiuauv1sNeqrV6mAUAaZ
	HrRoGXn/EktO/vNG5qaRNvcU91o5ucMYM2Uk22OMThx35UdCerquBD14ANnn/gNTAb/q6oKYXri
	PvNyrZg==
X-Google-Smtp-Source: AGHT+IHaQWcyIld8HmOWqZEWQ8mfScJy5XfhH5TexVF3JHDuC1C8WH0PzZCZR43OQba1F6XglJkm3Q==
X-Received: by 2002:a5d:648d:0:b0:39c:141b:904a with SMTP id ffacd0b85a97d-39efba2ca27mr13013041f8f.11.1745347935584;
        Tue, 22 Apr 2025 11:52:15 -0700 (PDT)
Received: from localhost (93-44-188-26.ip98.fastwebnet.it. [93.44.188.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4207afsm16278846f8f.12.2025.04.22.11.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 11:52:15 -0700 (PDT)
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
Subject: [PATCH v9 -next 12/12] arm64: defconfig: Enable OF_OVERLAY option
Date: Tue, 22 Apr 2025 20:53:21 +0200
Message-ID: <8baf7818aae1fe5be046015e4bd8121ccc9acb20.1745347417.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1745347417.git.andrea.porta@suse.com>
References: <cover.1745347417.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RP1 driver uses the infrastructure enabled by OF_OVERLAY config
option. Enable that option in defconfig in order to produce a kernel
usable on RaspberryPi5 avoiding to enable it separately.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 53748ea4a5cb..23656b0bb7e0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1640,6 +1640,7 @@ CONFIG_FPGA_BRIDGE=m
 CONFIG_ALTERA_FREEZE_BRIDGE=m
 CONFIG_FPGA_REGION=m
 CONFIG_OF_FPGA_REGION=m
+CONFIG_OF_OVERLAY=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_MUX_GPIO=m
-- 
2.35.3


