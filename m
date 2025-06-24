Return-Path: <linux-pci+bounces-30477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93569AE5D92
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 09:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFD116922F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 07:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D6522A4EF;
	Tue, 24 Jun 2025 07:22:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC97486347
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750749779; cv=none; b=gpWRN7NAGdtdinnnDL/6Q7DmhUdwrhbHYJVvOkmzKSNbNlTV1/AUwvoNd5UQ6+BuFLXB3T8S1EeDdBjvjglk4v6YoPMln5SFIVh2sioD4mRGidkVNcCxPGIXwHHMaGV3hp8A57tbGW+C1HpyIu0RF1QMCIuBrQX4aHjKb58TsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750749779; c=relaxed/simple;
	bh=A8G5HZKz0eE7tYSXZkdIkGNraipu/z0xvw8/3zvUwNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBJwgXTxg9L9RNek+OIrRIfq9MaJTXiYl1SygaCNEKMEgC/ETXTgvm6dcwju8Gnf2OFpuFWJsxcNgnPUcn2c5qdRO1uX1/ss56Vwhjn78CTd8IlGcdjS+SWl1JX8YnCHUCh+SFoNngVkyLjtMnBeZAa+4i6oN1fnksC7mlGcaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 152922009D27;
	Tue, 24 Jun 2025 09:22:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0D3A33B46B8; Tue, 24 Jun 2025 09:22:53 +0200 (CEST)
Date: Tue, 24 Jun 2025 09:22:53 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>
Subject: Re: [PATCH v4] PCI/PM: Skip resuming to D0 if disconnected
Message-ID: <aFpSTT_UHakY91_q@wunner.de>
References: <20250623191335.3780832-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623191335.3780832-1-superm1@kernel.org>

[cc += Rafael, Mika]

On Mon, Jun 23, 2025 at 02:13:34PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> When a USB4 dock is unplugged the PCIe bridge it's connected to will
> issue a "Link Down" and "Card not detected event". The PCI core will
> treat this as a surprise hotplug event and unconfigure all downstream
> devices. This involves setting the device error state to
> `pci_channel_io_perm_failure` which pci_dev_is_disconnected() will check.
> 
> It doesn't make sense to runtime resume disconnected devices to D0 and
> report the (expected) error, so bail early.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

> ---
> v4:
>  * no info message
> v3:
>  * Adjust text and subject
>  * Add an info message instead
> v2:
>  * Use pci_dev_is_disconnected()
> v1: https://lore.kernel.org/linux-usb/20250609020223.269407-1-superm1@kernel.org/T/#mf95c947990d016fbfccfd11afe60b8ae08aafa0b
> ---
>  drivers/pci/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9e42090fb1089..160a9a482c732 100644
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
> -- 
> 2.43.0

