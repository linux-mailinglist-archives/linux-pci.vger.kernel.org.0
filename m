Return-Path: <linux-pci+bounces-20589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D2FA23D9E
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 13:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16076168644
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D277E1BD018;
	Fri, 31 Jan 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXXbkW7h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0626190486;
	Fri, 31 Jan 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738326044; cv=none; b=oy7etMMAZ7t6sYbTgzEFV2pOfRs1955Rx2J1YsE92bdx3T2+8QQYvmzu+ZmSRhX+xHv1IkdKy59yh0k9ZK1uTVFeEKJM2WDA0ysoOe0aLnBF0vrAchfe4BvHqeTlrx+5lT9SAqxUVKS1oVx8gbUW6dWNi5aDQnjFjrNfkfh1E5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738326044; c=relaxed/simple;
	bh=7DxTqxqU7/7Bz491UePflolEkILKjOEb/ohAy79Z1j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4uBOsABLDoJfiGBmykIw9DPdxhyJsuCGMrjl8j+Z8qvmN9zl4Sehr5vbyWP0eTj9GtT26Xgpg3OoDhHTzkIehPGHrk7r2f5SUc4zfUcSDt/LX98wc0v/qCv8HP4IKvGGAQYJlTZdbA6pQ9YrfPSg4mkQq0Z3FbrH1u9yDuyCEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXXbkW7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08A0C4CED1;
	Fri, 31 Jan 2025 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738326044;
	bh=7DxTqxqU7/7Bz491UePflolEkILKjOEb/ohAy79Z1j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXXbkW7hIZQGgOIZczA1+RhRrTlrHtqKgxFMWq0Cm6N9+JzC7xdYpk6R5Dj+Dpznk
	 6x3Ylr3e326D/tkDo1pBDrQ/bFHn3mNElwyN0lW1cJDSCH7q1KHITBJyCISiD7Pq42
	 KBh/3WM1ixSF3LbY/I/XVQ8OTfK4v09BAdHnjxKotk+2QXzO8c5zlPGd4zzOqgvbNr
	 gYtRBfvQtUFaTX2MpUT1EPVvCwjXCwzjK9WexupmOjcnOdiOb9BmnL8bb/WjVOHW6H
	 BKUGfPCLBDaXcQedIhNoH5QVyjiqPkITlMWM6cz/30Rs81WcVBqwx5TiXJ7Bv1W+Y7
	 przb/udVmbYCQ==
Date: Fri, 31 Jan 2025 13:20:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
Message-ID: <Z5zAFhEJzwOQUccM@ryzen>
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
 <20250122022446.2898248-4-hayashi.kunihiko@socionext.com>
 <20250128143231.ondpjpugft37qwo5@thinkpad>
 <Z5oX5Fe5FY2Pym0u@ryzen>
 <fe8c2233-fa2a-4356-8005-6cbabf6a0e96@socionext.com>
 <Z5y9zpFGkBnY2TG1@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5y9zpFGkBnY2TG1@ryzen>

On Fri, Jan 31, 2025 at 01:10:54PM +0100, Niklas Cassel wrote:
> > 
> > If SET_IRQTYPE is AUTO, how will test->irq_type be set?
> 
> I was thinking something like this:
> 
> pci_endpoint_test_set_irq()
> {
> 	u32 caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
> 
> 	...
> 
> 	if (req_irq_type == IRQ_TYPE_AUTO) {
> 		if (caps & MSI_CAPABLE)
> 			test->irq_type = IRQ_TYPE_MSI;
> 		else if (caps & MSIX_CAPABLE)
> 			test->irq_type = IRQ_TYPE_MSIX;
> 		else
> 			test->irq_type = IRQ_TYPE_INTX;
> 
> 	}
> 
> 	...
> }


Or even simpler (since it requires less changes to
pci_endpoint_test_set_irq()):

	if (req_irq_type == IRQ_TYPE_AUTO) {
		if (caps & MSI_CAPABLE)
			req_irq_type = IRQ_TYPE_MSI;
		else if (caps & MSIX_CAPABLE)
			req_irq_type = IRQ_TYPE_MSIX;
		else
			req_irq_type = IRQ_TYPE_INTX;

	}

	...

	/* Sets test->irq_type = req_irq_type; on success */
	pci_endpoint_test_alloc_irq_vectors();



Kind regards,
Niklas

