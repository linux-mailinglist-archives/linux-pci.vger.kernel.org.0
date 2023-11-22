Return-Path: <linux-pci+bounces-103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E007F3DFD
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EB8282B6C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED38E15AD3;
	Wed, 22 Nov 2023 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EadhMgoL"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4961AD4B
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 22:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=EadhMgoLnZENyeD4G5Zyf2PfZQ
	ALgAVoh+E2m59BoIwYhTF76V++3keEdIBUDIme8HEpW6YgsRo4/JJKQUnO/NaDJEldpjUkX8VYQtr
	dGkW+6iVLyEvgj9/n8J9MSklSECUApq/lnGxzcSJ7RHT7PKpDsN3EgC3tB16UqMJ4lw+a6sZiHlBo
	kux3kAUf+uWfXj1DCygij8izocOgBLYi4s0BtaRM84YFl3/NoNY7YU7eVaZLQAk92yi+v0V3aacm3
	BrDuBMBq7JH6y0KSbkZFaMHU3KRMIUYYPR0qa659YxAjRDrwTWOqpigTLiyxz9D76LB3uJr3Pi0gi
	oIW4EK5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5gWZ-000ofT-0D;
	Wed, 22 Nov 2023 06:15:47 +0000
Date: Tue, 21 Nov 2023 22:15:47 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 02/16] PCI: endpoint: Drop PCI_EPC_IRQ_XXX definitions
Message-ID: <ZV2ck9rJesbuRdw/@infradead.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122060406.14695-3-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

