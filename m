Return-Path: <linux-pci+bounces-35039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBABB3A4F8
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 17:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0A768099C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B892512C8;
	Thu, 28 Aug 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQwXLrgm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75AF2505AA;
	Thu, 28 Aug 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396429; cv=none; b=LqkKk99tHkbUrUa9/GItbxl7C1jJdZrJ65bpaNT2FgH0NQtL9BZC6dkANWBEhr1z4yXA/v/ZcW3MI+Jg9GFLLfR3ET9UWZ/Xf0PVDyYo/C2ArhWGstNc/Lx+GHOh5GlXLvmjySqgOFIE7RpIEgmHiX46xsu2UPi5P6Ie+xIxGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396429; c=relaxed/simple;
	bh=HIE7vqMsij/Ls4YiN95VhdIT8axgc9qXGGvTPolxats=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LGEGPsD4S5ukWj74oAR7qaVEhxteV8dd4jjrXmtf/HkLE5TvET6IXbeqcRXcAluT1YkS72coGj0kOQAfv2E6s3aZwCnuuluXdMzlB9s2KGJcxV/vtgQSGvfso7ZKnowNN5R8XYFhc/9b01R6HJy6zyI89shf6/mPInCNmtX5qX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQwXLrgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854E5C4CEEB;
	Thu, 28 Aug 2025 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756396428;
	bh=HIE7vqMsij/Ls4YiN95VhdIT8axgc9qXGGvTPolxats=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PQwXLrgmKhXTFOf7XrKvFJ8D5HLs1QsafBd5GCtKgqt4XMNk+iqcgQKgscEhs7Cxn
	 wfGHdeyoUu16GP4ifwquJ5PEZtKdVmTaCDzAMxT77dCitX7rHiUiBrGEGPZe10BtGb
	 rK4w/dKfDrzDjydwGkdu4t4rhfEWgusX0fAdBzo+qvXTSz5RThgp8w/n1TTPT+9uTZ
	 EpjsbXTvYddyBlf4eUQCJUT+rdzaqE/UQMJqJTeTgSBlziZqrCOVJoJsRaO0cN0qpp
	 zOhJcwT2G0Mcu/cw+3PGATyDkN4PBukG9z5VUXqKBJIZqRbgyK9FmVisxAvaVT/iAc
	 Xu+UkdF/jzNTQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lkp@intel.com, huaqian.li@siemens.com
Cc: baocheng.su@siemens.com, bhelgaas@google.com, 
 christophe.jaillet@wanadoo.fr, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, diogo.ivo@siemens.com, helgaas@kernel.org, 
 jan.kiszka@siemens.com, kristo@kernel.org, krzk+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, lpieralisi@kernel.org, nm@ti.com, 
 oe-kbuild-all@lists.linux.dev, robh@kernel.org, s-vadapalli@ti.com, 
 ssantosh@kernel.org, vigneshr@ti.com, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
In-Reply-To: <20250728023701.116963-1-huaqian.li@siemens.com>
References: <20250728023701.116963-1-huaqian.li@siemens.com>
Subject: Re: (subset) [PATCH v12 0/7] soc: ti: Add and use PVU on K3-AM65
 for DMA isolation
Message-Id: <175639642101.69919.15722042082613439643.b4-ty@kernel.org>
Date: Thu, 28 Aug 2025 21:23:41 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 28 Jul 2025 10:36:54 +0800, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> Changes in v12:
>  - Fix Sparse warnings by replacing plain integer 0 with NULL for
>    pointer arguments in ti_pvu_probe() (patch 3)
>    (Reported-by: kernel test robot lkp@intel.com)
> 
> [...]

Applied, thanks!

[2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
      commit: 57a48a2619c5f99d48748f9c34db510efe5ee7c9

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


