Return-Path: <linux-pci+bounces-19836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F495A11B29
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4092216857F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB7A18952C;
	Wed, 15 Jan 2025 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2KeVv6B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7072435944
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736926999; cv=none; b=rIgaPiYlNFtcG6Eo2VRpHc5IKfh6s6FbM2B6R0WdfeahHBAwTXGQAYboCrm9Vqq0UKOvr1JIx887ZbWJlFcHunftLtcFEUaE9i4ojRkglLNWk8E4h/MyQ+GwPcTo8Nw9au3i/wsImR+HjxanH1NNDulpjdsCUZ2HI38MZyH1WVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736926999; c=relaxed/simple;
	bh=3DcuRaRR3rek/iMtx7Kx3cYHCFvPlsbEJPib8SHWNp8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pQdadZmmxGT0Lw3i2LdOxr7YBXBNzR4VXhAYoE+Sn49wQ4j8PXeBi3ZY59J/orx0Y7uB214x9b6ucOuaFD1pOcszcn9vbEsDbjGJFhtlJ+XvHJwsU0+42FGtfvRX7VkvR7TGOmvp6du0TUXXLEsvgRer2JkND3Sk1vWg6LLabrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2KeVv6B; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-29fb38de98eso2009899fac.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 23:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736926997; x=1737531797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=32d3TvXIAITzMzw8IRW1CVQ06ZVjM6jnHvqP8pOAfRU=;
        b=I2KeVv6BKZFYsyveQUV9OyGr2g05B56Ri597s/JKuwuHIfxzKZu+FHtCuznQhv7+Bx
         DCpr1io0cijs766e849aFQymvCgImixEyNSZJvIKZ3pnO2yqcum8Zl5LeMmEgZIRpeXq
         9zfBfuJXjxKrBHtn07VujeXQbBpimzX6sb+bi0aLX4fAL5Ao4ZASoGniYJuUaS3RPf38
         K5hzsAPl7XKUbSxNJTsbExCR5/eExhGc3a+TD84kmDItsaYzhvry1ezz5l/nZ8i9Ztzp
         xIQmqDElYvJPEYKJwFRMOqjB6HFbyXDiBUbDFcFmSHOJuplE77xCH+1rUAWXX6TL+gDg
         EHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736926997; x=1737531797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32d3TvXIAITzMzw8IRW1CVQ06ZVjM6jnHvqP8pOAfRU=;
        b=DXubLWaWGzXN38pNZWvc2bMCKixfohccryZpwPn8LllciKusJ/CRKGygMQmQSeHxLM
         Mvg0j4JrooTYejsqUqEz8kpvQd4s6SDTcBNeVoPfpbF6Js9J3DXley89DzfZ6qD3jWvY
         ruMuVoNzsWlHwDS6itySzmuLsKS2aNB+VNfqAzooGXPaSOcLkXb4//FoYIIpyDRVm2fX
         +fRlXOK3dF/yyWkx2NfyEGWiFUE9TPUcAbKI6RG7wFisPVI8VDSS/HeRh/8RcFNTUSnm
         X3nmoMRnc9j6IkQwCDSoewCVzIDT8NIhzmWLZY6reLiYpXVJ9eOfcmgzRpnAUSf5S5WW
         bzQg==
X-Gm-Message-State: AOJu0YwBvhZTdBnnf1xsyZBjb+hJVtndepCRxYrnn7MRYNBlIm7LicsI
	rJTEK1obJJQloCkPNV38DaZHM85AybJj/WpwkcWXK9lf75jjP3DPMPVbN5cxlgs2ouHI3JktlFP
	OkA==
X-Google-Smtp-Source: AGHT+IFDki1PU+72glSpjoiw/40WNkQMVAU0yTnmz6NLTCW2eFevSl76QhUxSojvA5WFxQKQNq99B9QOiAk=
X-Received: from oabgx6.prod.google.com ([2002:a05:6870:b906:b0:29f:9847:446f])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:a08b:b0:29e:76d1:db3b
 with SMTP id 586e51a60fabf-2aa066470fdmr16145556fac.5.1736926997427; Tue, 14
 Jan 2025 23:43:17 -0800 (PST)
Date: Tue, 14 Jan 2025 23:42:53 -0800
In-Reply-To: <20250115074301.3514927-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115074301.3514927-2-pandoh@google.com>
Subject: [PATCH 1/8] PCI/AER: Remove aer_print_port_info
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Info logged is duplicated when either the source device is processed. If
no source device is found, than an error is logged.

Code flow:
aer_isr_one_error()
-> aer_print_port_info()
-> find_source_device()
   -> return/pci_info() if no device found else continue
-> aer_process_err_devices()
   -> aer_print_error()

aer_print_port_info():
[   21.596150] pcieport 0000:00:04.0: Correctable error message received
from 0000:01:00.0

aer_print_error():
[   21.596163] e1000e 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
[   21.600575] e1000e 0000:01:00.0:   device [8086:10d3] error status/mask=00000040/0000e000
[   21.604707] e1000e 0000:01:00.0:    [ 6] BadTLP

Tested using aer-inject[1] tool. No more root port log on dmesg.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 drivers/pci/pcie/aer.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 34ce9f834d0c..ba40800b5494 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -735,18 +735,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
-static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
-{
-	u8 bus = info->id >> 8;
-	u8 devfn = info->id & 0xff;
-
-	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
-		 info->multi_error_valid ? "Multiple " : "",
-		 aer_error_severity_string[info->severity],
-		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
-		 PCI_FUNC(devfn));
-}
-
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 int cper_severity_to_aer(int cper_severity)
 {
@@ -1295,7 +1283,6 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info.multi_error_valid = 1;
 		else
 			e_info.multi_error_valid = 0;
-		aer_print_port_info(pdev, &e_info);
 
 		if (find_source_device(pdev, &e_info))
 			aer_process_err_devices(&e_info);
@@ -1314,8 +1301,6 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		else
 			e_info.multi_error_valid = 0;
 
-		aer_print_port_info(pdev, &e_info);
-
 		if (find_source_device(pdev, &e_info))
 			aer_process_err_devices(&e_info);
 	}
-- 
2.48.0.rc2.279.g1de40edade-goog


