Return-Path: <linux-pci+bounces-17028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9459D0A34
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 08:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289A728225A
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5519514BFA2;
	Mon, 18 Nov 2024 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="f3oZ9P4T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36B14BF8F
	for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731914989; cv=none; b=Gk6HMrPayP4jTPE+v4Ge5xZfJueJHBKK0GP6rR7ttHTLVuwka9CjxKwkMUVoX+pwboKXzA0BT+AQWRGrc+1x4FJeHuVTL/qIssYd6H1Fbyo9gnQYiA+lKJ17sgCB3obXxzGpH/Knw6UIWLwZVDwaeZf778hPtL3RAHRz9XqVZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731914989; c=relaxed/simple;
	bh=H9LQQX3+errApdP89llWL2h0g9xMJY3eOit1C3k3VPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KrKJ75jUdIcKSisb9tktBkWOwJ4Kabc3Rt30ZJXAsyBU4sMbVKQAAODTzFes69yWhP2aG238t7h8N/tCHV/njyRLqljiAfchDPcnX9RqpHw2cbnZ7J6YJyS8wa8rqEWz95DGVT/6c5o+3DGr+zDkygMZvnP4BU88c7xFQZH7Zsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=f3oZ9P4T; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=hpvNWCyCojrkvY
	du6o2rWrPDcX4yyavTS3Qt2myCoUo=; b=f3oZ9P4TdOlRmdKNkheJwEcz4/4MKC
	E+us1Y0Z5G/c0MS+Bz6Y92iZAVSu6gh8I2EHNZnsE4vvnM1IEBU4jw0BJ7jBK/23
	ZOZQ4RJ2AcAdG3Fo/aXZB9caknqWoqjSSmuy/JraNtaDb8tIiDJKRDaiRhkY0XkA
	7uTdsdNMuXZYeAsP3CdBbf4AhdYfGmUY5qgfm3fYIZ2/IzEDR4qK0/w+urqiJ5wP
	VkQidxTC4V72CV9fMrJrQhUtcLb2vyrTsDKAGJ7/HUe7z6Sm4E5RVmqvrVAL3k93
	lE86wQvmOS98Rttic76V8vKZ0HEY2F4KmUzwsfyyatEqffHmbpqiBuog==
Received: (qmail 112200 invoked from network); 18 Nov 2024 08:29:34 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 08:29:34 +0100
X-UD-Smtp-Session: l3s3148p1@ykLZ4ConvNUujntT
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Chen-Yu Tsai <wens@csie.org>,
	coresight@lists.linaro.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Len Brown <len.brown@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-usb@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	platform-driver-x86@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Sean Young <sean@mess.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	x86@kernel.org
Subject: [PATCH 00/15] treewide: don't include 'pm_wakeup.h' directly
Date: Mon, 18 Nov 2024 08:28:59 +0100
Message-Id: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on the wakeup functionality of a RTC driver, I noticed
that we have a few occasions where 'pm_wakeup.h' gets included directly
despite the comment that it shouldn't be done. It doesn't build-break
because these files also include 'device.h' either directly or via some
indirection, mostly 'platform_device.h'. Still, respect the requirement
that 'pm_wakeup.h' shall only be included in 'device.h' and not
directly.

Based on 6.12-rc7. Build-bot is happy and there are no dependencies. I
suggest that each patch goes in via the relevant subsystem tree.

Thanks and happy hacking,

   Wolfram


Wolfram Sang (15):
  x86/platform/olpc-xo1-sci: don't include 'pm_wakeup.h' directly
  drivers core: don't include 'pm_wakeup.h' directly
  HID: google: don't include 'pm_wakeup.h' directly
  coresight: etm4x: don't include 'pm_wakeup.h' directly
  Input: spear-keyboard - don't include 'pm_wakeup.h' directly
  Input: sun4i-lradc-keys - don't include 'pm_wakeup.h' directly
  media: mceusb: don't include 'pm_wakeup.h' directly
  mmc: core: don't include 'pm_wakeup.h' directly
  net: phy: broadcom: don't include 'pm_wakeup.h' directly
  net: wwan: t7xx: don't include 'pm_wakeup.h' directly
  PCI: don't include 'pm_wakeup.h' directly
  platform/x86: quickstart: don't include 'pm_wakeup.h' directly
  rtc: brcmstb-waketimer: don't include 'pm_wakeup.h' directly
  usb: typec: tcpci_mt6370: don't include 'pm_wakeup.h' directly
  PM / Sleep: don't include 'pm_wakeup.h' directly

 arch/x86/platform/olpc/olpc-xo1-sci.c              | 1 -
 drivers/base/power/sysfs.c                         | 1 -
 drivers/hid/hid-google-hammer.c                    | 1 -
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 1 -
 drivers/input/keyboard/spear-keyboard.c            | 1 -
 drivers/input/keyboard/sun4i-lradc-keys.c          | 1 -
 drivers/media/rc/mceusb.c                          | 1 -
 drivers/mmc/core/core.c                            | 1 -
 drivers/mmc/core/host.c                            | 1 -
 drivers/net/phy/broadcom.c                         | 2 +-
 drivers/net/wwan/t7xx/t7xx_pci.c                   | 1 -
 drivers/pci/pci.c                                  | 1 -
 drivers/platform/x86/quickstart.c                  | 1 -
 drivers/rtc/rtc-brcmstb-waketimer.c                | 1 -
 drivers/usb/typec/tcpm/tcpci_mt6370.c              | 1 -
 kernel/power/autosleep.c                           | 1 -
 16 files changed, 1 insertion(+), 16 deletions(-)

-- 
2.39.2


