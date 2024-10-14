Return-Path: <linux-pci+bounces-14428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7345A99C3C0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 10:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AD3CB23EE9
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8B41531F9;
	Mon, 14 Oct 2024 08:42:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B19155CBF
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895347; cv=none; b=E6643im1OTgXLpaJV4r9ws/1N4ZITiOg6ChpW5tuIOGjiiIJSH31JvBiugWEFDdr6yRhtHGvSszcPYtBDp/mTWKnuGZ0uiiZsShYTYof+IyuGI6bzGsBSf8aCZaGOS16sojGbE2sO8H7GOFhyef7N4bCLf0gZCYFxPveok5ctoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895347; c=relaxed/simple;
	bh=0DQirzMDm5FY+RYOI43L0Qj0IVWR9qr1UpBdExUmyhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw5X6wWm3Cj2/4v+J/hs4LEqPP4IpgDygdpDF7AcC2wmRzmf8/xxxpCBhIF+Xii3+cCoVSe8i9/67C2cU8oyNg+BGDX0fd+p4Tby+4UqDo2jMW+kOj+yZd9SlKXo6Gq+4rh+PAjBEBhwOG/Mh4fHNa1mdlv3O7gSWkGAKZLcExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5B0D227ABA; Mon, 14 Oct 2024 10:42:19 +0200 (CEST)
Date: Mon, 14 Oct 2024 10:42:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 2/5] nvmef: export nvmef_create_ctrl()
Message-ID: <20241014084219.GA23780@lst.de>
References: <20241011121951.90019-1-dlemoal@kernel.org> <20241011121951.90019-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011121951.90019-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

s/nvmef_create_ctrl/nvmf_create_ctrl/

But evem looking at the code later using it I fail how this could
work.

nvmf_create_ctrl is used to implement writes to the /dev/nvme-fabrics
control device to create a fabrics controller out of thin air. The
biggest part of it is parsing the options provided as a string,
which most importantly includes the actual transport used.

But you really need to force a pcie transport type here, which
as far as I can tell isn't even added anywhere.


