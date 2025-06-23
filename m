Return-Path: <linux-pci+bounces-30442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C31EDAE4C8E
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 20:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7217ABA58
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBA4279DCB;
	Mon, 23 Jun 2025 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czPDQHmt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F12F4F1;
	Mon, 23 Jun 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702244; cv=none; b=YXPqKMBncc8MON4bOdGUCI2W/9sD/Hg+qLeDuHZhakbdiWvgSaQrHMf1hSUe0byq0pPgJ03aNV39L4xOIr2nCKTZhnWZ0cMrgiHIHp6hKtctNZ1ova6qEKbKsqwiF6KfeufS45LO9XjrDBSdDhQEpZ7Z8QeeFC6vh8o6s5VogKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702244; c=relaxed/simple;
	bh=7tbf/KwfAn+T9x0r52PpAXJDPtRg3KWiYur85i2RrDM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=O/Dkw1I7xvTaLuRRBl2g4rC7plSdLNcwRrgTpXa2v+FU93CMQ47J1KlSJvVGN9UKAMeUXwXXI6fllSYD2KyGudH4bv2vcVzx0SCuj4xJR4teuMmr1AAQkFsWnNnaX/7sxt/EbAODQnADNWZqPH9CzhSaUASEU2lj65bmZBJDdWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czPDQHmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE83EC4CEEA;
	Mon, 23 Jun 2025 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750702243;
	bh=7tbf/KwfAn+T9x0r52PpAXJDPtRg3KWiYur85i2RrDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=czPDQHmtPwTTIXAXKW6k1kK6633S7vpkG8myRBSNAjyNKkYZOGFfR98rtT2xSO5qQ
	 Mvg16fXcccD7DTni0IyRnNTLgWOJg0gueEYmb75ybz5w7yfJKCm6PwTGjVTtLzEjb2
	 EeccXl72qdOincPXMz0ZU46BT9wvGpDuJJkFnJdDri9Nz/6/yxlYBJepq9xqGiRBTR
	 uGi7hTdYIgWjOAqvgVDFBi7tlYT02MfVe3VVpA0ktO0+/afo9Pg+Mz12R3cNSR6N6/
	 tYfc+4Df4q3rs7ecC3QABXBGX8EpFUPeJvYlp6SwmMkXhC3UHkIgIq08ZTknz6AuHj
	 WWJS+JtiLo2eQ==
Date: Mon, 23 Jun 2025 13:10:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] pci: pwrctl: fix the kerneldoc tag for private fields
Message-ID: <20250623181042.GA1436011@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618091129.44810-1-brgl@bgdev.pl>

On Wed, Jun 18, 2025 at 11:11:29AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The correct tag for marking private fields in kerneldoc is "private:",
> not capitalized "Private:". Fix the pwrctl struct to silence the
> following warnings:
> 
>   Warning: include/linux/pci-pwrctrl.h:45 struct member 'nb' not described in 'pci_pwrctrl'
>   Warning: include/linux/pci-pwrctrl.h:45 struct member 'link' not described in 'pci_pwrctrl'
>   Warning: include/linux/pci-pwrctrl.h:45 struct member 'work' not described in 'pci_pwrctrl'
> 
> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/all/20250617233539.GA1177120@bhelgaas/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied to pci/pwrctrl for v6.17, thanks!

> ---
>  include/linux/pci-pwrctrl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
> index 7d439b0675e9..4aefc7901cd1 100644
> --- a/include/linux/pci-pwrctrl.h
> +++ b/include/linux/pci-pwrctrl.h
> @@ -39,7 +39,7 @@ struct device_link;
>  struct pci_pwrctrl {
>  	struct device *dev;
>  
> -	/* Private: don't use. */
> +	/* private: internal use only */
>  	struct notifier_block nb;
>  	struct device_link *link;
>  	struct work_struct work;
> -- 
> 2.48.1
> 

