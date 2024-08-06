Return-Path: <linux-pci+bounces-11378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B352949816
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 21:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CD528300A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 19:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7BD47F4D;
	Tue,  6 Aug 2024 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltR5evcS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AF22EE5;
	Tue,  6 Aug 2024 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971743; cv=none; b=MXH8gX7Gms3V2gf7oDiUpUK63xTD7BD+P+L/mY1T+vYuFy26kiGh3bTMivv6E65zISFsjrqc0QJ7gmHINowv+3W9Q7U4Ycav/xA1MQ2U7YO6YvajEnbeHNjxujFLwn3wvGlTrezOrqlXZi3s3LNuKBw/arcJkbeTYUpn1BGp8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971743; c=relaxed/simple;
	bh=IPigE1OLiLK/kQzhQ1mOnd/jpfVw2p3MpJHk0IbUD+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fE8OFLC4JwR+Nt0/xTMDIlPfWkNGMOw9S+nR9qYqHivrXFhwpz6QHgg0i9N04hFnTUkCjYrKwTX+zBeEz06xQt5W7MkyKguN9Y1ok7ntR8JY0y8kLgeVwIvhjzg8o0trkJUwJfLd3CsR9e0oV4ndG6C2IKEOXG1lBbbi7X8OQJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltR5evcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1827C32786;
	Tue,  6 Aug 2024 19:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722971743;
	bh=IPigE1OLiLK/kQzhQ1mOnd/jpfVw2p3MpJHk0IbUD+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ltR5evcSgpuqejpeMX8yLRovt/p0qDKm3zRYPmYY3vKGGdF5yWCiLvmRt74Matd6n
	 BLF+AXEW+n5hf4L8YA+xoLic3qUOoJOPXpBF5sR8qatrDWt0NysdkliLWtTEvrM6v/
	 WOLyF5u923K/SN5ru3FjZYK283UNJppx2DJ+R068SuTWnpJPsF86rh9l3yqhpZxvc5
	 j05JkWltQ+IUqVQG17MyLqQN44ZcQTx5qRymmhUnmdQm7GskgsFgsIXle+IsH7Cqui
	 8bP4zQyCTFeFaiDIMieHnhZrfvfSEhuwOvxX6Qm9qVO7INC+21VTZ4X56qIKhr4PBF
	 xmk+FNeOb5J1w==
Date: Tue, 6 Aug 2024 14:15:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Move DMA check into
 read/write/copy functions
Message-ID: <20240806191541.GA73196@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806162756.607002-1-rick.wertenbroek@gmail.com>

On Tue, Aug 06, 2024 at 06:27:54PM +0200, Rick Wertenbroek wrote:
> The test for a DMA transfer was done in pci_epf_test_cmd_handler, which
> if not supported would lead to the endpoint function just printing an
> error message and waiting for further commands. This would leave the

I guess it's the *test* that prints the error message?  Is this the
"Cannot transfer data using DMA" message?

> host side PCI driver waiting for an interrupt because the call to
> pci_epf_test_raise_irq is skipped. The host side driver
> drivers/misc/pci_endpoint_test.c would hang indefinitely when sending
> a transfer request with DMA if the endpoint does not support it.
> This is because wait_for_completion() is used in the host side driver.
> 
> Move the DMA check into the read/write/copy functions so that they
> report a transfer (IO) error so that pci_epf_test_raise_irq() is
> called when a transfer with DMA is requested, even if unsupported.

Add "()" after function names above, as you did for
pci_epf_test_raise_irq().

> The host side driver will still report an error on transfer thanks
> to the checksum, because no data was moved, but will not hang anymore
> waiting for an interrupt that will never arrive.

