Return-Path: <linux-pci+bounces-39365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B28C0C914
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A70DC4F8DC2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB682F6915;
	Mon, 27 Oct 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzNWtaWR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72022586E8
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555800; cv=none; b=heb9VJuk3x9vOHHKkV58Y0t7GvE/5mhHhZFUfNM0EjD1/AahY/yHw4iRSHpz9x1s+m05Cvz2Rq8VumZLZ9CZxSs1Tb6Je9VqcaNGGddko3q5jaiCdewPO0HQMgV5tZV+IlsYyERvEm3K7L3HuS45T+gOeZWLz4tDb0feg/NI6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555800; c=relaxed/simple;
	bh=39JSbHmlk2Zr3lfvER7UAMC1eMXf7kaYCS5xIFrjxks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbRIdXWlGVu/SNiCq0n0KfmlodzPudbM4X7Yhvn/I4xD5oQbMQnynANXWk6toi62yZq+5nYDDvvqZ06nohxH0felGxolf3ieoHYKsO8z5qJJZlYXpEGvn5LxYWhh0kHWsaYh4k4TLxU++9gR6E6OOlFEp7TjCLX/1KGc/Cdus9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzNWtaWR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso3628903b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761555798; x=1762160598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2Xvuh0I/opmY/ziCGQafTK7nM7PxgpGRf3XOAE2Yhw=;
        b=ZzNWtaWRYmLgwI9k3YBLb+T1N9jJdjYIVjdts5PR7spwERLViiQHh4NkjoGOEQMdsc
         zSL4EoO0CB+Nysc7i7sPhJ6iaj4vUtyvgFTD+xEiYxUAuRnlEC4tU+pCmVU8UwwX7mYD
         sk4B+eSjiZPoC5/UHbiJQienmXvZIDXThBv2TdDBBxFnU19OWM+WhKnAJby/T7AbMG8a
         FDdq1oPMfP+pT6jb5PiLF/+pzTUK4HM+99BZhYtUFCHgXePuU+TDb8byyKvO+2FCch7w
         6ck/QzLriJeCEx/7menunNc/DBqfobox3lYU7i6nnOumer7Ed3WZQMvInKWNKMI++ruT
         xFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555798; x=1762160598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2Xvuh0I/opmY/ziCGQafTK7nM7PxgpGRf3XOAE2Yhw=;
        b=WZbWLZYMnGE4g+yc8FsdUDSWF+3zOb3w9k4XHKLY3lsized84ICTcMsIbYgO/kJ0yn
         nYF2hxZIhSHjJp6u3BWNgzFxCsp8+Ma9lggFWwQdM0bEoEhmVTDCjkEN1SxUUPXuVZhy
         zjOBa6fw1qPIY4vYDyqc5EWvvzyWE/z1S6hVdFYpDMot65BSvXqVkQxlqqpwfWIdPbaf
         DegbwK4lK4Qx7dt4rCNMfz4Nb1asZ5+WP0WcuRaTt2grpQExjDCzPpfGeuUIM2peQbdi
         XJ8abSBo1Eq9j2Ad8OUG+KetNBfu1SDspX0ZvNYl419Mbys1/Lia7/XFgBG/ujb+c/wd
         Ygaw==
X-Forwarded-Encrypted: i=1; AJvYcCV9AHA4O1MNutKkNC9pPOqbCeWZ/u7CA/QV2x1LEFJPyq7p36N3pl2pBgXFEg5Nn7MY3/THZmtQQf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVRF4Xdeh2fBeemB8iwyYuBWi4eI1IwyjrsYm19pQO9OyRdG5
	IJ/pVstBDP4B7o92O1uaHwz2/pnPxHBZRD9JvinO1XolfJ/sxKIxI+L+
X-Gm-Gg: ASbGncujuHaupXJ6n8GDK0fZzFx1fLLscz8qN9YVOb9IzDiFKD/sbGpj+rH7JgYjTPR
	2gcuj7cszCjbyiZ8FKJCzTyH2DqHdIBKpEyMbjK0LmUX6rDr38DZk9LW0kAXBLMt4jMXmwmoQBG
	pWnxMLU4W2SIHSnL8RqtWaR3kcEk6Zh6DQb7pOqR5gfUjZldTftBdYdn68H1wQtLCrFN54K3XUl
	l9HhP90p84T3RqtI7sXzAOFqNYPYhi2/7nFUidfPwvw3tAhwQMCYOmomGd5FDs5nwBTPfFVQm1d
	3JpkmAVuWFGZYLnocHvV4O5rYdn10KSrmDHPXPeMwXtZLnhiZ/Ugf+gaODAfSlic/ZFJanojY6o
	C9UAI2nBJLm2NqWdLr0D0UKVQJ3FI+KsH6yJoQASMbJgC4eVDcIY0zDUjKmO+X8Y6mbkurmV9h4
	ffO/zpfdU9
X-Google-Smtp-Source: AGHT+IGxRWBU+fTBAW0RgqmP8oSsQAfOzUEn3iCBlYhHwERcOsccVd8fAGBDoZpy6feb1Z5JjqF9+g==
X-Received: by 2002:a17:902:e5c2:b0:26d:72f8:8d0a with SMTP id d9443c01a7336-290c9c8c7c2mr441668685ad.12.1761555798089;
        Mon, 27 Oct 2025 02:03:18 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3433sm73881335ad.21.2025.10.27.02.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:03:17 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 0/2] PCI: j721e: A couple of cleanups
Date: Mon, 27 Oct 2025 14:33:04 +0530
Message-ID: <20251027090310.38999-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the J721e probe function to use devres helpers for resource
management. This replaces manual clock handling with
devm_clk_get_optional_enabled() and assigns the reset GPIO directly
to the struct members, eliminating unnecessary local variables.

These patches have been compile-tested only, as I do not have access
to the hardware for runtime verification.

v2  : https://lore.kernel.org/all/20251025074336.26743-1-linux.amoon@gmail.com/
v1  : https://lore.kernel.org/all/20251014113234.44418-1-linux.amoon@gmail.com/
RFC : https://lore.kernel.org/all/20251013101727.129260-1-linux.amoon@gmail.com/

Changes
v2  Drop the dev_err_probe return patch.
    Fix small issue address issue by Dan and Markus.
v1:
   Add new patch for dev_err_probe return.
   dropped unsesary clk_disable_unprepare as its handle by
   devm_clk_get_optional_enabled.

Thanks
-Anand

*** BLURB HERE ***

Anand Moon (2):
  PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
  PCI: j721e: Use inline reset GPIO assignment and drop local variable

 drivers/pci/controller/cadence/pci-j721e.c | 33 ++++++++--------------
 1 file changed, 11 insertions(+), 22 deletions(-)


base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
-- 
2.50.1


