Return-Path: <linux-pci+bounces-36447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E02EB87340
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 00:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36E87C2E96
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 22:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B3E2FCBF1;
	Thu, 18 Sep 2025 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8ytYRSs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E42FB627
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758233299; cv=none; b=DGn73YvZxFd2iO3j/NONrF/CsRGaXB4fREDLos0IklQDB5ZOT0vZxNvl0dK/SuFDRhBX1nrHEGVX+MCdZt9jDY8E+t/kmqHhgtRrs0z4Vi1z9C5I+UfA5m3lK+OtWy0ZuyHDurq/kGIWkGPO99CBf9bkJi+jtIRRg0i2rZk2eNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758233299; c=relaxed/simple;
	bh=5aweSLkzh7ejNDcgoNf1VnnuIro2pfodjmCHJRSPpTk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qWrLG3tQvY95xbvu8CtsRGs4JAyfyD4XJdvb34qWrSZLjtuf+1L/yMrLAmut4Hpx0ZXITB6TUCEPFUt6avBuhw8EMdwG0Cb5UPn9YAeRpgrDr9tJG/uTyJ7SUXTZEa5JFiS7M6BmgpvwxXfzd0q76dVpsUUmmzgSIDae2IYfnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8ytYRSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34769C4CEE7;
	Thu, 18 Sep 2025 22:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758233298;
	bh=5aweSLkzh7ejNDcgoNf1VnnuIro2pfodjmCHJRSPpTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o8ytYRSszEyC59bAp8RdK+emycoT4ysYYvq6viNpZ/cR8L8ET9La7Tul83PVwkoza
	 xDc2SxIvxDTzCkaLDFu3SAwlQIfTrtAotxi9MCPoBsFRl9erdlYXRuGfKpete2h4sD
	 eKyOo3r7FDXz2K/FAQ49C9ibMtxAqaLpUrlCGKeRYAOpsiYto5ZvkV3U8MJ3ZZ6tQS
	 U+jtUoHhE+PWmcHZZ6Q17UuHHEWshnFIOtn9o8aX+eR6kqyNottumygY//rPVbvxD6
	 XdhNshp7JfnVDDzWAMh3cpx3rOf8QpB2i5NVc+hQ8WCxcZh3EudlfyAUPr4lT8Rnsn
	 lq4l7voAiOqpQ==
Date: Thu, 18 Sep 2025 17:08:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
	Lukas Wunner <lukas@wunner.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7] PCI/PM: Skip resuming to D0 if device is disconnected
Message-ID: <20250918220816.GA1925068@bhelgaas>
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

Hi Mario,

I forgot to ask if there are any characteristic dmesg logs and user
activities that we could include here to help users recognize this
problem.  I suppose it results in messages like this?

  pci 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible

Maybe especially when undocking?  Although oddly a google search for
that message and "undock" finds nothing.

> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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

