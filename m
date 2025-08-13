Return-Path: <linux-pci+bounces-34007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7500AB25791
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BBC9A5424
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671602FE051;
	Wed, 13 Aug 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvabDMgN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580C2FC880;
	Wed, 13 Aug 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127794; cv=none; b=V1wB7E5mgpPVBCSSWOV05VwOjzJ923VujVPAbhX3fW6o9AuxU2n04fVvGsbGLIdy1fZlK7r1qUGySL7OziyBGwZZsViMzxmQmYrenTyrX3XeN7fOQoGpvsKsAiqTSIQAfC7wqs42XQR4xleSJNtkjpQl8PEqhuc9Qvv8akNqJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127794; c=relaxed/simple;
	bh=piMWvycnEdu70/fVFMAzrewIeeN8YHNbChA5Pe9yc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvrrdDEkGl3mm6TeIYRV6b5eceU9W6EeuaXzYG56Fi1Kz0FgI96zuFLpNlkFx9uJFVGEi3O/crcXMY0tUYQKIxGPtwmQ5ppYuWLiHNgz66fa5b4LAtVF9S7eJF2z138X5QlgSr0MQsIkhC1c2DchaGg2hDfz5W5QKR0JBD/tWec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvabDMgN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55ce520caf9so367434e87.1;
        Wed, 13 Aug 2025 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755127791; x=1755732591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xcrFSa1CYMVvWw2HSy0jSP8tcoIqOypycqASfeKb+8=;
        b=fvabDMgNuexNxovVsVXUto3UOtmzjdb9SxRDP3pp2c1TPBgLu+kEyWFbFFynBHJiGl
         0338IySBBPAx8WxlGUzQacWN0gO7AKEQd0bA90JRFzYJvB4ppsQHweNSVIp3kTKzczPe
         xmroKpfzCHzqeGGHcjxoxLEdiunS+CD6zahh6Oe8uI2Q58M6GuGkB5BBHYJOMNi2E0nJ
         jGUyvuzQukAL9x0whLLBEohIa7AC/wtSE9Mug50a3Tsy/tKo+VksFwF/C+hNSRtqhpWv
         qygzdN0EHE8UwWsYd914SHm8RAy3FS3f9Bg4YxU0wmAGLHKGTh9IyzRmV5STE1FrP191
         ZXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127791; x=1755732591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xcrFSa1CYMVvWw2HSy0jSP8tcoIqOypycqASfeKb+8=;
        b=KIX4HtwMkM0leFGw4vGbi4VgJ0Cf9eE7kVhBWtl8TD2GdgUqQ5fXQxIxREdegF/xnH
         iCsc8fFOn3fVFcql3LV8OiZrsJvRCYbeUoVu4SRoG3TbcMO2Zl/qRGQv26/6XDX6+tDq
         9bNSFga8oL9Jw9ux6o46JIqENmMEw0AErkuaALjpV5n5dng1NTJHeC7sdC3qCIDIc/42
         VOCChngpsae25ej09I2ALZE5WlB6QjoSyYBpyGVJWPt3jwjq2Iky67vrQgT4HNuhcNU3
         Vps3wh0wlafDMChfycoIQuqXlk4hFXcjkg/vDeqfqrqBO8DdGEKP8XF/f5AjdlYlKt47
         hF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6HW7YT4k1m3aDYIwYZB/7/Q7Tk4kPFN5i14m5cB9QuPg4T41alMBn3dpiWCebDryfOy0Yk3gF8iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzCethdcl289Ac5A3c5C5iq08S8W56lBzwezeek88Hwy9lClf
	SKwhMhrwj9WUgimw5ts/QVIJalfGV/d/oeEAiV7ItjgAZe7PQzE69GOfG8IBYGaH4cs=
X-Gm-Gg: ASbGncvSVmxvSJUvyXmmB0GyVFYU475+1/A6DupF6JC0QWSKbtlwmH//+aftCRDXeFi
	c1Dux2fQgYiZTjhz/+8WY3cDjUmDKOiBzOo/1ch886zYIyOG7Ob827OYm7LO4q0YtUvW9LSpp/W
	G10zv3Nmt+zR1DO1a2IF6tq1ZZKOeScTSbVSeDirbm/4Byu4DI91h8NQeELY8Wa5G++Eemh2hMz
	CI6k2JHJAggwDE2x4NsJPaHHcvi2Flwi+IZGox1Zwty8R1n6aV6mj2pZE4mHv21oyVxrI1ZbU5R
	ZpGmFoKVdT1RlS/lCfyWrJk2Z/kethbVH0KLdq9x2Trw2JdtPOcv26YBqHvmA8WBwcvQvsIyp+K
	wH2QBcnFUEOIfCiM5AkeX2w==
X-Google-Smtp-Source: AGHT+IH1sstAEYrZUE3/jW4348pTT71ciYB/Gp7Yz4EG8a/pEaDmYG81yi7mFTAFrfnk/H2scM8zDg==
X-Received: by 2002:a05:6512:6cf:b0:55b:940d:896f with SMTP id 2adb3069b0e04-55ce50b89a2mr279443e87.55.1755127790619;
        Wed, 13 Aug 2025 16:29:50 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55b8898bf90sm5539497e87.26.2025.08.13.16.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 16:29:50 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Juergen Gross <jgross@suse.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 4/4] irqchip/sg2042-msi: Set MSI_FLAG_MULTI_PCI_MSI flags for SG2044
Date: Thu, 14 Aug 2025 07:28:34 +0800
Message-ID: <20250813232835.43458-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813232835.43458-1-inochiama@gmail.com>
References: <20250813232835.43458-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MSI controller on SG2044 has the ability to allocate multiple
PCI MSI interrupts. So the PCIe controller driver can use this
feature if it also supports multiple PCI MSI interrupts.

Add MSI_FLAG_MULTI_PCI_MSI flag for the supported_flags of
SG2044 msi_parent_ops so the PCIe controller driver can use
this feature if it also supports this feature.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/irqchip/irq-sg2042-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index 2fd4d94f9bd7..3b13dbbfdb51 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -212,6 +212,7 @@ static const struct msi_parent_ops sg2042_msi_parent_ops = {
 				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)
 
 #define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |		\
+				    MSI_FLAG_MULTI_PCI_MSI |		\
 				    MSI_FLAG_PCI_MSIX)
 
 static const struct msi_parent_ops sg2044_msi_parent_ops = {
-- 
2.50.1


