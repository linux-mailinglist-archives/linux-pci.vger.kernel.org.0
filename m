Return-Path: <linux-pci+bounces-26523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8295A986C2
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 12:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2357C4405D5
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B602550CB;
	Wed, 23 Apr 2025 10:07:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553CE4430;
	Wed, 23 Apr 2025 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402860; cv=none; b=BryI/NxY6C6ZWhlzUQtuFZOTRBpCq9+dKlI1ioFblNxVOG7bRiv+tvM96BYJMfx0acTjrEOJE4/7fmaDWlFFmlnmq5Q7GQVrgImx3ATf2ZqhiqYUE+X9jDtXCZKNTa5Mp6fRU2uVu1E2Oxe+ZKjqav5jQYreVxeZYHovGWZyYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402860; c=relaxed/simple;
	bh=wQXTEMkWgFliKoE1gEUn4FynzE0KnIEdc7gUFG1pCng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfouEt6w7WNup4X08GOyPXQ4QHx3P45U+Yz3KTYrYDwvnbnlxMjqApVrw6DHFjy4Fz0B16PDIcnDljKBIUSDqNNx+g81K048QHuSpsdHc87/4+OcI4YKfJC/D6vEKDObWgzA+Xsq3pXvr/ZJ5XNQw3L1eHYgbl5Iy1UcmukVTFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 31AD5200A2AA;
	Wed, 23 Apr 2025 12:07:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 499E735835; Wed, 23 Apr 2025 12:07:27 +0200 (CEST)
Date: Wed, 23 Apr 2025 12:07:27 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v2 1/1] PCI/bwctrl: Replace lbms_count with
 PCI_LINK_LBMS_SEEN flag
Message-ID: <aAi734h55l7g6eXH@wunner.de>
References: <20250422115548.1483-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422115548.1483-1-ilpo.jarvinen@linux.intel.com>

[cc += Maciej, start of thread is here:
https://lore.kernel.org/r/20250422115548.1483-1-ilpo.jarvinen@linux.intel.com/
]

On Tue, Apr 22, 2025 at 02:55:47PM +0300, Ilpo Järvinen wrote:
> +void pcie_reset_lbms(struct pci_dev *port)
>  {
> -	struct pcie_bwctrl_data *data;
> -
> -	guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
> -	data = port->link_bwctrl;
> -	if (data)
> -		atomic_set(&data->lbms_count, 0);
> -	else
> -		pcie_capability_write_word(port, PCI_EXP_LNKSTA,
> -					   PCI_EXP_LNKSTA_LBMS);
> +	clear_bit(PCI_LINK_LBMS_SEEN, &port->priv_flags);
> +	pcie_capability_write_word(port, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
>  }

Hm, previously the LBMS bit was only cleared in the Link Status register
if the bandwith controller hadn't probed yet.  Now it's cleared
unconditionally.  I'm wondering if this changes the logic somehow?


>  static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
>  {
> -	unsigned long count;
> -	int ret;
> -
> -	ret = pcie_lbms_count(dev, &count);
> -	if (ret < 0)
> -		return lnksta & PCI_EXP_LNKSTA_LBMS;
> +	if (test_bit(PCI_LINK_LBMS_SEEN, &dev->priv_flags))
> +		return true;
>  
> -	return count > 0;
> +	return lnksta & PCI_EXP_LNKSTA_LBMS;
>  }

Another small logic change here:  Previously pcie_lbms_count()
returned a negative value if the bandwidth controller hadn't
probed yet or wasn't compiled into the kernel.  Only in those
two cases was the LBMS flag in the lnksta variable returned.

Now the LBMS flag is also returned if the bandwidth controller
is compiled into the kernel and has probed, but its irq handler
hasn't recorded a seen LBMS bit yet.

I'm guessing this can happen if the quirk races with the irq
handler and wins the race, so this safety net is needed?

This is quite subtle so I thought I'd ask.  The patch otherwise
LGTM, so assuming the two subtle logic changes above are intentional
and can be explained, this is

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas

