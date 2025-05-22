Return-Path: <linux-pci+bounces-28267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B299AC0A44
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 13:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911341BC4E14
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 11:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58C22690C0;
	Thu, 22 May 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el3XRMu4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B843B221FAA;
	Thu, 22 May 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911887; cv=none; b=KUIz9CddY6+/1gje8VevBaGl5dCKV48Uhl+3G1Bx+oN4TViwfy2/j0lO9B10mb2ZgBjpqmh8dBO45bl+6TispUgUCKrZF8AUmvhQ+1EOy9G3RIsmtwR0YT1SVuMnzCwP/g4Jk4uZUIdZP7+/tWzjxwIiRuy5EPo0p3joQR0320g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911887; c=relaxed/simple;
	bh=XCVGZBptPngsgiauWq4BS6Y5vaFq0UsSrQKpKR80tU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJbDQoTpR4MODy8dcJDu0TWcAJ/CK/aUzhtC0KHDRalwg83O/v4x9HWJc2AuN7mVyhQPdF7XRELBylheeZo8pMA6N7ckKe91+4Dl9pNE2RN8I+d3/5IBGB9kPvOHS7t5yqEmBr47g3wFSIQBj33J6sKaOsA/sCf5CgFKSdcBTDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el3XRMu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74ACDC4CEE4;
	Thu, 22 May 2025 11:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747911887;
	bh=XCVGZBptPngsgiauWq4BS6Y5vaFq0UsSrQKpKR80tU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=el3XRMu4vilz47QpC2uw9DYSWpAYhV/6JriIIjR2OedWeTusRVyornwfNJVYiI2pL
	 d1cZ5rMN5z+TNIsh2sKZTgk9tPNGB50QDgbqy2ynXPX6GVsBMNWNZksF5tOLhf+ENt
	 zSrFgktIh2YsCzqqNcxWTcBm7ElLOXQNg01D+NJJcwpCkln1llNHFpRMoPbanG/7//
	 C+pGJpWKwxEgvk64FKowOZchGQc0wTQUZ19OGxM+RcqYi8t6L/zwIiywb2FYqUjsDA
	 yh9KrU/F/l6I/KyOt4zcvgPKXesRGp5pwzCrYBeKS1ca212OiFjJTnkuteBE3CNM57
	 Tx0HW9RG63olQ==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	will@kernel.org,
	sunilvl@ventanamicro.com,
	Markus.Elfring@web.de,
	Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: PCI: Release excess memory usage.
Date: Thu, 22 May 2025 11:04:43 +0000
Message-ID: <174791182681.71268.8372880535317037945.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430060603.381504-1-qiaozhe@iscas.ac.cn>
References: <20250430060603.381504-1-qiaozhe@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello,

> In the pci_acpi_scan_root() function, when creating a PCI bus fails,
> we need to free up the previously allocated memory, which can avoid
> invalid memory usage and save resources.

Applied to pci-acpi, thank you!

[1/1] ACPI: PCI: Release excess memory usage.
      https://git.kernel.org/pci/pci/c/631b2af2f357

	Krzysztof

