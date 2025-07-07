Return-Path: <linux-pci+bounces-31619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4521DAFB57C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152751882F9A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 13:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B692BD01E;
	Mon,  7 Jul 2025 13:58:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4CE1F4CAE
	for <linux-pci@vger.kernel.org>; Mon,  7 Jul 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896721; cv=none; b=HOrJCdZ2BBvT1bs4R3rD4+90Niqc1mHBdSB6qdW+/z0MTOmOSVFVHgFDSe4817X5lKnxvs0nzuhe4IanV5z1ppfvNOOX+XBTE9SMIxDtbHq7SxDafepoasV/aWyQh3QRvn1uiR7rudk3qg56dz0RUdIkeLge/JJic6HUxoSrutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896721; c=relaxed/simple;
	bh=wkniiIbVVMt7AJg5Ojd6J8vayPVPSFRZdAycRjCeEJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYmpl/561s5WJePZoUoOHVLE41EjaydfDJwm1E5yxChuV0P1e8TXZIu3x6+dk7slKTKQkoXXduZRzq3G9KgA0T2IVsMVcR4G0wqnsoeHx8mcteldm5JPL70F07t6wDWLhXshuKA6YfVdlldNx358kqNH/D8/9HhUFIXNEJbkr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 330E42009184;
	Mon,  7 Jul 2025 15:58:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 268BA4D174; Mon,  7 Jul 2025 15:58:30 +0200 (CEST)
Date: Mon, 7 Jul 2025 15:58:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hans de Goede <hansg@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, David Airlie <airlied@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ahmed Salem <x0rw3ll@gmail.com>, Borislav Petkov <bp@alien8.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] agp/amd64: Check AGP Capability before binding to
 unsupported devices
Message-ID: <aGvShrJJTj2ERdZr@wunner.de>
References: <b29e7fbfc6d146f947603d0ebaef44cbd2f0d754.1751468802.git.lukas@wunner.de>
 <aGbaNd3qCK3WvAe-@tassilo>
 <4ef523a2-48b3-45e9-94da-7811e1bfae76@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef523a2-48b3-45e9-94da-7811e1bfae76@kernel.org>

On Mon, Jul 07, 2025 at 02:53:32PM +0200, Hans de Goede wrote:
> So I think we should move forward with Lukas' fix dor 6.16 and then
> my patch to disable probing of unsupported devices by default can
> be merged into linux-next .

Sounds good to me.

Dave is out all week and has not commented on this matter at all so far:

https://lore.kernel.org/r/CAPM=9tzrmRS9++MP_Y4ab95W71UxjFLzTd176Mok7akwdT2q+w@mail.gmail.com/

I assume Bjorn may not be comfortable applying my patch without an ack
from Dave.  I am technically able to apply my own patch through drm-misc
and I believe Hans' Reviewed-by is sufficient to allow me to do that.

I'd feel more comfortable having additional acks or Reviewed-by's though.
I'm contemplating applying the patch to drm-misc by Wednesday evening,
that would allow it to land in Linus' tree before v6.16-rc6.

If anyone has objections, needs more time to review or wants to apply
the patch, please let me know.

Thanks,

Lukas

