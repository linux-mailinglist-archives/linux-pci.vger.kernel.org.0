Return-Path: <linux-pci+bounces-36584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D70B8C62B
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 12:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AF57B5E07
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AF42EB5C8;
	Sat, 20 Sep 2025 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxl6vrc4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555B34BA2A;
	Sat, 20 Sep 2025 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758365818; cv=none; b=IuIQp+bUALM8g1A667Bo1uKP/zzUaxCM/ubBM9iv5nZh0zK68var/o3RFIYqPo8MV60KPDUADqMZDZGs7D/jXgbd5bwyQsCBHmLl0/6DGyhBiG8S3NNt6QdCEavpfXeQYAUgjwdHqYlO8TPCzj49zH5+oIFpzJm6O0YrQsOUgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758365818; c=relaxed/simple;
	bh=B/jdvogs/YBdZchcd4g5GXCV2jXYI1AZopvQxzMokk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZFNdzfA6Bwtg1dYqnLQRu65cn5TvGBS+7oYrLjS1ekmNOuhV1+vcFmpA4kXRbgpj7q9UQloXLGlhLBF+g/JiDYdBVrAEwMSSuHUdbwRuQTXFMhshzDp+u/RZuMYxckNsnWtws0s4tjx42xZbESGBAo7sxklkokxzsu1tiJKkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxl6vrc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DB3C4CEEB;
	Sat, 20 Sep 2025 10:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758365818;
	bh=B/jdvogs/YBdZchcd4g5GXCV2jXYI1AZopvQxzMokk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nxl6vrc4mTZtj2BTkgQFgBBw/525F/c3nyuca+ZwFiIHknVzwlfVYFshpMt8sNObb
	 sPccnYG0Vn6Sf4UFIRg23xmdHXZgciBZ9p7kun7r+JngWSOTKePXS1HlKPtYjx/cJ/
	 14YBtEkjaClcHOemF05uaRk7IaLAnkzve3Wmq2D5mUqJOs2lCuTBspWOuAOAUT7eOs
	 +e12oG0tzwubzUzWtAuGBFKnGtICR0n2xDzwcj2iRlG7QdCHgHceFzyulf+QADDGXe
	 uDw2CYwVuYiQpvyUROl73xQklteESNc7D4p9QISXNbIquPeF5TnmLX/pSLofrZcDjF
	 iqAFH1Id/exaw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 3/3] PM: runtime: Drop DEFINE_FREE() for pm_runtime_put
Date: Sat, 20 Sep 2025 12:56:41 +0200
Message-ID: <22849216.EfDdHjke4D@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6204724.lOV4Wx5bFT@rafael.j.wysocki>
References: <6204724.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The DEFINE_FREE() for pm_runtime_put has been superseded by recently
introduced runtime PM auto-cleanup macros and its only user has been
converted to using one of the new macros, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes.

---
 include/linux/pm_runtime.h |    2 --
 1 file changed, 2 deletions(-)

--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -582,8 +582,6 @@ static inline int pm_runtime_put(struct
 	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
-DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
-
 /**
  * __pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
  * @dev: Target device.




