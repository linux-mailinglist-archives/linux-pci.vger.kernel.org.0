Return-Path: <linux-pci+bounces-6780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C38B56FE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 13:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66078B21BA5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A840F481A0;
	Mon, 29 Apr 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsgsXeDR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9C40843
	for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390991; cv=none; b=LqwojN8fppLZcsmIvioOJOQZTcM/5yZBoTzYu9EHfpg3234jR93D49k1WaLA6P3MBZfysU6XlYFKOt5ZreRIEeTdotIsr2quyKkxNG9SZEUrVvZhQ8G0lQNgoDvDi/fj2xi6o34KVSC1wSh4kDGlf5joQBC/P7mNcjOCrUuV3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390991; c=relaxed/simple;
	bh=8aoPVLJ489On5ztbsvpmdxCALVbdDUa/I32RFYBdJCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wl6ViH7t5EK0Cp2z3e99zynfxafz+AuBEH53z07dOBrpZP0ziUSxg8yKmojOWbQ5bOg4jMsncT6wQcJ8BaCchlfggLkPOsDwcOfN2g3rPVFIPk7uRKA52kbkS+8EgNRdgFuyFtdbc8j587SGGYYLFpEjEYe78f0x21ssi2lfreU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SsgsXeDR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso24812195e9.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714390987; x=1714995787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eSPLQ0aSiWlUkLotmQUKbdSZn8q1v5DF9gInw6B0dXM=;
        b=SsgsXeDRILZOwswqsoGRMNoq0xnQA3pjT79D2Sgd0BkALBFIWURjZNm9pwkxWvFP27
         4p/ysSpLjXgDiWpWTJYwQfubTHfYzVQGsqaC8SQ+oexV5M+ylCDrPfXJao79hv+W9wtk
         i+utIvNBVMmQQFUtlCTW9o3qhNcr4JRD6dkqxKaUM65mgXnI8RRxe9il3TqunV6rCXo7
         hUJyQFSn68tUpA/K4EX3wD0s36Ofqu3nhz121yPMCXbb8OLVKhVNnaQRqyuB/tDLTbIp
         Ywz2FZ/RmVRaUqjXEb2xAOxC/il0fv7iSl1NThNXaMEWfVXR2RTVv+LgEMAQtqFmRpA9
         7e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390987; x=1714995787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSPLQ0aSiWlUkLotmQUKbdSZn8q1v5DF9gInw6B0dXM=;
        b=WTcD8KCeKujRWMBZlPXtaqtB2fWlEQxj6DfWeAJkf8YZXksEk3Cydfr5pC2qpbpTM+
         R/nYvOufDVMd1ZxjUtaNnW8XUnFfPXeIyxo5t4vH19j/S/T2iRNaFu9uvey3VuRILB3m
         /r0miThj0ITi8HpfX5Nz+l34XmYuwEPaZDGtRy+uP5Nj8sqvRXff6gdwiWNhr4LsSS4a
         uRl1TRKv/LIzsCFPNd8ABYHh2VwwbNKjjCpioKIPlSClP5PvR6j6we85lOOPqKTIy8M4
         fgb93PmqqnOsLuch8N+LEFjNfdINhKOP6Q4gpG0afte5dc2O+OnrsmQAnHGzGsjIl1l6
         nucQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVhD0XtBtwN2spVlPM9N7PG5t3MKzh9aMj+R3KZFsoMxBoDpgdCAtSdvj2B5yMqNSyZm7ZTg7Fh2HXRgwJEEBdEBqFJRjsmJy7
X-Gm-Message-State: AOJu0YyO34UqzMor/a6IJwJCjV3lEeZYJlipnzvf1W6g3drT7Ai4xuMZ
	KIbWdx7L6jM4l/RdPkp+uchRIyfqmQw1mnVR7f/g2P7RXIftUGRbqZXqniCgWNM=
X-Google-Smtp-Source: AGHT+IELIaH77G+cqO9Ae4tGmjB9R1iygWxsWgrPpSX+Zo6NaBJo82SewNNgw3IJ4qO6Jw9lSBHdQQ==
X-Received: by 2002:a05:600c:1d16:b0:418:5ef3:4a04 with SMTP id l22-20020a05600c1d1600b004185ef34a04mr9650703wms.18.1714390987239;
        Mon, 29 Apr 2024 04:43:07 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0041bfb176a87sm7006611wms.27.2024.04.29.04.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:43:06 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	liviu.dudau@arm.com,
	sudeep.holla@arm.com,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	nicolinc@nvidia.com,
	ketanp@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 0/3] Enable PCIe ATS for devicetree boot
Date: Mon, 29 Apr 2024 12:39:36 +0100
Message-ID: <20240429113938.192706-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before enabling Address Translation Support (ATS) in endpoints, the OS
needs to confirm that the Root Complex supports it. Obtain this
information from the firmware description since there is no architected
method. ACPI provides a bit via IORT tables, so add the devicetree
equivalent.

It was discussed a while ago [1], but at the time only a software model
supported it. Respin it now that hardware is available [2].

To test this with the Arm RevC model, enable ATS in the endpoint and
note that ATS is enabled. Address translation is transparent to the OS.

	-C pci.pcie_rc.ahci0.endpoint.ats_supported=1

    $ lspci -s 00:1f.0 -vv
    	Capabilities: [100 v1] Address Translation Service (ATS)
		ATSCap: Invalidate Queue Depth: 00
    		ATSCtl: Enable+, Smallest Translation Unit: 00


[1] https://lore.kernel.org/linux-iommu/20200213165049.508908-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-arm-kernel/ZeJP6CwrZ2FSbTYm@Asurada-Nvidia/

Jean-Philippe Brucker (3):
  dt-bindings: PCI: generic: Add ats-supported property
  iommu/of: Support ats-supported device-tree property
  arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP

 .../devicetree/bindings/pci/host-generic-pci.yaml        | 6 ++++++
 drivers/iommu/of_iommu.c                                 | 9 +++++++++
 arch/arm64/boot/dts/arm/fvp-base-revc.dts                | 1 +
 3 files changed, 16 insertions(+)

-- 
2.44.0


