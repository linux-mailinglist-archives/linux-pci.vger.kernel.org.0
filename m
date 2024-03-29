Return-Path: <linux-pci+bounces-5401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10CE891C68
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 14:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE2EB23B71
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 13:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E365181489;
	Fri, 29 Mar 2024 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBrJM5Jj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398CC181482
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716105; cv=none; b=iLrLkpWgUAtu2FLs6ISDg3/bIKHTxkqZm5+hYcHZBEeODITsm0t3tEjVNLFLXGZ7nz/UlSqIuqnNfX003EL6mz0lgx9+v/rCCLvFtaA8PYMllcK6joY2h40X4eY9vKa7lfjE6NzigEJpt5pyh6fXApHW89sAotiktMdJE27iOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716105; c=relaxed/simple;
	bh=MGQMjrN3E2cMAmaQFYgStNUss/TX0AOz9m6LyxdKvac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o1oUsP+7F1Z/YtYjjHuu0YzOWVb04G2VJowEaHCfgD4YN/YBiq6D+RtOs8ZFqv0h1iVeWh0sZpdk8mXn1whVe8O5F+IYWZGO4dBicSCdxhF3sd6pg+Y12ZQeVgtJYHU+PlNDxuE913suEP3kk4MkYvjK4zCHCpxrK2j3xpAwAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBrJM5Jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E4AC43394;
	Fri, 29 Mar 2024 12:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716104;
	bh=MGQMjrN3E2cMAmaQFYgStNUss/TX0AOz9m6LyxdKvac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LBrJM5JjwDG56aGa3eKVxxOz/QbYBaYP6BylgRJi3X1JlzXptSeS9sKqcpqzSSp6e
	 9Oljam7968p/0jUwr+I9B3KEw7kWlzf0Crv5MxzeclSUU/+VGgfzqt9JY+t8QlFlh6
	 QWwPLRi4ONjICITTlZuKhA2qUIeN+/O2OM6zjgM6tswWoA7Kpuj4e0SXG54pYvE0Hf
	 IOPh5DKl4MLubbYr95z/nd3/goz6ok6LFxSnQKYkLkSPz2yHtzGm6i95nBgYv9yZKd
	 PlGbXyTuRO/9OVQdcG6BnigfB0V1HDdgAAYCEq87aPkyhoNaKjSZxuWOgzg083TayI
	 DoUeyd78ldTLA==
Date: Fri, 29 Mar 2024 07:41:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 00/19] Improve PCI memory mapping API
Message-ID: <20240329124143.GA1638894@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329090945.1097609-1-dlemoal@kernel.org>

On Fri, Mar 29, 2024 at 06:09:26PM +0900, Damien Le Moal wrote:
> This series introduces the new functions pci_epc_map_align(),
> pci_epc_mem_map() and pci_epc_mem_unmap() to improve handling of the
> PCI address mapping alignment constraints of endpoint controllers in a
> controller independent manner.

>   PCI: rockchip-ep: use macro to define EP controller .align feature

s/use/Use/

>   PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSIX hiding

s/MSIX/MSI-X/ (also in commit log)

