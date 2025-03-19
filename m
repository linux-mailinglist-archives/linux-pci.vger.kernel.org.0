Return-Path: <linux-pci+bounces-24184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57772A69B82
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 22:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6960982A4F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 21:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35E1221D9E;
	Wed, 19 Mar 2025 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P5V1HG+u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A778421B9DF
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421105; cv=none; b=LEUKWTZAyyo+qb4EMbjnLKMghTO0gHq7+t70oS85QuJSdDLsQd1cInavd2k/+OJJB6FU9BN2IFWt51GP0mUKcXa2xBJxWbKKTHMqvmUkRsUE+/8eZlCprw9I0NZ702Hl+Dl8Egx5l1RL6ScgWBOgLkEydoIjOdyUxJp6dxg8qVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421105; c=relaxed/simple;
	bh=ZHGs6I7q3Tsyi9kzoh4U5cxC19XY6HnWZ9uwmmvUT2Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ro5IAkdTt7UF/ZJEWecDm1fPuR0SXoLSTCSUn2EJ+ZOrZ6tMB+tTqoXpiqRLPEeNWMVaaVu/dPtVn7XIShWEE0W6FvQAYN10dEsrXo8r8ptWOIoYxzQOWzuu3NN9e3w7pOwD143p+CAn+uYZ6doVmHZKe62VWI6ltVseUZzTvxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P5V1HG+u; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaeec07b705so24743066b.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 14:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742421100; x=1743025900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hon0A+RaNlvqPfqyKNkIXyr+XGvXZKWonIIqQqeswT0=;
        b=P5V1HG+ulPDbgraGKjpTHEUqniY1hrRZcEWRfY5LXZCbLbV1qm1sJs9Z+YUkaW7OLW
         Wo4HnKDwoRzDrNNL7XHWZnjSJ4726aJfMsGKc9rQDK89HH6rW+oAGqycuujxOAeMJoNB
         clSXIA5VC1S0ZcR+quBpJef8B4mTb3PQuUouXFfB1X/raCnWP7esAUa1GkPL2xB3sSTs
         DD4waHVdpUreOlQfYAaEPDSUWi87WnmmywL8R+lT1cV19iBx1sSx8BtTjQQ61xm/mWoA
         LvS+f65F9K+ghEt2BA1HaLbLKhXAbVdZbyTIiuz7HuDwscIJm2NuesiE4A9DUoIXgSJ/
         acag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421100; x=1743025900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hon0A+RaNlvqPfqyKNkIXyr+XGvXZKWonIIqQqeswT0=;
        b=GMD52WbxFRXZwbQ8EVQSWAK+oYUhHcPV7iARvCY5H2np4f/7IojenT2LSYJbBo2NQB
         eHcuQp1+/szGqPEdA/OEXAMMTjWfACv/aqENAm1/G61ngxIyTLYq5B1xJkYT9A9P76A6
         LlqIdExYxMPU2OfF38OjdrLWi+vMWqGH7KuKCc2Q905d0n2Ijao//r3aJXZwnVXT1IFU
         KWULixicLEwR4xvlApDFptTE5XbtfRQ4ZAyNfNr+pW2YEJoPpMwV0UbMdoqkYSnMdr8T
         jkoA5y6poGhMSb95d1DpKpMpQVwLQfBVPxHAZNFVnJt1Q9KPIE8LXXwBFGFXFPWBOC78
         uCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+MMpCU+5cmRKP+uno4CrSlNC3xPObpbW70/5ctgksWgSCN/i42eL67GMgPWx4H7ZD5R899dp5fWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLI5URPQmH7aArFSTOXSf5DuJuDokrBia2ebyZBFeek007pCKG
	6fn0Ag2E0Y3g4koH3oWCpoE3GtBhodK5wHgFzBdOtL3ocYH+xkwYD2dZYIUvCGM=
X-Gm-Gg: ASbGncvej/vnAFbaBjStYs4/y0px+Hc182AD7/TYHU2V2keqOpDH4+gZlaM5X/Lp+Wc
	lEkK25kBWEWoSilwdeIuKMbK/DLDJbbdOytWYBnnVn7gUfYjTgbDf0gXA4YOKrAKvIJi4QHkQvv
	qPrHtfHtmhkv7rBuHrGgbtoi18K7C7BkrVEcPp0xDtSHPjin8W8LU+UFY5ToL2O35Ib7Ci86GUh
	mPlZqB/Yu97O3WlVBcWf7nBKjsvgYQzx1WfLPE4uHKTO4NchN5x9uZW7NC+Qm4baF9DOEtQEZNm
	i9nXXalfB5QI9HDPIw6a6MdEGECsrlBE29pXm3kp2b6gdWKC4odlwHxCZ9OxyOXRdPlIxNVLMJn
	JaX7SVm60tg==
X-Google-Smtp-Source: AGHT+IEubZjv6HNcMkLRF8KIKKnDt5E7yfE5umLCedVB6lCh54dmHwyuBtrf8bjfetPJOMQZhmUQZw==
X-Received: by 2002:a17:907:96a8:b0:ac1:e1da:8744 with SMTP id a640c23a62f3a-ac3b7ed0692mr400259166b.38.1742421099920;
        Wed, 19 Mar 2025 14:51:39 -0700 (PDT)
Received: from localhost (host-87-4-238-14.retail.telecomitalia.it. [87.4.238.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149ced82sm1045348366b.123.2025.03.19.14.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:51:39 -0700 (PDT)
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
	kernel-list@raspberrypi.com
Subject: [PATCH v8 13/13] arm64: defconfig: Enable OF_OVERLAY option
Date: Wed, 19 Mar 2025 22:52:34 +0100
Message-ID: <9d5b41bf6d1565f0de96c7c1680bd404cba40189.1742418429.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1742418429.git.andrea.porta@suse.com>
References: <cover.1742418429.git.andrea.porta@suse.com>
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
---
The following metrics should help to decide whether this patch is
acceptable or not. The defconfig kernel with CONFIG_OF_OVERLAY=y
added (wrt to the defconfig one without that set) has:

- same uncompressed kernel image size (due to ELF section alignment I guess)

- ~7Kb bigger Image.gz

- 3 new modules (all related to RP1, i.e.: clk-rp1, pinctrl-rp1 and rp1-pci)

- 27 added symbols, of which 5 exported
 
hoping this is enough to gather a rough idea of the impact.
Please note that OF_OVERLAY has to be defined in a way or another,
otherwise the RP1 driver won't work correctly in case the dtb overlay
embedded into the driver is used.
Another way would be to add a phony target to the arm64 makefile which
just add that config option to the target.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cc70793e97ef..ca492fbd2773 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1643,6 +1643,7 @@ CONFIG_FPGA_BRIDGE=m
 CONFIG_ALTERA_FREEZE_BRIDGE=m
 CONFIG_FPGA_REGION=m
 CONFIG_OF_FPGA_REGION=m
+CONFIG_OF_OVERLAY=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_MUX_GPIO=m
-- 
2.35.3


