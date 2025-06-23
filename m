Return-Path: <linux-pci+bounces-30438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E85BAE4C24
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA0F168781
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9153129B776;
	Mon, 23 Jun 2025 17:48:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C631B393C;
	Mon, 23 Jun 2025 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750700919; cv=none; b=AkwK6XpUqg0U9vgrbyPgpkfWOuKVFipxGEbYAhFgKElSK2DNwpUZFGvYMMP84l4k47GEYXfbYd8mhSuPtIbS0KqATGGwreDYDpfOu2oOJi3koVOAmZalOUzaADF+t/KF6It+dEO1mVmYhXG3dwEYRSpGZjlCJD5GiBLjeRU6Xwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750700919; c=relaxed/simple;
	bh=5foJVQIbPVVu+7F1egWbRd3gr0xd0xbJ0PagND3KLw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9TC320sFHdIT+OqkbOatOCeQRm+RFGa75DweLQfdmLud3fkI3D2gaPdUj7EKGKl2C4nLo1ewCSC6ABOslCq8OFsOiUeUcIHC/Gp20ViOjx176o/3+hMH15DMiWM1IspRemIjJLUG8Sb7UfKtBuoKGbY1PHhvkKPyyerrY81WJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id D5C1820091A2;
	Mon, 23 Jun 2025 19:48:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D04CC3B459C; Mon, 23 Jun 2025 19:48:34 +0200 (CEST)
Date: Mon, 23 Jun 2025 19:48:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 1/2] PCI/PM: Skip resuming to D0 if disconnected
Message-ID: <aFmTcqQlz-Vz4v_b@wunner.de>
References: <20250620025535.3425049-1-superm1@kernel.org>
 <20250620025535.3425049-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620025535.3425049-2-superm1@kernel.org>

On Thu, Jun 19, 2025 at 09:55:34PM -0500, Mario Limonciello wrote:
> When a USB4 dock is unplugged the PCIe bridge it's connected to will
> remove issue a "Link Down" and "Card not detected event". The PCI core

Small nit here, the word "remove" seems superfluous.


> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1374,6 +1374,11 @@ int pci_power_up(struct pci_dev *dev)
>  		return -EIO;
>  	}
>  
> +	if (pci_dev_is_disconnected(dev)) {
> +		dev->current_state = PCI_D3cold;
> +		return -EIO;
> +	}
> +
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  	if (PCI_POSSIBLE_ERROR(pmcsr)) {
>  		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",

This hunk looks good to me.


> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -550,6 +550,7 @@ static inline bool pci_dev_set_io_state(struct pci_dev *dev,
>  
>  static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  {
> +	pci_info(dev, "Device disconnected\n");
>  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
>  	pci_doe_disconnected(dev);

However this one (which I think was newly added in v3) seems problematic:

pci_dev_set_disconnected() needs to be fast so that devices are marked
unplugged as quickly as possible.  We want to minimize the time window
where MMIO and Config Space reads already return "all ones" and writes
go to nirvana, but pci_dev_is_disconnected() still returns false.
However printk() isn't a cheap operation, so it may unduly delay
marking the removed devices disconnected.

Second, the object of the patch is to make hot-removal less noisy,
but this change *increases* noise.  It will emit an extra message
for every removed device.

Third, the change is somewhat orthogonal to the first hunk in the patch,
so I would have put this in a separate patch.

Bottom line is, at the very least I'd recommend making this a pci_dbg(),
but I'm not even sure the extra message adds sufficient value to justify
the change.

Thanks,

Lukas

