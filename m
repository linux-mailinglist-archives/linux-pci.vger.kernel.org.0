Return-Path: <linux-pci+bounces-30952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A46AEBF3F
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 20:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1E01BC4581
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 18:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A7B2ECD17;
	Fri, 27 Jun 2025 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEv8Ieyf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADC92ECD11;
	Fri, 27 Jun 2025 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751049631; cv=none; b=R5zwong5flmpw2pyBaBzHj3of1Ckx5qyKc+ZSSNszqUNPfuf5pEeqdDQ64W1ziUHGiPK+GSxel6OLOXTNCQc8DIzJeTqcnYHaq/aqQZV4PikRgJC0yHAY2OatgIV9lHrU//v6HaNNFdPpBLL0fp79FpSmLUoCnhTxHQXjjds8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751049631; c=relaxed/simple;
	bh=iND8UDv17DYSOnZinxgjyevii8OyA7GaHyjCwddFaGQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TglD7GRkf7Py7/UWyyw/HlqhsDW3Q7GxnS8lyBJAyHARsAYqmzWdVum59vrp1r0vYjXgtgR0kmtIvs3uyJky2/GCsAsAwM71Z56uv7Cqs/k+JUDa+Y6WRKh7FN6B4BA9eBrqx7PLre9SuzCAl97in1Ba7wEfrCnvqhUOzhvh/Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEv8Ieyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7702EC4CEE3;
	Fri, 27 Jun 2025 18:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751049631;
	bh=iND8UDv17DYSOnZinxgjyevii8OyA7GaHyjCwddFaGQ=;
	h=From:Date:Subject:To:Cc:From;
	b=FEv8IeyfwuKM2T/pOTfSFhE9NGuKwQOliQ4RlfcLkMOwxqCOFeyf2ZlzpWSeLHyPP
	 2XkIdi+9EeHiijLnE2aBQGQiLBUMiljik+Em9Wj8H8I/zsG8VlCt+SdLRzWjc0Tkf8
	 nfhUbZizSupGncGEjFfARcXNIoauRUawa4XwMANmkYBsZHS0wijnGfYaszGnglCf8S
	 Bd1Q5Q1QKfPTP2uyG9nX7XQKx/XkPjF4y0frmVBDxadGD3P8n86ewn73Z4CqHQJfEq
	 CUREV/cWWgKrIWBDoWE4GASCu3/pbMlH5gaKLtapqb+QtRKQv1A9324PGvaiwBpXAj
	 Us3W6M9aqCxDw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-408e0986303so154981b6e.2;
        Fri, 27 Jun 2025 11:40:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKBuWTvMo9IbUSFvB7pWn9pkdOG7d8L62idyYFdH5sc37yiccSBYQ09cxMem4KyWFdRdhYskTfsTBH@vger.kernel.org, AJvYcCUfU6l3O2VbudUjP8am9X/grCxC7f81ftChFf+OhnARAMpVy8bZXmp1zf94foBMFeCYhLAXzF0z6jDbzBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeEefU6UYUMAtX70rDCGE57/Tt2AW0B2q/Td4bKoV7XywqG5M3
	YAIIqcBosWgwkQVu+GR35y7LFfBH6iDimDnST3zfZMu3CbxeEvBJXj4TanCPA/kTLZFkIT8kFuS
	tCd48K1jRmkDQp3mZgvGteCwXJkXwPMM=
X-Google-Smtp-Source: AGHT+IGgEBpKnVyNz0zEriNdxcd3A3CxO/Mqhbc1dLKrCvT9+J0Rrl5ZKtlXV9pcFcQc75Ly4Gb4cUG35dEMfSw7bws=
X-Received: by 2002:a05:6808:222a:b0:3f8:150b:f571 with SMTP id
 5614622812f47-40b33ea6330mr3862978b6e.21.1751049630742; Fri, 27 Jun 2025
 11:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Jun 2025 20:40:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gp+fK8tVZf1K04nBpvUpAiXoPx0O0Ge4yJitPGOyEi+g@mail.gmail.com>
X-Gm-Features: Ac12FXzNtD-oJVROl1A7zf9kI8SvhTAocLSxDB-n5U192UMTUNXVmmeVbim43Wc
Message-ID: <CAJZ5v0gp+fK8tVZf1K04nBpvUpAiXoPx0O0Ge4yJitPGOyEi+g@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.16-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.16-rc4

with top-most commit 2b8be57fa0c88ac824a906f29c04d728f9f6047a

 Revert "PCI/ACPI: Fix allocated memory release on error in
pci_acpi_scan_root()"

on top of commit 86731a2a651e58953fc949573895f2fa6d456841

 Linux 6.16-rc3

to receive an ACPI fix for 6.16-rc4.

This reverts a commit that attempted to fix a memory leak in an error
code path and introduced a different issue (Zhe Qiao).

Thanks!


---------------

Zhe Qiao (1):
      Revert "PCI/ACPI: Fix allocated memory release on error in
pci_acpi_scan_root()"

---------------

 drivers/pci/pci-acpi.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

