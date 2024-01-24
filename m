Return-Path: <linux-pci+bounces-2524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76983ACAD
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 16:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7601F26001
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50237A707;
	Wed, 24 Jan 2024 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyhySwho"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4777622
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108510; cv=none; b=RBkFPYyW3H/oYcNJi4twAt2YUveOKSleOzd66hLKcrH+1c96rYQIb6hLgDypGqAjwYKFWgQ+OQntpeUQzP3AGkuXXLmzzc6dYZD4arjVHMtwqjM5nO+Df3rgnHB0IERKUqqDN+5W8YXITL4SsoSj0NHdh4wxo2L0C/d9flgYveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108510; c=relaxed/simple;
	bh=vXo7kwrg/JEtFg5VNFewRcL3UlxCm3whtvjszAzZPYw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CMITfJncLSdMjssUUWnTvdL/dQUBFoIz+xyjkodZ2V0wM8Hw8AMdW+9fkOmdmiiJWV6FMGSf5LcgwHSlmpRMnOHG+8igXsniohdGV4RK9E3BHfcvjwBUg/fySLtlKRoU0OOL62easx2QmWaeuNMXVj3k0VhS3wMm4Etc0bA5USQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dyhySwho; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3387ef9fc62so5153493f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 07:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706108507; x=1706713307; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wddH6dLZWFvD4sBtP23ayzipvN9tjMLSLEUIemLS/70=;
        b=dyhySwhofWH+JkOgzDfSLBlzS9igtUKpI70OvObtint2kwDXlu+crjO9IJGnpK4TI2
         zjwSGBmTDmNyZ7UsPFTWn0XgAcLA7cHnQWozb14ep80vxlgnCsvKc+XAsee6vFQ1xw74
         mxZT2wKqj1JIJ4Gl2MdzeWGElr85Lnyj8ss65BMn02is8cLtiQ7IBXMPhsEiuH/h2dKa
         By74+WvCjk4lIxVaq0FoAZ/8kq1IgZPlYsZhnFWSn7W5SOkn87eXMhJm3pnHB170beGM
         G0IUm0/bhnKz38V3tnQKWNqS+GnfnxrSZ8W8tVTQRGJSmzbjdbyXOIygJTVc1MOh3CMC
         7f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706108507; x=1706713307;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wddH6dLZWFvD4sBtP23ayzipvN9tjMLSLEUIemLS/70=;
        b=m08EAjq2UltRTDSHSgfBRLNmb1TKWGoGwxHjN0/zSUfvmOEahOazRHpHpPcUfYrd/a
         C1HngPL/NCgXC4n/Nqx+1Hm8GKCsIlMVnJi4EzvKkYAvZ6M5ekGHiiaadW5gwBj5Z3Qg
         6CjygZXo8xnYxnJWsz+fO6CUHZwZXzYJDlhm6tNIEc33nh9bT7cQIKsDSjzxz9QCY912
         JnV91eArU6xREptfb1L2OotLJ6/tQGgw/6vVY5bYW92Jikayov39tPZfyaIWotupBrkU
         bVj2B/p8aTliAyOXux5ZiFVHKdUxEACxg1fXes37SahAY0UGL465O1EPBkeNzqKCRd0+
         DhGA==
X-Gm-Message-State: AOJu0YywOSubXuMBTpOusXL8IBL0mgD4yjd9Fq4/M/q6vFOE3FltXqEF
	BQb/a7OnY+1ktgg6E0O8bX0h4Tb9FgmVr9cADQGflbnIoS53oe8IrMZg9NbhdII=
X-Google-Smtp-Source: AGHT+IHXHhrcwAHRLUnkX2s024mT8pEXvkb38AMMNc+9E2uH9gcDtJhJhoQ9GTqAP9FJosVbKHujPg==
X-Received: by 2002:adf:ef12:0:b0:337:bf29:b6ca with SMTP id e18-20020adfef12000000b00337bf29b6camr701919wro.23.1706108507315;
        Wed, 24 Jan 2024 07:01:47 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d62ca000000b00337d4ce6ab4sm15999360wrv.20.2024.01.24.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:01:46 -0800 (PST)
Date: Wed, 24 Jan 2024 18:01:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Niklas Cassel <niklas.cassel@wdc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v4 1/2] PCI: dwc: Fix a 64bit bug in
 dw_pcie_ep_raise_msix_irq()
Message-ID: <888c23ff-1ee4-4795-8c24-7631c6c37da6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "msg_addr" variable is u64.  However, the "aligned_offset" is an
unsigned int.  This means that when the code does:

        msg_addr &= ~aligned_offset;

it will unintentionally zero out the high 32 bits.  Use ALIGN_DOWN()
to do the alignment instead.

Cc: stable@vger.kernel.org
Fixes: 2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
v4: Add stable and r-b from Niklas
v3: Use ALIGN_DOWN()
v2: fix typo in commit message

 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b..51679c6702cf 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -551,7 +551,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 
 	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
-	msg_addr &= ~aligned_offset;
+	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)
-- 
2.43.0


