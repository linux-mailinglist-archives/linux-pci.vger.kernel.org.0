Return-Path: <linux-pci+bounces-1284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA05281C489
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 06:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67298289254
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 05:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9510223D8;
	Fri, 22 Dec 2023 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QYDSRrk8"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F3611B
	for <linux-pci@vger.kernel.org>; Fri, 22 Dec 2023 05:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pDnAKp49Dc9UdvSiFC2Qrgc4jZ55ko7bHwwiQywsG4A=; b=QYDSRrk8Jvvqp31IOwRbH0vama
	Haxsa8+HarUWTdkFLdV8p/yETdR93i42E3COduintDKRxsa8d3A9SpdO762dt9Gq9kjtQpPee+1VL
	ANiLdXOOZYsIAwO4lUP9/08RWleTRU8Wt81MXu0gI61N1qmaqIDpsIU7/uTuIi46SeYU2AjInuKPM
	LiPfqXhlVbfkd+9Tltk9M73qSjKpNK9hnCGNvZ+S4CMYPD57cCiYWcUtr/gl78+vzKsJe+iTE2NSl
	cHNFgzr/IzsbcLUYxuZNgmt7ptiBm7t28wy727qNARXRFgzJ3C4j9+QDJix66MXgGk+glwBfubjZm
	pFDXG8aQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rGXjJ-004vrv-3C;
	Fri, 22 Dec 2023 05:05:49 +0000
Date: Thu, 21 Dec 2023 21:05:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	William McVicker <willmcvicker@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Set DMA mask to 32 only if ZONE_DMA32 is
 enabled
Message-ID: <ZYUZLRczqgzO7Gf4@infradead.org>
References: <20231221174051.35420-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221174051.35420-1-ajayagarwal@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 21, 2023 at 11:10:51PM +0530, Ajay Agarwal wrote:
> If CONFIG_ZONE_DMA32 is disabled, then the dmam_alloc_coherent
> will fail to allocate the memory if there are no 32-bit addresses
> available. This will lead to the PCIe RC probe failure.
> Fix this by setting the DMA mask to 32 bits only if the kernel
> configuration enables DMA32 zone. Else, leave the mask as is.

And that's why you never must disable ZONE_DMA32 on devices that
can have more than >32bit memory and don't use an iommu for
everything.

NAK.


