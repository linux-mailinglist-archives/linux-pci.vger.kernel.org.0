Return-Path: <linux-pci+bounces-19113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE85D9FEE7B
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 10:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EB947A153C
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0941953BD;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quNSMcgx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59905191489;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735638254; cv=none; b=Y1c6SnKwfgfTghLRHINKULwnMahvKFgI0ykaXh8PNL2yAJPqYZi+Gi0HuUHbMfJcMBplm8FMv8QosdcDfzyTp54D7Ye70+vFC7SlT6CpKamSljW3cN2ttmxLe5a98MUCNu08tsAIp/VfaJXw8Ji85baegeJO+KJM1Stsm0iNl5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735638254; c=relaxed/simple;
	bh=EtKM6ndxdOTEv3Lg6SK1avX9h/VksamOyCmNxI9AcNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBae8/C4WpjTwqQxU2ih6V4Dda4C53d0jD6k9yVhySEt2qpGrBUzMEImCQDJVygQ6x4f/XO+0Gm95jqI19q1OJzV42FXqXIhSi3TV4laWWkyHq8OadAYnn0lnflMxGTA070NrrEjwAGagG76resh7e7J1A+56L02NdM7FNMynBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quNSMcgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1D64C4CEDD;
	Tue, 31 Dec 2024 09:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735638254;
	bh=EtKM6ndxdOTEv3Lg6SK1avX9h/VksamOyCmNxI9AcNU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=quNSMcgxiOtOJ188x/I+EJkt0rXpKxGIP+z/8Cxx5dX0iPn4zab6RsRU797akhLW6
	 k3kWfoa3hPqSeiIp0bo/af1TeacxZJmeWjn9q6zj7Z4QAnXxbN8Q14xe75+JY0RnQC
	 mR7ztg+moetsN9F4beFtR/HGpEUVSc2WRRTr2Mv3cj662y+GaIMoQqo3/J+d5/VXJE
	 eN6+EEYgXzyF8WQeoCuTjl4wMXKDkG8WW05u9fTMs49E9JI/FnBRGbHLMo88mlPj1n
	 lSJsYY8iipgEFtSTBr6Mi9OHHWGDziZ4PKOACKkiUkXs5eFiUelztUe6QOeElBIw5M
	 MVMV5pEqZYXqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC530E77194;
	Tue, 31 Dec 2024 09:44:13 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 31 Dec 2024 15:13:42 +0530
Subject: [PATCH v2 1/6] regulator: Guard of_regulator_bulk_get_all() with
 CONFIG_OF
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241231-pci-pwrctrl-slot-v2-1-6a15088ba541@linaro.org>
References: <20241231-pci-pwrctrl-slot-v2-0-6a15088ba541@linaro.org>
In-Reply-To: <20241231-pci-pwrctrl-slot-v2-0-6a15088ba541@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Qiang Yu <quic_qianyu@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2865;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=K+DYdieboNDk57dwVIEL7f2cQO+VTMxu2E7c8/n7Jlo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnc7zqTMNVJc/B8DvCcn2G3OvvaTAA8fnoqVLv0
 2ZwUIbqNt2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ3O86gAKCRBVnxHm/pHO
 9ZQhB/41JoxXANcG/9Tbc6G33jRxLNfoE/73Y3y9qigHsQ5X7/5RafygZfY4p79ClS3RIE5w4eB
 UahE3ASO8oYFZkN+sLicBX7NuVSe3qamxrcH0hWra+xz/D2BxAvJjXRDT5Mj1+I5HnWfI2kBETJ
 qmL/B6y7QOpDEfXftuWufkOA7NGj1ue4nKO6hn7ghLwoIqF4Or5XukrsFDR3zm8NSW74VuJ+vkq
 xbPXdIEvGXSW4+8MrCnEP+5uT7m7vQ86kknvDGcN654sYs1glDWOFOBnUKEJmnf2q/DwSAZtxHC
 nc+OapDZchATmfw/WgsZoztkd7yCskuTgSLQg0WEbuIXGwFV
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Since the definition is in drivers/regulator/of_regulator.c and compiled
only if CONFIG_OF is enabled, building the consumer driver without
CONFIG_OF and with CONFIG_REGULATOR will result in below build error:

ERROR: modpost: "of_regulator_bulk_get_all" [drivers/pci/pwrctrl/pci-pwrctl-slot.ko] undefined!

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412181640.12Iufkvd-lkp@intel.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 include/linux/regulator/consumer.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 8c3c372ad735..85be83c8fa17 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -175,6 +175,8 @@ struct regulator *__must_check of_regulator_get_optional(struct device *dev,
 struct regulator *__must_check devm_of_regulator_get_optional(struct device *dev,
 							      struct device_node *node,
 							      const char *id);
+int __must_check of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
+					   struct regulator_bulk_data **consumers);
 #else
 static inline struct regulator *__must_check of_regulator_get_optional(struct device *dev,
 								       struct device_node *node,
@@ -189,6 +191,13 @@ static inline struct regulator *__must_check devm_of_regulator_get_optional(stru
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
+					    struct regulator_bulk_data **consumers)
+{
+	return 0;
+}
+
 #endif
 
 int regulator_register_supply_alias(struct device *dev, const char *id,
@@ -223,8 +232,6 @@ int regulator_disable_deferred(struct regulator *regulator, int ms);
 
 int __must_check regulator_bulk_get(struct device *dev, int num_consumers,
 				    struct regulator_bulk_data *consumers);
-int __must_check of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
-					   struct regulator_bulk_data **consumers);
 int __must_check devm_regulator_bulk_get(struct device *dev, int num_consumers,
 					 struct regulator_bulk_data *consumers);
 void devm_regulator_bulk_put(struct regulator_bulk_data *consumers);
@@ -483,12 +490,6 @@ static inline int devm_regulator_bulk_get(struct device *dev, int num_consumers,
 	return 0;
 }
 
-static inline int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
-					    struct regulator_bulk_data **consumers)
-{
-	return 0;
-}
-
 static inline int devm_regulator_bulk_get_const(
 	struct device *dev, int num_consumers,
 	const struct regulator_bulk_data *in_consumers,

-- 
2.25.1



