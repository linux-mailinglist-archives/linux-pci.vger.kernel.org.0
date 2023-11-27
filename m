Return-Path: <linux-pci+bounces-185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895FC7FA56F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 16:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1071FB210CF
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30B0347D3;
	Mon, 27 Nov 2023 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7A81A1;
	Mon, 27 Nov 2023 07:59:17 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9629B67373; Mon, 27 Nov 2023 16:59:13 +0100 (CET)
Date: Mon, 27 Nov 2023 16:59:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>, Halil Pasic <pasic@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Ross Lagerwall <ross.lagerwall@citrix.com>,
	linux-pci <linux-pci@vger.kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Matthew Rosato <mjrosato@linux.ibm.com>,
	Jianxiong Gao <jxgao@google.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231127155913.GA1468@lst.de>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com> <20231103171447.02759771.pasic@linux.ibm.com> <20231103214831.26d29f4d@meshulam.tesarici.cz> <20231107182420.0bd8c211.pasic@linux.ibm.com> <20231108101347.77cab795@meshulam.tesarici.cz> <20231123111608.17727968@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123111608.17727968@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 23, 2023 at 11:16:08AM +0100, Petr Tesařík wrote:
> > To sum it up, there are two types of alignment:
> > 
> > 1. specified by a device's min_align_mask; this says how many low
> >    bits of a buffer's physical address must be preserved,
> > 
> > 2. specified by allocation size and/or the alignment parameter;
> >    this says how many low bits in the first IO TLB slot's physical
> >    address must be zero.

Both are correct.

