Return-Path: <linux-pci+bounces-29233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E176EAD2215
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 17:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3811890059
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD21B20AF98;
	Mon,  9 Jun 2025 15:09:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D891D63C2
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481769; cv=none; b=u4kl1twqbFKXeTnD3RnCbN9AfcD/A0wN3wc/R05MFSIxVQQVMkXKBZdyRYSlTPkgg3znXhUjefADO6Xfab1hzpQ9GadkIOOLsCfwSaccgd4y8Ub0M5cxz9yVbArIkwdRTMcF2H9ivfy+B7necSYVLCoInx6RrTJP+wiAJY+jtOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481769; c=relaxed/simple;
	bh=ZiTgNj6kzYHscENJHCV9L4XvbPXJkoddDUi4g+bQUcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZanZ4nJ1R4QNmNzMYY7dPJlAa5UMhS2RpM7vi4oo6mCqSMb+7CemL1OfYYSJsnnu53yukhEtBmmwkGnUmtRzQOxCMuVoSdSMFQgjWGQZaEJkdZw4W9HsDeFZ/3DVTYQpLFnxT0Xhzs/3dtmYoSuvdkl0yc4jSDEyVzh2KJ6M03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 43AC32C06E33;
	Mon,  9 Jun 2025 17:09:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3801C36419B; Mon,  9 Jun 2025 17:09:18 +0200 (CEST)
Date: Mon, 9 Jun 2025 17:09:18 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/4] PCI: Don't show errors on inaccessible PCI devices
Message-ID: <aEb5HjRQ6OHZj_hS@wunner.de>
References: <20250609020223.269407-1-superm1@kernel.org>
 <20250609020223.269407-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609020223.269407-2-superm1@kernel.org>

[cc += Rafael, Mika]

On Sun, Jun 08, 2025 at 08:58:01PM -0500, Mario Limonciello wrote:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1376,8 +1376,9 @@ int pci_power_up(struct pci_dev *dev)
>  
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> -		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
> -			pci_power_name(dev->current_state));
> +		if (dev->error_state != pci_channel_io_perm_failure)
> +			pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
> +				pci_power_name(dev->current_state));
>  		dev->current_state = PCI_D3cold;
>  		return -EIO;
>  	}

Instead of merely silencing the error message, why not bail out early on
in the function, i.e.

	if (pci_dev_is_disconnected(dev)) {
		dev->current_state = PCI_D3cold;
		return -EIO;
	}

Thanks,

Lukas

