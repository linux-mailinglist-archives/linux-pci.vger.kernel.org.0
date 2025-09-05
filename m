Return-Path: <linux-pci+bounces-35550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A4B46261
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 20:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBF4A4807E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA068273D81;
	Fri,  5 Sep 2025 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oo8UjTLl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8C273D68;
	Fri,  5 Sep 2025 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097515; cv=none; b=E4E3y1LLQ1GcS18E5VAOHlStSel1oXcVo0Uo2F4wTwqCHKX+Re10dtjXfmLYcb0buUnCRph0PUaA6qH0+jo6MBex5f6RKufDLVTtqwGPkgoeAcH/U8rbkbpWfwFa1E6GEWq6dqNDlBon9yNHhlcUqlkfUNHyurJjw34fC9i983Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097515; c=relaxed/simple;
	bh=0TTUMJ7XySbVmAWG6wHF3oscIjGqPW8iA/o4X2XB1ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fH7oRCkl34lSgkGNQP9iJ5NwbJTnfDEK+9S+x3U8obZScYOrxPA1UAAJv1U4CDagAJw0lN8ddCYZuGMsGYOkT7geKNDYMxtel54GaMfGU8nZBPMbQ7T+M+TPNi/v2yHavUmOfesczyUREqkONvppnQdzr2kXz0rA7e+6NxCgZ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oo8UjTLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A19CC4CEF1;
	Fri,  5 Sep 2025 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757097515;
	bh=0TTUMJ7XySbVmAWG6wHF3oscIjGqPW8iA/o4X2XB1ds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Oo8UjTLlCxxp8s08LT+xd+bvVecZFjW+ww5Li+G+KZveun8DFDB61mS5cp1Bfp2Ze
	 DaDoGIMhsx/RJVEGTDN0/FoiALzZgU0HuXdvv59EiQfZmcrLRyAfnGxI/k/JbLNikN
	 PaPH9wmolpmdsoSOb5m65lifuykvgyDSg5bSw/LBThlzYZrpJaWki1M0yteKbuoy8z
	 H7GaaXVm/a4eFkuC743XdrtdDST8/CSDIwYBecdZN7vDlplsQdNR/vUsovJFa2XEE4
	 2KwkJ6jgZtYsv5MbGQ4NVOSPbhpSWPvw+iqmeb5jV0qtfcBAWLmpDKrFAktAKanrR6
	 hxXILQXQsKuWw==
Message-ID: <ccad60cf-7aad-4cb7-9ac2-545e7ff4afe1@kernel.org>
Date: Fri, 5 Sep 2025 13:38:33 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] PCI/PM: Skip resuming to D0 if disconnected
To: Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Cc: linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Lukas Wunner <lukas@wunner.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>
References: <20250811163510.601103-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250811163510.601103-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/11/2025 11:35 AM, Mario Limonciello (AMD) wrote:
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
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Bjorn,

Can you take a look at this one?

> ---
> v6:
>   * rebase on v6.17-rc1
> v5:
>   * Pick up tags, rebase on linux-next
>   * https://lore.kernel.org/linux-pci/20250709205948.3888045-1-superm1@kernel.org/T/#mbd784f786c50a3d1b5ab1833520995c01eae2fd2
> ---
>   drivers/pci/pci.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cdd..036511f5b2625 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1374,6 +1374,11 @@ int pci_power_up(struct pci_dev *dev)
>   		return -EIO;
>   	}
>   
> +	if (pci_dev_is_disconnected(dev)) {
> +		dev->current_state = PCI_D3cold;
> +		return -EIO;
> +	}
> +
>   	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>   	if (PCI_POSSIBLE_ERROR(pmcsr)) {
>   		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585


