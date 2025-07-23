Return-Path: <linux-pci+bounces-32833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DFBB0F7F0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 18:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EF83B3CD4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C0914B96E;
	Wed, 23 Jul 2025 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSworno+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE02E36EB;
	Wed, 23 Jul 2025 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287529; cv=none; b=lY7+Rh8pcgHmhNUWOPc6BpcR6s7GjoKMM9yn/Rdi12+6NehWIqfvBICY71gWtL3HqSvDqbkTDh5QMS0Lis7KCkHVHs0ZcvJBXAuq8kwyMr2gU9aVptoEl4nJoWAyE2XnH45+iXPXXHmrMM89zJkNCmdyN6FPQroP9010zyemJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287529; c=relaxed/simple;
	bh=dhauIp1Xnth81IxqG0+WMwrHEpOwE2yWzY95avKoTso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIpwkNEr1JUFrmTEfQflCWx/Jv3FezrxMdCYjEZkIulTD854ZI7FH228Z4iaHKtLAFI2kd6MkcDarEATf/T8no/xtc0gX0zpdrCtWoAchw5pg5yA3YDupqu2wd902c7LSUmH1dIDvtFy5+tr6IQduf3WjZfepKcxeQAuGPRWfG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSworno+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57F7C4CEE7;
	Wed, 23 Jul 2025 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753287528;
	bh=dhauIp1Xnth81IxqG0+WMwrHEpOwE2yWzY95avKoTso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSworno+GrOn6eWwE0lERNiLWOgPZ+OQFIRBOmpz/IyA/MxR9sUl/G7APhxRMn0Te
	 ojqbzLAycq1Sj1Mgme575N5SDl8p8uVuIVMXmtR32Yqo+uwoeTufTD+YRiZlBjr/J9
	 Kegu5UUDMP/6MMW9oYtv6c/Q5U5w0eL5PqG+hsHlY7xKO+kjYJdE+Op36xfUjPVF/a
	 D+ehngdOu/EIdhnNX1mwyQbheQm54+ZVlHV12tpe7xKfMR8jHg9K7o3SHxI6BQGpOU
	 Ydk6ag0LcGDg3zQ3L/SnNZ4HoR3DJgEvZ8+c0AjRn2hWzr+Xi0PeK5sKKGs8+eIaPy
	 YuCLU5Z1S9pNw==
Date: Wed, 23 Jul 2025 21:48:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI/pwrctrl: Fix device and OF node leaks
Message-ID: <zzxc6b3prqg3uf6mkax7spqxmotnbsu7f6wyyqrnnt57wh7gma@zeaf4zufqdff>
References: <20250721153609.8611-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721153609.8611-1-johan+linaro@kernel.org>

On Mon, Jul 21, 2025 at 05:36:06PM GMT, Johan Hovold wrote:
> This series fixes some pwrctrl device and OF node leaks spotted while
> discussing the recent pwrctrl-related (ASPM and probe) regressions on
> Qualcomm platforms.
> 

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> Johan
> 
> 
> Johan Hovold (3):
>   PCI/pwrctrl: Fix device leak at registration
>   PCI/pwrctrl: Fix device and OF node leak at bus scan
>   PCI/pwrctrl: Fix device leak at device stop
> 
>  drivers/pci/bus.c    | 14 +++++++++-----
>  drivers/pci/probe.c  | 19 ++++++++++++++++---
>  drivers/pci/remove.c |  2 ++
>  3 files changed, 27 insertions(+), 8 deletions(-)
> 
> -- 
> 2.49.1
> 

-- 
மணிவண்ணன் சதாசிவம்

