Return-Path: <linux-pci+bounces-105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6257F3DFF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DD32827EE
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DDA2BB0D;
	Wed, 22 Nov 2023 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PfNrVewt"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90767D45
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 22:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=PfNrVewthnYzuhLvewDXMK02YU
	NTVUtKtMB6XBttEPsKOi1VG2ehcbTkQ27Z6S3NkLJQHWfKytzwFuUcjytjQkwS3bJ1ADXQhNB2vXu
	nANhAlUPPe4TgcudrwCwzAVnYoG5MKB7XohG/3wfD7px/Fndzr6GnFN8NJoZ1JNH2KhexjlGYDolS
	ny+X+u/3TVPA5sXwXHaEH9aVgGkrNRvJW5vj7iD8Fpq7PPqz39qL5uRaJ9AwShHvUd+dS9lXuNKba
	8mSIkJueYXd8RGAAPmiUxWvP3DxlP50O/L+GIv4KJ5AViONs4QvyyAJgxTjA5OEp3csQ86sJeO+M3
	2lEtLxWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5gX6-000ojK-1J;
	Wed, 22 Nov 2023 06:16:20 +0000
Date: Tue, 21 Nov 2023 22:16:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 04/16] PCI: endpoint: Rename LEGACY to INTX in test
 function driver
Message-ID: <ZV2ctEPT+ts34lYA@infradead.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122060406.14695-5-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

