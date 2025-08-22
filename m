Return-Path: <linux-pci+bounces-34563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEFDB31AC0
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1847BBEE5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6663054E7;
	Fri, 22 Aug 2025 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="d2Qxbrrb"
X-Original-To: linux-pci@vger.kernel.org
Received: from 5.mo533.mail-out.ovh.net (5.mo533.mail-out.ovh.net [54.36.140.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3F3054DE
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871599; cv=none; b=gk0E1liWvaERhMrKUpXY4IX8MMyyqECNlpDpFviICzX/dEKYj+tuFAh7XZ8rtYunvrhT87C9U99syKjb2Jn6F+Qad6CA/x+lFNQdyAHEEYk7RXcL4Wt7iZFRHjiC34Z29RCbm5R+qi4eL2tsKyapSSL7qWOsg3HzQavoVz+DhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871599; c=relaxed/simple;
	bh=Qbb/epaf7fqKy6B1p0XkqBoYHHqp4Kz/aBUdu96ueDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hDPLaj4EUvTvWXdXdmF47ipRxzgJE1EUPOEtuQOh2gz79ywWQ/o3uqE3YBw/+5xa5cyWL0v+RI2DQalTePigtorl1WW9Rj8eH+uyq/UxQJwSl0FvfpRhlkMf802UoTt7eKWtfMaJX626n6fuqyc59XX570AMN+ULwO88nKaXnbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=d2Qxbrrb; arc=none smtp.client-ip=54.36.140.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4c7hc82q6Fz5x9N;
	Fri, 22 Aug 2025 13:58:32 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Fri, 22 Aug 2025 13:58:32 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.178.149])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c7hc81BlFz1xng;
	Fri, 22 Aug 2025 13:58:32 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.4])
	by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id B71493E32CF;
	Fri, 22 Aug 2025 13:58:30 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-95G001c22d9f73-ec1f-49ce-9199-0c9084c0de17,
                    ADC0680FE15BB91110492B9A34CE42AA242C155A) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:147.156.42.5
From: Marcos Del Sol Vives <marcos@orca.pet>
To: linux-kernel@vger.kernel.org
Cc: Marcos Del Sol Vives <marcos@orca.pet>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 0/3] Introduce support for Vortex GPIO pins
Date: Fri, 22 Aug 2025 15:58:10 +0200
Message-Id: <20250822135816.739582-1-marcos@orca.pet>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8613134289362769510
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrrhgtohhsucffvghlucfuohhlucggihhvvghsuceomhgrrhgtohhssehorhgtrgdrphgvtheqnecuggftrfgrthhtvghrnhepgffhgfefvefghfetveevgffhleffjedvjeekieejgeeiuddvffetieejjeejgfegnecukfhppeduvdejrddtrddtrddupddugeejrdduheeirdegvddrheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepledprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrrhgtohhssehorhgtrgdrphgvthdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
 dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
DKIM-Signature: a=rsa-sha256; bh=XZ4yITvAsFyCu22AAADrQVM1VgCRSYKKdnUzs27X8JM=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755871112;
 v=1;
 b=d2QxbrrbVzs3o5PNO1C5U7BEmy3vPPLUl5lfEgu4U0gZzxA8A+4cAqWi9oOLmLB0ebtnjbCn
 Tgp4fmvcm3oSOD4NbGyAtKQiwOsnJPYxHIwmsWmzt/72AaObVHcz9Ts3IpWj4YEDloClbaGhyHr
 LhOIk1O0iWFe3qV4G24Mid5K5UlyLLekUcuL4KGxuctkErmgt0piZ3BzQsg/bXtdUZVRJ35qI0C
 k1yFRYOgRDuFsZgVt0LBMG3RVQ92TYtsR4H60dvA9BxGuHAxjOyVbxdjw+FmJf1QqxIvGuws+/7
 Hu15GYXr5jNXB2TKMb8jjMPX89xTp/zNrsmfjxMJ2ml2Q==

This series of patches add support for the GPIO pins exposed on the
southbridge most DM&P's Vortex86 SoCs, using a new GPIO driver plus a MFD
driver to automatically load the driver in supported platforms.

Supported SoCs are Vortex86SX/MX/MX+/DX/DX2/DX3, though I have only
personally tried with a MX and a DX3.

Marcos Del Sol Vives (3):
  gpio: gpio-regmap: add flag to set direction before value
  gpio: vortex: add new GPIO device driver
  mfd: vortex: implement new driver for Vortex southbridges

 MAINTAINERS                 |   6 ++
 drivers/gpio/Kconfig        |  13 +++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-regmap.c  |  17 +++-
 drivers/gpio/gpio-vortex.c  | 170 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig         |   9 ++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/vortex-sb.c     | 135 ++++++++++++++++++++++++++++
 include/linux/gpio/regmap.h |  19 ++++
 include/linux/pci_ids.h     |   3 +
 10 files changed, 373 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/gpio-vortex.c
 create mode 100644 drivers/mfd/vortex-sb.c

-- 
2.34.1


