Return-Path: <linux-pci+bounces-34448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664CEB2F52A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 12:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADD372768D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 10:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802D92F1FD2;
	Thu, 21 Aug 2025 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="WR8ZMqS1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout8.mo534.mail-out.ovh.net (smtpout8.mo534.mail-out.ovh.net [54.36.140.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE51224A06D;
	Thu, 21 Aug 2025 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771590; cv=none; b=GPNuxcGOK064iFQHV1aPNfKQa0gNys0u0sIxn40VuiuEX5z6c2bS11yUo0Lpa2HDOiM237118q+jMoUcMjvV3Pf5WPkMVtjmC4Na8RMan7Nr8BjOuZqdOzkRMw5asu0E+SmfjfdFFnEsf6mVwaq2HSXUxR8bWR1wj0pB0px7KEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771590; c=relaxed/simple;
	bh=tVlqvAOYw/pc2M/okavMfcc95C5J5uhGx4Bacy9kaio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tlbX44xxhGcUaN0/bqyRX6ew3ep6/RvrPIQJCqOwe6F23d1Nopkl60MXBi21+arI+Och687fiYkwjqpQ0Qj06KKzi8axmFhYkjRs+Wf2Yszf+QuiW7aykWNREoURum3ykwefcjZHuD9iQM75bV8RMEiRtjXKlqK8VTa7zCdr6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=WR8ZMqS1; arc=none smtp.client-ip=54.36.140.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c6zp35z2Nz6CNb;
	Thu, 21 Aug 2025 10:19:39 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Thu, 21 Aug 2025 10:19:39 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.0.122])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c6zp34tgwz1xnd;
	Thu, 21 Aug 2025 10:19:39 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.9])
	by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 8DBF7B832CC;
	Thu, 21 Aug 2025 10:19:38 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-97G00287c6276b-4378-4784-bda3-8ba47990026a,
                    684E78C7C579463DAB27E2CA1F9C4E28A39E1181) smtp.auth=marcos@orca.pet
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
Subject: [PATCH v3 1/3] gpio: gpio-regmap: add flags to control some behaviour
Date: Thu, 21 Aug 2025 12:18:57 +0200
Message-Id: <20250821101902.626329-2-marcos@orca.pet>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821101902.626329-1-marcos@orca.pet>
References: <20250821101902.626329-1-marcos@orca.pet>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17490573581666178662
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhgtohhsucffvghlucfuohhlucggihhvvghsuceomhgrrhgtohhssehorhgtrgdrphgvtheqnecuggftrfgrthhtvghrnhepudffudeutdejudeffeeugeehveevgfefiefgueejueejheevtefgtdffvddukeelnecukfhppeduvdejrddtrddtrddupddugeejrdduheeirdegvddrheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepledprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrrhgtohhssehorhgtrgdrphgvthdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdroh
 hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
DKIM-Signature: a=rsa-sha256; bh=mrCfxy0L2trdWCO+bWDn7qiJXiD9r/vRTGQ9erRpGx0=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755771580;
 v=1;
 b=WR8ZMqS1qLZJ9GzYPWVVG9JGmuEQamJCqa2dJGhKATv0yh/Xd6ilLFcnkE4JLWeYsKiL5D5/
 tNln0DbY/EvWmg6gFOOtxUtlp5MfRDEH5j7lFUsjmbnSP3oyAiPv/TLSIe7CnnY/y1QWAihGot6
 XqIeS8SuEv1VXJ9Ax2hInfFjFhEXt2Hr63jUZkK//EG/qdOHMw+Eh9Tb8hTgAQp+nDmiepkjnei
 Bv5+NGEjwFWIZdvWSwnFtpz5V7iYmo7yIGMNtbdvcJbGZZ6z3KKSFTZTMhXVbpId1JTU+nwqBi2
 6Hr6ncXPjql0lNqDiyhkDThD9CcFfOY8JfTJS94EG2aXw==

The Vortex86 family of SoCs need the direction set before the value, else
writes to the DATA ports are ignored.

This commit adds a new "flags" field plus a flag to change the default
behaviour, which is to set first the direction and then the value.

Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
---
 drivers/gpio/gpio-regmap.c  | 17 ++++++++++++++++-
 include/linux/gpio/regmap.h | 17 +++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index e8a32dfebdcb..24cefbd57637 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -31,6 +31,7 @@ struct gpio_regmap {
 	unsigned int reg_clr_base;
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
+	unsigned int flags;
 
 	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
 			      unsigned int offset, unsigned int *reg,
@@ -196,7 +197,20 @@ static int gpio_regmap_direction_input(struct gpio_chip *chip,
 static int gpio_regmap_direction_output(struct gpio_chip *chip,
 					unsigned int offset, int value)
 {
-	gpio_regmap_set(chip, offset, value);
+	struct gpio_regmap *gpio = gpiochip_get_data(chip);
+	int ret;
+
+	if (gpio->flags & GPIO_REGMAP_DIR_BEFORE_SET) {
+		ret = gpio_regmap_set_direction(chip, offset, true);
+		if (ret)
+			return ret;
+
+		return gpio_regmap_set(chip, offset, value);
+	}
+
+	ret = gpio_regmap_set(chip, offset, value);
+	if (ret)
+		return ret;
 
 	return gpio_regmap_set_direction(chip, offset, true);
 }
@@ -247,6 +261,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	gpio->reg_clr_base = config->reg_clr_base;
 	gpio->reg_dir_in_base = config->reg_dir_in_base;
 	gpio->reg_dir_out_base = config->reg_dir_out_base;
+	gpio->flags = config->flags;
 
 	chip = &gpio->gpio_chip;
 	chip->parent = config->parent;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index c722c67668c6..aea107e71fec 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -12,6 +12,20 @@ struct regmap;
 #define GPIO_REGMAP_ADDR_ZERO ((unsigned int)(-1))
 #define GPIO_REGMAP_ADDR(addr) ((addr) ? : GPIO_REGMAP_ADDR_ZERO)
 
+
+/**
+ * enum gpio_regmap_flags - flags to control GPIO operation
+ */
+enum gpio_regmap_flags {
+	/**
+	 * @GPIO_REGMAP_DIR_BEFORE_SET: when setting a pin as an output, set
+	 * its direction before the value. The output value will be undefined
+	 * for a short time which may have unwanted side effects, but some
+	 * hardware requires this.
+	 */
+	GPIO_REGMAP_DIR_BEFORE_SET	= BIT(0),
+};
+
 /**
  * struct gpio_regmap_config - Description of a generic regmap gpio_chip.
  * @parent:		The parent device
@@ -23,6 +37,8 @@ struct regmap;
  *			If not given, the name of the device is used.
  * @ngpio:		(Optional) Number of GPIOs
  * @names:		(Optional) Array of names for gpios
+ * @flags:		(Optional) A bitmask of flags from
+ * 			&enum gpio_regmap_flags
  * @reg_dat_base:	(Optional) (in) register base address
  * @reg_set_base:	(Optional) set register base address
  * @reg_clr_base:	(Optional) clear register base address
@@ -68,6 +84,7 @@ struct gpio_regmap_config {
 	const char *label;
 	int ngpio;
 	const char *const *names;
+	unsigned int flags;
 
 	unsigned int reg_dat_base;
 	unsigned int reg_set_base;
-- 
2.34.1


