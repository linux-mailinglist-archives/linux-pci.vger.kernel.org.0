Return-Path: <linux-pci+bounces-18214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F7D9EDEAE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 06:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A168283A7E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 05:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5DF1632D3;
	Thu, 12 Dec 2024 05:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lKu5AYnG"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DDF1632CA;
	Thu, 12 Dec 2024 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733979878; cv=none; b=ja7PNesJRCeoGK9nkD0U+9CnxEyCutmgaET2/9q6sBsZVMgecAWjdOJQI4nRpVI1w6DjnNCGFJMfSI9FwC+of7r82ZyDsVhmTjEky6dNVXGN7gunHfQGDgvQeoM35c2bh137RghdLJigWadIrXrWszxuCE3Zvg6YjchKFB9WxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733979878; c=relaxed/simple;
	bh=VEKVRBoe22J+1hv8PucOdmZQtu/cWRv25jx9p6mkVjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+UBN/yZnqc1l2q/1QJY/qPBguO/3AQha6J2HHY1XOEQsTXkD9TehZcZFjYTJllU5cb1jduiFNpDmF86kaLG4gIEIzGHS1dHPgUnsddPzFP8pHNNPdXiyYgtxaUsr5lmBJcwpiwF1YZZitP85+vomHfnaDACqEmCPDPbFQTTGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lKu5AYnG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mkkj/z+6cVMqEWDiwe1t0JQPVqzn1IGN5HRxuZF7jNk=; b=lKu5AYnGUJqai2k9tax9eGs6FR
	y2yi6Tdnzdg/iMW/G593cApOV0DEgN3FoqFleQ6Fwsi0XCMXlVtjzWl42J5987nzsL8GH3PWH7m4M
	Iuq6FzI2GkpvFFR8lgNjoPQBjVJHwRRti2xp5iYvBFFCADzmGUk3e64HdBlU0SOf8S9u2YZW/oflb
	nnzpDMJazID2RX7qhR3Fd3AgbuvzbGkl17YmxHXof9o32c8mJUrgPRtwZ6V8jTOdvHvr4bKyRJu9G
	yRw9dsodpa1NdfKdyEnoGKF9UN4dkTBPG8WizyofmTPpzvGXMOhXL7NSJxJFkkavoSyFQ6E28NDC1
	YzSrt0Kg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLbNJ-0000000Gw1r-2vR6;
	Thu, 12 Dec 2024 05:04:33 +0000
Date: Wed, 11 Dec 2024 21:04:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org, logang@deltatee.com,
	Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
	sumanesh.samanta@broadcom.com, sathya.prakash@broadcom.com,
	sjeaugey@nvidia.com
Subject: Re: [PATCH v3 2/2] PCI/P2PDMA: Modify p2p_dma_distance to detect P2P
 links
Message-ID: <Z1pu4YCfk6OAPsIP@infradead.org>
References: <1733901468-14860-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <1733901468-14860-3-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1733901468-14860-3-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 10, 2024 at 11:17:48PM -0800, Shivasharan S wrote:
> Update the p2p_dma_distance() to determine inter-switch P2P links existing
> between two switches and use this to calculate the DMA distance between
> two devices. This requires enabling the PCIE_P2P_LINK config option in
> the kernel.

What the heck are "P2P links supposed to be.  And why shoud Linux
support something non-standard like this?

NAK for these hacks to the core code unless you can get a vendor
indpendent spec for it.


