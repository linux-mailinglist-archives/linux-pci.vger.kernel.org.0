Return-Path: <linux-pci+bounces-24961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E306BA74E44
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 17:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB83B7A3210
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 16:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828451D63F9;
	Fri, 28 Mar 2025 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqjE1Bod"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E51C8FD7;
	Fri, 28 Mar 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178292; cv=none; b=KwDBP2OGyZvPvJ8kZf6lCeT8N4XBU5UYGc0SE4LxZFx3UlX1/jGUt8czS/e80wuYpILAfwngt7DaGXmAXHtQg4OfTTqmeP8TulS0iSikd+MTIJengHdS846ZNyG5xQxK9vaqzZmQ5n2b9SVu9VH1Fqkr12djAzJbi89B9A2wvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178292; c=relaxed/simple;
	bh=vd+MsqR+zb+ZUwrDod4YyaT5G91/MYukXepr+eOQBMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxJWqIpN77CHTqxhnKUTkLV+tr+uSIajOrotrCSMoGSURAe2y9pv9KNqIqu4uqLajqz5xB9z1qgjs6jbHdB1kS2Zvx5A23C81M/ZvqB18jnN9iTfC+AxeVQFDnqIf+nVKiU2C3nUrpMTjZrX6oa5FbGvNUw+Jti15uVmnWx9qis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqjE1Bod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68534C4CEE4;
	Fri, 28 Mar 2025 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743178290;
	bh=vd+MsqR+zb+ZUwrDod4YyaT5G91/MYukXepr+eOQBMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QqjE1BodPJFzurkmx6XGTJzHwXGtQsoj6RrUC9OFfJw9Q5rrVLGe+fQvF7lBiRmih
	 Q5n3RLJXMhEzWJ8L+pwPclOgDTZFeY+I5d7jJhHAD3mtKZ7VBpGw08rFqzFK7ybnka
	 HTTwDLHNvWdlsfTuhBPWCsCB7XOcS6vdSYZYb2vpNf+6AtSFUE2tSsU9rVas11XopT
	 gnupgIcs/V6SVdwUMrtoE2K3BcX0+Sd4j6lEdvYj3vpcuC24r7lrgjPuEIyhQKuKzL
	 FTYnoboB9tXJN1zY3z3iroEVGlasuOtNb2YYT7IXKwn21/l7FII8CjUQBWXVFktYpf
	 qiWnSOdZvaeoA==
Message-ID: <04201b5a-34fe-45e0-bb96-237bd6eec414@kernel.org>
Date: Fri, 28 Mar 2025 09:11:29 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] PCI/arm64/ath11k/ath12k: Rename pwrctrl Kconfig
 symbols
To: Johan Hovold <johan+linaro@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250328143646.27678-1-johan+linaro@kernel.org>
From: Jeff Johnson <jjohnson@kernel.org>
Content-Language: en-US
In-Reply-To: <20250328143646.27678-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/2025 7:36 AM, Johan Hovold wrote:
> The PCI pwrctrl framework was renamed after being merged, but the
> Kconfig symbols still reflect the old name ("pwrctl" without an "r").
> 
> This leads to people not knowing how to refer to the framework in
> writing, inconsistencies in module naming, etc.
> 
> Let's rename also the Kconfig symbols before this gets any worse.
> 
> The arm64, ath11k and ath12k changes could go through the corresponding
> subsystem trees once they have the new symbols (e.g. in the next cycle)
> or they could all go in via the PCI tree with an ack from their
> maintainers.


I'm fine with the entire series going through PCI
Acked-by: Jeff Johnson <jjohnson@kernel.org> # drivers/net/wireless/ath/...


> 
> There are some new pwrctrl drivers and an arm64 defconfig change on the
> lists so we may need to keep deprecated symbols for a release or two.
> 
> Johan
> 
> 
> Johan Hovold (4):
>   PCI/pwrctrl: Rename pwrctrl Kconfig symbols and slot module
>   arm64: Kconfig: switch to HAVE_PWRCTRL
>   wifi: ath11k: switch to PCI_PWRCTRL_PWRSEQ
>   wifi: ath12k: switch to PCI_PWRCTRL_PWRSEQ
> 
>  arch/arm64/Kconfig.platforms            |  2 +-
>  drivers/net/wireless/ath/ath11k/Kconfig |  2 +-
>  drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
>  drivers/pci/pwrctrl/Kconfig             | 27 +++++++++++++++++++------
>  drivers/pci/pwrctrl/Makefile            |  8 ++++----
>  5 files changed, 28 insertions(+), 13 deletions(-)
> 


