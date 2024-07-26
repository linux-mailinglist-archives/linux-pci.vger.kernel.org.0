Return-Path: <linux-pci+bounces-10843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29D893D465
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 15:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232F41C23051
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA92617BB3F;
	Fri, 26 Jul 2024 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCT95JBi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F326AC1;
	Fri, 26 Jul 2024 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001303; cv=none; b=CxG3JIImcLpp3pkUahUK15VjZ7qZgE4ZQebEawvTxF6ZKZAd/Mf+SzRyMEgBQ9r/9zKk9tTz4xiMEKt4vs5QTATpIFPGB/wDcDX892yoEXvJfq7Mtd3QgGCFCYjyDJYxsq1YsAlnd6v+hTkzrbffoMw8YU2mV6AvuhwsuXBklVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001303; c=relaxed/simple;
	bh=2uwGAT67KdxSGGyx9e1hkXaE47VnHch064J3H/Nv5VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdQW/RrGuzxf1Zg5+0ISO0FKbPlrTacZqiB0oIk6x8w0T1mRxsYbUeFum2ZzBYGmhCR2GZ2qcQ0BPM16hKz/XTn/jlhQ/S5jPYIxrvOQUVH5Z8zu/h92vn3yfVEznCsvfdwOpNnAvsKHrG4pqQm9ckuIPtoiNxedOr0NzWAnhUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCT95JBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89579C32782;
	Fri, 26 Jul 2024 13:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722001303;
	bh=2uwGAT67KdxSGGyx9e1hkXaE47VnHch064J3H/Nv5VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qCT95JBiNyMQUnVYinaep8t2WRvwpf7EMBoGMk6ydE4aUQfu+DSocckfOd7DvjCh6
	 DYg865rP41ytadSnYgRSwrXqDh4os+UkGJzOTfVujNxClEvNUvzHCtesw47CuJeSWy
	 2dGd4PFcZDyJEZJieIOb21iKp/rAcK/2MqNtc4FlvfMzvJC51t22vzgYxQUAMgm/lp
	 nJws/mu7KU+XwHWVs0HEsP4vAbYtMmdjhTxdrRFMWXr9LVuef2Z1U1Z+FrlmLD8adX
	 JerndEIFDi/BF/s+fRKd7Zn+5hw8lsISP9qLoIgC1inNOeGFNDi2x8ZpNBfgZzP4Uc
	 Q7aq4R2VIDpPQ==
Date: Fri, 26 Jul 2024 15:41:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
Message-ID: <ZqOnkTidYLc0EboJ@ryzen.lan>
References: <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan>
 <20240725053348.GN2317@thinkpad>
 <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>
 <ZqJeX9D0ra2g9ifP@ryzen.lan>
 <20240725163652.GD2274@thinkpad>
 <ZqLJIDz1P7H9tIu9@ryzen.lan>
 <9c76b9b4-9983-4389-bacb-ef4a5a8e7043@kernel.org>
 <CAAEEuhp+ZtjrU1986CJE5nmFy97YPdnfd1Myoufr+6TgjRODeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAEEuhp+ZtjrU1986CJE5nmFy97YPdnfd1Myoufr+6TgjRODeA@mail.gmail.com>

On Fri, Jul 26, 2024 at 01:21:32PM +0200, Rick Wertenbroek wrote:
> 
> One thing to keep in mind is that 'struct pci_epf_bar 'conf' would be
> an 'inout' parameter, where 'conf' gets changed in case of a fixed
> address BAR or fixed 64-bit etc. This means the EPF code needs to
> check 'conf' after the call. Also, if the caller sets flags and the
> controller only handles different flags, do we return an error, or
> configure the BAR with the only possible flags and let the caller
> check if those flags are ok for the endpoint function ?
> 
> This is a bit unclear for me for the moment.

Indeed, it is quite messy at the moment, which is why we should try
to do better, and clearly document the cases where the API should
fail, and when it is okay for the API to set things automatically.


How the current pci_epf_alloc_space() (which is used to allocate space
for a BAR) works:
- Takes a enum pci_barno bar.

- Will modify the epf_bar[bar] array of structs. (For either primary
  interface array of BARs or secondary interface array of BARs.)
  Perhaps it would be better if this was an array of pointers instead,
  so that an EPF driver cannot modify a BAR that has not been allocated,
  and that the new API allocates a 'struct pci_epf_bar', and sets the
  pointer. (But perhaps better to leave it like it is to start with.)

- Uses |= to set flags, which means that if an EPF has modified
  epf_bar[bar].flags before calling pci_epf_alloc_space(), these
  flags would still be set. (I wouldn't recommend any EPF driver to do so.)
  It would be much better if we provided 'flags' to the new API, so that
  the new API can set the flags using = instead of |=.

- Flag PCI_BASE_ADDRESS_MEM_TYPE_64 will automatically get set if the BAR
  can only be a 64-bit BAR according to epc_features.
  This is a bit debatable. For some EPF drivers, getting a 64-bit BAR even
  if you only requested a 32-bit BAR, might be fine. But for some EPF
  drivers, I can imagine that it is not okay. (Perhaps we need a
  "bool strict" that gives errors more often instead of implicitly setting
  flags not that was not requested.

- Will set PCI_BASE_ADDRESS_MEM_TYPE_64 if the requested size is larger
  than 2 GB. The new API should simply give an error if flag
  PCI_BASE_ADDRESS_MEM_TYPE_64 is not set when size is larger than 2 GB.

- If the bar is a fixed size BAR according to epc_features, it will set a
  size larger than the requested size. It will however give an error if the
  requested size is larger than the fixed size BAR. (Should a possible
  "bool strict" give an error if you cannot set the exact requested size,
  or is it usually okay to have a BAR size that is larger than requested?)


How the current pci_epc_set_bar() works:
- Takes 'struct pci_epf_bar *epf_bar'

- This function will give an error if PCI_BASE_ADDRESS_MEM_TYPE_64 is not set
  when size is larger than 2 GB, or if you try to set BAR5 as a 64-bit BAR.

- Calls epc->ops->set_bar() will should return errors if it cannot satisfy
  the 'struct pci_epf_bar *epf_bar'.


How the epc->ops->set_bar() works:
- A EPC might have additional restrictions that are controller specific,
  which isn't/couldn't be described in epc_features. E.g. pcie-designware-ep.c
  requires a 64-bit BAR to start at a even BAR number. (The PCIe spec allows
  a 64-bit BAR to start both at an odd or even BAR number.)


So it seems right now, alloc_space() might result in a 'struct pci_epf_bar'
that wasn't exactly what was requested, but set_bar() should always fail if
an EPC driver cannot fullfil exactly what was requested in the
'struct pci_epf_bar' (that was returned by alloc_space()).


We all agree that this is a good idea, but does anyone actually intend to
take on the effort of trying to create a new API that is basically
pci_epf_alloc_space() + pci_epc_set_bar() combined?

Personally, my plan is to respin/improve Damien's "improved PCI endpoint
memory mapping API" series:
https://lore.kernel.org/linux-pci/20240330041928.1555578-1-dlemoal@kernel.org/

But I'm also going away on two weeks vacation starting today, so it will
take a while before I send something out...


Kind regards,
Niklas

