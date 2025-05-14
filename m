Return-Path: <linux-pci+bounces-27741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78082AB713A
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 18:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19C84C77A2
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2334F1B6CEF;
	Wed, 14 May 2025 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6zsutCm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC041A5B90;
	Wed, 14 May 2025 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239887; cv=none; b=XaMC2gvtON2yPo4OyeQVsC+1YUri4io9bXzGY/8W9wG2fqYqd5V39dJt+Ubxa4nm5EoiVt4et+2Fc1i8CoxX4lF8N1Yu5ESL/KAp1yfMGQvI5AFj4NKrB6RlP1bdEObucTnWTVg8giDtWUe4xeSI8xvxmK/6+T26t/F/AUArhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239887; c=relaxed/simple;
	bh=QQzWroxycWKiS40RfA45EEWgA9oSgXb2SOtVMAxE/uM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmvWXiljTyBpm/MLiNhZYHpzDXHLFpTgyUlntqzqJB86Iq6SD/AGcT0rmDDhrjfK/NNO3722onAtLhw0QcPatHKXKIUVswsMRZHvHyepuJkuyDkuTORWJUQD/9RnXYFm72ANDheP8n6zDbjnlpCtP0B6Rhuic2BgZ1xsu4y/DHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6zsutCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0883AC4CEE3;
	Wed, 14 May 2025 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747239886;
	bh=QQzWroxycWKiS40RfA45EEWgA9oSgXb2SOtVMAxE/uM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n6zsutCm2zXHNvV5atWf7Zq4GLZmmFoWOOsQCUgj0E7gcjlfmegAebvrVybfjrSpb
	 M1bnezbUWaItLlEBrg09Nj54qdRwSh11cLqJ02u1PtBbHoKFFOU61MMptePqvDZNkl
	 r3m9ZvXPbyyerUqxGOsBMoUPATexzJGK5yYjimOV4Y7CCTXD0tO9r5kEj+uNK83e0n
	 1c+O0yRKWadxmyyRYMvYrZR4MwZro0RFRSCYa78K2H3u1ULv5UBdZ56z3xiR9xD33U
	 nOF7zD0tSAsRkvg5lsPbKoBNWhMMl+w59r23ePswkZROc2qrpyMLwMaX/a0KrgQoQM
	 bRFPyUghnQcCQ==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Remove pci_printk()
Date: Wed, 14 May 2025 16:24:44 +0000
Message-ID: <174723782977.8612.11302358945479121973.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407101215.1376-1-ilpo.jarvinen@linux.intel.com>
References: <20250407101215.1376-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello,

> include/linux/pci.h provides low-level pci_printk() interface that is
> not used since the commits fab874e12593 ("PCI/AER: Descope pci_printk()
> to aer_printk()") and 588021b28642 ("PCI: shpchp: Remove 'shpchp_debug'
> module parameter"). PCI logging should not use pci_printk() but pci_*()
> wrappers that follow the usual logging wrapper patterns.
> 
> Remove pci_printk().
> 
> [...]

Applied to misc, thank you!

[1/1] PCI: Remove pci_printk()
      https://git.kernel.org/pci/pci/c/56d305b24d64

	Krzysztof

