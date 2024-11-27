Return-Path: <linux-pci+bounces-17383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614149DA129
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 04:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089BE168319
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 03:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90AB2BAF9;
	Wed, 27 Nov 2024 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOsO9Abw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFF1DFFC
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732678687; cv=none; b=GrGzgZMWo9p+Bm6Xxv1NlGAECBSFUOZEoNErF8pN3f8icFngF8d4SRu+irKispHJFiEcws9wzvJxkTWfGPU60Exa7E5KSev6wInMr88F94QK7l/g154yEt1HxRg+brfY4GaScdLoNRWJdBpnuUu5r9nrv14GNogVKvnGnSt7DdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732678687; c=relaxed/simple;
	bh=IUjgYsGeVcFKVgcKtbJpxWNVFB0rREwWcMBMIQIjans=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qXX7icob0BA3yOQiS8CX6BMyd5MpIQ8kj48FLZ3rKEVEH5kgDmXXmhQ2Vpdd6wFgTBSVy/nDe6ZIBKk/5KzbmxAvpJNd7jQngfofSIgKGT69lpcRzalhqp3Z/ug+X6NZKpj+JTLcCF3ek2c6X9iqNV4F6DNwd6tUm0Rh8BTYEoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gOsO9Abw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21147fea103so85990635ad.2
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 19:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732678686; x=1733283486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ili9BWyM5f9kQeEzEFmXsf5nPuFRfWZgrDDYSq39LmU=;
        b=gOsO9AbwGhktzb3eXSvypxbIWlu1pnxf56vaYVc6aiZA+kobYt5vv58H+y9xeCaNeh
         8QJBJeQrUSdhBHivwfGVO5iBLRm77xBWUTxdSFWp4Fz7ejdELXcj+0pELC9gWmoH+oHs
         ky+wHol3ssKzEq4OzI5xrtgSH+6RG7jn8aWfGREz32g1wZ4mGpK3Ba9TOQYtwKPwW5FV
         RNoTssorjIrgEKi8Pl4aOh4ZEO7e3CPTqJJOfFn9S0e9S1aBxe1gWNZdiIDk+iJUJqSc
         +LtYtXiiUasK/uBF50uCOfVXtDo+6KoRc3/eeyxs0qTIU5iZ6XjoGsQiJsdhWiYVK753
         S2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732678686; x=1733283486;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ili9BWyM5f9kQeEzEFmXsf5nPuFRfWZgrDDYSq39LmU=;
        b=YikMJbM5Gd2i+SFYveHSwLgyorG9wTbf2g/FmhvIoRAIHREeYSqrpLu4HE/dDJDJZG
         3tDn92eXXKMCCHMnXbtKQi94pJl4qjhxKnbvRlPXxm97F47KdhcRqWcVdd+ix8Ui3SUW
         dz6kLOVXWwa4M4290YOrGF40f3taaDplRncLHiY3SWZdDEJaFL5JGp8HDOykMCIJCPeC
         LowA8Rn8zuM9yPhx79l6xTZtOXtwPvTXFOx1n0ca9ZT2JWz0UWfdaDigtHTjT9qad9Jd
         QDVWYgkRr0bo2Y+Rd0zfKjLXvTzcVCgE6+/gYlVcsKnxw+ly95rxD0vjOqk49lx1v+QQ
         xAcw==
X-Gm-Message-State: AOJu0YwIJFimmWiZF2xqKewjH0wIHLKPmq1C6AjbHU5VOpq8H14BIcEK
	ex9OKGY3YSLK1NMF8TBTzOKlMWDs02S5Lg9N+WdnefuZ8aUUstJlTYMbWsvHqWWutP3BrIMsH69
	688enSZBVVLejUT91kbVSGA==
X-Google-Smtp-Source: AGHT+IHNbsPZZcvVqU+OSoPeX77FgSdOZT2QQjX0TdO4QPG/2tLcmvDiDM3CnPBfxUPHGTPN/vnarLLQyjKZzjUUmw==
X-Received: from pjtd11.prod.google.com ([2002:a17:90b:4b:b0:2ea:5613:4d5d])
 (user=ajayagarwal job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a91:b0:2ea:6b47:167d with SMTP id 98e67ed59e1d1-2ee097e51ebmr2174100a91.37.1732678685698;
 Tue, 26 Nov 2024 19:38:05 -0800 (PST)
Date: Wed, 27 Nov 2024 09:07:58 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127033758.3974931-1-ajayagarwal@google.com>
Subject: [PATCH] PCI/ASPM: Save downstream port L1ss control when saving for upstream
From: Ajay Agarwal <ajayagarwal@google.com>
To: "=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"

It is possible that the downstream port's L1ss registers were not
saved after the initial configuration performed in the function
aspm_calc_l12_info() during the child bus probe. If the upstream
port config space is saved-restored due to some reason, the
downstream port L1ss registers will be overwritten with stale
configuration due to the logic present in
pci_restore_aspm_l1ss_state(). So, attempt to save the downstream
port L1ss registers when we are at the upstream component.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
 drivers/pci/pcie/aspm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cee2365e54b8..769a305fad63 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -99,6 +99,19 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 	cap = &save_state->cap.data[0];
 	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
 	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
+
+	/*
+	 * It is possible that the downstream port's L1ss registers were not
+	 * saved after the initial configuration performed in the function
+	 * aspm_calc_l12_info() during the child bus probe. If the upstream port
+	 * config space is saved-restored due to some reason, the downstream
+	 * port L1ss registers will be overwritten with stale configuration due
+	 * to the logic present in pci_restore_aspm_l1ss_state(). So, attempt to
+	 * save the downstream port L1ss registers when we are at the upstream
+	 * component.
+	 */
+	if (!pcie_downstream_port(pdev))
+		pci_save_aspm_l1ss_state(pdev->bus->self);
 }
 
 void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
-- 
2.47.0.338.g60cca15819-goog


