Return-Path: <linux-pci+bounces-107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0D37F3E02
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD36128280C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67B92BB0D;
	Wed, 22 Nov 2023 06:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tIIp0biq"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98DE19D
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 22:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1dgS5NQGxd568AEPXLaYtkB16x7fZvZc3oTo9Z3hZSI=; b=tIIp0biqgWf33r2zmdyOFarUTF
	5CAxPYfNm52oY58Y1s+iO6MX1lt1TBGW51wMEhQJI1yFjwvfvs8uch6PJH8ajz4RWWWGrWe45+PoO
	GAk0xwesCa39fGDMuU47D3oc60/2pZ1EMiLAbi+Z6TZzteawPhaZARBc9K2MTUpSRRG0yVRz00k9Z
	CJcOAjXVVkrdgQiCpDVkO0RUpfpg01ZG7ZTdfxjZ+qCDR3LQPTROcDoBUEZ9OEx6FU7FMG8dpB1dv
	BfcYMhO/RYh5Cs097pZliJQrVSfQ3WEYShZ8aUtVww6g8ZKs7fsy94m/R6U8JJpDm1rqH9PNZYf2g
	GdPP9qzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5gXm-000omK-1d;
	Wed, 22 Nov 2023 06:17:02 +0000
Date: Tue, 21 Nov 2023 22:17:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 06/16] PCI: portdrv: Use PCI_IRQ_INTX
Message-ID: <ZV2c3oAHtmmYgSGn@infradead.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122060406.14695-7-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 22, 2023 at 03:03:56PM +0900, Damien Le Moal wrote:
> In the PCI Express Port Bus Driver, use the macro PCI_IRQ_INTX instead
> of the now deprecated PCI_IRQ_LEGACY macro.

I'd prefer to just script these cleanups in one big run to be honest..

