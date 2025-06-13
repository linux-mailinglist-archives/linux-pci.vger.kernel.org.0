Return-Path: <linux-pci+bounces-29652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D42AD85E2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 10:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 066F07AB314
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 08:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EC125228E;
	Fri, 13 Jun 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Io6BXJVO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990F52459D2;
	Fri, 13 Jun 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749804350; cv=none; b=D5PAaHONRyHrvYwmXbu6nrE4gwmMaSsScO6nM0KMImDVz3UwkQSs5pIa/86gxRMN+O41rgg7s5AaRWQkCaC46uTzVt6+1yaUxGebLkvt3FuIDYt/rKCjzg3UP2+mLK2Vx+u34sWPUSb61+gSRW+vX+0MXv7wm7GY/qHRHrdpL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749804350; c=relaxed/simple;
	bh=6PQjGNdTndadBOHPNSprrGjhrgshe7eqm6LfkP0/LiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqXVuFxqruAwUDvjxpGg13K/sET520uuyfIb8kU6mluj6TOlk4jIGkvKcmLy79s248ReNpgUondyyllBIlJX9teMJGqJvNfwSBjFopyRSnzOyW/HP/IethOA6/4y9r3ViRoG1KWwNOXVvQHeMns4e+WJb4/05cAjKonNq1KAgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Io6BXJVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4682AC4CEE3;
	Fri, 13 Jun 2025 08:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749804350;
	bh=6PQjGNdTndadBOHPNSprrGjhrgshe7eqm6LfkP0/LiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Io6BXJVOBa3rGapk/leIugA8Y0mg9CsNPVHgzaioUd+wmmJzgXCNeBylEZf7BTz95
	 /rq0CwhhW0lO46pyfqsFZzIAWgtMxGt1nuoMJC57bG9/3TQj5yWYORirArDMGB2mB8
	 tUThlPLV/GKKLEweCgbFvdjiHomidjbppYF5KTQmm77oG93fGmla/PI/v9r60EtMjZ
	 yORFY3xe0HKEYZOXIoHtrVL5M+ZqLQGXetecA4RaWPYO6TunP6sjBS0U2QdyJy2c9a
	 1y+30HoSoC5Hg5iUcQYn2JQBt3HlzRCJUOAuM2DmLw+Ut89iABTAMGXpe1Pfg6nSZE
	 cgGzTmqFhr5vg==
Date: Fri, 13 Jun 2025 14:15:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, tglx@linutronix.de, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, mahesh@linux.ibm.com, oohall@gmail.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Hans Zhang <hans.zhang@cixtech.com>
Subject: Re: [PATCH 2/2] PCI/AER: Use bool for AER disable state tracking
Message-ID: <ufdexukxobnpyjmfbr7gb2zvlv4xshkwbuinrrr3fowtmjtcyv@xfmmg7wrvjm7>
References: <20250516165223.125083-1-18255117159@163.com>
 <20250516165223.125083-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250516165223.125083-3-18255117159@163.com>

On Sat, May 17, 2025 at 12:52:23AM +0800, Hans Zhang wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Change pcie_aer_disable variable to bool and update pci_no_aer()
> to set it to true. Improves code readability and aligns with modern
> kernel practices.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>

Applied to pci/misc!

- Mani

> ---
>  drivers/pci/pcie/aer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628..ade98c5a19b9 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -111,12 +111,12 @@ struct aer_stats {
>  					PCI_ERR_ROOT_MULTI_COR_RCV |	\
>  					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
>  
> -static int pcie_aer_disable;
> +static bool pcie_aer_disable;
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>  
>  void pci_no_aer(void)
>  {
> -	pcie_aer_disable = 1;
> +	pcie_aer_disable = true;
>  }
>  
>  bool pci_aer_available(void)
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

