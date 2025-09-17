Return-Path: <linux-pci+bounces-36387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E912AB8217A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 00:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB065172005
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 22:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E18289340;
	Wed, 17 Sep 2025 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQTT3NL9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1372123ABA0
	for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146641; cv=none; b=tX1eHA5D53JYW4Y0Fr/2hcJl/yXy5bubBmlgtNcDb0kKo5Dw/A0Ae8bPEQroyYobw6/j2/kS4WGDWf+WH1aMFH5Ds2YLtaIp8QkdTauu3QK6VUpmyvstqcFIXp0ujAeGGrDBdQTIvGP/T7qcSPEOToBqIwPWcJfOls8AdrRwwWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146641; c=relaxed/simple;
	bh=k0nQcch1exthX5y375fnAM/rKw5+r4sZQRE5ja526JE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OXI5Jcmlgr+Gje6yC4OyKPWYpnsEoqyfay7u+xyolbPJdQq4pZT6kmyzfuUF7DoFN3T47XnDNwLeY+2rd+XuPR0FppaEwvYIzRKu8K6UMgtgjgT1NaT3lV09cXDJ9+5kDrdiQq/ChuTufbrdGdXGsg8cxNDShsDnnAhohA67sps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQTT3NL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70738C4CEE7;
	Wed, 17 Sep 2025 22:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758146640;
	bh=k0nQcch1exthX5y375fnAM/rKw5+r4sZQRE5ja526JE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dQTT3NL9+lHO9jfiIkV5KN4lAfP28eFGLHU1xDD3QmqtblWsLeUUGQHfHdQbqXoyU
	 8nWVxURgce2i1Wda9Sckwt1CxibMXlj2CtXtADi2voLnAEC+KzGbJlBfYEo2aPMuJV
	 SG0RPFjGYEsD1H5BL0kWsJ7BVfXjvKhdm5k+867xwLdCSOGr6O5M8EhkVAZZLmg8of
	 SR7NBic4c1hl4I9T8BRmff9A0MNTH5HmIdJIn5kdGzDtjnWeaIcKiLftsbmFtd3zRk
	 FhUY2r7aqATRtw1lBJFcNyXUlo4zSldkAwkPuO2v6p5SIOYdMWxCWmuW6yn/XWe1IY
	 1P6FN5M7/pfCw==
Date: Wed, 17 Sep 2025 17:03:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
	Lukas Wunner <lukas@wunner.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7] PCI/PM: Skip resuming to D0 if device is disconnected
Message-ID: <20250917220359.GA1877999@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250909031916.4143121-1-superm1@kernel.org>

On Mon, Sep 08, 2025 at 10:19:15PM -0500, Mario Limonciello (AMD) wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> When a PCIe device is surprise-removed (e.g., due to a dock unplug),
> the PCI core unconfigures all downstream devices and sets their error
> state to `pci_channel_io_perm_failure`. This marks them as disconnected
> via `pci_dev_is_disconnected()`.
> 
> During device removal, the runtime PM framework may attempt to resume
> the device to D0 via `pm_runtime_get_sync()`, which calls into
> `pci_power_up()`. Since the device is already disconnected, this
> resume attempt is unnecessary and results in a predictable error.
> Avoid powering up disconnected devices by checking their status early
> in `pci_power_up()` and returning -EIO.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied to pci/pm for v6.18, thanks, Mario!

> ---
> v7:
>  * Reword commit message
>  * Rebase on v6.17-rc5
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
> -- 
> 2.43.0
> 

