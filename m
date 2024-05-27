Return-Path: <linux-pci+bounces-7875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF088D0846
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430751C2288D
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E8016D9A6;
	Mon, 27 May 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F4h6G8/A"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518EA16D333;
	Mon, 27 May 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826526; cv=none; b=SG83cYDsBvEWduOPGR8V4NkbLUXZlV+Vqrmhk2Gj9ZL/TIFsc0aCTb8O047m0Na6z0lSqTWEwz61vVr+qtXJSevauR2bAU2V03FaC3oQa8fOF13DalVsQA9yIvrttiSaLDpIeaJTEJhieguT+q9Ia9+6AwTJvmLojpt+PrafXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826526; c=relaxed/simple;
	bh=47UWH4KURJgUJfA5++HvyM/XP+Ig032FdKBU4JWD2mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zf30hbe5d/bdlosa1JLgG19wzdrV/4KlgcMUBsfBhyntHdYog6JksybEVQKAoZloivMNimuxIjaiP3iSQN463oSVva/IbkzR2tJ+SYKD5w+UNVXWIMMCSBCYHfXYZ7nLDqM1wH7/68zRvI+Lcre4yg5xMf4Sh7nOYcNEhfd+aa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F4h6G8/A; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 3EA1DFF80F;
	Mon, 27 May 2024 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mF8W0q33/WLkH7WVZ32ffP/0R0KTagxfDzA1SpJMHeE=;
	b=F4h6G8/AlLbVnFnZ5vKQPhDJdVvmTWCmZGLDBNDnIIq3lB3QnQZFz/my78gSgZ9BHAFa43
	Ml1Il0+9vCqn1iLh7jgMukY7Q+Cp6xI1wZV0vllvxhPcTaNTBzO0wiTZWLUZnMAftkWPd4
	sacXvNPipctbZCxUQgcCMijue3RtJQ/8b7ta04+kylDMtPNpgSFeqghxRNHTgay6wjEKYd
	vApo00aynnlhxHy2rzNzLXW9qaQxzhm59P0u+3p6fyNqhvLfOXSOF1cxt0ju058mHRISce
	pMl/w15TJv15xlBVbDgKhVM1j4br6z4AwNU/OmGyJEUBiA66LPgwGJ8hJNtpbw==
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 14/19] of: unittest: Add tests for changeset properties adding
Date: Mon, 27 May 2024 18:14:41 +0200
Message-ID: <20240527161450.326615-15-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240527161450.326615-1-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

No test cases are present to test the of_changes_add_prop_*() function
family.

Add a new test to fill this lack.
Functions tested are:
  - of_changes_add_prop_string()
  - of_changes_add_prop_string_array()
  - of_changeset_add_prop_u32()
  - of_changeset_add_prop_u32_array()

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/unittest.c | 155 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 445ad13dab98..f8edc96db680 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -917,6 +917,160 @@ static void __init of_unittest_changeset(void)
 #endif
 }
 
