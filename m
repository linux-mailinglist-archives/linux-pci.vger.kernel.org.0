Return-Path: <linux-pci+bounces-34966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23129B3936D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 07:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624AA1C24C38
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 05:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C540272E57;
	Thu, 28 Aug 2025 05:52:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9F272E61
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756360366; cv=none; b=iwl2ZUiVpS1CqLvAsO0wyGi4lpZOdYZWSuX+Zje4PpyLIMRjVPArApcFDsSzRFFw2o18enSZDGLXzX24QDALTsogDwSLabpR4bgG5meM0QIy5kRQ2T3IJ3xuTcmqFNKPDyhQkIBlNZl/WWlpliz9B+MRYom0NKJAjJZjfM9/JyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756360366; c=relaxed/simple;
	bh=pM489TXR2z+4apoleTO7nIcRmxj0j7dhD4tgXeUTvCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkcGAkLRO9On/PpPajQNZ8xPBo4styGOKnmhPc/N84z3CX91h3J8ubnHRbzui5lMR6ds81lDZwWWTnHnFaAoQnrwyJSgGS/+1z+PQEZWcpn1KHT8ISdzbqOuoOcHihRteJKEoGAq33erOnP5WwQh6RSVqBPVI5pRifzkQIgbtiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id D1240200B1E0;
	Thu, 28 Aug 2025 07:52:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B4137244BB4; Thu, 28 Aug 2025 07:52:40 +0200 (CEST)
Date: Thu, 28 Aug 2025 07:52:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Support errors introduced by PCIe r6.0
Message-ID: <aK_uqHGw3B4vtx66@wunner.de>
References: <21f1875b18d4078c99353378f37dcd6b994f6d4e.1756301211.git.lukas@wunner.de>
 <64a661bd-cb64-4850-90d8-f34de9457173@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a661bd-cb64-4850-90d8-f34de9457173@linux.intel.com>

On Wed, Aug 27, 2025 at 12:56:41PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 8/27/25 6:41 AM, Lukas Wunner wrote:
> > PCIe r6.0 defined five additional errors in the Uncorrectable Error
> > Status, Mask and Severity Registers (PCIe r7.0 sec 7.8.4.2ff).
> 
> is 2ff a typo ?

"ff" means "and following" (pages, etc), according to:
https://en.wiktionary.org/wiki/ff

Section 7.8.4.2 is the Status Register.  The Mask and Severity Registers
are specified in the following sections 7.8.4.3 and 7.8.4.4.

Thanks,

Lukas

