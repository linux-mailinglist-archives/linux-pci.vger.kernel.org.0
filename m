Return-Path: <linux-pci+bounces-4000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B9E86729F
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 12:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4565E1F2B6D1
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 11:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283331CFA8;
	Mon, 26 Feb 2024 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UlTvyCKR"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A101CD30;
	Mon, 26 Feb 2024 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945703; cv=none; b=j/lzty9WfUbB6DriATsJ0GrZ2m/KvQqlNKcqRt4IKuxoOxtL6d/EKIRJYRcA6+a30VgCtmXKWPubj9AVhKvET10l6PowuaoXLEDFr5dNSAyzkLcJVjMBcGFad2cCBtU+cINymb4dhfc4XbpSGZ1Zw/tVfVOlA2ebw6hcM6oC2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945703; c=relaxed/simple;
	bh=MH3NkRJlLsr92n8XmE7uUhNlrOYcMau2VISmVPiEn7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdmhzCuFQrCkKScpd73xNSeoirHp33RO7QUUJZPwZyUlGiNKzegvXhqHWIp6zjlX62EDRXaS+ukKtI3/oKVp34+a/BwrLpoYxaXiFaTlkeSPCUkEAxgCkj4vwdNB/i64lxLpesjfE+l0syLHTFdGnvpdgLfPKo9/cuARZWfkGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UlTvyCKR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oj61w1EtZvU5zXErbswMW0jEIMEss4/Kn4pcmzNb168=; b=UlTvyCKRizAl9mcUNVH9wzWNh+
	admk3vNpmvpsGmhf5Ff9vy2+atxJhnGlMY1w7eweWoSfbMInJK32TAw6YIEI54cIHOPk7jX3m0EJM
	FCKDpecaX8Hd05q3enPumxLA5vAPJ4Py/nS+sh81DhcFA2arUv0Zo46xSp07wFVkLNN4CTBUQaWr8
	ifro4rtJ+6gB0lSL+/K0RzIuRXcSpEgAL9pbsN8CjfoMqdUibIrF/F9pZFPEWDVuEAsYp5WfK76BX
	B7pruLi30yTDCZpZp1MsrS1r2kxzzCraJGzi8sma7qaxMV/CxIg5xjzB7E1pUEBgCOihYKj9gbcVx
	8Wrh1Nvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reYqJ-00000000HTi-0SxK;
	Mon, 26 Feb 2024 11:08:19 +0000
Date: Mon, 26 Feb 2024 03:08:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Shunsuke Mie <mie@igel.co.jp>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for Block Passthrough Endpoint function
 driver
Message-ID: <ZdxxI7bqdajK3Hb7@infradead.org>
References: <20240224210409.112333-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224210409.112333-1-wafgo01@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Please don't just create a new (and as far as I can tell underspecified)
new "hardware" interface for this.  If the nvme endpoint work is too
much for your use case maybe just implement a minimal virtio_blk
interface.

