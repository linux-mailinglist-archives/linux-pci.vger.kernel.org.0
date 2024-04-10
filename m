Return-Path: <linux-pci+bounces-6035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C689FAE3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110EF1C225F1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5D716DECA;
	Wed, 10 Apr 2024 14:58:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C516DEB0
	for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761120; cv=none; b=LMdGQAp+eun9XimzJCbbJv5Qk2c3f1QqEjgGy4q/CYxlQ6RQd7ChXpoY+cEQD0QL3HJ30fKY221j3O7K/I7jQsakgwncH2PZu3cNXgIvRyPFr4AfNsiZXBOr52O7F0d/EiqwFCFBFsq+IXTE4G/7D7teWbhpq5VqMFgxDgHTF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761120; c=relaxed/simple;
	bh=7ZUapsFQgy/YPVPPuPHyZwpwk5SAWQ1d3RrmVaIJPRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GH+gSxvg9JaXka8Pkh6LCv/VZe2v8oeiYf/zxZw3IrchT/6/QwSzTwBQ+NyPP1aD6zIA+r3/8BFbZyU+xJw5jnMSmZaccjGiM+02apfCKKMYHd2x4foD8rPL1nQ8J8nWvqhuJ9KLDD6tew+Wjsf3N2e/ghypcoP4nwpZYOnhYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8B3C53000D5C5;
	Wed, 10 Apr 2024 16:58:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 771194EE682; Wed, 10 Apr 2024 16:58:28 +0200 (CEST)
Date: Wed, 10 Apr 2024 16:58:28 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ricky WU <ricky_wu@realtek.com>
Cc: "scott@spiteful.org" <scott@spiteful.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [bug report] nvme not re-recognize when changed M.2 SSD in S3
 mode
Message-ID: <ZhapFF3393xuIHwM@wunner.de>
References: <a608b5930d0a48f092f717c0e137454b@realtek.com>
 <ZhZk7MMt_dm6avBJ@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhZk7MMt_dm6avBJ@wunner.de>

On Wed, Apr 10, 2024 at 12:07:40PM +0200, Lukas Wunner wrote:
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -152,6 +152,25 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
>  	return 0;
>  }
>  
> +static bool pciehp_device_replaced(struct controller *ctrl)
> +{
> +	struct pci_dev *pdev;

I've realized this needs to be

+	struct pci_dev *pdev __free(pci_dev_put);

to avoid leaking a ref on the child device.  For testing purposes,
the patch should still be fine without this change, but I'll have to
fix this up if/when submitting a proper patch.

> +	u32 reg;
> +
> +	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
> +	if (!pdev)
> +		return true;
> +
> +	if (!pci_bus_read_dev_vendor_id(ctrl->pcie->port->subordinate,
> +					PCI_DEVFN(0, 0), &reg, 0))
> +		return true;
> +
> +	if (reg != (pdev->vendor | (pdev->device << 16)))
> +		return true;
> +
> +	return false;
> +}
> +
>  /**
>   * pciehp_check_presence() - synthesize event if presence has changed
>   * @ctrl: controller to check
> @@ -172,7 +191,8 @@ static void pciehp_check_presence(struct controller *ctrl)
>  
>  	occupied = pciehp_card_present_or_link_active(ctrl);
>  	if ((occupied > 0 && (ctrl->state == OFF_STATE ||
> -			  ctrl->state == BLINKINGON_STATE)) ||
> +			      ctrl->state == BLINKINGON_STATE ||
> +			      pciehp_device_replaced(ctrl))) ||
>  	    (!occupied && (ctrl->state == ON_STATE ||
>  			   ctrl->state == BLINKINGOFF_STATE)))
>  		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);

