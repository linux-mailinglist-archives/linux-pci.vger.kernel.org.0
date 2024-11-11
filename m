Return-Path: <linux-pci+bounces-16435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5029C3998
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 09:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFCF1C2129D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 08:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1313B15A842;
	Mon, 11 Nov 2024 08:21:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5A13E02E
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313275; cv=none; b=Wzzr+vIdh1PyOfGWZ+G3RGa5EjItYdN4DLxelPVDOuajivXnIE62pAA40XzDSqghs6qhphqFqCXGXH8zZ5A+UP49+IhUaG6CqGqu0dQsO7NNlYmpUz79Lsx0juKPE65+p0JdYpbxJj64QBVlm5Q85yv1oWTbt26iodPfpsbKxGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313275; c=relaxed/simple;
	bh=Ryr/JRqjEbrUhu57xwCIPf4wg5Nnw2T/WY6O6luZpHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UR36ohMUypIhYD+8mw0crNFmlMVtGo0+tIIaJRvLYLbayoxrSkrNe6Hk41GJUufI8z9XHYxElFNEcXXBTI/MoLHyIafU3gyXOhpk/SRmRSrclVkoBjESAyexUrVVAu0TdskNK1nhgvIjvx1CvkWE9wEaPgE55uFfHUWjW8XO8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 66D3528013881;
	Mon, 11 Nov 2024 09:21:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 465F73FB865; Mon, 11 Nov 2024 09:21:10 +0100 (CET)
Date: Mon, 11 Nov 2024 09:21:10 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Keith Busch <kbusch@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCHv3 4/5] pci: walk bus recursively
Message-ID: <ZzG-dly2nGtTgNoC@wunner.de>
References: <20241022224851.340648-1-kbusch@meta.com>
 <20241022224851.340648-5-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022224851.340648-5-kbusch@meta.com>

On Tue, Oct 22, 2024 at 03:48:50PM -0700, Keith Busch wrote:
> The original implementation purposefully chose a non-recursive walk,
> presumably as a precaution on stack use. We do recursive bus walking in
> other places though. For example:
> 
>   pci_bus_resettable
>   pci_stop_bus_device
>   pci_remove_bus_device
>   pci_bus_allocate_dev_resources
> 
> So, recursive pci bus walking is well tested and safe, and the
> implementation is easier to follow. The motivation for changing it now
> is to make it easier to introduce finer grain locking in the future.

Hm, I find the loss of non-recursive bus walking regrettable.

If the solution proposed earlier today...

https://lore.kernel.org/all/ZzG5koPOn16KQ8uM@wunner.de/

... is workable and we find it doesn't need recursive bus walking,
perhaps we should consider reverting this change (which is now
e24eafdda271 on pci/locking).

Thanks,

Lukas

