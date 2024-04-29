Return-Path: <linux-pci+bounces-6784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5534F8B5B02
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 16:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71ED81C20F4C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545141A89;
	Mon, 29 Apr 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SltcyRHK"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991313DB8E;
	Mon, 29 Apr 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399915; cv=none; b=oFiTtMrLo2tot4cjdreDSxKxZ6tMNFRYF9X0MUBys1B/nOi3uSiROeHNzXPoXntVQW9bd/pKF6432eZn5rwyerSvsNMXNHAu61B1SJe5P8GZvOzvHgNQChJFPlFlYgcY1rBAMrf0P1TmDDLm/8mlwehXQLwO+b+efYHJCGvmtcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399915; c=relaxed/simple;
	bh=D44hOeoypmQ10W5fzTYHywa/8IQmIl7tt7zItpMnhRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmclw8nGdWxDdg/lWPi2vZVkR/0VNzqQwrQJ8OGNOaS2jFgstUXl1YYaRJ5/7MoI/XoHmPEmeQtdjA1X8QB2mHRWTG0lApcR+u6X1Z9z7h6HPGWwBG5OnP0DC13VLs8/rRp0LNUezR9EWJDfRttN+P83USVm0deUosQSj9ROeIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SltcyRHK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cM55691nSetTWyOwxCR1cmb4jKFAsdfIi7DcIL6d+gs=; b=Sl
	tcyRHKrp4owDfrLYM3TxslfSSuGiliUZbLkTUUh/Hna9VCeOdopbzWvhwyFfNpcgdenGfjXb4dXIh
	YqFdveZjJLLJPkK/17R6RIuT/KLYGwOVa9nL9kEntz3yI7B/N8I5kuqu4V+wovBR7/cXGuXTMeCcB
	KVF3AmXEOlk7H3g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1RjL-00EG4d-Qy; Mon, 29 Apr 2024 16:11:43 +0200
Date: Mon, 29 Apr 2024 16:11:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] ARM: orion5x: Pass devfn to
 orion5x_pci_hw_{rd,wr}_conf()
Message-ID: <76674e10-66e1-4068-bec8-0404631c245a@lunn.ch>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
 <20240429104633.11060-4-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429104633.11060-4-ilpo.jarvinen@linux.intel.com>

On Mon, Apr 29, 2024 at 01:46:26PM +0300, Ilpo Järvinen wrote:
> Pass the usual devfn instead of individual components into
> orion5x_pci_hw_{rd,wr}_conf() to make the change into
> pci_conf1_offset() in an upcoming commit easier.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

