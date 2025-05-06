Return-Path: <linux-pci+bounces-27266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D24FAABC95
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 10:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4449A504E96
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 08:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68513227EA1;
	Tue,  6 May 2025 08:07:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378422A1D4;
	Tue,  6 May 2025 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746518826; cv=none; b=YFyW0jtTylYKXxqLbsgFiTXDrmcHRjDo3MINyeCVlLXj3XDCgcvGlqW4ikSIXFV1KQLDowdaPoBYhB5t2LCes3gMjEe13i1KgImsf5zq8PxRvDNNiYtFmEmjGNibx1L6cD6ycZXdcsuhaoRmZ2Xro/c5OdywggijeslTk2/0JEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746518826; c=relaxed/simple;
	bh=ctqEI29Ajb0YxefQ/2ghw4IH1R7Rowb1zE0UcrgYyP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXiBJ8o88GuF7KK9/o2b4rjz9a462SnXPAElorOtl8j7JNRfY+QMMSyTJvI4YlW2OWHeggDGHyv0Sz5jVHMPYPV0M3LoPXJlseE1LtJJn1YD/GXc1rMU6MQOCjvjkrQrC5+aUyISC6dK0HWuGtan2yZ5UFIhffD5j6XChdU+N2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A004B2C000AD;
	Tue,  6 May 2025 10:06:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 620E44183C; Tue,  6 May 2025 10:06:59 +0200 (CEST)
Date: Tue, 6 May 2025 10:06:59 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 382/642] PCI/pwrctrl: Move
 pci_pwrctrl_unregister() to pci_destroy_dev()
Message-ID: <aBnDI_40fX7SM4tp@wunner.de>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-382-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505221419.2672473-382-sashal@kernel.org>

On Mon, May 05, 2025 at 06:09:58PM -0400, Sasha Levin wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> [ Upstream commit 2d923930f2e3fe1ecf060169f57980da819a191f ]
> 
> The PCI core will try to access the devices even after pci_stop_dev()
> for things like Data Object Exchange (DOE), ASPM, etc.
> 
> So, move pci_pwrctrl_unregister() to the near end of pci_destroy_dev()
> to make sure that the devices are powered down only after the PCI core
> is done with them.

The above was patch [2/5] in this series:

https://lore.kernel.org/r/20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org/

... so I think the preceding patch [1/5] is a prerequisite and would
need to be cherry-picked as well.  Upstream commit id is:
957f40d039a98d630146f74f94b3f60a40a449e4

That said, I'm not sure this is really a fix that merits backporting
to stable.  Mani may have more comments whether it makes sense.

Thanks,

Lukas

