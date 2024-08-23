Return-Path: <linux-pci+bounces-12077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D8595C949
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 11:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2556E1F230DE
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6114B97A;
	Fri, 23 Aug 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1Ezp5jcP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3213A86C
	for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405616; cv=none; b=n8SUnOKS5qtJLxBqshFu4b1y94WJzGPuiehkgvZ00OinS/mInOJuz88CDnntB6j8uW3AVWdjUGgAaQ/EPncXJZx9TGgo1nY1QTwgRPdfIAvtbAHS1YG0tYeweigQpbpWOf8BXpjIEGrFRSB0vcsK7DbI1ugPrMCqxWAnGLq/4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405616; c=relaxed/simple;
	bh=yXAQbDWUQZ6r+nEz8nE7n9kw07wLSRQo1x8APZyKjuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KbVj/Vu0KZr0BRWQAZahUIrMRiNDV7rZgi7OjhndqRCNIt0UKuzH8j0sUaAZEFZi80C2Mmj/Mg6YnO69Dh0HnsZWV7UHhdKFzpz12NNOGzCLJY55WNrgnBqwxpjVmctUNad+iiscaQXLWR1+DSQNPUybVbDYjXamudv0viiN064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1Ezp5jcP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428e0d18666so12721695e9.3
        for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724405613; x=1725010413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=89Z7LwWjklZhnxkTO/oPThGX3SaFwawp/+SPFmQXVtw=;
        b=1Ezp5jcPno2CGVnXhvD2833EudSxNrcfMNVxiX3iDFLZwPeaQ//pHuxvMhqoyKc4CA
         2DjZOF4Myb56uH4UqQpzpCUFi8oBKvMLZn3tba6stu5EA2WrbfoCYA7Plk+BBpvgzgVY
         i4vYvSPiea6Y92Tv+2jFY1HIFZkU/6Vz3Jwid1kJTsIxDd3AomX31t3JgxkFju4Fut2R
         MqRAPmbRRv/O11CG+PZHOjPmbP2hyXehadPz+yhwr01LIMaHTMnR/lpux0usH964Dhhs
         oI0t3cV3JqQbKlSXwevQwwNCETFc2X6gZU7F8no57bNQhMIRUuTwFh/v8heV3EtEnvry
         t3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724405613; x=1725010413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89Z7LwWjklZhnxkTO/oPThGX3SaFwawp/+SPFmQXVtw=;
        b=AVo/JKHZO4I5mnKYsyHaGImvaN8Aut2DhZ5uL2hIe908J3vOClWoA3DSyavszRe7YU
         IxELmM94raWgAbqXqFojrsZrEqDhczXWI4gaEDa+vggqPqYQ8jOfRYRrtpzCPCUty+JN
         PAI8+tHWqirClxy4vwBABQy7omuE8kSAaVzxjwDQtELJHJHDwpHNlhYOsE+ZiPyWd2LJ
         EY/PR9wcnFXiKFJw/8+i9am7jakqNV4r4HzSUyIXKQEUAEkcGtvGs7rbNroK0dd8Wooq
         U4XwmrbMwABHtpXA1M0b2HLvwWXQnBQ9fjVYCEUeoz7Vfcs0Kg9IftC/mrC7yyFMJMAz
         3vKw==
X-Gm-Message-State: AOJu0YykcDu4k56pcArO0j++zgf963RjclBInkc4yNeYHgu+c2rWXbRq
	jyOZd2Cxzn6RmpIixJdceVo+AgRetf0MUOgATuPnhoM7g9az9oyEeETEwli+iCI=
X-Google-Smtp-Source: AGHT+IGkniwla9gjN4/yqKrzNjwnr52TiM77GyCtRWPf0X6VoILg5G2zYHffC2xwjmkIMJIIHH0Ucw==
X-Received: by 2002:a05:600c:35c1:b0:426:627e:37af with SMTP id 5b1f17b1804b1-42acc8d3772mr11594065e9.3.1724405612352;
        Fri, 23 Aug 2024 02:33:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:58fc:2464:50b0:90c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86d5esm87612035e9.15.2024.08.23.02.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:33:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 0/2] PCI/pwrctl: fixes for v6.11
Date: Fri, 23 Aug 2024 11:33:21 +0200
Message-ID: <20240823093323.33450-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Bjorn,

Here's a respin of the PCI/pwrctl fixes that should go into v6.11. I
eventually found a solution that doesn't require Krishna's topology
change but Krishna: please make sure to update the code in
drivers/pci/remove.c as well when rebasing your work once this gets
upstream.

v2 -> v3:
- use the correct device for unregistering the platform pwrctl device in
  patch 1/2
- make patch 1/2 easier to read by using device_for_each_child()

v1 -> v2:
- use the scoped variant of for_each_child_of_node() to fix a memory
  leak in patch 1/2

Bartosz Golaszewski (2):
  PCI: don't rely on of_platform_depopulate() for reused OF-nodes
  PCI/pwrctl: put the bus rescan on a different thread

 drivers/pci/pwrctl/core.c              | 26 +++++++++++++++++++++++---
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c |  2 +-
 drivers/pci/remove.c                   | 18 +++++++++++++++++-
 include/linux/pci-pwrctl.h             |  3 +++
 4 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.43.0


