Return-Path: <linux-pci+bounces-6305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397318A6331
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 07:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C6C28660B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 05:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F47B3C08D;
	Tue, 16 Apr 2024 05:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afmwVHJq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1AE3A1BF
	for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2024 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246180; cv=none; b=R0najniLuIsx4Z2h9uXcEDcQqQIkjZ1GSt1fjTfCim/4WjrqtVemwAkITVed0ZwN2xI6bw1mma8nkplYcJONTWeXEvrqsd/i3shBiRWZJFOkZvnwqOMSFo1inm9aPwAy1eMiKGshv+1UY61pAYgswB8fUULmVJytt8Eu4GFVwkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246180; c=relaxed/simple;
	bh=YzcwzdZL4XKreo1CF3wbVR5j3L/jHhRL6gcOR16pIWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eXZXlRYALEHqiAo1ZyiB/CLydzXa7EsujG1NFXMBInemY9QYg8GxihlS9lQN6PcJ3aSctFsbV9YJ29mhQ6537DrxG4XiNdZls8YWjQrjM4xdc+B9za4LkOGQ9H9MUAMx602W+Qf1F260u6s4hlokhnOLY/wuT6LnvmVjGl2g7Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=afmwVHJq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so3568830b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 22:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713246177; x=1713850977; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3zTEkiG2nqHLpygf92sT5A2vKJ1K17V0uKLVPKWPqc=;
        b=afmwVHJq6P4RkXfLxRHYIyMImrFVEOFBftD0voKWUkTgdOst3JyWVUB475Kaa5pr/d
         eZ4o47yjeQ8mbk7q5ycqTKIi2orccszgKUmPFySedt8pIyFphCBKVX3+JWjVPtbnoPBF
         JDXn9ZA4w+329jq0Ba9l1/TKglCAEe71ZZcsUEj0cCI2q2H3VELHwnDe0N9lQJ/OsPpO
         lv/ZHXzZCdJ9Mc1oLlbDmh91DIAW+CvTfSbhP/buyOVoL57bSY6s/m4H4kiDDOANlI/a
         3KzTWkFdE+9dFEK46j9110q3218wWETI4mU8Njfr51hheFZLB8rNEHCE80cA6fMsyRk1
         VCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713246177; x=1713850977;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3zTEkiG2nqHLpygf92sT5A2vKJ1K17V0uKLVPKWPqc=;
        b=HVCiFLEkpSpWtVSuKl450SY7K8DnkYIkhrYjp0tNMn0ER/cUxcjCB0l9vUDLW9jqpd
         ZFhEx/dVISa+ykh6JIdLFEgFHqzIGV6+RWonL5z74Xy/0IWY3ZcoKwcpQuOwZu2Az5S2
         E+NIATvcWSH1KrLOaMLAyK+OHlFLsydEl46NcqpXHzXty4cgmbJUHFuFA7LIBR9pp9M7
         AJX4Y/IauI/41asnShF/Uc8ErMwJIWQk+QIL7pQEZVjJ8Yu/vhq8CvediB+p3kvp7g4Z
         9iOCAuB5tJeBvpbeNmL07nDlZcGja4xkexTwxPshzU+Lr9jhySAhZNDgRBfDuzKVrocH
         W7Bg==
X-Gm-Message-State: AOJu0YyghsD00ioX0peIZNA9aeo4I42cCg22/8wP3+iCvgMMeMcUx/Kj
	5iN9nPjhOiq/RK2obyw7qvaSAGkU5UF9i/nOkNqBY8Y548EGD2Wz6XepXU1EZg==
X-Google-Smtp-Source: AGHT+IHmL5CGk/C9YY3eQgCl7Y3aehKD10gTha3MpE92TAHps4Lx1+7Q4FtBizYCJM5LHup7vD1Aeg==
X-Received: by 2002:a05:6a00:1945:b0:6ea:f4ad:7298 with SMTP id s5-20020a056a00194500b006eaf4ad7298mr16195085pfk.34.1713246177243;
        Mon, 15 Apr 2024 22:42:57 -0700 (PDT)
Received: from [127.0.1.1] ([103.28.246.221])
        by smtp.gmail.com with ESMTPSA id jw9-20020a056a00928900b006ece7862035sm8096651pfb.128.2024.04.15.22.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 22:42:56 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 16 Apr 2024 11:12:35 +0530
