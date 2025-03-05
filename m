Return-Path: <linux-pci+bounces-23014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D14A50C31
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 21:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D61FD7A5B6C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 20:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166CA24EF74;
	Wed,  5 Mar 2025 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6Dv3h6k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAE1F417B;
	Wed,  5 Mar 2025 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205104; cv=none; b=AC0TPYHk8hyGY4T8BgaahmSxsv08knEU1/rmH83Cz23/0Bkx3+Im8GmmtvmqRQtUgtQFHhKEewfFHhUMKwwxQWXy9Kojq0bwkhwlVMvVSMLoDqp4DTdbR2GOtiSk9o/EP9JFSffWRTMd4A73RUf6vJfso4UrniPTzLBaOoyW6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205104; c=relaxed/simple;
	bh=KKnj9dxKXJB40tqR+6IExvR3H85hVEXghFLtTqUDeoo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WMDy6c/fmYnhxkaHr3KFMaCZOhNs7GMWkbs2zk+bEM5Tixbx/yLK694wveyMiN/pKdKuaKthWHjQiZDr38/IOwYL67bkme7zpt+nx3geeKmBU57gmfxYe0KIFL7qqfCPIV5Ih+lG9Q/COSbPbfh5zd+/2H1QoiaE7f8EKA/aL2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6Dv3h6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20364C4CED1;
	Wed,  5 Mar 2025 20:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741205102;
	bh=KKnj9dxKXJB40tqR+6IExvR3H85hVEXghFLtTqUDeoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U6Dv3h6k7O9rLnV8yk/VGi2973xLaJYRmnmdv8Ejn4RbrWcteMhVfa7gxHU0fOlGp
	 a+ndIz9O6kQ61NNkoiLxwoQpKzietTIegJFao66s68vhD+CN8kfU7uf6O9U+MincI8
	 2g2KZKmd3jrb6hKkHuFNB7Vebh8gVlHy4KpUzRiEQRbnrdR5zkD7+NTFoWye4zGTed
	 ZCMeClaY4R2IyfYRq0oFLxokS2yqsrrYYDFOeY9xDdehbISOqpnCY53y1nS58uDjWw
	 +fKy+yJdoz7kZ9vmJ50AGr7fys2GOQnEDemU0Ipt4oOPmYE7LS2Dm+Q0tGmOxhcvd7
	 CaKabRxVNahpA==
Date: Wed, 5 Mar 2025 14:05:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alistair Francis <alistair@alistair23.me>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, lukas@wunner.de,
	alex.williamson@redhat.com, christian.koenig@amd.com,
	kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, alistair23@gmail.com,
	chaitanyak@nvidia.com, rdunlap@infradead.org
Subject: Re: [PATCH v16 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20250305200500.GA267333@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227043404.2452562-3-alistair@alistair23.me>

On Thu, Feb 27, 2025 at 02:34:02PM +1000, Alistair Francis wrote:
> The PCIe 6 specification added support for the Data Object
> Exchange (DOE).

> +++ b/drivers/pci/probe.c
> @@ -2662,6 +2662,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	WARN_ON(ret < 0);
>  
>  	pci_npem_create(dev);
> +
> +	ret = pci_doe_sysfs_init(dev);
> +	WARN_ON(ret < 0);

IIUC the "doe_features" directory is added implicitly by
device_add_attrs() in device_add(), but the *contents* of that
directory can't be done that way because they're dynamic, based on the
DOE features we discovered.

I see that we WARN_ON() for device_add() failure, but it doesn't
really seem like much of an error handling strategy in either case.
I think we'll just get a stack trace that's alarming and probably not
useful.

I think it might be more useful to use pci_warn() at the interesting
places that might fail inside pci_doe_sysfs_init(), e.g., where we
know the name of the relevant feature, and make pci_doe_sysfs_init()
itself void.

