Return-Path: <linux-pci+bounces-23092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DE1A5629D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 09:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2781714EB
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5E51B86EF;
	Fri,  7 Mar 2025 08:34:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F11A83E8;
	Fri,  7 Mar 2025 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336495; cv=none; b=lglH1y5kWiWwNFNXqJo5rC61y6vxUHjy5gR2sK95DcKVkpfM7drvkllc5HKJoudCAgqv0rrHiFkYZeEAyx7+WUk5o71ik/reAK7AkQZufb/sHQCTB2MkiqSC6hIXVnk8fAiO0HiJKs0pnVQRh9BhEikfT9vDRxnqXY6ONkI71Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336495; c=relaxed/simple;
	bh=QKt7S8W8M5/jPz1pe4PXUMPxklGGARlrxMvPPd2OrFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay4iABwIyG18Xqqjr+CXjm1ef+BZaaBj2h1CHNzg+JACG5SM+HjCzwxsxZT28GTOvXIxtrWaq1gIr8kmCoO5ZAD9g0osfqjcgEDTzDnIz6Nnj7qk8BWbKzM14/zC7bObuPjP3Idwwl2Ndq6YHWLVaSLlXuOKg/bRli8a99LlsWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 35CA03001409A;
	Fri,  7 Mar 2025 09:34:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2442C2A7F6; Fri,  7 Mar 2025 09:34:43 +0100 (CET)
Date: Fri, 7 Mar 2025 09:34:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Message-ID: <Z8qvo0_tuSbwwyIY@wunner.de>
References: <20250304135108.2599-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304135108.2599-1-ilpo.jarvinen@linux.intel.com>

On Tue, Mar 04, 2025 at 03:51:08PM +0200, Ilpo Järvinen wrote:
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5564,6 +5564,33 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0144, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
>  
> +static void quirk_pcie2x_no_tags_no_mrrs(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> +	u32 linkcap;
> +
> +	if (!bridge)
> +		return;

I note that in a lot of places where pci_find_host_bridge() is called,
no NULL pointer check is performed.  So omitting it would appear
to be safe.

The quirk is x86-specific, so compiling it into the kernel on other
arches creates unnecessary bloat.  Avoid by moving to arch/x86/pci/fixup.c.

There should definitely be a multi-line code comment above the function
explaining what defect this works around (slower performance apparently),
and also link to the PDF document.

BTW the PDF document says "Intel Confidential", I'm wondering why this
has been made public without stripping the confidentiality marker...

Thanks,

Lukas

