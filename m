Return-Path: <linux-pci+bounces-19111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1239FEE75
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 10:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09AE1882C07
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900A4194A65;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMiUKz7l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5986618755C;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735638254; cv=none; b=d6O8phGX9AdJLs7IkgrkrpiykvYbEEir5HUEJr8JcS4EVQn15oHqFy3a1mg9CC0wbtVUvt9caXml8TIyMeXmDxada6nDhePzHD6H+NQVDjip8f9qOeLPw+QMdtfWSa8lCyaj6KGf8HmEUeyk4x+6imizSWf9RAvxUWe1QGGdGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735638254; c=relaxed/simple;
	bh=pJh5AXQbg+1t0rZcEXAK+EutSUZovxAeK8iPRrFkzhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYy4F65TFBeYCCM4LECT/afmNEwJPSdXATOOj8gKFLAGxq9CcMDco/lu5l+Bh0QL2oK9LoQR26DCphgEiLlJSW8kJ4vgSrYlBtro+7VyyyCFytgw/4GhR4Z3JvfcNanGsagvlVE2DeeToIwZvXFkn6H+jHXoeNQDRj2pywvveiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMiUKz7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07F0AC4AF0B;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735638254;
	bh=pJh5AXQbg+1t0rZcEXAK+EutSUZovxAeK8iPRrFkzhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BMiUKz7lisA2K0V+mD5cocp88f5HWquX6gKMKiG++4iBBGSNWzxFhuxSintp5mNnD
	 Hu4nleDkPJ0U4JiOdZO6v0C1bN7Hk52xleoLyTN/yK0NxM707pXddXI51/rPWtO/Wo
	 eVtLZmk3bGTfEPom6shJwhWAF3J6rHKgklViFCUJR9PcS7v9a63VBbGBGQUqhX1KhQ
	 13lIKq+cZ8ZO2e3mc4g8SW1Z/MPwkaiY7tsYx0lzcLXeN4ytM4WEVXY0ijx7w3OnEx
	 0l3XV68zfYrVX7vmOjF/HTISU4mg1FRIOkxaxmlRIZ2hA8Ex7w2ID82NhgaMgaKK/6
	 CRTWTryBKSKjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA88E7718B;
	Tue, 31 Dec 2024 09:44:13 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 31 Dec 2024 15:13:44 +0530
Subject: [PATCH v2 3/6] PCI/pwrctrl: Move pci_pwrctrl_unregister() to
 pci_destroy_dev()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241231-pci-pwrctrl-slot-v2-3-6a15088ba541@linaro.org>
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
 Lukas Wunner <lukas@wunner.de>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=R/h8mRffg4ftb0mSxAjhuMkQ2AXNpRy+KTjYeuy7GyY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnc7zqe/gxeg/v0jwc0tTdNPblhXylvQuh5P3pm
 uD8mA3Lzy2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ3O86gAKCRBVnxHm/pHO
 9Ym1B/4rWPv8lWQeEs4wVzLMvuKJ2+Bw9inpcseTx8Fp78JHx7SvU58LyUKncjTs5Zgql2CmBij
 TAjENRBZe4G/xUcAwFBxmbKUFB8beiO4YCV+Uar8NfEeQW4hb2zD83VRHJTHvglGxk48LI6kflQ
 +0Y1wGsOk42NLIAkimf/bhPZehhvTgiE1NRgFUH2LjjMJGqtzPtJ2N+QpqPVuQVUjJFqU5NMWok
 fpyP+ev3iDbwhZjjzJpspXbaYegoERYMcav0GZa31tq8WhYdm7en7AW492hNaS+JigrG5XDv1l1
 G2/RZRAuMZp/YLJkPFX2+5RMFima3rmybEt/boxIU0AbDNbB
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

PCI core will try to access the devices even after pci_stop_dev() for
things like Data Object Exchange (DOE), ASPM etc... So move
pci_pwrctrl_unregister() to the near end of pci_destroy_dev() to make sure
that the devices are powered down only after the PCI core is done with
them.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/remove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index efc37fcb73e2..58859f9d92f7 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -41,7 +41,6 @@ static void pci_stop_dev(struct pci_dev *dev)
 	if (!pci_dev_test_and_clear_added(dev))
 		return;
 
-	pci_pwrctrl_unregister(&dev->dev);
 	device_release_driver(&dev->dev);
 	pci_proc_detach_device(dev);
 	pci_remove_sysfs_dev_files(dev);
@@ -64,6 +63,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	pci_doe_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
 	pci_bridge_d3_update(dev);
+	pci_pwrctrl_unregister(&dev->dev);
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }

-- 
2.25.1



