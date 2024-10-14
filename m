Return-Path: <linux-pci+bounces-14445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321BE99C93B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8BFE1F22C1B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA268F64;
	Mon, 14 Oct 2024 11:45:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43B19E7ED
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906336; cv=none; b=b8nGYepF8OxdxZSprrj0rH76KI9ZSNte9snjVc8HqfRPBSfExRvcnoFOOgGu47FHoV66wvU/AThimXFJTTwbbx7yKKv3UGYXkrz+AbczHNhfSQw7p1cePrkVip6CXZeGMW7MSvWphuBAGIEyehdNd2ebwDBHbjCsS03Nq3RyGto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906336; c=relaxed/simple;
	bh=AsjmZEpESY0QKrwVS3n+245zwDrWO5ESBA7YsTDLidQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN3FCC8qmVKNeqlM8ByPxa3kcq1ziiAdoMJd9lTmw+xrZ50TJtI/t+SjLkOUWdPufMJNha0aTJ6zUcR94zIzTbYMMC992MqVp/OzXWMeFb6S+UWeHsHlTjTb8ED2APWKI8FbQanA9dT3WNsiXhPVJQI1U/5OV2xvjwHYxoWYN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 890DB227AA8; Mon, 14 Oct 2024 13:45:29 +0200 (CEST)
Date: Mon, 14 Oct 2024 13:45:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 2/5] nvmef: export nvmef_create_ctrl()
Message-ID: <20241014114528.GA31937@lst.de>
References: <20241011121951.90019-1-dlemoal@kernel.org> <20241011121951.90019-3-dlemoal@kernel.org> <20241014084219.GA23780@lst.de> <62ba5cda-338e-48bf-b82e-60e4721b1bfb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ba5cda-338e-48bf-b82e-60e4721b1bfb@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 14, 2024 at 06:10:36PM +0900, Damien Le Moal wrote:
> Nope, the PCIe "transport" is the front-end of the endpoint driver.
> What this patch does is to allow this driver to be created by passing it a
> string that is normally used for "nvme connect" command, which calls
> nvmf_create_ctrl().

That's a pretty wrong and broken layering.  PCIe isn't any different
than RDMA or TCP in being a NVMe transport.

> The entire thing was created to not add a PCIe host transport but rather to use
> a locally created fabric host controller which connect to whatever the user
> wants. That is: the PCI endpoint driver can implement a PCI interface which uses
> a loop nvme device, or a tcp nvme device (and if you have a board that can do
> rdma or fc, that can also be used as the backend nvme device used from the pci
> endpoint driver).

You can always use the nvmet passthrough backend to directly use a
nvme controller to export through nvmet. 


