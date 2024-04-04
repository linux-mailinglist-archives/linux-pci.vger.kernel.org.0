Return-Path: <linux-pci+bounces-5721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C75E898443
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 11:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1A11C26C57
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 09:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30548839FE;
	Thu,  4 Apr 2024 09:35:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B9745C0;
	Thu,  4 Apr 2024 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223300; cv=none; b=a1o0Wpim0+TLV0VIofekCbGG6urL1VruW/PcfYmX9j6Oyqvt3/BDn79IQrDjiV45SZEk2DfRaIyjQDeuIaohYywxnVpL0TH9FpSSGwl4fUNaRvTguOS03B36KNGTQH0E41MEdcJtGdpGiPj7Fmg3cn9FAj4PJHc+DZLvxvjB1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223300; c=relaxed/simple;
	bh=cOlbx3VyA8Goyat6NvnGVEgExOlYfQ9rH5auXMVzt5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXBB4NrbkRD4TKJKeDybnWeNY73k+FrYsQoFLES+XQBiwvk1N4vitLDxhLqYndCza0RVCPCDsoV/KQh5k3sNnALq6RshtzUgBvEo2mIlmHty1HpIKFCCjzo2FNEjoHPb+Fr3sHqF/gEJM5QDyv7ku1BzavFnTrQQ+uesfJn9Nts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9013530006260;
	Thu,  4 Apr 2024 11:34:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7B76E5FC4D6; Thu,  4 Apr 2024 11:34:55 +0200 (CEST)
Date: Thu, 4 Apr 2024 11:34:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] PCI: Add TLP Prefix reading into
 pcie_read_tlp_log()
Message-ID: <Zg50P2JcpvO8S-a7@wunner.de>
References: <20240403100206.4403-1-ilpo.jarvinen@linux.intel.com>
 <20240403100206.4403-2-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403100206.4403-2-ilpo.jarvinen@linux.intel.com>

On Wed, Apr 03, 2024 at 01:02:05PM +0300, Ilpo Järvinen wrote:
> pcie_read_tlp_log() handles only 4 TLP Header Log DWORDs but TLP Prefix
> Log (PCIe r6.1 secs 7.8.4.12 & 7.9.14.13) may also be present.
> 
> Generalize pcie_read_tlp_log() and struct pcie_tlp_log to handle also
> TLP Prefix Log. The layout of relevant registers in AER and DPC
> Capability is not identical but the offsets of TLP Header Log and TLP
                ^^^           ^^^
Somehow this doesn't seem to make sense.  Is the "not" perhaps wrong here?

> Prefix Log vary so the callers must pass the offsets to
> pcie_read_tlp_log().

