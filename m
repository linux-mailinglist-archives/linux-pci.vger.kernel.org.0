Return-Path: <linux-pci+bounces-17102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0F99D3384
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 07:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383DF1F234CA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 06:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FD5157466;
	Wed, 20 Nov 2024 06:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8pD2CKA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934B156968
	for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732083914; cv=none; b=q+pt50kPm4SRSv58DBPW7Xaao6d8y4LBuGAE7KK9AlCGAfnyvZia7VmHmNsUVPtWM7m5cgT+41yvKepKR1peKxzXxj+606zyPFFUpsZYfRsUtdRBwgpcZg1KzQVTqMWc1dB/LdVENnSe1JQsQdVUM17zSXjON17Y2H1lh2k5QR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732083914; c=relaxed/simple;
	bh=ZKZ7wqRxV9VansX75u0xiTrAs0FThBNj2emfiSY9AOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DqaK7i43nVnwNj/Lyo6nvJGpO9rqYotmlSrBkzMkMOGuP5oIrghJC95T1l+9Jc1DGnSvImFX6/46r+HCkCquhDPiNMZzyNzdYihJU9VK4VIY1nCTA29zlAwR1BQVjRopEsrMJ6YesuwoGDHw2Af6iPYT7lUbdoJK+7XJ4oF8GoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U8pD2CKA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso16904985ad.2
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 22:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732083912; x=1732688712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFKz5oP575/GGKkSd/ejkrlLxXRfRJ0KjhmoJGqH3o8=;
        b=U8pD2CKA+IRPQapBKZS2zXFqCa+KEaOHEBp6FVsC/O0IVOObxT0KbzQH+Yh5g9Y7+X
         0l2i6s0U8dAJzwNv4YvJjDM+LXmT8Xa5sG9FAPiSRWCv4jT00DrYcVnY6JqkWKt6ZmIb
         qzg/bX5prDXmTUOefbeNlexXWF9uYiX2EtNtBpeBs3NNENM28ydZIwZmMFIa9jlwQgmp
         N+7m0N0QPhAmhg5nk9ftED5T6+wDv2F1AcklpYFV81BohCb54wy1ZkEs4+j3adQ7Bcl7
         tDm88fGtluFPbqRYVfhUyk75u/Xbv1zzjDfbHVG2r/5ZC3CquzdZk1P9XKwFz6S4wtBF
         BVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732083912; x=1732688712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFKz5oP575/GGKkSd/ejkrlLxXRfRJ0KjhmoJGqH3o8=;
        b=sNrQ7cwZVapPQjyb4YZ3J+S3lGvyZ/K/VzeYJmzokZdNN46V99T5Ly8lWRaFpliRRD
         7SSkFBwweXxsg+BjvZ9Ks+xBt06Y9RBACyIn1hLPrsHBJL+6mfyxvsLigQepI8J1uXH3
         9sd4HYAsnMcg+UehD/diqs+bL7eT9eAKqsZPWwV4mfKJoX0xD31lIcjKy2Vgjrl0Sbon
         IcczZsC28U3x13zj+ocd/qIP97UGrDrYEtln/0lA1MM1pZ0+2zxjB7mmXIBRUnMP019B
         sHMtnXD1fCMXzas8CHHkaEyzy91V6edCEsQ/rTcld153K+gwWwG+1bLcITEu3FGnMf+t
         oH5Q==
X-Gm-Message-State: AOJu0YxgcmAOjwSPjLcm+62q2nPOe/HCT0IySZ248d0Sdv3ai651lFDf
	Rod45rEdgtPbH/6/1g5AWvzhdoAXZPQV95TyrPcFzZJNCn9/ojJ3vxTQSc+HkpC5iKKmYAMzQF4
	=
X-Gm-Gg: ASbGncvT9XrlZn3KHBTAy2S0edpEdUCvNmoDKjgNlmfwvlKpSOPG1UMQeKZ08Z7uexI
	9kjbcUfyIa2QgO+Qz203drAOuVB0S5BXsWslQExXwlictk+Iw9jOspkR1CjQUqq5c2Qd9zfPz0C
	oPSjlkTchyJVTlCu8/U59GrOVGNukOu0oyzUGgB2iLOj2FfNZx3YCrXgFmzIfT7BemMFT64/T64
	GgpY5O16Wurpn47DyMasZz6U/xyVjR3bLxgNHxYP3ccYWZ+UeJjz2aELrm/ZpPaHyQi+qrTr83u
	9Dg=
X-Google-Smtp-Source: AGHT+IGHiuQVE1t8Q8CRcKG+GcCbtmsWOft9c+j5QdvhCJHhuIzszwKB9MS1lyGgjA5L/zPWEVEGTg==
X-Received: by 2002:a17:902:e804:b0:20c:9e9b:9614 with SMTP id d9443c01a7336-2126a389ddcmr19064835ad.15.1732083911836;
        Tue, 19 Nov 2024 22:25:11 -0800 (PST)
Received: from localhost.localdomain ([120.60.129.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21229d7901csm43595145ad.265.2024.11.19.22.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 22:25:11 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bartosz.golaszewski@linaro.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jonathan Currier <dullfire@yahoo.com>
Subject: [PATCH] PCI/pwrctrl: Create device link only if both platform device and supplies are present
Date: Wed, 20 Nov 2024 11:54:59 +0530
Message-Id: <20241120062459.6371-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking only for platform device for the PCI devices and creating the
devlink causes regression on SPARCv9 systems as they seem to have platform
device populated elsewhere.

So add a check for supplies in DT to make sure that the devlink is only
created for devices that require pwrctrl support.

Reported-by: Jonathan Currier <dullfire@yahoo.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219513
Fixes: 03cfe0e05650 ("PCI/pwrctl: Ensure that the pwrctl drivers are probed before the PCI client drivers")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 7a061cc860d5..e70f4c089cd4 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -394,7 +394,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 * PCI client drivers.
 	 */
 	pdev = of_find_device_by_node(dn);
-	if (pdev) {
+	if (pdev && of_pci_is_supply_present(dn)) {
 		if (!device_link_add(&dev->dev, &pdev->dev,
 				     DL_FLAG_AUTOREMOVE_CONSUMER))
 			pci_err(dev, "failed to add device link between %s and %s\n",
-- 
2.25.1


