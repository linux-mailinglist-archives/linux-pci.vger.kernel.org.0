Return-Path: <linux-pci+bounces-24201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E99A6A123
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C53189ECDB
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DDF211A29;
	Thu, 20 Mar 2025 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQtHrzW5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589C2101B3
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458873; cv=none; b=MCXuVdgPEpy6IRWyHgVyqDcV+yGcQav6r2Squ+iBzw/1vnpyc4De3YJHJvBhmKCrS85sAwwnxDXaMClw1gwDk4ZgjEPP+aw6PgWTIk6qejcMUF1TKy9oUiwevoVhz4DEedCB35Tj4qB4eJBePLTE2mXYmIJ8Drpf+VjXzVprb/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458873; c=relaxed/simple;
	bh=hUuSUx3XYdhvegKSNUib9/0JGMbzyE8+ZELh8QTuVJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rBrK6nUOzr263AuLbMRAOzsKfJqvsRUpYkqDqAurQG5gUY+hemppXSfAE1e0jOxefBXA1+eE0MIkSse8SIVM/ySCLlNhhENWzaAmdnAFKsOU0hnKVJ9ZQCqDzVQOhmVs0U9zbkkbQLLkW3Al203vw/qzKRe+rJSBw7mIBHoP27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQtHrzW5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff799be8f5so882252a91.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742458871; x=1743063671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxDaVJAKP2KKesZ7/XVRXQO8ANeXT1HSmHjzkchBsm0=;
        b=YQtHrzW5ZTNu0+Bl3gWsEmY4YTE8okHU2DaPaJcydqz+VlXMChi8EGDJglVk1JXz59
         NcezGSMNMwpf4Ut67ld78+g3AqpCtcOXtqjxyQROnuYkieAx5OQa3VCk0mK+7s/bQyOW
         5NmyZZ9cf1NuByr9CgkPlq2nbbOw9v5Hk4rNMXm1SqqlwdauBTaMuEQ0zLouwXPvbei1
         TjLmPKFR9lRJswyCThwSZtc2gcwSeoCWog7D8nrGL5Bih8ecd92UFcHy7zm4oPCrJfKd
         9Z7Z3w0XhoNsBf6mViUCDxozB85vMvluMu2chWETbvpMk42jKZFPkeM+xCPzRouOmzPB
         8c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458871; x=1743063671;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MxDaVJAKP2KKesZ7/XVRXQO8ANeXT1HSmHjzkchBsm0=;
        b=RfnmpPqYpcKsJOpFM0VQYnhKDXmPeXGKFh0cYEyYbGZIjbqPZIlsFaRtX9OblX2Tlp
         Y1pQspNkTVZ4d0RHqN4Xtl0DUfpdsBws2Uyi5HoD9exxU+QgC+engYBK2qtdIzBaLQGq
         uBScMS0XVmjMaOOa5szi1SOfmokdHaB04fpRAM5IcAjgllmvE0qUMJptNPS0GdLXeKLT
         9Ab6tnzcq7/GlYcQ9DDfIO3JcBsgCUfgrTmmusO002KEMUtNCSZG9Tz0mIc5I6pGElfF
         z+x2nzLrD5NxeK57OkRsfQR00sn0WilR0YVduAX2q/CZZhGCGh6TLFOgaNy6X4FdRmAf
         vKtw==
X-Gm-Message-State: AOJu0YzeyrCjirRFr3H9ejrwLkDUojzNnym8uaZJ3+bX7Q13xIut3vFU
	mwJMIfneubs3X2/3sSzlCeO2lZJ5K7Uu7aYUlUhpd9o/AFSADugRCB+1OxOUBLH0Nbb1wffnLcx
	jgg==
X-Google-Smtp-Source: AGHT+IFhtCDIGzAJ+PMU6PcFnp6oVCiVX/Kcas2/YjLhsMbWRekuCaPrGlt9GAqIqbQz30g2JRSksoLhcfU=
X-Received: from pjbpm6.prod.google.com ([2002:a17:90b:3c46:b0:2f4:4222:ebba])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b0a:b0:2ff:682b:b759
 with SMTP id 98e67ed59e1d1-301d5074849mr3636271a91.7.1742458870952; Thu, 20
 Mar 2025 01:21:10 -0700 (PDT)
Date: Thu, 20 Mar 2025 01:20:52 -0700
In-Reply-To: <20250320082057.622983-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320082057.622983-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320082057.622983-3-pandoh@google.com>
Subject: [PATCH v4 2/7] PCI/AER: Make all pci_print_aer() log levels depend on
 error type
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Karolina Stolarek <karolina.stolarek@oracle.com>

Some existing logs in pci_print_aer() log with error severity
by default. Convert them to depend on error type (consistent
with rest of AER logging).

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.i=
ntel.com>
---
 drivers/pci/pcie/aer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 45629e1ea058..3116b4678081 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -784,14 +784,14 @@ void pci_print_aer(struct pci_dev *dev, int aer_sever=
ity,
 	info.mask =3D mask;
 	info.first_error =3D PCI_ERR_CAP_FEP(aer->cap_control);
=20
-	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
+	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, =
mask);
 	__aer_print_error(dev, &info, level);
-	pci_err(dev, "aer_layer=3D%s, aer_agent=3D%s\n",
-		aer_error_layer[layer], aer_agent_string[agent]);
+	aer_printk(level, dev, "aer_layer=3D%s, aer_agent=3D%s\n",
+		   aer_error_layer[layer], aer_agent_string[agent]);
=20
 	if (aer_severity !=3D AER_CORRECTABLE)
-		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
-			aer->uncor_severity);
+		aer_printk(level, dev, "aer_uncor_severity: 0x%08x\n",
+			   aer->uncor_severity);
=20
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
--=20
2.49.0.rc1.451.g8f38331e32-goog


