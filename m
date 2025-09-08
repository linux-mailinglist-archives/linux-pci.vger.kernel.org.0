Return-Path: <linux-pci+bounces-35691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6580FB49B69
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 23:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D581BC46BE
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF0C2DCC13;
	Mon,  8 Sep 2025 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUD2eANc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D901798F;
	Mon,  8 Sep 2025 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365440; cv=none; b=mV8NVYy9+BNkKAIbWomn9i+D6ynAtelhEsXykXkMs39D/r40jTe3eC6Aws9zHUfQ6851e8+hIxsj+MYjXC7VoE/ZgdGHPCOHY2FmguKHYrIJWF7VwCvsoYC/2uLBdiKRx4oqogKv0EP2g4RBN4613D6no6F4JL4AuMBZp8kbwNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365440; c=relaxed/simple;
	bh=lmBcECvI36pXG+iHU1bzh6Ylx9CdhpfB7qPxbZazMD0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jTFIZcyrremzvaI+AhQXFlKUvEoj4cijXbMYeKXMkMTerh+jdMxfTKNOaLPiPmac1RRrBoxau7kFqYZamearV6tnc+9IYTZTwtE1Wai1+ER3K5IScjg/4XgjQ3PcARZBvHC0P0jMrdxzKXuc+ndNqgCCe5wahB9zG6zM57MelYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUD2eANc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2FFC4CEF1;
	Mon,  8 Sep 2025 21:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757365440;
	bh=lmBcECvI36pXG+iHU1bzh6Ylx9CdhpfB7qPxbZazMD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kUD2eANcUSnmZikgbgETII3iTa24k+oeRhzfI9YCi5f3bwtd4lgG2fwztFAvjYI60
	 F/zHHjUVFvBISmBziuBrXXoL78lba4vMDWNeJhxbUFqKW6bAdnP/xvF+Jibtaaj7/K
	 2xt+be6LoPggc/4xlnto2Kz8RTuhDdvU2ZgivWjekGN9S75oliz3Kz88e+yPEN0ABX
	 +3+xF708OF3uhYQ5T6OQ/0SR1tSQvr/jk9XyMTZckxGQHXe3b9LKDCM+Mc0jE98A6s
	 jxR12bUB2aUHvCGU0YUmZtRrbdLp9evBqazn565mnJcUOOR4JllnCwuGgcikgzOn3e
	 pxhldnRmZOYaA==
Date: Mon, 8 Sep 2025 16:03:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6] PCI/PM: Skip resuming to D0 if disconnected
Message-ID: <20250908210358.GA1464207@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811163510.601103-1-superm1@kernel.org>

On Mon, Aug 11, 2025 at 11:35:10AM -0500, Mario Limonciello (AMD) wrote:
> When a USB4 dock is unplugged the PCIe bridge it's connected to will
> issue a "Link Down" and "Card not detected event". The PCI core will
> treat this as a surprise hotplug event and unconfigure all downstream
> devices. This involves setting the device error state to
> `pci_channel_io_perm_failure` which pci_dev_is_disconnected() will check.

There's nothing special about USB4 here, right?  I guess the same
happens with any surprise hotplug remove?

pciehp_unconfigure_device() does the pci_dev_set_io_state(dev,
pci_channel_io_perm_failure) part on everything that got removed, so
that part is pretty straightforward.

> It doesn't make sense to runtime resume disconnected devices to D0 and
> report the (expected) error, so bail early.

Can you include a hint about where the runtime resume happens?  It
seems unintuitive to power up removed devices.

> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v6:
>  * rebase on v6.17-rc1
> v5:
>  * Pick up tags, rebase on linux-next
>  * https://lore.kernel.org/linux-pci/20250709205948.3888045-1-superm1@kernel.org/T/#mbd784f786c50a3d1b5ab1833520995c01eae2fd2
> ---
>  drivers/pci/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cdd..036511f5b2625 100644
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
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> -- 
> 2.43.0
> 