Subject: [PATCH] PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting
 ep_gpio
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-pci-rockchip-perst-fix-v1-1-4800b1d4d954@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMoPHmYC/x2MQQqAMAzAviI9W3BFxvQr4kFq1SLo6EQE2d8dH
 hNIXkhiKgn66gWTW5OeRwFXV8DbdKyCOhcGaqhtWucxsqKdvPOmEaNYunDRB0PgjsiTm7sJShx
 Niv7Hw5jzB1Ks2+JoAAAA
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Heiko Stuebner <heiko@sntech.de>, Brian Norris <briannorris@chromium.org>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 mhi@lists.linux.dev, stable@vger.kernel.org, 
 Slark Xiao <slark_xiao@163.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3420;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=YzcwzdZL4XKreo1CF3wbVR5j3L/jHhRL6gcOR16pIWc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmHg/crzU1Kkb1i9AqXVJ3hRXBiUx9TkrzmPVOq
 mUTZO2izYWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZh4P3AAKCRBVnxHm/pHO
 9fTRCACK8wHhlIy/kLvZHbQzhc/EFgpLhGxBwGkKpiC9xOYMycx6mQuk8X1lpK2goCoKljGgktY
 e/Ti3YO9R2ntH5ycJCk/FK/xMY1wZffrkZYUg6QKtEvZoa/kWnzAIk+Vt9bagTtP++dRzu4C7bq
 0Zgccetk3ERl1hzVhTluvHGB1AEHOCgCIyQTOS31v3gy2QmRLo4zDLQULZvtm6X0fNDJNQ2qlsW
 ftcyIPvXBVxIDlkQsY8t5m23kXP/PeVhPhIn/bvbB2rJ5g4Tsr15A3RwqVuSKt9C6V89PogwlGn
 qFNOcL9t95ugWM11fE3JxyLL309ww7DJvfLnqgnK8zPZDpqZ
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Rockchip platforms use 'GPIO_ACTIVE_HIGH' flag in the devicetree definition
for ep_gpio. This means, whatever the logical value set by the driver for
the ep_gpio, physical line will output the same logic level.

For instance,

	gpiod_set_value_cansleep(rockchip->ep_gpio, 0); --> Level low
	gpiod_set_value_cansleep(rockchip->ep_gpio, 1); --> Level high

But while requesting the ep_gpio, GPIOD_OUT_HIGH flag is currently used.
Now, this also causes the physical line to output 'high' creating trouble
for endpoint devices during host reboot.

When host reboot happens, the ep_gpio will initially output 'low' due to
the GPIO getting reset to its POR value. Then during host controller probe,
it will output 'high' due to GPIOD_OUT_HIGH flag. Then during
rockchip_pcie_host_init_port(), it will first output 'low' and then 'high'
indicating the completion of controller initialization.

On the endpoint side, each output 'low' of ep_gpio is accounted for PERST#
assert and 'high' for PERST# deassert. With the above mentioned flow during
host reboot, endpoint will witness below state changes for PERST#:

	(1) PERST# assert - GPIO POR state
	(2) PERST# deassert - GPIOD_OUT_HIGH while requesting GPIO
	(3) PERST# assert - rockchip_pcie_host_init_port()
	(4) PERST# deassert - rockchip_pcie_host_init_port()

Now the time interval between (2) and (3) is very short as both happen
during the driver probe(), and this results in a race in the endpoint.
Because, before completing the PERST# deassertion in (2), endpoint got
another PERST# assert in (3).

A proper way to fix this issue is to change the GPIOD_OUT_HIGH flag in (2)
to GPIOD_OUT_LOW. Because the usual convention is to request the GPIO with
a state corresponding to its 'initial/default' value and let the driver
change the state of the GPIO when required.

As per that, the ep_gpio should be requested with GPIOD_OUT_LOW as it
corresponds to the POR value of '0' (PERST# assert in the endpoint). Then
the driver can change the state of the ep_gpio later in
rockchip_pcie_host_init_port() as per the initialization sequence.

This fixes the firmware crash issue in Qcom based modems connected to
Rockpro64 based board.

Cc:  <stable@vger.kernel.org> # 4.9
Reported-by: Slark Xiao <slark_xiao@163.com>
Closes: https://lore.kernel.org/mhi/20240402045647.GG2933@thinkpad/
Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pcie-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0ef2e622d36e..c07d7129f1c7 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -121,7 +121,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 
 	if (rockchip->is_rc) {
 		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
-							    GPIOD_OUT_HIGH);
+							    GPIOD_OUT_LOW);
 		if (IS_ERR(rockchip->ep_gpio))
 			return dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
 					     "failed to get ep GPIO\n");

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240416-pci-rockchip-perst-fix-88c922621d9a

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


