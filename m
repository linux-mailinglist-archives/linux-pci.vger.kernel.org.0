Return-Path: <linux-pci+bounces-16688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6699C7CE4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B9BB2ED77
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 20:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF941662E4;
	Wed, 13 Nov 2024 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vt9C9wpg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A720125C
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529341; cv=none; b=Mn7Sv2xJFq/i332e7R5VZeFX8fUbYdqCpXeZRzx+veVt2uxLX6MxE2F+UGRTFpV7lkZD2sVcaf41ua17ji7CRvZszMCpTQVwpWi9OPIy9/rpLntPQESpNQNbzMqGEQr3LL64WM6FTFHwHIiwrCXk/axo03w+H0jlP+OAUHdw6O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529341; c=relaxed/simple;
	bh=i1reo/puGs40XsgdXpRo5jLuvVCjJ2MdZ9V3/j/rjsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=og/Vz9euu5+rGp7d6UF++nRwN6Y0eiMNfK+bzfbIIw4m4XpJaFuw/DThEbZPAHuWdezAd/x6S4XnQP+XQB2X/EHbCeqbUV0yy6AgU6pMldP8edcFOoK8uZnCfHDowtmvHBRal2gHTux8EJML9KpJ39ueBuLY/gyOv3wd230BEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vt9C9wpg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35a643200so125351167b3.0
        for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 12:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731529338; x=1732134138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJGyo8V7hZdpO0Kqq5qpbbvS7ePkaWzpyfoWKyhMfqw=;
        b=vt9C9wpg+qlrz9flU9C8aOowOA3Uy374AEpUOCasqLGA7K+PBRQvbX36YXzkJnP5Lr
         XoYYlQ+hBaRmtwGMgAV6VwdeM8xfMk0GmJsV6ENm1vHfJWh6RaU3AnsR+RCfHKj+hHuL
         GJuYyM79ne6QgYkasMgpAvWMpfB4+JK1IWKvq2MxAIuY+CSfH5MOVeVg3XmyJhFOT3mJ
         YQQGAngJH4WCDZAclu6wIHWa2gpnJFxko2E5dmx5H19wIHVz9cvGJXBqeNBXQasiUtrn
         DXzibR/OFV0XadTxgKMXN3CMVIwpZmjnrSahcdJ9PqmI/5x6Kbr43rlGQNXutElTjEjD
         tQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731529338; x=1732134138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJGyo8V7hZdpO0Kqq5qpbbvS7ePkaWzpyfoWKyhMfqw=;
        b=SaDk3QCV+06p32fv9TSictQqpSJ/J+fEqpLKIwuKa3xqVMiz+v7CllXSNCIN9Xucyg
         n+TghbVMfNN7IClHmK2740AaOBFCcUz4V9cObdp2ae/j0VKD64LpA46yeq7GPlX/v9cT
         mX4Ow+YFsoxdwewp3DL28YM7UxergZvKkxdvJa/dUk/0NhwNLnq85L4GzCunAXgMUy/T
         H34VGZopuGeZz8spjvKBEC1Ewpc+DVccEB8Hb2QQx8T9rLnR72FT+VNNKL7za3y6gtxy
         UIL22TdIGy5fDYbkzj/sxsvpU/wQiIIWr7p0Tzu/tclKVuC6Vo1YIrpJqpNkj3IFFJLd
         qV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQkYKN9LGmNgiQNXQ/WnatqFaeXe/xdW48qTyFENOgNjjLME6AmxHkqFxk4cAXQbr88kazQ1nCN68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhA0u2hpR55Etf8rTdnHV9HZC57FsPi0vb3Z0YjVMPZPy+lIJi
	cFKRrhHDvPiJDy3uHek4Xxid3iU0LpkuEilt6/l7YDFo4uzLsr2GQTlxmUknDAmg74fHBFErrIR
	W2SJ1RQ==
X-Google-Smtp-Source: AGHT+IEgGSNApUMGmwT/5GWxoKIRky9G2mDTqjPFWSUJWlfb9He+rGDVI8sa+ciqObwRMeOIZsiDz7ItzLGb
X-Received: from jperaza.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:f86])
 (user=jperaza job=sendgmr) by 2002:a05:690c:6608:b0:6de:19f:34d7 with SMTP id
 00721157ae682-6ecb31b51f7mr2229637b3.2.1731529337892; Wed, 13 Nov 2024
 12:22:17 -0800 (PST)
Date: Wed, 13 Nov 2024 20:22:12 +0000
In-Reply-To: <20220426172105.3663170-2-rajatja@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20220426172105.3663170-2-rajatja@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241113202214.1421739-1-jperaza@google.com>
Subject: [PATCH 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
From: Joshua Peraza <jperaza@google.com>
To: rajatja@google.com
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, gregkh@linuxfoundation.org, helgaas@kernel.org, 
	iommu@lists.linux-foundation.org, jean-philippe@linaro.org, joro@8bytes.org, 
	jsbarnes@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	mika.westerberg@linux.intel.com, oohall@gmail.com, pavel@denx.de, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rajatxjain@gmail.com, 
	will@kernel.org, Joshua Peraza <jperaza@google.com>
Content-Type: text/plain; charset="UTF-8"

This patchset rebases two previously posted patches supporting
recognition of Microsoft's DmaProperty.

Rajat Jain (2):
  PCI/ACPI: Support Microsoft's "DmaProperty"
  PCI: Rename pci_dev->untrusted to pci_dev->untrusted_dma

 drivers/acpi/property.c     |  3 +++
 drivers/iommu/amd/iommu.c   |  2 +-
 drivers/iommu/dma-iommu.c   | 12 ++++++------
 drivers/iommu/intel/iommu.c |  2 +-
 drivers/iommu/iommu.c       |  2 +-
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci-acpi.c      | 22 ++++++++++++++++++++++
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         |  8 ++++----
 drivers/pci/quirks.c        |  2 +-
 include/linux/pci.h         |  5 +++--
 11 files changed, 44 insertions(+), 18 deletions(-)


base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.47.0.277.g8800431eea-goog


