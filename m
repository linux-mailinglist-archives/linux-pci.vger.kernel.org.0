Return-Path: <linux-pci+bounces-18959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 111249FABF9
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 10:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1181885C77
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C661922CC;
	Mon, 23 Dec 2024 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXav9sII"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93499149E00
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734946273; cv=none; b=RGC1BskJRVqgihhMgMU9eOkgWe2879j8KiNmQZ+BIUk1xS+GQd2Xjmbtl8BHSDAFlfUzkjgpA2NPBlsQHxqYbiexguGG6svasj14I2mlhd0RZkn+35otfnAjBaznNtnOBxRFaKba4ynrNOsJlrj8ukUCWSXBNsthV4sWJFW0rMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734946273; c=relaxed/simple;
	bh=lvzt1Zms38U56aqRZCSaql9Ng6jr4KG6HO3o52vRj5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui7aCkUzSi0RRgBox4q6ylUo/JRDgX7/xhuHUyN3XVYZSbrJpMO+DHVccRzp5Pc90KMdsrab+vFyDmdYl23e9s4lOcWMY9UjWyaZ07Coa0T0yOFkZGtCKmf7nIZMuhCeZDd8dpuldCafFbsU0IjqOzzKlmKxuTds/hfG0LKIuU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXav9sII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B6BC4CED3;
	Mon, 23 Dec 2024 09:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734946273;
	bh=lvzt1Zms38U56aqRZCSaql9Ng6jr4KG6HO3o52vRj5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXav9sIIRiHiZ0xj8LAaqsHYwcYHAWhG8Gf9pETBFzpUuSz2XpLgJi8Op6LQA/KvK
	 f2jChCvIUwReu8jKPILaGvUd4wU1NGr3jZqwm1GujTw86ST07CZ4aUggTyLTm+NIK3
	 g9kbzLMvqcJcxFySktffQE4ypfrCNFHrdzpNuCNV5ZkB2r/u1QoBHGMcp8uHi14166
	 IYTP25QJix5oOJY+j3pFK74PiduKb4y8ulVLo9Puyk5iUMSZkdBTg0tlK3pdn4GyAu
	 TAEEnqXZ4K9fwf6vSrrdez1RQkCHK3h+5shUTQSWJ3hMHEFt8S0Y1QCytoAgChIMS8
	 oM3rPDRXR01/A==
Date: Mon, 23 Dec 2024 10:31:07 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v7 17/18] nvmet: New NVMe PCI endpoint function target
 driver
Message-ID: <Z2kt26T3SKrmrUXI@ryzen>
References: <20241220095108.601914-1-dlemoal@kernel.org>
 <20241220095108.601914-18-dlemoal@kernel.org>
 <20241220161945.GA1007198@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220161945.GA1007198@rocinante>

On Sat, Dec 21, 2024 at 01:19:45AM +0900, Krzysztof Wilczyński wrote:
> > +config NVME_TARGET_PCI_EPF
> > +	tristate "NVMe PCI Endpoint Function target support"
> > +	depends on NVME_TARGET && PCI_ENDPOINT
> > +	help
> > +	  This enables the NVMe PCI endpoint function target driver support,
> > +	  which allows creating a NVMe PCI controller using an endpoint mode
> > +	  capable PCI controller.
> > +
> 
> Perhaps:
> 
>   This enables the NVMe PCI Endpoint Function target support, which allows
>   for the creation of an NVMe PCI controller using an endpoint mode capable
>   PCI Express controller.

I like your suggestion.

However, looking at drivers/nvme/target/Kconfig:

$ git grep "This enables" origin/master drivers/nvme
origin/master:drivers/nvme/target/Kconfig:        This enables debugfs support to display the connected controllers
origin/master:drivers/nvme/target/Kconfig:        This enables target side NVMe passthru controller support for the
origin/master:drivers/nvme/target/Kconfig:        This enables the NVMe loopback device support, which can be useful
origin/master:drivers/nvme/target/Kconfig:        This enables the NVMe RDMA target support, which allows exporting NVMe
origin/master:drivers/nvme/target/Kconfig:        This enables the NVMe FC target support, which allows exporting NVMe
origin/master:drivers/nvme/target/Kconfig:        This enables the NVMe FC loopback test support, which can be useful
origin/master:drivers/nvme/target/Kconfig:        This enables the NVMe TCP target support, which allows exporting NVMe
origin/master:drivers/nvme/target/Kconfig:        This enables support for NVMe over Fabrics In-band Authentication in

It seems to use both:
"This enables the NVMe ... support"
"This enables NVMe ... support"

In this case, I think it reads better if we use the latter.

In fact, in all these cases I think it reads better without the "the".
Perhaps add a clean up patch that drops the "the"?


Kind regards,
Niklas

