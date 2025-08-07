Return-Path: <linux-pci+bounces-33546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D490B1D6C9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 13:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38906189DCE7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 11:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883F9279798;
	Thu,  7 Aug 2025 11:34:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D79275B12;
	Thu,  7 Aug 2025 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754566495; cv=none; b=biA9/jdwAl4LwKwsDn/5Q6OFdpMv5OuOqkQU0U3/rPCbCAHR+xS2yER5J0o/vx4wO9PHQMglhLzhKA4d1pqdmGI3O+HYfaQyhrQpJjRqBFWg1Y+lfjiYDUg+bu7LtCWWq9LViiCdVcoLx36LdJDmBglIAA6MIswjvyCnkajP3VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754566495; c=relaxed/simple;
	bh=G6vZA4wmQaLjgQfEsmiovY05d3mgMfUQwi8NEhL89MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3S5/xq3Vke7dIGyz0g0UEUQytbfKxRCdP10Qs2DjOn9m8J7qR4XS4aPDLy7MVr6tr2Di5rMNduRaH0eHvsLrr5Hlpm8u0TvUDU3diGC+0j4ogts3HnHQhX5eTkd52Hxrf4jbY1sJxxHKCMtY/U92u5oQkM2E8U3C5S5xZRaB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B89B52C02AF7;
	Thu,  7 Aug 2025 13:34:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A174D48BAC8; Thu,  7 Aug 2025 13:34:43 +0200 (CEST)
Date: Thu, 7 Aug 2025 13:34:43 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Linas Vepstas <linasvepstas@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Sinan Kaya <okaya@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 2/3] powerpc/eeh: Use result of error_detected() in
 uevent
Message-ID: <aJSPU6bF-DRNN1ZT@wunner.de>
References: <20250807-add_err_uevents-v4-0-c624bfd8638d@linux.ibm.com>
 <20250807-add_err_uevents-v4-2-c624bfd8638d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807-add_err_uevents-v4-2-c624bfd8638d@linux.ibm.com>

On Thu, Aug 07, 2025 at 12:15:32PM +0200, Niklas Schnelle wrote:
> With pci_uevent_ers() handling PCI_ERS_RESULT_NEED_RESET the result of
> error_detected() can be used in pci_uevent_ers() even if drivers request
> a reset. This aligns EEH's behavior with both AER.

I guess the sentence is supposed to end with "and s390"?

I would have recounted the history a bit, e.g.:

Ever since uevent support was added for AER and EEH with commit
856e1eb9bdd4 ("PCI/AER: Add uevents in AER and EEH error/resume"), it
reported PCI_ERS_RESULT_NONE as the result of ->error_detected() to
user space.

Commit 7b42d97e99d3 ("PCI/ERR: Always report current recovery status for
udev") subsequently amended AER to report the actual return value of
->error_detected().

Make the same change to EEH to align it with AER (and s390 error
recovery).

> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Link: https://lore.kernel.org/linux-pci/aIp6LiKJor9KLVpv@wunner.de/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

