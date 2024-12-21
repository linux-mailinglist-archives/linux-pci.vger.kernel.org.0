Return-Path: <linux-pci+bounces-18925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9769F9E03
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 04:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F316188C4B1
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 03:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7BF137C35;
	Sat, 21 Dec 2024 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSUTsGlY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AE371747;
	Sat, 21 Dec 2024 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734750047; cv=none; b=fkwcg0EaynaygnsGDpHtatwfcEC8Z/H62YikOCEOeucDtM/s8f4vuvQx9jCxURdMJHYkQNiRGz4tsMuS3/phhdxEF/X2KFZ4exW3ZMmHJjzjkvLYEUSCAxM/SnGYM6IsG4J3n2AfXqyncP4XwE/FlwJQACr8+5CpmujljSt5inQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734750047; c=relaxed/simple;
	bh=gNjxbJOdJ3QYaWL8knRcn34pwv1UYeTFW4XYqCDZ694=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hENrAVQxZ/gatITSUuDMk+YZ8AcWSUrDbGdC5lvn06cYw/lDXIDTAUiGZZPZBZlKe940jDPJESaCqKUFaW+2CMk6XE/rW+lGHi5KGB75jrUEocsyNhAQ21hWQoNABfKjPZnLXoIltWHk5H7harKz984s10xBAhz5bZrWJC9igmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSUTsGlY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728e3826211so2147434b3a.0;
        Fri, 20 Dec 2024 19:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734750045; x=1735354845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEA2bN+skDyGcmLM/SnEgdQzCOXmBD1TOTdlAo459JE=;
        b=RSUTsGlYpJGshLVny+SgqM50gaJZb/PTTqCuG1Xr6pkNFlD2G4lpAqLP9Rn7L7utJe
         AGUv3t3Ji3sHnL9F4GqIkYVMc88khfVt3VJhiCcfgLaEWIIEbEz7+XaIWwaYr6dTb16H
         SO3c8Qa+GIgXAKphdo6dXtwvPwAJbm9IHqsfMyJ20xK86xdz2bV/ibQUm+fr3/RxvEpY
         4B4flO3QPTIQm/bG7TRgf0GAaf+5yHESx6eyNVGms0HPwwSGo82KHVhI6I1/yLjxbq38
         oXeqPMaw9s7DZtq0RMB0Pqgl/4gZ2Mb3TfDUjaGSAkamLjlxmXZhUqYma0zIwkf1rIcD
         6sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734750045; x=1735354845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEA2bN+skDyGcmLM/SnEgdQzCOXmBD1TOTdlAo459JE=;
        b=JInAxXnSleYGvvSkMv4Y+QXEYhqAkJjFNdGFqMnTgDbxgf9tvWhYiF2GfhFSXKPKlh
         EVcpL3/pnAFmH02QQX2ub3c6D+RJoSe3eNl3YEYbTnbQObFpkZgjq+oLC8c89hMQ47jB
         WIBucMfydFLjDWcuUiti7XnddOSPdi6YGNqfoRpB3y06om3Iyo0Y6a+tZGT1x5gVcod3
         SC7eQA6bAjZ7kP0YzOzxXjMA27PS8RlRn16bh4XxoEfGgGu8reQQ5J53krKLgITRlsZD
         ccb7E+eWLVfHHmXV/04gC8k8rgAwZeLqIj/ieVrDNOgeYPX3TZFLEvNhFXLmeJr3Tfsf
         eGQg==
X-Forwarded-Encrypted: i=1; AJvYcCUEMDEfd6xBL1nqgakrfS3khaBz909PC32RL6nqnR0fjlDJ1yCHArDS1f4eRYc/uGbUfpJA6UdfAHXd6E4=@vger.kernel.org, AJvYcCXBqAwcP6+7UVJwIolHlyb4jllsxOalh0PXidKZ2zFBhlrWMak+qob29+rAFPcggBiXgZr/syuTGNdX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jCqOgTgULPblpvDOpezlSxfBuzJa6fmAqGLs3Wp/zLor0BAv
	wPa7MFsTqiJskJlZsnaThYhStCDKF7LuFzyYAIRkDYHtdYAY/yav
X-Gm-Gg: ASbGncvi3Mne9i82iiLv52z4sxurWMFouxppAh71/kWhVEG1rNy4kXnyAU6a2PDx+t7
	HlYPcRr5On3drDYylmoUEppjHBKXhG3+EBT1urUUx0l89QZfw+aodqvZdjHI6QrxgZwFQUjcX29
	32iI4yndKXSnczKcVSnYCtLWh37jACjCWokhYQDdPb5a4RBeQmKIs8tTqVRgUIh9ynO+ZLe40N0
	YVAPNnVXQM02+GybiLn+gkqlk2AEcJrmUJJHUXo/Jfzzj0HNMvCJUvcXlNFomBhoB8mlAkThovY
	sF9agAhRf58LR2mW9ZVJ+5EmuQ==
X-Google-Smtp-Source: AGHT+IHSKeDZlyOmFhlwobovEtQoLllpmo84a9E1XeT1D2Ni2ec8aJO8JThjyfwbqq6FilX/tND2FA==
X-Received: by 2002:a05:6a21:2d8c:b0:1e1:c943:4e8e with SMTP id adf61e73a8af0-1e5e081ee88mr8638343637.41.1734750045056;
        Fri, 20 Dec 2024 19:00:45 -0800 (PST)
Received: from localhost.localdomain (c-24-7-117-60.hsd1.ca.comcast.net. [24.7.117.60])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad8fd610sm3810671b3a.136.2024.12.20.19.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 19:00:44 -0800 (PST)
From: Mohamed Khalfella <khalfella@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Mohamed Khalfella <khalfella@gmail.com>,
	Wang Jiang <jiangwang@kylinos.cn>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Set RX DMA channel to NULL aftre freeing it
Date: Fri, 20 Dec 2024 19:00:00 -0800
Message-ID: <20241221030011.1360947-1-khalfella@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a small bug in pci-epf-test driver. When requesting TX DMA channel
fails, free already allocated RX channel and set it to NULL.

Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")

Signed-off-by: Mohamed Khalfella <khalfella@gmail.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116..d90c8be7371e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -251,7 +251,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 
 fail_back_rx:
 	dma_release_channel(epf_test->dma_chan_rx);
-	epf_test->dma_chan_tx = NULL;
+	epf_test->dma_chan_rx = NULL;
 
 fail_back_tx:
 	dma_cap_zero(mask);
-- 
2.45.2


