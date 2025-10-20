Return-Path: <linux-pci+bounces-38713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D63BBEF838
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 08:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5AD3BD37A
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 06:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC301E3762;
	Mon, 20 Oct 2025 06:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHQ1m61L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1535950
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 06:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760942931; cv=none; b=TeEbMrHKhMb7x8UWetErZVuEODCz71jVDjQSzl6WltEEnrI4B8Vd5negaMqetPatdC4LCpZfczQ7iKJHonSNZIWvkoKJ1XXPe4oSOxQsUMCyPlMCSWvr78byP6jJXdBjsE5VnxyaDDNz9ZJTJFN6ubEORYeEn2ERzx/5w+lgme4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760942931; c=relaxed/simple;
	bh=eOvXu/Wt631UQ7h+nKDlG0JqLQILHr1KHOnpkchCjkU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B2i/4p+c+SUUlkX9jqYFFZjTYlW1riApt4czht+MjCWUOYNPzwfADCexegyszJFGfqE2v81+rd07VFSI3VWZpII9wgaxU9vvlT80qPl+gVCs8gOoZlgDSdse9SgnuoJsF/PjqB8GIi08i0nVhVvMVsI30yg99+DbZrcYqAVguY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHQ1m61L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9655C4CEF9;
	Mon, 20 Oct 2025 06:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760942931;
	bh=eOvXu/Wt631UQ7h+nKDlG0JqLQILHr1KHOnpkchCjkU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=pHQ1m61LB/QwHWrEUPf7VQNm4nibYaWMkQ7QNhJqiRpVboY3V+9ZcvlXYUosG98nJ
	 1hrJNH6Ak8uyAJsRGcmdy2OI2TB53nNiLrmuRk31EsgsOPBzLubaiy8eT1iOoeA/6U
	 UOOfYrOU1FgSeQ1PrO0cTbST5ATL0THDuPPQOjxCGde8i2ismpugenSPIJ2EJ0mcfs
	 Q8UkxjWoF1xtJDxmY+MHSnQ3cZ6NTB0b2gX57EcGa0DReYrpuI5/R1b9d8X7EbECv2
	 x26uqF+NpcB+KabT99zj2GoEX6kUbhOXLjWN7A/s4YsaIc21lcI+s/TxYC/OrvdjVQ
	 JY6uJ+YF2EHWQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Cyril Brulebois <kibi@debian.org>, 
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Jim Quinlan <james.quinlan@broadcom.com>
In-Reply-To: <20251003195607.2009785-1-james.quinlan@broadcom.com>
References: <20251003195607.2009785-1-james.quinlan@broadcom.com>
Subject: Re: [PATCH v3 0/2] PCI: brcmstb: Add panic/die handler to driver
Message-Id: <176094292821.11548.4875305934446802597.b4-ty@kernel.org>
Date: Mon, 20 Oct 2025 12:18:48 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 03 Oct 2025 15:56:05 -0400, Jim Quinlan wrote:
> v3 Changes:
>   -- Commit "Add a way to indicate if PCIe bridge is active"
>     o Implement Bjorn's V1 suggestion properly (Bjorn, Mani)
>     o Remove unrelated change in commit (Mani)
>     o Remove an "inline" directive (Mani)
>     o s/bridge_on/bridge_in_reset/ (Mani)
>   -- Commit "Add panic/die handler to driver"
>     o dev_err(...) message changed from "handling" error (Mani)
> 
> [...]

Applied, thanks!

[1/2] PCI: brcmstb: Add a way to indicate if PCIe bridge is active
      commit: 7dfe1602f6dc96f228403b930dbe0a93717bc287
[2/2] PCI: brcmstb: Add panic/die handler to driver
      commit: 47288064f6a6ce99c3c1fd7b116011b970945273

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


