Return-Path: <linux-pci+bounces-11181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B087945B75
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 11:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7CDEB21F51
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 09:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8A91DC472;
	Fri,  2 Aug 2024 09:49:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DA51DAC7C;
	Fri,  2 Aug 2024 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592176; cv=none; b=g1tcQzClSzkPwtRtLBorB3KU3H39xGhrg/z/R0EEEIXK5QmDoakVdAlE8Zr/4M0QtH6d6WMyb1mSgdg7pAlPDpyjTvsgPZH9XPt8Ac4S9sYnPjmSyTutJjYBT2C77Rl5IEMowF0EoYc4X7ZDeS+56XdFiTrnhqGbw85gu75vM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592176; c=relaxed/simple;
	bh=TLnUJHP/gBmrZs4sMzkN0je1i78gY19QnEy6AZbjwLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqQy9g72kFkHD1lxyCyrG+02UWXBFQDYTMCl6jDfO97h5XP2rPc/DUsFshrsOyJiy80socFOobMMj94jArpVHQ+924nKE0m2I2gptHPPsUBgUnFbP++0TGPTsan5Nw1c+ocIfqwCmTNVPMTeERxfBEb1nIvCPjMJ0GOy+bX1qvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 3E677100DA1B2;
	Fri,  2 Aug 2024 11:49:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DB3E1176024; Fri,  2 Aug 2024 11:49:23 +0200 (CEST)
Date: Fri, 2 Aug 2024 11:49:23 +0200
From: Lukas Wunner <lukas@wunner.de>
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	mika.westerberg@linux.intel.com, Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 1/4] PCI/portdrv: Make use of pci_dev::bridge_d3 for
 checking the D3 possibility
Message-ID: <Zqyro5mW-1kpFGQd@wunner.de>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-1-2426dd9e8e27@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-pci-bridge-d3-v5-1-2426dd9e8e27@linaro.org>

On Fri, Aug 02, 2024 at 11:25:00AM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> PCI core is already caching the value of pci_bridge_d3_possible() in
> pci_dev::bridge_d3 during pci_pm_init(). Since the value is not going to
> change, let's make use of the cached value.
[...]
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -702,7 +702,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
>  					   DPM_FLAG_SMART_SUSPEND);
>  
> -	if (pci_bridge_d3_possible(dev)) {
> +	if (dev->bridge_d3) {

I don't know if there was a reason to call pci_bridge_d3_possible()
(instead of using the cached value) on probe, remove and shutdown.

The change is probably safe but it would still be good to get some
positive test results with Thunderbolt laptops etc to raise the
confidence.

Thanks,

Lukas

