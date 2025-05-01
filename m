Return-Path: <linux-pci+bounces-27068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B844DAA6103
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 17:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA2D1889B43
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD17204C00;
	Thu,  1 May 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5bZ6jtm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764CE1BF37;
	Thu,  1 May 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114988; cv=none; b=fOy+TWYYB/hGQ/IKe1fJoO/IGrLXCKt/CD1toOvyu1JLmWkGdPMLXhQzffR/e7QAMWJw5pg7Gbx94SqTTd3w5gUGBDGfFprTFNaIjdoFiMZnYsYUSklesJOErzHH4oOqIFwjJAn3Xqd/5hUc8rPVx9AUcLkUbY3CqRVwVlzQ/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114988; c=relaxed/simple;
	bh=H1fNj/CakZBvpJsUCy07rk5bya3VmD17bPcA2zPX7iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ccws/4qcI7kN9iCbDkXZVRKuN05bNLudiaepgDSEJNJgiUG4+4OpFi+5CGB9eDzCbpeyzkLk7YBP4MoK9U5N30UR6xck8g+SMRFEHwYNtjptd1KGaIBbmmdDibE+SX4JhbnnVZZmZlpgC3qxq3K+RVnHoggi/PmuZOkrnpa0il0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5bZ6jtm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso6673225e9.0;
        Thu, 01 May 2025 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746114985; x=1746719785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUtziZ6CdgJPkUUTKYy83P04/OdvunL1Qfhe4qlBO24=;
        b=Y5bZ6jtm55UsTohxqV7x6SLgGZHXL+SvxGZsc0DBcSE2oTi0rL1C5Daff8cuKUGSiF
         oDbXnJORaMCd//iivbqR7ukLqPCEpbwK8knOavmGEOFydmP/E/CrYv4j1z3Ylj3hmusQ
         M/cnX8tGmdl848kk83nTEX4ONlrpJa1f6uc9hgTawAdxHj30mEdW3bSShapg+4LKYsoL
         p0hKG8n2Fg4b5qBFgv3/hcXj1KYzm/IbXI7yXrJCjtydCI/OIYB5TMf5a6wuW9YXb8Ko
         6jhVipIQAi4lm1ZTM+zusiVZs2LzzWU8mScZX/fWr+Okk2IssHFG/b9rgiwsSv/Cwrmv
         HtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746114985; x=1746719785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUtziZ6CdgJPkUUTKYy83P04/OdvunL1Qfhe4qlBO24=;
        b=owvcZhhmlFypBnYtjI7zmbahP1i208vNl+ouqLtdA24S7pK16Owz10GhbLghKKgoFl
         t6fDZxGY1sZUFjYexuuus3zgnXKAfY5NDIALuh7BC0llf9+FNEFlVO3MIvMHE8dqfiqD
         74069srDIiNcuL2Cm+hF08gF5fTBsRpT8HOgw8FnJoR4x3sZPiQ9fPU8brRUgU9X0+wy
         ZSSESBSszSrqubTSoEG9d+rpVFREM4/0TPQLsLPWzj1VFzMp/mVTnNFsf/IGgcZhIJNS
         1N57uzcivLv6TWpAqlFdeHU8xVw9TUhJ7x7P7uFRP9MF9jlewy/83LrMomHsFrDCmdsb
         6J6w==
X-Forwarded-Encrypted: i=1; AJvYcCUrf78VvsCJXF+yRItHUWIGbopturyNl8Lc0mK8I2DZ3A1S6Jw3jtiNY4WzyOg4Of+zdk/bu4b0COUo@vger.kernel.org, AJvYcCVyHIvi7KaSdAGy1XXe5RmNRm9DwK8xdL1L5d0a3TNXs2Ge9A3XWXAgIOZALIsXratGc7mc7hEhszHFPJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfQCi8pBgAh2b59LxQUH+kv6O4HgcbvR6XN13JSReQ6QIY0a9a
	AiqX9akCR4LdMI0uqSj6Rwq9QBAyPpjzu6dWax+4ghcWLLor89cp
X-Gm-Gg: ASbGncv4PQHqZKM5o3ZsX47xWLr7HZql51vGO/TglND3jlTp9R+95mX6bINsvr6F+Va
	xv5Es/rZIdfBVartZVT5aDVtp3oohphAqRka7vIgdCcBYTbD7oC+rfreEIOyyjZxnk5Xcxf3dhr
	kEYhv7rL75JK0lgVIufym34wU6FEOmiuPwb0+spKB4KFsxSVqTJDua1ybCvaZH9rKVzYIJsvk1u
	oELc9xeL/ZgI1n71CdMX7NXClOqBkoOHbGSW4aZfcrC2z2hTQvL5J3V0z50dqy8sMM0fL7cuOZZ
	P8AflNEzU+bsu7pgQdiI0uE6CEV0s1GMUwEpzg==
X-Google-Smtp-Source: AGHT+IETeYrIGjejYMYYwg9fuX5TFzLcyAJxcf0oW+2E2LtWOD14TYWU9Jhme1v9ggIySPIqV/QOvw==
X-Received: by 2002:a05:600c:3e1a:b0:43d:174:2668 with SMTP id 5b1f17b1804b1-441b715a687mr25533195e9.0.1746114984606;
        Thu, 01 May 2025 08:56:24 -0700 (PDT)
Received: from pc.. ([197.232.62.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89ee37dsm16226065e9.22.2025.05.01.08.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 08:56:23 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: manivannan.sadhasivam@linaro.org,
	kw@linux.com
Cc: kishon@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH 0/2] Use scoped_guard to safely manage mutex locking
Date: Thu,  1 May 2025 18:56:10 +0300
Message-ID: <cover.1746114596.git.karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change replaces manual mutex locking/unlocking with scoped_guard
to ensure mutexes are always released safely, even in the presence of
early returns or errors. It simplifies control flow and eliminates the
need for explicit goto-based cleanup blocks.

Erick Karanja (2):
  PCI: endpoint: Replace manual mutex handling with scoped_guard()
  PCI: endpoint: Use scoped_guard for manual mutex lock/unlock

 drivers/pci/endpoint/functions/pci-epf-mhi.c | 358 +++++++++----------
 drivers/pci/endpoint/pci-epc-core.c          |  53 ++-
 2 files changed, 190 insertions(+), 221 deletions(-)

-- 
2.43.0


