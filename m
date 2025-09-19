Return-Path: <linux-pci+bounces-36523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA830B8A9BF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A060B1892315
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4023218D0;
	Fri, 19 Sep 2025 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds0uyiLo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAD631AF14;
	Fri, 19 Sep 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300056; cv=none; b=XuLdaEmF8CcMahWD3mGH4s65I1Qbr4EpUrR8kYizZ1V2weHVETOg6N1uF70Pwt8gQZF/0DjpVvqpRibYszhD9/FvsEYHFxQ2Ric2BJNH3PPH3BG3e/fYj2JGUAbehmIeje/RXrfbJ07xIHeD5Dkrp3OBMpREBNKYelSccADbhYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300056; c=relaxed/simple;
	bh=HdgipyHtOMNRrZCFIm64Rk/o9cdbBY8x2poCKIP5wGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p++6WtP3aQbLDFkWFkS+zhTTEDB6DLt0CPMtPWvNmRtBdqKUP+rolxNw1XW6eacY9fojoVKRL/NKEUAdnV0XiRVfdJ44K87F/r1j/qV8WZaXcSwLWZjDbYyRBDm978C40tAfbURql4rGxT1lgMPW9kpzKYfiVBdenrccEmPR5Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds0uyiLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5025C4CEFA;
	Fri, 19 Sep 2025 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758300055;
	bh=HdgipyHtOMNRrZCFIm64Rk/o9cdbBY8x2poCKIP5wGM=;
	h=From:To:Cc:Subject:Date:From;
	b=ds0uyiLodzYLE5Qonq4nfT5Wy8QVabIOkgPU/KoHMK22BPVUPmd0PpO0VThIBNXKn
	 1GwM9B4vPx3k9RpH93prWG0EX8zOfND757bbEbP+GVBtfBapub/gYEgguPsF+DXrqP
	 SIWquKjXrpmMtSOOc/FXoDQzpsizMfUeKCy608VtNx7oinCRSPGC9+ysJCL7fPcknl
	 648JX7kdPmcYyq9MrMpx/TpXxLtPSfTcZiV08yTp9e3SopiGjrqyNSh6Zortw3u5iv
	 hWbGPtGJmRReKAvdb5X2Knn40Rx/8+PzJfMMeSGypUpPIGSUytbyLRe1sKvFxB5781
	 MTmk24eRQlqLA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject:
 [PATCH v1 0/3] PM: runtime: Auto-cleanup macros for
 pm_runtime_resume_and_get()
Date: Fri, 19 Sep 2025 18:34:40 +0200
Message-ID: <5049058.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series adds two auto-cleanup macros for runtime PM usage counter
incrementations carried out by pm_runtime_resume_and_get() ([1/3]),
converts the only user of the previously introduced DEFINE_FREE()
macro for pm_runtime_put() to using one of the new macros ([2/3]),
and drops the DEFINE_FREE() mentioned above ([3/3]).

The new macros should be somewhat more straightforward to use than
the existing _FREE and they enforce error handling.

Thanks!




