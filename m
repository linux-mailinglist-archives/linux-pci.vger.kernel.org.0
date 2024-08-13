Return-Path: <linux-pci+bounces-11648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B2E950CE8
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 21:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7B2B24058
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 19:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7A41A3BC7;
	Tue, 13 Aug 2024 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X5vVS4OY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9601BF53
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576288; cv=none; b=TpXggmx4HfuFtZbp07BExdlM0o7Y7urtIvvUEe5dh3xCbPZHHH6RzJL5xLIimmWF/15rkxE84yuOp547XboQYQpE0sFKlf7MVrKHE6NYRd4QvIj//9ImskfPKAVwfb8cO5nuxjwzuRmTKqim10TAFcAZwPaycCUDoi4RDtPtuYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576288; c=relaxed/simple;
	bh=Capz7/MVFUR8MVRPR3rC6opOLu3/h6ZEHajy++lbmZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YSmrsvMOZ/K1fXDoCX8Ne0lHZ4hGl17ORUgVNVg7Yslt+mvjTZFvaHhI7kcgFEwfBHLPCROx1DZcPn0CrUiP75A91q0uiHMjGHX9WZu5FVB3yMysfMdQWAdIDiXqOzurpcpbMEwMXtJxGo534/BjQnjKHBPimVzpQst+nqxJZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X5vVS4OY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428119da952so41318015e9.0
        for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 12:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723576285; x=1724181085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yXRoj/CRIPkOaFbXJh9rGVv+pMj27qqwtYARVY+jZMI=;
        b=X5vVS4OYAxTiiqv2S/S1LuUN75Jp4biXgKsKRSyaGfqQQxPtZ+wNK1/smgmQqVY2Ea
         4Sk+vsfhRGMFzFA7++Z6AnwhQTK3rqJuTtX9nLa9FC6FsKXHmeGZsBEbglBc/wpIAvP8
         aJ/tS/39NgrrKoStmd6gfvfrrnnCvbIzrCqdgz2QgqqNmF1SrvLpUKTeL/Tzgfr5HHig
         KrrRccv6z0aoRVIP4mKos1GSLRIR4tW74ewZ4aEYgSBgtt56hBQLjfQW7mkoEHKb8DCp
         Y7RzEnkdQIGOAenDQCVkjQdf8dtBJ+QLvWYsTcxIUkfVwqsz2sb3MyJmDSNZs1qE12vb
         a2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576285; x=1724181085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXRoj/CRIPkOaFbXJh9rGVv+pMj27qqwtYARVY+jZMI=;
        b=kLk3gc0F9YbE1VcpXyjkLOH2f9SUPAj/Yr8ksbknFAsHSI2yYjwPkfckxcAILTkYqa
         Qm3jMTy+9cYDzmvgq7mUxPfFjHFhB0kcmzUkY+/P2JOZkGsxuXkru7Nc4w8HVUVEXAJt
         WuIm8GbSaTm8R+nuY8wqE6dPHoZJRSkOA2feJ0QwHS1eDsgnfjJK0vxwVYl0/aWEwglR
         cXflZpEsgMiVbTJ7hMFQoc1BfAdMD+DYlV/qd+BORXIuiu1AykmHCkjze+QHE9rabAoV
         GpYjcEEfr01lWbYUCaK/0rIYLumXpqhsQNMnXdgNE0gHpcZqURIsHXEdxhOcDe03Gtul
         BLXw==
X-Gm-Message-State: AOJu0YxAAQX7GU2T+qfAQnqcnewblaY/Ehv9ALy5/kI3621Le/uXXKY5
	gycRvY/WU3It2rmMO/mg0ooFjEUpnt7L3mxDGTNYke3J3B+J3yEr52W04glnakU=
X-Google-Smtp-Source: AGHT+IGLyKYAHRtlezJvxZA160Zehf75EedZmMnpGppB6IO1FcRbhXTR8SS6MJ6YkukdO3EYeKb8ww==
X-Received: by 2002:a05:600c:198e:b0:426:6f5f:9da6 with SMTP id 5b1f17b1804b1-429dd25fb22mr3451805e9.27.1723576285129;
        Tue, 13 Aug 2024 12:11:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7734595sm147511405e9.36.2024.08.13.12.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:11:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/2] PCI/pwrctl: fixes for v6.11
Date: Tue, 13 Aug 2024 21:11:16 +0200
Message-ID: <20240813191119.155103-1-brgl@bgdev.pl>
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


