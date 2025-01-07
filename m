Return-Path: <linux-pci+bounces-19448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D23A04702
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 17:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B3B18888E3
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 16:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC03153836;
	Tue,  7 Jan 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaWtVrsQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93FA7081A
	for <linux-pci@vger.kernel.org>; Tue,  7 Jan 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268481; cv=none; b=N6eJbxZXc0isuy6/00UQdwgwCdVZtVXNAvt2halASUqg0RyehSK9NZLF/KtbKWXAU8q/5bV6rzQmQ4RbpkhNZDZdI8EAsFhbihqXmEDGIQ3Ub4roNR4qX8CmxUqqCCr+OAy3t0m1PVQbmx4AdskjCcmmQ+q5EMfSS27x1vbDp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268481; c=relaxed/simple;
	bh=cvqRLuHBsga1aqimRGOF0V9OkCcRAupDB7uSQeD2pvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SazC/vz5zf1I1CxELxm3rhFWClkfcQASvEoYOacxtKlj+PWGx2HFEHd7jqpv57hh5R3sekLaHjP0oHsnp4rEo0cpgrQfIcx8EoD/CQe43h/5DVjVZ6+FkA68y/bW9PLihuH7fyN9sQYBZL9YiWSi2cAiu1sUIEdOo5+Kc6VVUHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaWtVrsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C84C4CEDD;
	Tue,  7 Jan 2025 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736268481;
	bh=cvqRLuHBsga1aqimRGOF0V9OkCcRAupDB7uSQeD2pvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OaWtVrsQB8LCx2DosiLvU4DBuTeP/tOlrvAvgEVwJL/nO+oymLnJ5pngdKLul0rW+
	 pJF+gG5/gwF9tVm0kDK9iqO4BcA5YoYVpjaUNRnFeQx2JGZPeyfzQF8l8JGNKsSCX7
	 PIBjexpjCSUeVPVWVmrTY1YjAfb5UQShp/lxj6LYXUl/CBs87V0nL8zg0p6JnUD9hh
	 DiUnw6pSRHwPIbxHmRCsVB4HgNgDBZVaexNBAvjPAhrtf1RKzvB9YndFdzsw7eCbNG
	 yg65edkwDKWBI9F+rlCoyIkSlQpGL/JP+fu5dCiJiS97ISkvCj7Fd/xtbkL/MbnaD2
	 VizKoV/EAcZVg==
Date: Tue, 7 Jan 2025 09:47:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 00/18] NVMe PCI endpoint target driver
Message-ID: <Z31avimMhZ0Bo4r0@kbusch-mbp>
References: <20250104045951.157830-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104045951.157830-1-dlemoal@kernel.org>

On Sat, Jan 04, 2025 at 01:59:33PM +0900, Damien Le Moal wrote:
> This patch series implements an NVMe target driver for the PCI transport
> using the PCI endpoint framework.

Thanks, applied to nvme-6.14.

