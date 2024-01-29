Return-Path: <linux-pci+bounces-2736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC35D8412B3
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 19:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3CE1C22DB2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 18:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AFE15698A;
	Mon, 29 Jan 2024 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQiUsHzL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0113DB96;
	Mon, 29 Jan 2024 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553836; cv=none; b=G3rE1Xm3hy45BjVPF5r+3/E3UhUONPMM89mAqu4SkSWh5M5asfEpdauGCjGk6tvIF6/s/TvRtAiMiMtkxz/agPmbqUPh32tOtSgkhnXK/4nwxF9zrT8B9Zw6VwGjYQpI3nVXMQetWJ/WCT740+mIM/717JMGN9+36yZzirKXUmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553836; c=relaxed/simple;
	bh=kBUlimme0aHHv3ib7jWky40pcFXZPQIKkBv6fF9NIkM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fuOrGmFMgEnKYQPMbjBwbhawvO65db4RJwxSviuPalEWVbuVTmJJ5cgv7LI7yX7nIe8xQlSgdpGDQtkfulmu6ZwBJeO9Bs2V7nbyeVeLQZOAgXi2aoDl9VO8knWQRfBd+clZBLSy4SvhcRQtf0j+OCBJXIyr/ZUvvvcbqu8KvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQiUsHzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB33C433F1;
	Mon, 29 Jan 2024 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553836;
	bh=kBUlimme0aHHv3ib7jWky40pcFXZPQIKkBv6fF9NIkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jQiUsHzLvgRaXw/Rx8Xk3VQ+OnpRjZLvC2wjhFKMsMdQciYgp8rdV3oZEEdm536yX
	 bYWHsbX7vLMv1N4C3AaDfb62L0AGMqYxakkNNMvShx4ZQdcLKZynvcX0AKziNFZ0nz
	 swOriLJKUE8hbv0S0OxXPW8a5GleMqSTsre1chaV5sTqhFOvC+Qw+xEPbyM+3pizR9
	 L1PZhj6XLHt3C0+LYyiO3+8MQynwl9YAdVxg3C3yfmgNtazl9J80GBxmeNKNshicKg
	 /luscWDgqnB9DMsk5WF2FrnsPfK03cYuEMxzfkCJb3OouHPG1D0KQDEn2i2AB4gQz1
	 XLQuLBcrGbxhQ==
Date: Mon, 29 Jan 2024 12:43:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Clear LBMS on resume to avoid Target Speed quirk
Message-ID: <20240129184354.GA470131@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129112710.2852-2-ilpo.jarvinen@linux.intel.com>

On Mon, Jan 29, 2024 at 01:27:09PM +0200, Ilpo Järvinen wrote:
> While a device is runtime suspended along with its PCIe hierarchy, the
> device could get disconnected. Because of the suspend, the device
> disconnection cannot be detected until portdrv/hotplug have resumed. On
> runtime resume, pcie_wait_for_link_delay() is called:
> 
>   pci_pm_runtime_resume()
>     pci_pm_bridge_power_up_actions()
>       pci_bridge_wait_for_secondary_bus()
>         pcie_wait_for_link_delay()
> 
> Because the device is already disconnected, this results in cascading
> failures:
> 
>   1. pcie_wait_for_link_status() returns -ETIMEDOUT.
> 
>   2. After the commit a89c82249c37 ("PCI: Work around PCIe link
>      training failures"),

I this this also depends on the merge resolution in 1abb47390350
("Merge branch 'pci/enumeration'").  Just looking at a89c82249c37 in
isolation suggests that pcie_wait_for_link_status() returning
-ETIMEDOUT would not cause pcie_wait_for_link_delay() to call
pcie_failed_link_retrain().

>      pcie_failed_link_retrain() spuriously detects
>      this failure as a Link Retraining failure and attempts the Target
>      Speed trick, which also fails.

Based on the comment below, I guess "Target Speed trick" probably
refers to the "retrain at 2.5GT/s, then remove the speed restriction
and retrain again" part of pcie_failed_link_retrain() (which I guess
is basically the entire point of the function)?

>   3. pci_bridge_wait_for_secondary_bus() then calls pci_dev_wait() which
>      cannot succeed (but waits ~1 minute, delaying the resume).
> 
> The Target Speed trick (in step 2) is only used if LBMS bit (PCIe r6.1
> sec 7.5.3.8) is set. For links that have been operational before
> suspend, it is well possible that LBMS has been set at the bridge and
> remains on. Thus, after resume, LBMS does not indicate the link needs
> the Target Speed quirk. Clear LBMS on resume for bridges to avoid the
> issue.
> 
> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pci-driver.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 51ec9e7e784f..05a114962df3 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -574,6 +574,12 @@ static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
>  {
>  	int ret;
>  
> +	/*
> +	 * Clear LBMS on resume to avoid spuriously triggering Target Speed
> +	 * quirk in pcie_failed_link_retrain().
> +	 */
> +	pcie_capability_write_word(pci_dev, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
> +
>  	ret = pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
>  	if (ret) {
>  		/*
> -- 
> 2.39.2
> 

