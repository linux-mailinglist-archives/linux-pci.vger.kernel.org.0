Return-Path: <linux-pci+bounces-26413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D522EA971FD
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 18:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CD918977F4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 16:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB23E28F956;
	Tue, 22 Apr 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX3Z65O5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D720102C;
	Tue, 22 Apr 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338167; cv=none; b=JdhOK2cufGqqifInAbboux/Bn/0HFE3WEntTljgHt/6tSaWB2CPtQHLdatxrF5w7eRRS/G5LUMVCrd29vEPfIca8zF27DyKb5uQuutKHygtMmBNJ4fb3AB+Yp9fdsMk7ZMieJ4wXpy2FcsU1CxQ356D1BrqVpvm9F3g/fMpmUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338167; c=relaxed/simple;
	bh=Qd8a4qsvk9G4mClmpO236TQ3jYEPXO158QQTn0cWxKo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dGA5+b+cArV6dIFwPjDmNC/iTf0wyi+ocUCPKDxf2aYkJyseq/pW3G9ghCDVJQUu1OGuT+43q9/rQsr6ZRUeFtJiWEGA+mfK20mUlQ6AQMA1sLGf51D7jOpnhEmWN5RGKfoIsEdA/MSeca9VAA5+65ZmqSRTZroKZp90mNvdmr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX3Z65O5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83FCC4CEE9;
	Tue, 22 Apr 2025 16:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745338167;
	bh=Qd8a4qsvk9G4mClmpO236TQ3jYEPXO158QQTn0cWxKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HX3Z65O5qlPLh9w2tzD5zgqTmEEUNEK6frdS/LWvlhyQODlex5+w4HSJdCbGoofuA
	 0gQn+BMTfXd7XLr5lao+kMAgSu5Txq5IIBHoQq02UTsB1+yfusdHTZI/mXSP95k5IE
	 JCqMtjnYl26+MirO5su+/S/djJo/B6kalqrlikwIdjb4Vu39zEDTDScyyECsjs7Fai
	 xj3CMInF+87Vc5jbImMVngqirfWPFFY/EVDQg/io5f0AlQfwCXr3BL8xM6gBslPVaG
	 2Q2/l3deREN+8U1BisoC7SipI13tcn9e/v9PO9fsuIMRuduBgAtTmFYvGLoD4BtpK9
	 aTOM6KqJS8fLw==
Date: Tue, 22 Apr 2025 11:09:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jonas Gorski <jonas.gorski@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ath11k@lists.infradead.org,
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI/arm64/ath11k/ath12k: Rename pwrctrl Kconfig
 symbols
Message-ID: <20250422160925.GA331992@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402132634.18065-1-johan+linaro@kernel.org>

[cc->to Catalin, Will: note the arm64 Kconfig change; my understanding
is that this shouldn't break existing configs]

On Wed, Apr 02, 2025 at 03:26:30PM +0200, Johan Hovold wrote:
> The PCI pwrctrl framework was renamed after being merged, but the
> Kconfig symbols still reflect the old name ("pwrctl" without an "r").
> 
> This leads to people not knowing how to refer to the framework in
> writing, inconsistencies in module naming, etc.
> 
> Let's rename also the Kconfig symbols before this gets any worse.
> 
> The ath11k, ath12k and arm64 changes could go theoretically go through
> the corresponding subsystem trees in turn once they have the new
> symbols, but to avoid tracking dependencies over multiple cycles it is
> much preferred to have all of these go in through the PCI tree.
> 
> The wifi patches have been acked by Jeff and I don't think Will or
> Catalin will mind the single rename in arm64 if they don't see this
> message in time.
> 
> Note that the patches could be squashed into one, but keeping them
> separate highlights the changes done to other subsystems. I also find it
> easier to review the changes this way.
> 
> There are some new pwrctrl drivers and an arm64 defconfig change on the
> lists, but the former should also go in through PCI anyway while we can
> make sure that the defconfig update matches the new slot symbol.
> 
> Note that getting this rename into rc1 would be great as that way it
> would end up in most subsystem trees soon as well.
> 
> Johan
> 
> 
> Changes in v2:
>  - drop deprecated symbol for the new slot driver to avoid having to a
>    add a new user visible symbol (e.g. any early adopters will be asked
>    to enable the renamed option again)
> 
>  - move arm64 patch last two avoid temporarily not having the pwrseq
>    driver selected (Jonas)
> 
> Johan Hovold (4):
>   PCI/pwrctrl: Rename pwrctrl Kconfig symbols and slot module
>   wifi: ath11k: switch to PCI_PWRCTRL_PWRSEQ
>   wifi: ath12k: switch to PCI_PWRCTRL_PWRSEQ
>   arm64: Kconfig: switch to HAVE_PWRCTRL
> 
>  arch/arm64/Kconfig.platforms            |  2 +-
>  drivers/net/wireless/ath/ath11k/Kconfig |  2 +-
>  drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
>  drivers/pci/pwrctrl/Kconfig             | 22 ++++++++++++++++------
>  drivers/pci/pwrctrl/Makefile            |  8 ++++----
>  5 files changed, 23 insertions(+), 13 deletions(-)

Applied to pci/pwrctrl for v6.16, thanks!


