Return-Path: <linux-pci+bounces-38758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D6BF1AF6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 15:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7838F3A5D79
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83262318136;
	Mon, 20 Oct 2025 13:58:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66C241665;
	Mon, 20 Oct 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968709; cv=none; b=bi5/xXROliU1uwqlQayl4jZjZ6bAZrEnHY738bnYPCIuMNGS0USakkhhuoyWN6PU/aQzkpSOzC8QmGFZSRBz/kEE4X+Uq08EI7q4csDZUtqHT/VLRRiKgmtuH5rDalVYNsVehy5wqwR2m+qB4/vbljbFY5t4Mf4ukt/1Euf1Yxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968709; c=relaxed/simple;
	bh=EDGJWaQ3mSpBPu9LAkM/86F9DE+VAX88S07CBhf9Dxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtbrnGUjDn433i7y7ull86xADHtt+VpYXhV0fQUDxaWn209EL/IlLVWWQTYA/xWzH3ipy2kQRPSX6/sHnCOPz66QN6jJZCixzGUmK11Ssxub8c92NxLfykNOxPAKrVzVxCMMp14OuY/g/Twaf7mLCAWGvPjg86KCNtJbN1Fd2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id F199C2C02B96;
	Mon, 20 Oct 2025 15:58:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D719F4A12; Mon, 20 Oct 2025 15:58:24 +0200 (CEST)
Date: Mon, 20 Oct 2025 15:58:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6 4/5] PCI/ERR: Use pcie_aer_is_native() to check for
 native AER control
Message-ID: <aPZAAPEGBNk_ec36@wunner.de>
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-5-xueshuai@linux.alibaba.com>
 <aPYMO2Eu5UyeEvNu@wunner.de>
 <0fe95dbe-a7ba-4882-bfff-0197828ee6ba@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fe95dbe-a7ba-4882-bfff-0197828ee6ba@linux.alibaba.com>

On Mon, Oct 20, 2025 at 09:09:41PM +0800, Shuai Xue wrote:
> ??? 2025/10/20 18:17, Lukas Wunner ??????:
> > On Wed, Oct 15, 2025 at 10:41:58AM +0800, Shuai Xue wrote:
> > > Replace the manual checks for native AER control with the
> > > pcie_aer_is_native() helper, which provides a more robust way
> > > to determine if we have native control of AER.
> > 
> > Why is it more robust?
> 
> IMHO, the pcie_aer_is_native() helper is more robust because it includes
> additional safety checks that the manual approach lacks:
[...]
> Specifically, it performs a sanity check for dev->aer_cap before
> evaluating native AER control.

I'm under the impression that aer_cap must be set, otherwise the
error wouldn't have been reported and we wouldn't be in this code path?

If we can end up in this code path without aer_cap set, your patch
would regress devices which are not AER-capable because it would
now skip clearing of errors in the Device Status register via
pcie_clear_device_status().

Thanks,

Lukas

