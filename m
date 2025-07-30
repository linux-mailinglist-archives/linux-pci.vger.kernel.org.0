Return-Path: <linux-pci+bounces-33203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC483B16797
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 22:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD33583CC7
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 20:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA67D21CA14;
	Wed, 30 Jul 2025 20:26:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74431EA7FF;
	Wed, 30 Jul 2025 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753907211; cv=none; b=Nbl+wIfkI40Tslf5aISXtBntTDfEuP+0z0X/RIuC8BoSOp7GvPUljYdTnUy0GlPU2L2UxHW3tzVECbsjbuNYUxOVa+dApkITni6/22eQ7GU706mHfV9M1NyIUfjwPyi0GJUsSySNc1nP2seoPd8xQX9mqHCbsm/0vrNntf6Q8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753907211; c=relaxed/simple;
	bh=9WF2xUGso3inJoPUIHRvuIUXbxlZaUx2xG78+B3xOX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueNQxXjxsZSwl1vLxSOqnrJgpGWkzrxIlNK+xq/rxSExBT8y6jwvN61qGW9OC7If0uFIt5bey5K+U1vutU529IGcZSegu9Gk+aGo/zCwRJkYrUxcNbi/gZXb12SJ+6c/mUiGRf8arMbxWceTjeyG3jpHG/NCo23upCnpk5HbmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B8A482C02AD6;
	Wed, 30 Jul 2025 22:26:47 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9FCEB467C41; Wed, 30 Jul 2025 22:26:47 +0200 (CEST)
Date: Wed, 30 Jul 2025 22:26:47 +0200
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
Subject: Re: [PATCH v3 2/2] PCI/ERR: s390/pci: Use pci_uevent_ers() in PCI
 recovery
Message-ID: <aIqAB5P1wOA8bpC_@wunner.de>
References: <20250730-add_err_uevents-v3-0-540b158c070f@linux.ibm.com>
 <20250730-add_err_uevents-v3-2-540b158c070f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730-add_err_uevents-v3-2-540b158c070f@linux.ibm.com>

On Wed, Jul 30, 2025 at 01:20:58PM +0200, Niklas Schnelle wrote:
> Issue uevents during PCI recovery using pci_uevent_ers() as done by EEH
> and AER PCIe recovery routines.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

