Return-Path: <linux-pci+bounces-28879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B569ACCBA7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640FA1684CF
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546931C861B;
	Tue,  3 Jun 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dVzWJ+Fd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3571A23A0
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970247; cv=none; b=MqQeJgsyEStVqhL8IPDXELK25vbX3V3yDhU8Nq42ZrsS8gdtHxj65CqyexpiBOx4zzFXZrS/07bOSB4ridnNd8/8hf+M5JcWKdinukrm6YPYIM1zD1Ff5aSM3fIGd86Ij2X4siOYqDBZA/kq1IBIwTJ6ZPFLSiDJQsIdCXYaXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970247; c=relaxed/simple;
	bh=JozCp67AnlSYShwlsFNUrel1ROhupwez9JoaLcJqwi0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JMto+BYRLv3kuBFUpDq1zYA2oKZyfRPTQA55RAGfX4lLh5DeX4eAKAN3p78Tj9YMUzxZrxk7q8U987MqCdgVa1tlUc0NHPEvvoMJOWj/pnN1wYKJJ75A/E1tcY1cMXSpPpidlEMVs4/9KA2535tzakZfmxTe/lHCdDtKO7kPkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dVzWJ+Fd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so585675e9.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748970243; x=1749575043; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ex2bRTEEKAaHGwwEHbqDYgjYKXMrIuwAO6C+EJ6JNE=;
        b=dVzWJ+FdW5sGMVU2X9b074UU9G4FuvQBDXUNl4rzXAOkLdScLPUNFfGeWa+J8evZzR
         UzwoUzwS97hf7Dskx+sAWfbMz4WAPvpgkA3xfDo+KGrUQ05M5QI1wKs0ixsIvXPhtjLE
         UoK1gLelIU1Sm6hG0mgIBosx4gntcbmxayoahJBLnHWLNSzMGkxcvAcy6UzL0B4B0mqV
         F2h6wMpVm1jPVtI06xd5GrznyA2YEcQub+7ALEIUUjy/3PO6xdaISX4vsm1+kIaErbBu
         xsarNa4qvzpak7HSk3HXUQDn2cEcBnxwahCo3Yw3eO87/Q13hR63J1Wa/KpeSLUVK94U
         cXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748970243; x=1749575043;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ex2bRTEEKAaHGwwEHbqDYgjYKXMrIuwAO6C+EJ6JNE=;
        b=rl7ES1mK5OyGZHCriLSIDPrOR1Y1uUNIKtxQc6/FOw2Skexcru/IC4VececKgPdjw+
         6lxHp5ZLrKRKahcvuUzSDAtzgscvUWWaOPUPBLr8UM81k1f7hMSna11albGVs+66gljD
         P8/9vM9Yj6j0Dkh1KE0hC+86bhKurrsjb8kA8lgKBZpW2HN1hsu/H5iTH5QN9GWaShpk
         vFD6VYPnu1F66dGPefDFudX2H6CvHL1vD5z3zIaqGMe68Y/flSPpsXuC0wh5kcjonyZe
         MQ1Y6646nQUQls14XOJfVk2Kb3pS8uNvPMC91S1kqLgk01MbCpaVqxeJJH3q0hd6g97H
         4fbA==
X-Forwarded-Encrypted: i=1; AJvYcCX6LchW50gZCrneJCuBqug3Wc+u4vCXQchroWRWmDADwc6fGwQbmhT0s6hH+BWoVHO4mdQDYmrLb1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx724H/UdnTD+Ki6NDxR0IG3CP0JNwVRI2yBmpc+33Iran3Mb5l
	czI+nEoiKCE3bNNUe6XauKI25Z5yntqRdOuEyjTPITS4cTBRkRNR3jy+ezjsIevID9vCpvoESL2
	FejaH
X-Gm-Gg: ASbGncvBYn3oCxmTadg+wX3HyCkc9e5A9s6V9pZrRgn878illXtr09zfkqZeXEM1vBl
	JxsiP9IGuK3Cqanr0hal8VO8VFKMVSa/FNoD2XI0TEazFG2mcfDc9pohFNIEOQpzUAbxCDR2uOq
	UhbZfaORYLq0P58gttccccagHlyCyyLSovdn8RjUf/M+D3eNpppFfZbsqPYI8Grl265L43QwNmr
	Z9lznxVEHSMJlpYcevr+8MDkFfSTgEJIxW5Gu8BdiCT5n+Z7hnJYjfUr4ndvpz6oKxjECYDcn1z
	00r9hd7wf1NWB7vTpSGJkJsxaRZMNizilQTvCmNlQ5a/BLVBSPnTCkvlf4azo90AOg==
