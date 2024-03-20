Return-Path: <linux-pci+bounces-4933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7CB880CB7
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 09:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255D31F22E66
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0452BB19;
	Wed, 20 Mar 2024 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Btg6uxI+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E91642B
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922110; cv=none; b=c3TWAslQnqEFAnzMFDmiMTlqs+eqMU643F8G5P2eWNwhIQZLwfi8Ui5J6kVyNamATv9dttYIhQC+2wzJdlEP/NfL4zs12iysAquAEn+ellfBymDnEqNpt+to/R3LAKm3c1VE4sOTiUJH0lmTHQPVatZKvbcOObhxDYaYxUkfd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922110; c=relaxed/simple;
	bh=LHWh3GBT5RZiiGHVEinVHWSHnQ2jUSdOJgIsKgjNFdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnnhiNSYXWXq1u8r1eR9ifQOhP1JskvB2+Oedt4EeqWgVb6T2X36xlDvfboB59iK+WDt+m9mmVi34JBfv2YoJ4E51E1Q0qGGgfgOiH/QKozKMmsjehhDnkCAt5cxSOSRybf083LV0+Wv/y8KPSG9grqOV83tanJbcCj8taQrMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Btg6uxI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5F8C433F1;
	Wed, 20 Mar 2024 08:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710922109;
	bh=LHWh3GBT5RZiiGHVEinVHWSHnQ2jUSdOJgIsKgjNFdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Btg6uxI+ZSqrrsCzywyrD5WeEnVxUlhRtMaD2Rl+lAeMRTcojewRcnaiL8GMVBqSc
	 pLVc95w53XqNLEdcipQcpjQXAh7Gto+kPS3lFBWzsT04UV+NVyBY3O9vSHQjmYZn46
	 s91r/qjRN+g2+RTGPeodzyq+HsZSbl2UN1AHkqv+WCgWYYUgyXV1qvOvs5rkgkF3U/
	 qA3yWBbHd/MdUA7Pt6o9abKfU1uGmJ8LkSb8fyM3HbQEV0jZ3pIO6AyivilfZLZ5tc
	 QO7Zo3vCu/gm7iSHUlw1e60wMLdVNKavmWqcKsaUZkrsizvzNRi0z6uEzXZTvY1R2g
	 Ao8zt/0NQ46Tw==
Date: Wed, 20 Mar 2024 09:08:25 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <ZfqZeQ_Spx0FzH6o@ryzen>
References: <20240319213807.288550-1-cassel@kernel.org>
 <49cb292a-fc84-4f5f-a1cd-8650341c4517@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49cb292a-fc84-4f5f-a1cd-8650341c4517@linux.intel.com>

On Tue, Mar 19, 2024 at 03:39:09PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > +
> > +	read_buf = kmalloc(buf_size, GFP_KERNEL);
> > +	if (!read_buf)
> > +		return false;
> 
> Not freeing the read_buf/write_buf in return path?

That is quite embarrassing...

Thank you Kuppuswamy!


Kind regards,
Niklas


