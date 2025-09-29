Return-Path: <linux-pci+bounces-37225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E8BAA3FC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 20:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 645507A18C9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A61F22422E;
	Mon, 29 Sep 2025 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klcrZ7ZU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B1D515;
	Mon, 29 Sep 2025 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169187; cv=none; b=n5wAk+kJVSseGf6BMVU4BxHgBhEvvV1eQFtW7C0Uc11cK94f4+ypfwbqCNEeL3vSNXtLxM0cqL5MBHtiHj80B+A32zl3VgLW7vqewIAVKOWurhD2u6t6by4oODulMCG1XklIzDjNkVbQ6ao6Ly/XHmBde4xjubU/u0w4xWPVw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169187; c=relaxed/simple;
	bh=aXF6dblNZTmlNaQRE73OUxEz9KeOhfncEzYh4mOBv34=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ucGUCPxhTJfgp0hipdIpVlIWAJdwmWxbsMgQdBo2TTUfQKQqrZ6xfEiRzd8GA/wjKB7ciUbqKIkB3roMX09rZF3kXOUKShCTe2CZLXCxFgLrVehugViYDyOHhjPcpE438l584xNAkLFkFs9vuyLeu8pbsydd3L+TqjN9/j5uPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klcrZ7ZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA06C4CEF4;
	Mon, 29 Sep 2025 18:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759169186;
	bh=aXF6dblNZTmlNaQRE73OUxEz9KeOhfncEzYh4mOBv34=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=klcrZ7ZUFDGA8KX4HAryBRfyd2QyRv0g2WQkq8/HCU1OXGe0kN2UlS3NIhlkE0t6/
	 PyzM7dnrMjhVj3pvZcDwQ1ev2pM3Za7lVGjZxumRHVZtZLO7gXrpDcAr2DJA+vsbS8
	 xrRAxEY7SJxWX7StZzS1p2tgG9bQIKV83TYAn3cSDNTZ+T7DC7gFAu1vMZgg6T1frf
	 FfwVNOM61NC4z3KVG2ji9CrFe1Ub/BSvvEn6ONz+39nlfHG8Qw0icDCpEyiulhzPkA
	 BlK4aQ1jUULq8sEUbx5zjK6QYVEHk1VSjGy+nPvLHMZ1CWjTOkaakOR3op/Vo2Pdgl
	 zRVDCXJRnaYwA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: vigneshr@ti.com, s-vadapalli@ti.com, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
 linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250905211436.3048282-1-alok.a.tiwari@oracle.com>
References: <20250905211436.3048282-1-alok.a.tiwari@oracle.com>
Subject: Re: [PATCH] PCI: j721e: Fix incorrect error message in probe
Message-Id: <175916918016.21534.16971810252510733613.b4-ty@kernel.org>
Date: Mon, 29 Sep 2025 23:36:20 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 05 Sep 2025 14:14:34 -0700, Alok Tiwari wrote:
> The probe function printed "pm_runtime_get_sync failed" when
> j721e_pcie_ctrl_init() returned an error. This is misleading since
> the failure was not from pm_runtime but from the controller init
> routine. Update the error message to correctly reflect the source.
> 
> No functional changes.
> 
> [...]

Applied, thanks!

[1/1] PCI: j721e: Fix incorrect error message in probe
      commit: cfcd6cab2f33c24a68517f9e3131480b4000c2be

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


