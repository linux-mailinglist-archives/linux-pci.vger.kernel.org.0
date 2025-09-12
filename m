Return-Path: <linux-pci+bounces-36047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D74B55527
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 18:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67431D6439A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 16:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D913168E4;
	Fri, 12 Sep 2025 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivJVpJTY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE75C1FCCF8;
	Fri, 12 Sep 2025 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696172; cv=none; b=rDIDQHQR5bnAb/vH9XImMdAdBozFbvcV+2VVXjHbNvrUb5YpmoMUjUQ3Db6fWkoOGhmwprTw7c7nJHlNShSto9jL0YU9fPZMVaUrRZXodu8pwpuFVquVzl4DMfxlCBJz2HYb25jKmbrM9bHvrn7iv0rVPmkOpsksGftzDwbnawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696172; c=relaxed/simple;
	bh=lCl0XQHwbM5pI8x6nDZ7HvUoRHtAmwNonsL9f/l04Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGwOulk4pYgdi9Ps1yq/WtTH/bxjOcCTJXBsM/n7RY6AGIN/j12kp4Cy0Y63kPblLLbMqrqFu0wNYwV17gM9dzf8EcSx2R/5Wqi3YeY6Fb29qTZWr158LDNESrU+XAEwQzip93UB/5Au+P9ubLIcVamc3xDjnRIZ2Ib40S2QPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivJVpJTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EACAC4CEF1;
	Fri, 12 Sep 2025 16:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757696172;
	bh=lCl0XQHwbM5pI8x6nDZ7HvUoRHtAmwNonsL9f/l04Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivJVpJTYZb6FGFKKUQDcDV981FMKlNM1jwYODBbKEZVTiwCF1DAhbhxmdHub3wXSk
	 +Cn1F8485hkJzCnpoYnpb/igk2JdT4NZZLvrK3eHqqHU/da38S2DoaW8ySt/xXa61P
	 9w6sfkUpbjNwhZt8XyEUOpubnWbKf1RGDgG+O9eTubABaZlDwXeSQU14WlrrlUcLwa
	 Kk9N77I3CJBsnMqVl4+uuNtG/fJ1CgFHDAL3X6O+1fnFf+vTR5G63X7DV2GNhOMkWQ
	 6gEvLWZsb+EKxpIh07pEoWkmXbNqh+sJJIRtsuh6pxJkHeWk1R7HJZFxUqBRGnF4PI
	 YqziXLVENNZJA==
Date: Fri, 12 Sep 2025 12:56:09 -0400
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <aMRQqc_eLhRKfnBo@kbusch-mbp>
References: <20250821232239.599523-1-thepacketgeek@gmail.com>
 <20250821232239.599523-2-thepacketgeek@gmail.com>
 <aK9e_Un3fWMWDIzD@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK9e_Un3fWMWDIzD@kbusch-mbp>

On Wed, Aug 27, 2025 at 01:39:41PM -0600, Keith Busch wrote:
> Can we get a ruling on this one? It's pretty straight forward
> implementation exposing a useful attribute. This patch has got a good
> amount of reviews and tests. Any objections?

I guess silence means acceptance. Unless I hear otherwise, I'll queue
this up in my tree to be sent out for the next merge window.

