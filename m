Return-Path: <linux-pci+bounces-27714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4F0AB6A68
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 13:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6FC1886D3C
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 11:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C443826FD9D;
	Wed, 14 May 2025 11:44:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692E2749FE;
	Wed, 14 May 2025 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223041; cv=none; b=Upj8v/f6SQV9oJlsIU5i7eOwqYQMBwAtOl/RQKlzmhgWPTBQrDiaTNqlhLb9k9nZGM2kC0a0IBHzr64d/skLoWC37CKcNLnfGzy578/vVnoQuG4kY4F2c8Vt379HinUAjqsC84DF3D0iteC4o1bgEAtqWDKBoBazY9NnuFM548E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223041; c=relaxed/simple;
	bh=KtUKx9ie85H8a9S3QkpygFRL+K3FmLo8pmKLS8l1L3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRzFbh6Gh2zQ3Y0Nux/MViS4YAeeSAZGFWy7SK2wif5ZgdCIEUNBN7ngXleW0+e+BV1TXPZ2nXTgBq1b0eEY5aYUxsR4c79C9B0p4t8vW4EdpQPECLUKUDaiFmkzM5r8rtuobWLbDruBN+Xu7PWKrIwJXBbzo/SN2hiHDkHiARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 987F52C000A5;
	Wed, 14 May 2025 13:43:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C70A120B92C; Wed, 14 May 2025 13:43:49 +0200 (CEST)
Date: Wed, 14 May 2025 13:43:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Move reset and restore related code to
 reset-restore.c
Message-ID: <aCSB9Y5OwNkdiuez@wunner.de>
References: <20250512120900.1870-1-ilpo.jarvinen@linux.intel.com>
 <aCRBFWHKa02Hu-ec@wunner.de>
 <7c8ebe5d-a5be-6aba-1b84-15dd2f32b52f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c8ebe5d-a5be-6aba-1b84-15dd2f32b52f@linux.intel.com>

On Wed, May 14, 2025 at 02:29:42PM +0300, Ilpo Järvinen wrote:
> On Wed, 14 May 2025, Lukas Wunner wrote:
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -69,15 +69,7 @@ struct pci_pme_device {
> > >   */
> > >  #define PCI_RESET_WAIT 1000 /* msec */
> > 
> > I'd move PCI_RESET_WAIT, pci_dev_wait() and
> > pci_bridge_wait_for_secondary_bus() to reset.c as well.
> > Then pci_dev_d3_sleep() is the only function which is no longer static.
> 
> Okay I'll move those as well but that static statement is not exactly 
> true, I'll these need to do these as well:
> 
> - move pci_bus_max_d3cold_delay() along with 
>   pci_bridge_wait_for_secondary_bus() to keep that static, or turn that
>   into a non-static.
> 
> - make pcie_wait_for_link_delay() non-static.

Sorry, missed that.  In that case I suggest moving pcie_wait_for_link()
as well.  It is already non-static.  Then you can keep the static on
pcie_wait_for_link_delay().

Per PCIe r6.2 sec 5.8, a transition from D3cold to D0uninitialized
implies a Fundamental Reset.  That could serve as a creative
justification in the commit message or in the code comment at the
top of reset.c why it contains D3cold-related functions. ;)

Thanks,

Lukas