X-Google-Smtp-Source: AGHT+IF5Dhul75lrTEl3J/ypMqK/4hDiuurg9bam0ViaibUWgPSEYcpCtLq+55HUirHbAIfEI2cO9g==
X-Received: by 2002:a05:600c:a03:b0:442:f861:3536 with SMTP id 5b1f17b1804b1-451ef0129a9mr1112745e9.7.1748970242858;
        Tue, 03 Jun 2025 10:04:02 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:ce70:8503:aea6:a8ed])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4f00972f3sm19165796f8f.69.2025.06.03.10.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 10:04:02 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/3] PCI: endpoint: pci-epf-vntb: allow arbitrary BAR
 mapping
Date: Tue, 03 Jun 2025 19:03:37 +0200
Message-Id: <20250603-pci-vntb-bar-mapping-v2-0-fc685a22ad28@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOkqP2gC/4WNQQqDMBBFryKz7pQktgpd9R7FRRInOlBjSCRUJ
 Hdv6gXKX70P//0DEkWmBI/mgEiZE6++gro0YGftJ0IeK4MS6i5qMFjG7DeDRkdcdAjsJ2ytbZ3
 r1I36Duo0RHL8ObWvofLMaVvjfr5k+Wv/CLNEgYLEKJVRTvfyafT+ZhPpatcFhlLKFzQV20+7A
 AAA
X-Change-ID: 20250505-pci-vntb-bar-mapping-3cc3ff624e76
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=JozCp67AnlSYShwlsFNUrel1ROhupwez9JoaLcJqwi0=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoPyr+4FQSbqXPzNxUs6+o4a40BkRBh1wQbRX37
 8voEuN7k0SJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaD8q/gAKCRDm/A8cN/La
 heWDEACkRo5R+AWvaG8KCmliu8MLD1sJeFpSmJhITe/w3K55jw+N4hvySZrU5N33Sa8ETogbnfj
 PTHGmakRhQsWEjLMnaq9MrYW/1mUteyRj8GZT8D+q3Ag0xznLCzuoYgHHdUP4dE4s2c7PZcpKHE
 AkDAIARsD/MnIeO2knavb4EyOxZo0o6cGDtiWdnmtw3+JuvhgWunc9LlAje7QaA/5Q7IhMvOlC/
 mJ6jCvKq4ctfXvw/yAH2+yWVVdTSBsocCttcr8ijC5WcIQ2aXvhc7ORBEk0j/ZZGy5lQW3zKMXZ
 FEI8ueAzCdaQ/f3pKSQT7fui11qcUKyxTDIC9v3w9NKWNbNMZAPJBojddW0KsiwD+cLjJcp7jOn
 gS+kcEMRT8JKmQJJG9MwOi0fGILF577h2iAUQpj61VZXzzV1baA5mQmuXym8dWERkER6q1ShC/1
 RcKHdWq8vmTVnWbMfXLbI3o6gi1ACbscmGDxeYV7I2XL877ffiuiXaBCuGICFv9JSPrgDegJe0k
 weOGNimEalQz5YmCbTcErBtSkPGJ/Y+4XR4fcMz+OHlJklsBd2dCMxIuuyeE28kKpLF3So9vx1u
 55tK7l4SWgWoCuHxf06pvvFb0JUy4qE8f3bpEJi4UGFQVJ980k9CZ0q+EvmQOBlLGQp1t6ZKG/a
 +H/ysSoDUjGNx/A==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The patchset allows arbitrary BAR mapping for vNTB PCI endpoint function.

This was developed for the Renesas platform with requires a mapping that
was not possible before:
* BAR0 (1MB):  CTRL+SPAD
* BAR2 (1MB):  MW0
* BAR4 (256B): Doorbell

It is possible to setup the host side driver with the mapping above without any
functional change but it makes sense to also add arbitrary mapping support
there. This is will be sent in a dedicated series.

The patchset should not change anything for existing users.

Possible next steps:
- Align the NTB endpoint function: I'd be happy to propose something there
  but I would only be able to compile test it since I do not have the HW
  to test it.
- Expose BAR configuration in the CTRL registers: I've been doodling with
  the idea to add a few extra registers in the CTRL region to describe
  the BAR mapping of the other regions. That way, there would less chance
  for the 2 sides to become mis-aligned. I'm not certain it makes sense and
  would welcome others opinion on this :)

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Changes in v2:
- Align commit description casing style
- Delay adding MW4 enumeration to patch 3
- Apply renaming suggestion on patch 3
- Dropped patch 4 for the NTB: will be re-sent separately.
- Link to v1: https://lore.kernel.org/r/20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com

---
Jerome Brunet (3):
      PCI: endpoint: pci-epf-vntb: Return an error code on bar init
      PCI: endpoint: pci-epf-vntb: Align mw naming with config names
      PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 141 +++++++++++++++++++++++---
 1 file changed, 129 insertions(+), 12 deletions(-)
---
base-commit: db2e86db6ec76de51aff24fb0ae43987d4c02355
change-id: 20250505-pci-vntb-bar-mapping-3cc3ff624e76

Best regards,
-- 
Jerome


