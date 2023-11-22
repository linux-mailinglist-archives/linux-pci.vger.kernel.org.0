Return-Path: <linux-pci+bounces-119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16FD7F3E16
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962DB1F21568
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A749BC2C2;
	Wed, 22 Nov 2023 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YU7d/ELz"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A47BB
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 22:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+VwNihBMRf/3LlTOaK36jk4MMD/ARmVUsOGh8xVYs+A=; b=YU7d/ELzx2SQ265SsETG8e6+EA
	d+QCStt6K/fQQNGnqXXe3K1wVibJOYL0ddHqAI1neQ/wIKdTYGmglrcCZaIm0TjwFe9LFqJQCji/g
	eBUrU0lOS9si0+wRce+Xvk/KaIifHsLKjL86B7tMm1OoRGTVisu4vEh6Hi2h/6OTwHaolQXTnfHdo
	mN1qexouBPBOI1S9y0Zy4QtMLrKsHHGdJtK3wO3nLzmDtYdAJND6qBiqwQXha19G00piT+rRn8QUf
	KsIsKgi+pin214u88kWWAPDWV8wzQ60g7rrZwhwZJD/xtsEQdm2INFc0BtBtQ1vpdFvE9jeubjZEQ
	jq9yZcbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5ge3-000ps7-1A;
	Wed, 22 Nov 2023 06:23:31 +0000
Date: Tue, 21 Nov 2023 22:23:31 -0800
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
Message-ID: <ZV2eY8iH41eOSgIZ@infradead.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-7-dlemoal@kernel.org>
 <ZV2c3oAHtmmYgSGn@infradead.org>
 <3859e36a-f920-4df8-922d-36305c81758b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3859e36a-f920-4df8-922d-36305c81758b@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 22, 2023 at 03:22:54PM +0900, Damien Le Moal wrote:
> I did not want to go as far as changing all drivers everywhere and limited the
> series to drivers/pci. We could do a coccinel script for everything else.

Yes.  This is actually even trivial enough for sed :)


