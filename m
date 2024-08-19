Return-Path: <linux-pci+bounces-11798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89600956588
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 10:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467E1283133
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 08:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8B315B10A;
	Mon, 19 Aug 2024 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="08VAi1KM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D715B0EB
	for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055891; cv=none; b=tTb/WKxLdKwXozf0BFx8Fr9zD5ul/HTZg2szgUoAvXleNMEYCbkJmMgY7YRNNj5qivP2ll4M5tqE8thyBO+FJS4c4GUJ4v8NNHP0viPrySpHSrBHAlaBReHWll1UPiWCMoasicqqpsPKiWJclaNnvu4Hv+70+Jfjn2yY8lQNkbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055891; c=relaxed/simple;
	bh=FamuYlAjig7+R6Qx10U1TbALvNH2O6j/k6jsgrIpL4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ph6mKb0xuxs86GXsln1iI93BB2JdA0nryVH8wcFBkYeTSsy0CPxi+LoIIg7DoinkIlGWjYLfQsXEP5lzVZUhvlPq25atz+m8qPW5FGDeY/VUJ3gkazwckDRFm2LEoOV0/+8H8K5XcFEdipidZfEoN/T185Uf15sTdnywBhJpjEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=08VAi1KM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-429c4a4c6a8so32770765e9.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724055888; x=1724660688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIBDwkrvQYglDtNL2nrORHa/NryU/QKFWL2iAI/C8cU=;
        b=08VAi1KMRzBdh1Sm5t3/O3XyGvbaQvSOw1Yrc1HFqy0ZLgmIrtKx8Ygfp7emW7RYSi
         s6pxV0nIji+n6L15ze95PDIFIkP6lteaYSN8iI1TRyPDzk8Lz9Kjpi1qUfJ1Sw9KqJ7m
         n0nFoPWPYYgcXciDOXhE2BycmpwWHAetqc6NsYO7yES3wukNIgPBx4h+428VmU4ykDKo
         9+qHBvU4nR+OA15qXSkjARYI8Um/GWdVoUVZ3aUwoIvZx7Wo1MMZrNbqaHXjnhMKGQo8
         0UKlPYdXhKOoRbPrNPrFHQfUGmuQGyas5cOqtl/gA2NYjKKDwGPnFSIUS932dsbEEQ6R
         /RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724055888; x=1724660688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIBDwkrvQYglDtNL2nrORHa/NryU/QKFWL2iAI/C8cU=;
        b=IAmaiJT5W9HxVA1DDvaWdH6ZVHpu7nee+aK4Vr1t2Dh567HJMIj83dENp7CM6hIRuv
         gXjWE9Pw4mg/JMu3FBmwX43kmzLIiQS4Smu5yrQwlKAUBIYOQ8qlEd0DNRkN0XqYH1ho
         qiTeGbD1egEbjOpor1qbGerWSBZlmOCi0Xy+C8s3pBKQ/Kv8MuhXNzzWGqIoGPIiCy4a
         trL5kNcyJlHUrbXoZcmujlB0tTsZN06WJkY2GWJoVRXrNoY0LO1ilGzezvcU+J2eRYI+
         uL2IRWKFK8U3lbG2Z7uBsmZ0uTHmm7prfaTHuETSnrxNKjcXlGwrqaATF5MJuMIbjhTQ
         WGqg==
X-Gm-Message-State: AOJu0Yx1lt+Gl3vK10CFh8SON1gdH3pkC878+pCPk7yqkz0eu4c8LVrn
	1a0C0msc6uDJ97B9ywnlJoUPfSy0Qybg6OYLWvMxtqb/tsztKuu6/bSLzkxfn30s92IoysxfR1X
	s/Z0=
X-Google-Smtp-Source: AGHT+IFroE0AUVn42490Pv0WzAZonKNG3nvovJgY3AqmZF1oVEGmbJKI8gbrCaahPK6xzDdxQAgNmw==
X-Received: by 2002:a05:600c:1c24:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-429ed620183mr78741815e9.0.1724055888127;
        Mon, 19 Aug 2024 01:24:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7b55:8f70:3ecb:b4ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5a9sm153441175e9.43.2024.08.19.01.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:24:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 0/2] PCI/pwrctl: fixes for v6.11
Date: Mon, 19 Aug 2024 10:24:42 +0200
Message-ID: <20240819082445.10248-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are two fixes addressing issues with PCI pwrctl detected in some
corner-cases.

v1 -> v2:
- use the scoped variant of for_each_child_of_node() to fix a memory
  leak in patch 1/2

Bartosz Golaszewski (2):
  PCI: don't rely on of_platform_depopulate() for reused OF-nodes
  PCI/pwrctl: put the bus rescan on a different thread

 drivers/pci/pwrctl/core.c              | 26 +++++++++++++++++++++++---
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c |  2 +-
 drivers/pci/remove.c                   | 16 +++++++++++++++-
 include/linux/pci-pwrctl.h             |  3 +++
 4 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.43.0


