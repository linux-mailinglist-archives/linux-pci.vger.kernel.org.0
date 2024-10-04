Return-Path: <linux-pci+bounces-13822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910399903A2
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 15:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43CFB1F242C6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559661DB95B;
	Fri,  4 Oct 2024 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGthLXxR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127079F3
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047586; cv=none; b=HQjoto4BpFwLRtRWcdTIeexw1joPEervX9ObZaZOopOv6Am32jg/YFYPnoDk9rVdz4fh1lFk0DJty5Tw5SRCN3r49mDme4Hamw++72A3x6oFZ3sIky9c1KFNlF0sxERjiRbZWB+E5g8UZCHGxysM8SXH5rU0SaT5pOREB1zjTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047586; c=relaxed/simple;
	bh=psM0QqMpdJaBOkRvWH9v1igZceCpHP15n8/14Ff2WzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d47kj8sH1VF7mFhdyUgl+rqFtFRaXYfjlkqQvQlmXAGRxN/HimAlbF5LQdUqxGHcZUj1h7G2qyv/QIRCQk5v6CQXsfD81k1AuFnNtUttz2USvqjp8CLtlfN0snfJHS5z3OdwveosCTcRdAOAZJMVZGIsOQfTl40NaJdW5I6daiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGthLXxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641BDC4CEC6;
	Fri,  4 Oct 2024 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047585;
	bh=psM0QqMpdJaBOkRvWH9v1igZceCpHP15n8/14Ff2WzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGthLXxRlT6HoNNho8kVEuatMFmxONs+evMuIGYL98vmFv1jjp+sT/tTJYWL7Yp8T
	 eMJi7+ltO6s/GbPVNraTO26oAEZGcwYazVNHkMYWdAS+BZa84t0QnfQTyp4p81m1Ch
	 c33JRic4HPuahIC12AJPa+iN+QCGLwm6viBm5EM9a0gkYV0rdMeh12NR2BSnjZKvnG
	 /fCm44hODog1j+X3wfV1eu/GeAaIcZz20MpYlZdsWzkOFizi2WyxiTurMvAfneUegr
	 JRijeRd6xCmYpfPF1Df+jJ9pQP7UpFZFjUKagIIgq3x6HcOp5M92sjw/G89ZgK4iJQ
	 hCH7IEajKqLjw==
Date: Fri, 4 Oct 2024 15:13:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v3 0/7] Improve PCI memory mapping API
Message-ID: <Zv_p3CjYblYnY9Dj@ryzen.lan>
References: <20241004050742.140664-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004050742.140664-1-dlemoal@kernel.org>

On Fri, Oct 04, 2024 at 02:07:35PM +0900, Damien Le Moal wrote:
> This series introduces the new functions pci_epc_map_align(),
> pci_epc_mem_map() and pci_epc_mem_unmap() to improve handling of the
> PCI address mapping alignment constraints of endpoint controllers in a
> controller independent manner.
> 
> The issue fixed is that the fixed alignment defined by the "align" field
> of struct pci_epc_features assumes is defined for inbound ATU entries
> (e.g. BARs) and is a fixed value, whereas some controllers need a PCI
> address alignment that depends on the PCI address itself. For instance,
> the rk3399 SoC controller in endpoint mode uses the lower bits of the
> local endpoint memory address as the lower bits for the PCI addresses
> for data transfers. That is, when mapping local memory, one must take
> into account the number of bits of the RC PCI address that change from
> the start address of the mapping.
> 
> To fix this, the new endpoint controller method .map_align is introduced
> and called from pci_epc_map_align(). This method is optional and for
> controllers that do not define it, it is assumed that the controller has
> no PCI address constraint.
> 
> The functions pci_epc_mem_map() is a helper function which obtains
> mapping information, allocates endpoint controller memory according to
> the mapping size obtained and maps the memory. pci_epc_mem_unmap()
> unmaps and frees the endpoint memory.
> 
> This series is organized as follows:
>  - Patch 1 tidy up the epc core code
>  - Patch 2 improves pci_epc_mem_alloc_addr()
>  - Patch 3 and 4 introduce the new map_align endpoint controller method
>    and the epc functions pci_epc_mem_map() and pci_epc_mem_unmap().
>  - Patch 5 documents these new functions.
>  - Patch 6 modifies the test endpoint function driver to use 
>    pci_epc_mem_map() and pci_epc_mem_unmap() to illustrate the use of
>    these functions.
>  - Finally, patch 7 implements the rk3588 endpoint controller driver
>    .map_align operation to satisfy that controller 64K PCI address
>    alignment constraint.
> 
> Changes from v2:
>  - Dropped all patches for the rockchip-ep. These patches will be sent
>    later as a separate series.
>  - Added patch 2 and 5
>  - Added review tags to patch 1
> 
> Changes from v1:
>  - Changed pci_epc_check_func() to pci_epc_function_is_valid() in patch
>    1.
>  - Removed patch "PCI: endpoint: Improve pci_epc_mem_alloc_addr()"
>    (former patch 2 of v1)
>  - Various typos cleanups all over. Also fixed some blank space
>    indentation.
>  - Added review tags


I think the cover letter is missing some text on how this series has been
tested.

In V2 I suggested adding a new option to pcitest.c, so that it doesn't
ensure that buffers are aligned. pci_test will currently use a 4k alignment
by default, and for some PCI device IDs and vendor IDs, it will ensure that
the buffers are aligned to something else. (E.g. for the PCI device ID used
by rk3588, buffers will be aligned to 64K.)

By adding an --no-alignment option to pci_test, we can ensure that this new
API is actually working.

Did you perhaps ifdef out all the alignment from pci_endpoint_test.c when
testing?

I think that having a --no-alignment option included as part of the series
would give us higher confidence that the API is working as intended.

(pci_test would still align buffers by default, and the long term plan is
to remove these eventually, but it would be nice to already have an option
to disable it.)


Kind regards,
Niklas

