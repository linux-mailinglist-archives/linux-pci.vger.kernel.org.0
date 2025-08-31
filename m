Return-Path: <linux-pci+bounces-35198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0355B3D4C5
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 21:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFEE18983F3
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 19:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C6C21772A;
	Sun, 31 Aug 2025 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhQi2lmJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8AF45029;
	Sun, 31 Aug 2025 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756666865; cv=none; b=LODkv0MP1tdZJW8tIeEKE5Ob+InmmPHCiJnREdzy6wrnG/EDve90aTBEB/ArytIZOGIo3cAIRjM3Q8bZLO35KE/f+8JL9GoRaSkiqtp6B3rn46P3GKbzV8tGNUBbSBo4EXEbLz2+tEkhCtcjPg18Nl84KpXVtNEQuLrtFwkgtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756666865; c=relaxed/simple;
	bh=x9x4yAjQdc9OshEv6rCBbv0t6jvRuV9OYkiqBmKru68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MCtuFXA/8cqEHofB3R6wuvDwVcWz6MAy3vTdUVj3vf/YQWMsXhnIST1aCxSQjg5WbNG0aYGpgv7PlqjgfUv29SqXq9hpLlDTAeJaE4terAUNbNhvaJOu993jRHXbSAk+35S7+yQN2D6vUcGJFxYS/hrKmLZK+DesBb9Xk/TsD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhQi2lmJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so3557938a91.1;
        Sun, 31 Aug 2025 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756666863; x=1757271663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vrYs9YxYEtBoI7/YEgRrxmn25mpmua4Qc6VJAZZuAA0=;
        b=YhQi2lmJQDCH8UQxKKjh7XDj6nsUhRrWdwZc1/PM8z8EZaE87lbX0rgJ/LFTQ6pM8X
         ZPJT8fq0mqynHuAM0jpXepuUFDY30GUo1nhPywFpA504jMQKaQLhcMq6tSBsIohSlTWP
         fNJGKb8LJ7UrHzPpqfrUznv6iXvQzW98rWpurOeF5wLCnOtohQ0LiFgP+N3IsRank4m1
         3jrArrGc5rdbUdwHdBD00qJ1arzqBJNpUXq8ddGysJQMmd6YNZMHbOPuMc6IFxtKOAUx
         VUx+jLYHgfaNO5pZ3UjFZ4Hmp+OJgvl3siQmUbV4jlH5T0kWwV+BgDroiSAOSBEz9v3x
         6vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756666863; x=1757271663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrYs9YxYEtBoI7/YEgRrxmn25mpmua4Qc6VJAZZuAA0=;
        b=C6TwWlZP3wHmzL891Kiq0P7ZfOoiZlmqEoHcZntyXNk+8FaVLDi7CTDgaglI01/+gd
         P4AVfyHJpEJ0J21CUcuAlfmuaU5Wp0+lWIb43LaxgjNv1R4r+z8zKvbOBinzvLBNJ8zb
         YGGFdxerJM+kJrRsrjEqTeBmr/EdHzmphZhm12mGY2Vc5I4PG9eaifYEhTy2pDUCzwuT
         HccAzbvigk3eDi6vc3g9r7Qsiso4SsLfJnofDt2HXO7SCvKxOMskOcrCCz625AjrSlX/
         rfU3wfvGGV9EFQlN7KrbmE0tzotC9MtVLHI1/n2lmoRxxNVU9Tf4gINkIeADCDOzIaJM
         lM8A==
X-Forwarded-Encrypted: i=1; AJvYcCUsozHyldltb3uFBIJGR2VO7bBsxV3tAb/bExDBdz3th+Li97ZsXJYa+tzGkvc3cNF2H7DnnSywCeX99jc=@vger.kernel.org, AJvYcCWK/quMDd8uivkfV60Kh+SV6W4euQKZdP3EBxwIXy/moaIASDUG/n3EnQR29kpS+SNAUHEnFXYaFI/3Hts=@vger.kernel.org, AJvYcCWd/LL8d2TeI00tVYavv2GQhOzmvNv/DnoFQysCHaNn3GRSi+sgMT5vm4eyPiTqJwCRC/+3hnkC/vgc@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMCXVT1LaHa68JWfVBSDPbmfW+z+UagXlKpPWod+fuX25dgIm
	gwQxuvyxFq2D2zjRODZiMgHvzdEjDc1J0936BDsWQTT+GQvZ8sdWgdbm
X-Gm-Gg: ASbGnctYKVRTRPQZ0ClF4smBmsyXfMR2Djhm5l3j6Ni8NFwNAbrDIUAIyLf5EUnx0Wg
	L5cz1Eah5R+qc3rB5r81llnDVOW5z2WkXKN12HjgHrgevTEuuxk6595ni+MPEPLkzdp65cJBu2k
	lW42Q/g5fJIQwr62mjY9wII3PUKJPpM+nX6SrAN+Y964acP4NlCTjR/gXwjDxksTEaAT+LhGbny
	fJW4r6f8nBRYfb3VCAVj6fRQOSXoLbBBU+4IumzseHH0eHi9jO0AWEwj5+c6nqgNrIjhA58x1LL
	t17RmNoGIp4qITsCQJiD5tUw/cUOVigGEBIznVje5hCm1Uu8A724gaOiKBHDb7J2Is/9flCqgVc
	YDWsEZrfrPj89YjGddjbA
X-Google-Smtp-Source: AGHT+IEcNVi2o7VXme1/DBaqQT0UJas35BqIHk2Q4/LySdHxKGnn+iZMqV4YwVhzoo0U97CVXz6YIA==
X-Received: by 2002:a17:902:c406:b0:231:d0da:5e1f with SMTP id d9443c01a7336-24944aefe1dmr60484695ad.21.1756666862940;
        Sun, 31 Aug 2025 12:01:02 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490372723fsm81118355ad.39.2025.08.31.12.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 12:01:02 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RFC v1 0/2] PCI: tegra: A couple of cleanups
Date: Mon,  1 Sep 2025 00:30:49 +0530
Message-ID: <20250831190055.7952-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This small series provides two cleanup patches for the Tegra PCIe driver. 
The overall goal is to replace custom, open-coded logic with standard
kernel helper functions.

These changes improve the driver's readability and maintainability by 
everaging modern, well-tested APIs for clock management and register
polling.

Thanks
-Anand 

Anand Moon (2):
  PCI: tegra: Simplify clock handling by using clk_bulk*() functions
  PCI: tegra: Use readl_poll_timeout() for link status polling

 drivers/pci/controller/pci-tegra.c | 109 +++++++----------------------
 1 file changed, 27 insertions(+), 82 deletions(-)


base-commit: 5c3b3264e5858813632031ba58bcd6e1eeb3b214
-- 
2.50.1