+static void __init __maybe_unused changeset_check_string(struct device_node *np,
+							 const char *prop_name,
+							 const char *expected_str)
+{
+	const char *str;
+	int ret;
+
+	ret = of_property_read_string(np, prop_name, &str);
+	if (unittest(ret == 0, "failed to read %s\n", prop_name))
+		return;
+
+	unittest(strcmp(str, expected_str) == 0,
+		 "%s value mismatch (read '%s', exp '%s')\n",
+		 prop_name, str, expected_str);
+}
+
+static void __init __maybe_unused changeset_check_string_array(struct device_node *np,
+							       const char *prop_name,
+							       const char * const *expected_array,
+							       unsigned int count)
+{
+	const char *str;
+	unsigned int i;
+	int ret;
+	int cnt;
+
+	cnt = of_property_count_strings(np, prop_name);
+	if (unittest(cnt >= 0, "failed to get %s count\n", prop_name))
+		return;
+
+	if (unittest(cnt == count,
+		     "%s count mismatch (read %d, exp %u)\n",
+		     prop_name, cnt, count))
+		return;
+
+	for (i = 0; i < count; i++) {
+		ret = of_property_read_string_index(np, prop_name, i, &str);
+		if (unittest(ret == 0, "failed to read %s[%d]\n", prop_name, i))
+			continue;
+
+		unittest(strcmp(str, expected_array[i]) == 0,
+			 "%s[%d] value mismatch (read '%s', exp '%s')\n",
+			 prop_name, i, str, expected_array[i]);
+	}
+}
+
+static void __init __maybe_unused changeset_check_u32(struct device_node *np,
+						      const char *prop_name,
+						      u32 expected_u32)
+{
+	u32 val32;
+	int ret;
+
+	ret = of_property_read_u32(np, prop_name, &val32);
+	if (unittest(ret == 0, "failed to read %s\n", prop_name))
+		return;
+
+	unittest(val32 == expected_u32,
+		 "%s value mismatch (read '%u', exp '%u')\n",
+		 prop_name, val32, expected_u32);
+}
+
+static void __init __maybe_unused changeset_check_u32_array(struct device_node *np,
+							    const char *prop_name,
+							    const u32 *expected_array,
+							    unsigned int count)
+{
+	unsigned int i;
+	u32 val32;
+	int ret;
+	int cnt;
+
+	cnt = of_property_count_u32_elems(np, prop_name);
+	if (unittest(cnt >= 0, "failed to get %s count\n", prop_name))
+		return;
+
+	if (unittest(cnt == count,
+		     "%s count mismatch (read %d, exp %u)\n",
+		     prop_name, cnt, count))
+		return;
+
+	for (i = 0; i < count; i++) {
+		ret = of_property_read_u32_index(np, prop_name, i, &val32);
+		if (unittest(ret == 0, "failed to read %s[%d]\n", prop_name, i))
+			continue;
+
+		unittest(val32 == expected_array[i],
+			 "%s[%d] value mismatch (read '%u', exp '%u')\n",
+			 prop_name, i, val32, expected_array[i]);
+	}
+}
+
+static void __init of_unittest_changeset_prop(void)
+{
+#ifdef CONFIG_OF_DYNAMIC
+	static const char * const str_array[] = { "abc", "defg", "hij" };
+	static const u32 u32_array[] = { 123, 4567, 89, 10, 11 };
+	struct device_node *nchangeset, *np;
+	struct of_changeset chgset;
+	int ret;
+
+	nchangeset = of_find_node_by_path("/testcase-data/changeset");
+	if (!nchangeset) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	of_changeset_init(&chgset);
+
+	np = of_changeset_create_node(&chgset, nchangeset, "test-prop");
+	if (unittest(np, "failed to create test-prop node\n"))
+		goto end_changeset_destroy;
+
+	ret = of_changeset_add_prop_string(&chgset, np, "prop-string", "abcde");
+	unittest(ret == 0, "failed to add prop-string\n");
+
+	ret = of_changeset_add_prop_string_array(&chgset, np, "prop-string-array",
+						 str_array, ARRAY_SIZE(str_array));
+	unittest(ret == 0, "failed to add prop-string-array\n");
+
+	ret = of_changeset_add_prop_u32(&chgset, np, "prop-u32", 1234);
+	unittest(ret == 0, "failed to add prop-u32\n");
+
+	ret = of_changeset_add_prop_u32_array(&chgset, np, "prop-u32-array",
+					      u32_array, ARRAY_SIZE(u32_array));
+	unittest(ret == 0, "failed to add prop-u32-array\n");
+
+	of_node_put(np);
+
+	ret = of_changeset_apply(&chgset);
+	if (unittest(ret == 0, "failed to apply changeset\n"))
+		goto end_changeset_destroy;
+
+	np = of_find_node_by_path("/testcase-data/changeset/test-prop");
+	if (unittest(np, "failed to find test-prop node\n"))
+		goto end_revert_changeset;
+
+	changeset_check_string(np, "prop-string", "abcde");
+	changeset_check_string_array(np, "prop-string-array", str_array, ARRAY_SIZE(str_array));
+	changeset_check_u32(np, "prop-u32", 1234);
+	changeset_check_u32_array(np, "prop-u32-array", u32_array, ARRAY_SIZE(u32_array));
+
+	of_node_put(np);
+
+end_revert_changeset:
+	ret = of_changeset_revert(&chgset);
+	unittest(ret == 0, "failed to revert changeset\n");
+
+end_changeset_destroy:
+	of_changeset_destroy(&chgset);
+	of_node_put(nchangeset);
+#endif
+}
+
 static void __init of_unittest_dma_get_max_cpu_address(void)
 {
 	struct device_node *np;
@@ -4101,6 +4255,7 @@ static int __init of_unittest(void)
 	of_unittest_property_string();
 	of_unittest_property_copy();
 	of_unittest_changeset();
+	of_unittest_changeset_prop();
 	of_unittest_parse_interrupts();
 	of_unittest_parse_interrupts_extended();
 	of_unittest_dma_get_max_cpu_address();
-- 
2.45.0


