Return-Path: <linux-pci+bounces-7065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C754D8BB7D0
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 00:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A5A28689C
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 22:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390FB80038;
	Fri,  3 May 2024 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN1qhSjF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1181877F08;
	Fri,  3 May 2024 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776788; cv=none; b=tKzJwaEmzUrxwY07b+kF3orPGxfpiFPnyD0sEwkVCJNpm4hcuVvrzmS6ELhqc4N4F1Qjw7KOVvgUoci2h07T3/wUyMvU28ntirNkzgBOS3YWZNpHD2E4B0ROEKbUfM15i5Y2MtKxiQlfEbZSjiCU7VSMlV2GWiw9/xpKxmHSJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776788; c=relaxed/simple;
	bh=mXcYLMX35fPnLEPH9zrI4bMp+JPZC+O689bhhbTpo/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fkJLHmyuo2TihCut6a3G1DZXW9EX7JuRvuLkSSX1ncGH0h5wlB7Y/TPg8x1T04mrXTJDF8+XsPxRQHcaTh+1kIWfsrwuxpuUP84iE0iIj55xQYDub61fGSQ+Ky/1EFXpLU/h7JxCT4n2KBvEMJ9VtgRg8ESeuE13bslZE6vL1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN1qhSjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2293C116B1;
	Fri,  3 May 2024 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714776787;
	bh=mXcYLMX35fPnLEPH9zrI4bMp+JPZC+O689bhhbTpo/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oN1qhSjFtfExfcxp83Bnx+pofMcdi/EXKHF/817yLrh6CgflKgvoJCwR2vGGsCl8W
	 BH3uD1m9s+Y+lFfVKyFCLD5HmKBXBd4Cv8OTNmjN8FMXOu7vHV/ktIA32LAwkmJzpb
	 SMEKKGVzYWgrVCP4JBFVtZ+bDAAWNE6BsWablP9gsqxQvdUqpRAqi7TCqG22Kg00Jr
	 TJLehTP1MnHzrOFt3RrIlDmIx/739zyd/khyjVxrI+VT/LjQ9sgoQY14/G3e88rupv
	 vnEmTJ0KBZeGyGQ7H18LOxlzu83Dc4xmNsZA+Pk979Ea1/wfmQn+bqC6qvw5vvzFk+
	 0bFWAPvc5oMAA==
Date: Fri, 3 May 2024 17:53:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] PCI: Add TLP Prefix reading into
 pcie_read_tlp_log()
Message-ID: <20240503225305.GA1609388@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412133635.3831-2-ilpo.jarvinen@linux.intel.com>

On Fri, Apr 12, 2024 at 04:36:34PM +0300, Ilpo Järvinen wrote:
> pcie_read_tlp_log() handles only 4 TLP Header Log DWORDs but TLP Prefix
> Log (PCIe r6.1 secs 7.8.4.12 & 7.9.14.13) may also be present.
> 
> Generalize pcie_read_tlp_log() and struct pcie_tlp_log to handle also
> TLP Prefix Log. The layout of relevant registers in AER and DPC
> Capability is not identical because the offsets of TLP Header Log and
> TLP Prefix Log vary so the callers must pass the offsets to
> pcie_read_tlp_log().

I think the layouts of the Header Log and the TLP Prefix Log *are*
identical, but they are at different offsets in the AER Capability vs
the DPC Capability.  Lukas and I have both stumbled over this.

Similar and more comments at:
https://lore.kernel.org/r/20240322193011.GA701027@bhelgaas

> Convert eetlp_prefix_path into integer called eetlp_prefix_max and
> make is available also when CONFIG_PCI_PASID is not configured to
> be able to determine the number of E-E Prefixes.

s/make is/make it/

I think this could be a separate patch.

> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -20,6 +20,7 @@ struct pci_dev;
>  
>  struct pcie_tlp_log {
>  	u32 dw[4];
> +	u32 prefix[4];
>  };
>  
>  struct aer_capability_regs {
> @@ -37,7 +38,9 @@ struct aer_capability_regs {
>  	u16 uncor_err_source;
>  };
>  
> -int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_log *log);
> +int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
> +		      unsigned int tlp_len, struct pcie_tlp_log *log);
> +unsigned int aer_tlp_log_len(struct pci_dev *dev);

I think it was a mistake to expose pcie_read_tlp_log() outside
drivers/pci, and I don't think we should expose aer_tlp_log_len()
either.

We might be stuck with exposing struct pcie_tlp_log since it looks
like ras_event.h uses it.

Bjorn

