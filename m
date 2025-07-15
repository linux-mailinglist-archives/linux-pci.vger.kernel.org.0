Return-Path: <linux-pci+bounces-32131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B773CB0547F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 10:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8BD189F204
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 08:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435B325D55D;
	Tue, 15 Jul 2025 08:16:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231162405F9;
	Tue, 15 Jul 2025 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567392; cv=none; b=USyVDv+a6c1ywE1kIRGCPt62IeELUQ2x15sBtEvJf8cNHR000tUgqDTSFmHg6iUnsoCX2jJBuroNaCPAVI9zMnGtChEEnJOH0I16o8041v+LvY7uIfvCv8GZVj9EB8NbtOuoSB9JR/bsK9lzwvYGmwZJ9RDjF/JJ4wZHxoLQ898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567392; c=relaxed/simple;
	bh=49FlX1avA+FOW1F2dbzHOqWjJIKmKe/jaMgbW4rSOXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFpBwnCjkD8V4XY2g646O1XoFG3vlP2syhx4ls3fX/X6K4q//Mkd2TndOXqCzVK/xl+7BwHXKX4bOCLiYlH5neFdgir9R0uVFktBTI3TtdnVMIuUBZG6rDX0QJcd/utbPtzXgKHtxrbU99ntGZRDhHmHOwt/CwV8zGZEcWHA8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5578C2C06843;
	Tue, 15 Jul 2025 10:16:27 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 20CD4390420; Tue, 15 Jul 2025 10:16:27 +0200 (CEST)
Date: Tue, 15 Jul 2025 10:16:27 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/4] PCI/ERR: Add support for resetting the Root Ports
 in a platform specific way
Message-ID: <aHYOW3P0wvHo5a1j@wunner.de>
References: <20250715-pci-port-reset-v5-0-26a5d278db40@oss.qualcomm.com>
 <20250715-pci-port-reset-v5-1-26a5d278db40@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-pci-port-reset-v5-1-26a5d278db40@oss.qualcomm.com>

On Tue, Jul 15, 2025 at 01:29:18PM +0530, Manivannan Sadhasivam wrote:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4964,7 +4964,19 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>  
>  void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>  {
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	int ret;
> +
> +	if (host->reset_root_port) {
> +		ret = host->reset_root_port(host, dev);
> +		if (ret)
> +			pci_err(dev, "Failed to reset Root Port: %d\n", ret);
> +
> +		return;
> +	}
> +

There used to be a pci_is_root_bus() check here:

https://lore.kernel.org/r/20250524185304.26698-2-manivannan.sadhasivam@linaro.org/

Thanks,

Lukas

