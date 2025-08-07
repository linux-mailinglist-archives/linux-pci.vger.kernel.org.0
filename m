Return-Path: <linux-pci+bounces-33541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B0AB1D68F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 13:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D6B16EAD1
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 11:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDD2238140;
	Thu,  7 Aug 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwIYhISs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B2A43164;
	Thu,  7 Aug 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565855; cv=none; b=TGmbrj8JIoMfC9+fXr1hW7cfzaR+1p39lSf5zOMSzJZJFc7oOcdmqGUA+jgFCh/gD6wfKswEPOrynaMSP5OpwS2iyV3J+a46MAgxnHQVnER9jg6sTTk+Upa+cH0EdWNaXjjPF/h7S6yK+Qgva0sNViGK92aSvcjzSAgRy/xxuJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565855; c=relaxed/simple;
	bh=13bO3mosqN7XaGSH+KmpQC/AMBz9oRks9YWS2ZwKUWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYpjqCGd8DHUrvYTka7S/zlWvOxyVmAxwR+/rKLQj7evKipj7rCt6dwU5GnOD2DLFlYvt/XwwDVXeRwGwwxq9/0Vny1xs6PHYD2irwWByC3PfUX/ZFVtwxzmWrNG4L6z9Ef10NaZW5b4H0Z4Smdhz6PusWuD0c6hNdsL/8OP3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwIYhISs; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3324e2e6f54so18354321fa.1;
        Thu, 07 Aug 2025 04:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754565851; x=1755170651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nppKGdh62wkwe6uXDGvNrJpkZuqQuluOhbTqI/PoE38=;
        b=cwIYhISsBO7QOubeClZRWEPz4JJoskI0TLlO6OgbHk+Y19MZ1NEfybBL2A9J7CBqJT
         AcGtoXPPMSQpwpfYX7LrXPa/hACJB1TIxs1ng3ePdibLc/I/iikCq6zQfMNDng2OJvCh
         bKTYvgn3rLd14eVn/3aRBLC0M2Dhi9LQRQS2/k+Ljk4mRctFaUmAf6JX/g+k+RYEKrw1
         5GZ8ny7QO4BVMUir6N/l72lnbAPpcZQidZRKhWY2VQz8NmLnQS3c4CFmSzRhq5L1rU5j
         6iColIHoX92RfWr+ms17N45m2A1eDUqu/wp99J2Ijklh4yJaFt1zQXRkWeptqJyjNL17
         t3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565851; x=1755170651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nppKGdh62wkwe6uXDGvNrJpkZuqQuluOhbTqI/PoE38=;
        b=TsL0fjkbA+A1MCr95W3j/IpL8xKE/C9xRl0QeK4hzEYixF0oH8C7yW3nDK45up8ely
         E3TDrevjEpWdnKMWNb7BEnDzzgeiKj+Ciqk4w8qQSmLtSI4dsBIkwxZuMwLZhR3CgaxR
         80oqt+kv36stMsUYYMhLokk1WjxF446azqmMGGCDscVg3rcLvuBQ1ROriA0MJ6Bgq+4M
         LxH5t4VMRFCMu/nTlJQMm8Px6VovJA31KxNCItd1SK99C4UdvjbfeF3GuncCOk+1Y+O9
         tSRnJD84oWJTbo2fZ8b4eTbpaOcQ/Ysw3vChIVZUJXN1NGwNzQKrYKKHcDvxlTkAqYB9
         6w/g==
X-Forwarded-Encrypted: i=1; AJvYcCXGaodaT2am98+UetarhFjU8ahVCSyWR/pWmkV0bRwYnV/PHP/2xL28OpXtZcj4z6PlK5YJbebe1qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoERZirG3HR5vPPcdts6NuMl97ZnBuA0ppdbLIPR/lGFHXTkaB
	NLi7M1a4XV3qUoNpaFcgOVyzdqjYmjhNFpfQ8xxrZiRYwIweFkPePiGf
X-Gm-Gg: ASbGncubAbeANKwOwdA3/kahhHdNuqRYj3agNTgTz9h6N5MozWj8UdiDdsfJz6+M0Xs
	UrBp8jlsaFdKCh+2PiU6dpb+mua5gEh86a3LabbPT7e1aOLhjQ1i2j39bFbzCyu6gXupXWQfeJa
	jK4/r6eweMZrd+oDrdY1qCjDXKQWcSOXn/4VGcuEBElRsu3+epE4lLAYpdQN49rqiKBIGlf6/BQ
	RmqPu5XbOZ2zipfKeOJci2dx04n4wutn92fSUzB7gFC0Nyqs85zPJ4B012yecGzf2p9K+HFtsb/
	AH7Kn+cT62ESG2PgwFjLwwmpaoxvCt/ZMLDkMtSSNLI9beEOS+j1NTrSwaUJ1CN5VoKovEOe4jt
	UgFpVv2Y4rsN55g3i0Ns3ZQ==
X-Google-Smtp-Source: AGHT+IEAoeaF4wZ8gCJUeXiQDcR4+Vw/BkT9iQWpSW+C0+vFih5wfcUMtoKhPHLBPwI9FXiclDTVTg==
X-Received: by 2002:a2e:8e8f:0:b0:30b:f0dd:9096 with SMTP id 38308e7fff4ca-3338d17fbe9mr6220351fa.12.1754565851026;
        Thu, 07 Aug 2025 04:24:11 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-3323827290bsm25907111fa.8.2025.08.07.04.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:24:10 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 0/4] irqchip/sg2042-msi: Fix broken affinity setting
Date: Thu,  7 Aug 2025 19:23:21 +0800
Message-ID: <20250807112326.748740-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using NVME on SG2044, the NVME always complains "I/O tag XXX
(XXX) QID XX timeout, completion polled", which is caused by the
broken handler of the sg2042-msi driver.

As PLIC driver can only setting affinity when enabling, the sg2042-msi
does not properly handled affinity setting previously and enable irq in
an unexpected executing path.

Add irq_startup/irq_shutdown support to the PCI template domain,
then set irq_chip_[startup/shutdown]_parent for irq_startup/
irq_shutdown of the sg2042-msi driver. So the irq can be started
properly.

Inochi Amaoto (4):
  genirq: Add irq_chip_(startup/shutdown)_parent
  PCI/MSI: Add startup/shutdown support for per device MSI[X] domains
  irqchip/sg2042-msi: Fix broken affinity setting
  irqchip/sg2042-msi: Set MSI_FLAG_MULTI_PCI_MSI flags for SG2044

 drivers/irqchip/irq-sg2042-msi.c | 13 ++++++--
 drivers/pci/msi/irqdomain.c      | 52 ++++++++++++++++++++++++++++++++
 include/linux/irq.h              |  2 ++
 include/linux/msi.h              |  2 ++
 kernel/irq/chip.c                | 37 +++++++++++++++++++++++
 5 files changed, 104 insertions(+), 2 deletions(-)

--
2.50.1


