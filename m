Return-Path: <linux-pci+bounces-38039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C857BD90DE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 13:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED553B893F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 11:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7637630C63B;
	Tue, 14 Oct 2025 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzswigXC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19DB30E849
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441583; cv=none; b=FO+cCFPZ0q8MUzoLQyvJ+q8DW7XHBRVR1eOhGZ+QcKR0iHZqLydV3wTKkw7JTr1UJr3zfgUjeAam/F3VW+93roswPd1qa3I0/ZzfuoZ1FvR4gz4dPMSFDCTCzdT5pq3reR7AFtJmR7hZmfWa72RGLNy+8vCvmkESny4igamQEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441583; c=relaxed/simple;
	bh=m4JimLcVKSmkW3C/jrPc3p4+w8KZ9hwzs7ARWBUJAzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRvDPBANZ2h1cKpyfo6cnqEsq5qQ4HI4HFSv/t2ydVcJfBGXtkLWWtd5HXenWlXoLZJzymrohPACgoD9soGjGhOxsPH4GJQFygYaq2+wG++nsLokaa+L/NcVfBpgzQsu7kQCVHMxqpD5We2QEBZ1NQ44w+Y2gizWXnxSlLTRlq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzswigXC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781010ff051so3706825b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 04:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441581; x=1761046381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpDUom30mVihFUe1ZHKp2VNngPZC0EmXCJHb+H0vcDc=;
        b=kzswigXCMa5zypTQT6Ndr/rdapTXIxq+T/K27hAHz95bezqtleqQqIi2oZBF0l1kKo
         Rqil6btCRVZ9kbA6C13vINA4uqWPq1LnufOdryc/zGsAt0Bwj9E5K6Shuo3s9uWjRNEE
         iL7oVNkTl8l34vRWTgjlHsXL0CPBj3gdc31fGruY36wPVIDdetyPzTXmYHb+teIRIsnY
         OR1KxnofNzV/7NJG4EG4RdkkfL2+TGit4uhi1G2efqhJG+mqUwlHxjg3z6kq14NMrFNq
         lL6vfKYlbQGB3aiUUrn9145vyWIR0LktAb5zvKZUgAW8v4AhBUmJm8Z55D+PV0oCGvfE
         pzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441581; x=1761046381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpDUom30mVihFUe1ZHKp2VNngPZC0EmXCJHb+H0vcDc=;
        b=ZVuyjHAAl+wcjQt0VkZxPhNXQ93v1Ryj2SoxM1gLRldxherEsrK9V87IyoQAc+5xWw
         8RZAoi/NGeOpOtzTJqtjrW0uov+yUzliroW9Cy0PDa64WaegX4Vhbl9BLxnimLOqD28v
         1iSzTUGaIZFkwXRDZTgDHiI8qlEJG57SDhDj6m0JPhM3qWMmzNMXDHPKEmB/E6T8Zh5h
         NKxSBacgIjQgS95oHJdzFW5t0zCW+n++wxEK/7McqgB6AElmIUGecXdK9S2dYzKBfDhO
         Gg8EUGga6TeWaKYfbYS31R5DtgfLqPwk/G3xFSDaVRJ72EcIpjuOXx048xOWbwiyj9JR
         EdKg==
X-Forwarded-Encrypted: i=1; AJvYcCVCjVOo9GuHTggrZcDbLQgtLFDq+Mdq4h9KhAakYNBGGJA5jRNwQEagyX4eVl49EbUeGFNpuRS9t5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuwEJnJ89B/vNuAcWN9Zv4jiASaX4fkA3N9jA+ai951WX2UvEf
	iCgDzWk4HnupXEmhWIUuuahz/ZXczDnDDacAwbvQZ7uHgiftdlyUj4/0
X-Gm-Gg: ASbGncvLah6nZa+NzRZrygIhLgvGVaR3hey9X/EybqmEYqxkIDvvxip8qw5gRjBd/67
	MdjjhoczpLW+GfM8eUYI1kY+fxdFTApUumCeY3FgVFj4WFg6bfn9awGtoSIih7/ybUKKbmVdNRN
	jGvRR/hyLM6YNtJAIKSPzOh1TpLVxKh0dx/ogkWpYy1ZiiHA3isaTApYL1v5JCod8IYt/LJRA+c
	my/6M4+1VZbDKt2wE3QpdVpFWfVYxmxGeK477DULV2amsuyg/u4gMVNJPFnUloh6WFvKXXEpnI0
	5G9akb5ZXy6tevI1Pn3NBoGaeQJ23EQuD3BzsDSKyDhWIO3mp8irnQ7i5RzZ05AEYDc6qNWrT26
	6/T7JPucoZFYpZMf36mAoxLdOgwakqKQa8cYbZAOnT5z2YtcVAw==
X-Google-Smtp-Source: AGHT+IFVLpe1YlyoBz6ibhhreG6Fl3FbCAxKdtEs4SmjRs5bXwF82T38vjadMP9BpiSOiF7uDxR7XA==
X-Received: by 2002:a05:6a00:1705:b0:78c:97fa:6170 with SMTP id d2e1a72fcca58-79387242e1amr34246206b3a.17.1760441581102;
        Tue, 14 Oct 2025 04:33:01 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0965c3sm14871383b3a.52.2025.10.14.04.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:33:00 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 3/3] PCI: j721e: Use inline reset GPIO assignment and drop local variable
Date: Tue, 14 Oct 2025 17:02:29 +0530
Message-ID: <20251014113234.44418-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014113234.44418-1-linux.amoon@gmail.com>
References: <20251014113234.44418-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change removes the unnecessary local gpiod variable and assigns the result
of the devm_gpiod_get_optional() call directly to pcie->reset_gpio.
This makes the code more concise and readable without changing the
behavior.

Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: Add Rb - Siddharth
---
 drivers/pci/controller/cadence/pci-j721e.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index ed8e182f0772..bd8fda0baba8 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -477,7 +477,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	struct j721e_pcie *pcie;
 	struct cdns_pcie_rc *rc = NULL;
 	struct cdns_pcie_ep *ep = NULL;
-	struct gpio_desc *gpiod;
 	void __iomem *base;
 	u32 num_lanes;
 	u32 mode;
@@ -589,12 +588,12 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	switch (mode) {
 	case PCI_MODE_RC:
-		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-		if (IS_ERR(gpiod)) {
-			ret = dev_err_probe(dev, PTR_ERR(gpiod), "Failed to get reset GPIO\n");
+		pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+		if (IS_ERR(pcie->reset_gpio)) {
+			ret = dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
+					    "Failed to get reset GPIO\n");
 			goto err_get_sync;
 		}
-		pcie->reset_gpio = gpiod;
 
 		ret = cdns_pcie_init_phy(dev, cdns_pcie);
 		if (ret) {
@@ -615,9 +614,9 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		 * This shall ensure that the power and the reference clock
 		 * are stable.
 		 */
-		if (gpiod) {
+		if (pcie->reset_gpio) {
 			msleep(PCIE_T_PVPERL_MS);
-			gpiod_set_value_cansleep(gpiod, 1);
+			gpiod_set_value_cansleep(pcie->reset_gpio, 1);
 		}
 
 		ret = cdns_pcie_host_setup(rc);
-- 
2.50.1


