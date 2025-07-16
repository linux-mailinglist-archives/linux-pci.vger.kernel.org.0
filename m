Return-Path: <linux-pci+bounces-32316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBFCB07D58
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 21:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC3A7A13D3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F78C27EFEF;
	Wed, 16 Jul 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PWsy9riY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F328033C
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752692594; cv=none; b=pa8vnP8/bJUDRlKxZi7PNHqnlZEJMsAJa24zZGy3zGNfVcU79bZq9ZOh5BbZQB4A2uEsGYA7nUNXK8G/s+mIqi15rOLWpxogGp/J8fMloMLTmanLxdbxZiNl/LnvcPlCKX9EY9gaFiQGJsorIxr3TUisCN8S1bStuwNwb+rlK8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752692594; c=relaxed/simple;
	bh=TyIh9BYUvuw9uBSJD29s/Jg+laOpxEg0CYbAq3xJajc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuvddDoPSRQpiaU9vhPSdRZMR9T4tVspGbWiTde4UgriuZ0pLfZTY0EQR/JQkkfNAEkmYJHM5yZ2b7hfYQ4LQR/9kQrLTU7z/hfRxB395qIyI7uswtcpUXds+OaESHed7VMamQTHRKwVOM5/8FeO2KyQT5qnBA2F+8sxE8ssE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PWsy9riY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2363616a1a6so1166275ad.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 12:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752692591; x=1753297391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iF5Uc+Od6wdP/zXTuVFIkz/CthUPzEMkqlakKPK7Ao8=;
        b=PWsy9riYI4yygIWcmuNH3YtsdKIdPkenFxWIGSU8K3Ny/a3djXW9AnJ1DFjn69VW0e
         tk5VjcZ8fYw4yPJhTbhWGTfbfPKgsH3D6hqLVlgx1IEBFWpvxBICwYhn2oOYDGEc5naw
         jG4QJ78fTRHO1ztp62b8hTRU7N8jDUnpYzKtwaj9aJMRzarIkBlCRMlwYbwmR+UZgHVS
         q2NQkZE7d7nvWDcigCtVttE1/PZCFokcDcid/xA++Ju2UByz6o8Uax8FBqrdP8+RNwYv
         N/aZ+qE61FbPnSKTUErVhxI0rlNQ2iiWx/haFsYAmTzZNgS5PxHUBkGeEjmFudQTsHC0
         agAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752692591; x=1753297391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iF5Uc+Od6wdP/zXTuVFIkz/CthUPzEMkqlakKPK7Ao8=;
        b=D5AThjUgVesl60l/fMQybgYnrigQVySEkkbE9B/yVWJU0hn4MmZEjIpiVZZawDSVue
         a3vJvaXEYPoYPXzWr2d82AZInNrfssx3UEK7aSJWFj7aSehFBuYu+jPl67HLsnz78sTa
         vrI5CYkaIdpXwEnTUiFUqyMk9d8RMAzr/dGRKRRWQ9+PSV89bjI4MACmr9ftidfwfikl
         /6H5xht9CYWjaAbNfODunjZ8AXLBsUmBV9+WACIQZc8ksw5qKHpFOmkjTfveLLIJ0fDs
         f38/3ANEr66rrPZOwJSS6DuBdATZKdfiBC7+gAxeGRNy7lQsO3sZ7CgNrRLJ8Lv0CII1
         R/ZA==
X-Gm-Message-State: AOJu0YxkwXzCexN0pnjszIInFqwnViNFIDhTDn1D5iMUFNDiIydm4Ygb
	uXu9TcA/68lJVW0PTQHpxzN3xT4axmEzhilKaQo9+QstsQeVuZJ7nF8Jn0KSS67ZSGlVzH1h4e3
	FtoWpK1d49HZW2qp1h6tGiCI7lmAVY7qw+VPfWFOurqNfkAPhO7iFnKqckUDObpmSUIIabOiMeQ
	dVFqvoaHGk7nzixyIhCv3I+aYuD2b9OOFreDzKOAE3e5jq2g==
X-Gm-Gg: ASbGnctwfriI8Zhh9IuBJ1+Hkyh34ISV4nbJ/UltajhpcMFHzqq19e7qiRnOtBFMzb6
	8UU34Ij6waaHwRRxlAF1ik6yCLuBOK9py8Sef4kX6fBQ30GAqmHYFr5pGShkkqWykTxPiFWWE6b
	dzoyIfOAFuo8tUAgyStPEPNOJceO7h2nozAgbC5YZ2jLpH/5zzpu51sVsO78L+yC2b4JoZAAbRK
	XHBWDozF8pxTaKPtuqe96QcPT4POqlax8b4zwVhJBPLc7sLjOq1pjp4kNLNv2ipBwjAjd/ItpFt
	jjw9zhKnqJdLwMvku3sIeRZSFZ7s9hE4vncnwW/TSiz9y33doG5LOz3muWr2fAyhBOdK+aNiZUE
	IxDC18my8ovUir8QSkDUf7WUT3wKwiVk9LKNpZwDJXbmYbEaZ
X-Google-Smtp-Source: AGHT+IHQ1pVCS0Wzji64GQhNJGuLn9ioF4xGIQGqcuf+9M/QFLer+83IavfwNdYYM6RrlDFUJqtROw==
X-Received: by 2002:a17:903:3bc5:b0:235:6e7:8df2 with SMTP id d9443c01a7336-23e2575a8d6mr53475405ad.41.1752692591121;
        Wed, 16 Jul 2025 12:03:11 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de42864a8sm130323405ad.42.2025.07.16.12.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:03:10 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	ashishk@purestorage.com,
	macro@orcam.me.uk,
	bamstadt@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	Matthew W Carlis <mattc@purestorage.com>
Subject: [PATCH 0/1] PCI: Add CONFIG_PCI_NOSPEED_QUIRK to remove pcie_failed_link_retrain
Date: Wed, 16 Jul 2025 13:02:05 -0600
Message-ID: <20250716190206.15269-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kernel config to allow the removal of the pcie_failed_link_retrain()
quirk. CONFIG_PCI_NOSPEED_QUIRK=y will allow users to prevent the kernel
from forcing a PCIe link to 2.5GT/s. This may be beneficial for systems
or devices under debug as well as hardware configurations that have
demonstrated a high degree of device compatibility & are expected to
endure large numbers of hot-plug/error events & always arrive at maximum
speed.

Matthew W Carlis (1):
  PCI: Add CONFIG_PCI_NOSPEED_QUIRK to remove pcie_failed_link_retrain

 drivers/pci/Kconfig  | 9 +++++++++
 drivers/pci/pci.h    | 8 +++++++-
 drivers/pci/quirks.c | 3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.46.0


