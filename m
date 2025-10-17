Return-Path: <linux-pci+bounces-38508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BE0BEB481
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 20:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3742C6E5FE6
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 18:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F151A3203A9;
	Fri, 17 Oct 2025 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9kjYzWk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2983081AD;
	Fri, 17 Oct 2025 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727168; cv=none; b=bjtfrTlv0cz5wjAxApqS9UT9T79218YVomFfdfq99z20lVLyz/no/AUl8Y7cDDUyU247mEA77/S3sSPTwz8OVjIV7E0y5Ac3pWxJoVic+HqMKFx3Rsca5qwRO93Eou45VlnBhJ3ADRxawrdEqem250LIn4i4KbArDbFW0huZczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727168; c=relaxed/simple;
	bh=zaQR5SGMpqDsyH147zVmilmIxBOcceMdtiFddd0hMEs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s56L1FmpfncGMG3NQ5bAxCG8cn413Jzr09tyA6JFIMxFTpy17Fwx7yWaqiR8BP14bzx2nILzUIMpISrAdHizvQrL1v3GlJwgFrDJgEHdt486Ybcm0g57LLpg/Z5PdyonZK933lXzKE97EKNvdwmMyAc8QOEqwDKviGUq8P9LIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9kjYzWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB1DC4CEE7;
	Fri, 17 Oct 2025 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760727168;
	bh=zaQR5SGMpqDsyH147zVmilmIxBOcceMdtiFddd0hMEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C9kjYzWk4g2jXhmKqdvJnDt3sjR3zjl819WBuVw4VUdTogqYT6mblLUKZS7xi+2Eu
	 pbRUyarG+EZo9fd5QAHepLdjSkv9KbE7snW92jl0x5iccOoGV4iJu/kETDok3TOY8e
	 yWRUEaxmOLoPliNH2iG66dMzFcAr2WEaImiAHtGBJRbNqI98n7n7qcH3UiTxeJOIHv
	 bI1cWj8nZ6zo3Rl+NOL/tzXMnt01MFYw3auBbXfLJEJtiHsysNtHjw8koJHUwwlSnq
	 eYZkUo5JzkZ8Rm10AHKsBRD1qblPMTQFS8IsZF+EyLuiLOSSOKaBjgBvp/i4V5Pgnw
	 Aor91GF8osVTA==
Date: Fri, 17 Oct 2025 13:52:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: ilpo.jarvinen@linux.intel.com, bhelgaas@google.com, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lucas.demarchi@intel.com, rafael.j.wysocki@intel.com,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
Message-ID: <20251017185246.GA1040948@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b144ae1b-8573-4a71-9eaa-d38f38e83f4a@gmail.com>

On Fri, Oct 17, 2025 at 11:52:58PM +0530, Bhanu Seshu Kumar Valluri wrote:
> Hi,
> 
> I want to report that this PATCH also break PCI RC port on TI-AM64-EVM.
> 
> I did git bisect and it pointed to the a43ac325c7cb ("PCI: Set up bridge resources earlier")
> 
> Happy to help if any testing or logs are required.

Thanks for the report!  Can you test this patch?

  https://patch.msgid.link/20251014163602.17138-1-ilpo.jarvinen@linux.intel.com

That patch is queued up as
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=469276c06aff
and should appear in v6.18-rc2 on Sunday if all goes well.

If that doesn't work, let us know and we'll debug this further.

> echo 1 > /sys/bus/pci/rescan
> [   37.170389] pci 0000:01:00.0: [104c:b010] type 00 class 0xff0000 PCIe Endpoint
> [   37.177781] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x0000ffff]
> [   37.183808] pci 0000:01:00.0: BAR 1 [mem 0x00000000-0x000001ff]
> [   37.189843] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x000003ff]
> [   37.195802] pci 0000:01:00.0: BAR 3 [mem 0x00000000-0x00003fff]
> [   37.201768] pci 0000:01:00.0: BAR 4 [mem 0x00000000-0x0001ffff]
> [   37.207715] pci 0000:01:00.0: BAR 5 [mem 0x00000000-0x000fffff]
> [   37.214040] pci 0000:01:00.0: supports D1
> [   37.218083] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
> [   37.231890] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: assigned
> [   37.242890] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: can't assign; no space
> [   37.251216] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: failed to assign
> [   37.258309] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: can't assign; no space
> [   37.265851] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: failed to assign
> [   37.272896] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: can't assign; no space
> [   37.280439] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: failed to assign
> [   37.287459] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: can't assign; no space
> [   37.294986] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: failed to assign
> [   37.302011] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: can't assign; no space
> [   37.309536] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: failed to assign
> [   37.316595] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: releasing
> [   37.323541] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: assigned
> [   37.330400] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: can't assign; no space
> [   37.337956] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: failed to assign
> [   37.344960] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: can't assign; no space
> [   37.352550] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: failed to assign
> [   37.359578] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: can't assign; no space
> [   37.367152] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: failed to assign
> [   37.374192] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: can't assign; no space
> [   37.381709] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: failed to assign
> [   37.388720] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: can't assign; no space
> [   37.396246] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: failed to assign
> [   37.403795] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
> [   37.410513] pci-endpoint-test 0000:01:00.0: enabling device (0000 -> 0002)
> [   37.417796] pci-endpoint-test 0000:01:00.0: Cannot perform PCI test without BAR0
> 
> 
> Regards,
> Bhanu Seshu Kumar Valluri

