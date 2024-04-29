Return-Path: <linux-pci+bounces-6809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB58B62C7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 21:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5863C1F2118B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78313AD3E;
	Mon, 29 Apr 2024 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VQTJ1wRu"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359AB839FD;
	Mon, 29 Apr 2024 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419962; cv=none; b=f+A7pKN5GwD0Y3VKDKQyz09CW0uankoS285DgvQ9Wnnf1kU9quyUKdeOFmWjnIxIb9Z1613daH0adURzfhi6n3P1jqhT+SQWbF6fMtMJLYOiCCQFFvIopDF+Fv1wjU/MkeQ3oXha7ncJRD9ln9AzPdteFKQWNhbdC/zyP3txYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419962; c=relaxed/simple;
	bh=FZ9nXRV6ERZg5RvY6CtRN1IuNEzt8HVpFnFfYNjPhqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmJeW81MhvgxhMoUgvX9UVs2NiGnMogjJPdu9jCgVGsURdEUc1GStJE5Un13r811iGMHrjCNwhsZab9fAPrjlbuma0lCy1vYiHyoV5bCOtmkarhX53pSzI8XWg3VUaU184KwcaR9+Dhq+n1jrkx0CA0JIaYVghNyHYSEVyJoreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VQTJ1wRu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=mb9OU1e8CDPWok28cClhi1tNTddJ9azpQJpcP/8KdxY=; b=VQ
	TJ1wRuo6vKos0f+Nf1lutKbY94bPLsu3/eC76QIaUObwB3bOqYhrbcjwNZ+DlTMAlkH+LA+N8y8+I
	QeIraoAeO2WYTQMrvrZWu0p4bCNK7kxLvNftz/sGemAaVuQb78j7BTozNe3zN72i5ru+5dY7my/a3
	PI/I79gPCK9Hy6c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1WwZ-00EHPQ-LU; Mon, 29 Apr 2024 21:45:43 +0200
Date: Mon, 29 Apr 2024 21:45:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] PCI: mvebu: Use generic PCI Conf Type 1 helper
Message-ID: <03a5fc99-2fd2-4788-a9cb-bf7e5d8353b8@lunn.ch>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
 <20240429104633.11060-10-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429104633.11060-10-ilpo.jarvinen@linux.intel.com>

On Mon, Apr 29, 2024 at 01:46:32PM +0300, Ilpo Järvinen wrote:
> Convert mvebu to use the pci_conf1_ext_addr() helper from PCI core
> to calculate PCI Configuration Space address for Type 1 access.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Tested on a kirkwood QNAP and an Armanda XP. The kirkwood correctly
reports there is nothing on the PCIe bus. The XP finds the two 88W8864
WiFi devices, but there is no mainline driver for it, and it also
finds an Etron Technology USB controller, which enumerates O.K.

Tested-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

