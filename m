Return-Path: <linux-pci+bounces-16936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E92CC9CFA6E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 23:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FC4B3D353
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 22:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5621E1C04;
	Fri, 15 Nov 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvwUwvJ7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397318D63C;
	Fri, 15 Nov 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707074; cv=none; b=muQugGTM+5cQXI206N8EGaXPt47GjFBNpYKjkGIWOX5/WpBVr0wGO0sJ6c6/A4x7Bq35deZTu7zRKrfaHIaUQmWBTGUqXjuYw9Takt/GsZG2U/cn1otcSjWot7PtLx8FhHPDDSg66hsPjtlRCwIxj317yqcaJfHCUtIKlV7bFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707074; c=relaxed/simple;
	bh=7Gb7nd6YvJFNfQB+VrKVs9OlmLpsiuz+BohmKw3jZSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F0XSPWMmuKrXMcMGG07wuOWuZQwjHwRLF1B64VuCcvj1KZBAZ0nTjBtbpBErsl+bbYic6flp5Kq6CqaesBuF+e8DpZecS3N/XwhL+6cAWOqZNZlS+6cPL8O61aGIkv+7+FJRsHk8U1qiGAkPTmIhQ3/0YnOEpScVRoQpk+vDK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvwUwvJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB59AC4CECF;
	Fri, 15 Nov 2024 21:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731707074;
	bh=7Gb7nd6YvJFNfQB+VrKVs9OlmLpsiuz+BohmKw3jZSM=;
	h=From:To:Cc:Subject:Date:From;
	b=kvwUwvJ7FuiIP+hSH+SqJKpzTSa18sj2nnwAIRGFzM6mZ4+zDDt1YUo99VV1PLMQ0
	 gRnp/x+/jlofQ8V0YkqzVCAF5O8oWhrwjArD+OyV17c6NFUFz/zO7ztZeAlp28caOY
	 b0L5KNx3tCdq9zcjQZFC4b3kDqSFPmIi8epaatKCz4hAhwSWK8vGSJ95gALoQWkwuH
	 ekBIaawZlDmDvRw0eNFwQnmbBp+K/2CYbIEsvDV87QCmF6vNRSkbqhDq8wOe56nmdi
	 r4GsQr0Kg1j8vekruKdt8iZROIiyHIBo5uKvokCnac5A2kF3lk9CFeUMwG6GdPVEms
	 7kvWlbb7koEVw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI/pwrctrl: Rename pwrctl to pwrctrl
Date: Fri, 15 Nov 2024 15:44:26 -0600
Message-Id: <20241115214428.2061153-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

I'm sorry to propose this, but it seems like ongoing confusion to have
"pwrctl" and "bwctrl" (different ctl/ctrl suffixes).

pwrctl was merged for v6.11, so I would propose changing bwctrl to match it
except that we already have several "ctrl" files in PCI hotplug drivers,
and in the wider kernel, the "ctrl" filename suffix outnumbers "ctl" by
about two to one.


Bjorn Helgaas (2):
  PCI/pwrctrl: Rename pwrctl files to pwrctrl
  PCI/pwrctrl: Rename pwrctrl functions and structures

 MAINTAINERS                                   |  4 +-
 drivers/pci/Kconfig                           |  2 +-
 drivers/pci/Makefile                          |  2 +-
 drivers/pci/pwrctl/Makefile                   |  6 --
 drivers/pci/{pwrctl => pwrctrl}/Kconfig       |  0
 drivers/pci/pwrctrl/Makefile                  |  6 ++
 drivers/pci/{pwrctl => pwrctrl}/core.c        | 88 +++++++++----------
 .../pci-pwrctrl-pwrseq.c}                     | 34 +++----
 drivers/pci/remove.c                          |  4 +-
 include/linux/{pci-pwrctl.h => pci-pwrctrl.h} | 22 ++---
 10 files changed, 84 insertions(+), 84 deletions(-)
 delete mode 100644 drivers/pci/pwrctl/Makefile
 rename drivers/pci/{pwrctl => pwrctrl}/Kconfig (100%)
 create mode 100644 drivers/pci/pwrctrl/Makefile
 rename drivers/pci/{pwrctl => pwrctrl}/core.c (50%)
 rename drivers/pci/{pwrctl/pci-pwrctl-pwrseq.c => pwrctrl/pci-pwrctrl-pwrseq.c} (64%)
 rename include/linux/{pci-pwrctl.h => pci-pwrctrl.h} (69%)

-- 
2.34.1


