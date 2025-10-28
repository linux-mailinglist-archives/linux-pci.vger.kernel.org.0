Return-Path: <linux-pci+bounces-39507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A14C13F86
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 10:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAEB3BA980
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 09:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C016305946;
	Tue, 28 Oct 2025 09:53:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ADA2D877B
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645237; cv=none; b=ohJfoLmUSDvwFVPiq8SChr03QBS6daJ50u78RUwIvwOKZWRdJYG9PGmpePlQfc/wDvxO1j8qeK5+QGVtv/RT1csiRGvH+P7yI75h/GVSXvxusvRMVKCGTxvlIFCOQGse+5Kfz1vtIEBA/wO+Cv7OFhuGZ9g/ju08Cs5/YT/gTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645237; c=relaxed/simple;
	bh=5fe6ZbxS0pIyDBWzWX3DxA5XkKI7mnVbzKM04tNUGOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxEwgEmEPTI7pBw20m+KdQW06utD8VVpdN1QjHEn3nLYZuIDmtmN+q91SWSibznZRABWk67yCVF/NTAwqLUbvX7nAVvNrcQoSMeyVvZCX79ahi0Yz6mSbC3cebYR8dFZXt6r4QIw55TfB2gBE8lSYf9RA6BFiPjhlnRf4vsmJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B4F2C2C06E2E;
	Tue, 28 Oct 2025 10:53:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9FA02572D; Tue, 28 Oct 2025 10:53:44 +0100 (CET)
Date: Tue, 28 Oct 2025 10:53:44 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI/PTM: Do not enable PTM solely based on the
 capability existense
Message-ID: <aQCSqKm8gaUtuD-6@wunner.de>
References: <20251028060427.2163115-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028060427.2163115-1-mika.westerberg@linux.intel.com>

On Tue, Oct 28, 2025 at 07:04:27AM +0100, Mika Westerberg wrote:
> It is not advisable to enable PTM solely based on the fact that the
> capability exists. Instead there are separate bits in the capability
> register that need to be set for the feature to be enabled for a given
> component (this is suggestion from Intel PCIe folks):
> 
>   - PCIe Endpoint that has PTM capability must to declare requester
>     capable
>   - PCIe Switch Upstream Port that has PTM capability must declare
>     at least responder capable
>   - PCIe Root Port must declare root port capable.
[...]
> This happens because Linux sees the PTM capability and blindly enables
> PTM which then causes the AER error to trigger.
> 
> Fix this by enabling PTM only if the above described criteria is met.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

A stable designation might be merited, it looks like we've been doing
this wrong since forever:

Fixes: 9bb04a0c4e26 ("PCI: Add Precision Time Measurement (PTM) support")
Cc: stable@vger.kernel.org  # v4.9+

A spec reference in the commit message may also be helpful:

PCIe r7.0 sec 6.21.1 figure 6-21

I guess Bjorn could add those when applying if he deems them necessary,
so probably no reason to respin just for that.

Thanks,

Lukas

