Return-Path: <linux-pci+bounces-27439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 902E4AAF99B
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 14:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDFF1C018F0
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 12:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DF3221F38;
	Thu,  8 May 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVwP7JDu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45A1DE4C4;
	Thu,  8 May 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706650; cv=none; b=bxt40BlR6ZcturMe/AgV/qn3lbngWie3+y60b95lgI7sUqI8gI6GG7W58Dr05vq1b1HZPPWsSbi/x23vVhGOLFFyHp0tzEXdUB0rydoxgZN2WPvKJQ5pkZs+y4wUVAEHC5chqiHEVqk4wtsWIurUtD0slzF/eg+B8zhhZ0k9/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706650; c=relaxed/simple;
	bh=X09kpoC2cYWElAOM5zUAu13xi0FNAuNy6V6g/+7RQ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eh5uJA+rj33AiEIhhsATRcV4+Xi34rzqK9o9sUgjWDdIHz/T1KYnjxlpGzSkSwbpy8xn3iS6tAMfejlN1OVkKffMzWAq2UxUt4Eam54NJKxjnmTQchK2a1863bUZpZPstcySWU9MsQdQy+tocOge1n9kVQucW9ljLuZIDFcMHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVwP7JDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310A5C4CEE7;
	Thu,  8 May 2025 12:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746706649;
	bh=X09kpoC2cYWElAOM5zUAu13xi0FNAuNy6V6g/+7RQ8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVwP7JDuLgdhcFC47yVaiHpl+m9tnhdBU7VJa33L5UZ3bzbo1d9gg1zOJgiX8ZhPZ
	 vWUccB3Z7eKykUxxJWt9aAXOQrMy/RPSzarmsHB7Py6Dc1MkPtBjKMFX1CXWyw0Wpe
	 GKe0LenHznUZvUA7Ikd1WtXsdFED7efCiqSvnJfU26f6nEHnp4EqEyk4aFXWXOO4Jq
	 A7WELwulFYWquVkg0iFM/hPWAPUVBtmkMYqzdjnvZ2vcUs+63NFPD7mnAsJMlKrSrY
	 y+5w3D3ZYIGXZt6mDBs9qmaXP5vyfqDTBJzUWBQo37qE2iKMyR8SYm8dHjnuxboa3f
	 TY+Q4BIWlpoLw==
Date: Thu, 8 May 2025 14:17:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <aByg1GUBno3Gzf4w@ryzen>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
 <20250508051922.4134041-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508051922.4134041-1-vidyas@nvidia.com>

On Thu, May 08, 2025 at 10:49:22AM +0530, Vidya Sagar wrote:
> Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
> check for the Tegra194 PCIe controller, allowing it to be built on
> Tegra platforms beyond Tegra194. Additionally, ensure compatibility
> by requiring ARM64 or COMPILE_TEST.
> 
> Link: https://patchwork.kernel.org/project/linux-pci/patch/20250128044244.2766334-1-vidyas@nvidia.com/
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---

Looks good to me, but there will need coordination between the
PHY and PCI maintainers for this to not cause a kernel test bot
build failure, if the PCI patch is merged before the PHY patch.

Reviewed-by: Niklas Cassel <cassel@kernel.org>

