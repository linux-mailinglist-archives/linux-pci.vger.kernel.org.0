Return-Path: <linux-pci+bounces-102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3F67F3DFA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE302828F6
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4A815ADB;
	Wed, 22 Nov 2023 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UO0Zz7oW"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96DA1A2
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 22:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1nlSJlab+LvptHpIVUkkqLBidUT2cOTYLWup2iIXkQE=; b=UO0Zz7oWmFyHz24L8pbauQbTDm
	6BeuKBKMTo0lMT3Deb6XWAp16mQ8gzo8Vz++RmC3WuXxAFD9rIkI114rUIJ4voh1eSwQU64wiRzMk
	7udiex6uyqzKO8P6mY07jVScHJHNTEUPq+JLBpSXTf03cYYrxg9m6bOI07EQLRsEtEKJI/tcpIRWn
	sxUoaxRX/u6fT3ouhfnqa4NfJc414bCaGmWsfdsgRCRe7jky/eD/7HRtzHgE+fILHJKiROiaC8ewL
	7n7L56889DXTmlRFFytQ/zSi2gx0aMvDcEB+brnPXUSNhmZ5wlbrump3CpzdCOpLaaQcAQvWlttPE
	kBN412PA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5gWG-000odX-1O;
	Wed, 22 Nov 2023 06:15:28 +0000
Date: Tue, 21 Nov 2023 22:15:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 01/16] PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
Message-ID: <ZV2cgLnXuZhN5r+8@infradead.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122060406.14695-2-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 22, 2023 at 03:03:51PM +0900, Damien Le Moal wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX to be more explicit about the type
> of IRQ being referenced as well as to match the PCI specifications
> terms. Redefine PCI_IRQ_LEGACY as an alias to PCI_IRQ_INTX to avoid the
> need for doing the renaming tree-wide. New drivers and new code should
> now prefer using PCI_IRQ_INTX instead of PCI_IRQ_LEGACY.

Sorry for picking this horrible name back in the day.

Reviewed-by: Christoph Hellwig <hch@lst.de>

(and please run a script to fix this up after the next -rc1)

