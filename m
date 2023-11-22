Return-Path: <linux-pci+bounces-121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F4B7F3E41
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E347228147B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1117E1;
	Wed, 22 Nov 2023 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PmKeYGnZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7460F9
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 22:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B2tNJw5SWDrp41BqmKXpIbbW53qSgbDt50D8XBuQ2ro=; b=PmKeYGnZHPt9KzrgX3aOxTfhb3
	sMtFCLb5RwrbqAx7mj/48rpfV1Moel09S5qxbXPS+kAj+1iFUPU4VFODD0UYk41RELwz50uaZwkL1
	2Gl7vQJy8bmPXBbGp4UamAQFo8kK5m4KwxHdpv1q4mYLAKw2M8hlTlvQQdV5ghGAlLSG3K7CNPBN8
	uNg80AOkdC6H0Z/qwCrUAOKTiqrKMmkYQQQi66VSVKYnwclNw64KALb5LixSk1KMeeeDsRBIGyyq5
	TEsXCAZtC33vvkLhcDsYHyDY1KRY/f4j4Z/ZFnWWsUQbS3Vwq6z51gSCjLN1B5McvqNFfgSRnRg5v
	QbWgN7nQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5gqV-000qX6-1B;
	Wed, 22 Nov 2023 06:36:23 +0000
Date: Tue, 21 Nov 2023 22:36:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 06/16] PCI: portdrv: Use PCI_IRQ_INTX
Message-ID: <ZV2hZ+0jRQUJqMH6@infradead.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-7-dlemoal@kernel.org>
 <ZV2c3oAHtmmYgSGn@infradead.org>
 <3859e36a-f920-4df8-922d-36305c81758b@kernel.org>
 <ZV2eY8iH41eOSgIZ@infradead.org>
 <d8e64422-d332-4c99-88bc-85f6e2077c32@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8e64422-d332-4c99-88bc-85f6e2077c32@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 22, 2023 at 03:33:04PM +0900, Damien Le Moal wrote:
> On 11/22/23 15:23, Christoph Hellwig wrote:
> > On Wed, Nov 22, 2023 at 03:22:54PM +0900, Damien Le Moal wrote:
> >> I did not want to go as far as changing all drivers everywhere and limited the
> >> series to drivers/pci. We could do a coccinel script for everything else.
> > 
> > Yes.  This is actually even trivial enough for sed :)
> 
> Surprisingly, only 44 files use PCI_IRQ_LEGACY. Let me see how a patch look
> with the change.

As mentioned in reply 1 I think this is perfect for a scripted run
after -rc1.

I'm actually surprised PCI_IRQ_LEGACY is used even 44 times.  There is
really no point in using the APIs based on PCI_IRQ_ for legacy irqs,
and the case where it is just supposed as a fallback are covered by
PCI_IRQ_ALL_TYPES.


