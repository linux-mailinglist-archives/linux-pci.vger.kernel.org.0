Return-Path: <linux-pci+bounces-13812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA5E99024E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 13:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC651F2403F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E353D15B11F;
	Fri,  4 Oct 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNiRQzv1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF515C122
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042308; cv=none; b=dNzTaZVY5zlSICwG8xmq6j1AZf1gquIZcZUM5y2dzn8ebHyHK3qoZGYbcC6HbQQ6o/nou8cZV5LKoJDsQN1AsD0SBAVBDMKduHfHSwYSZ4wnVCMZIENCWYg4jZox8NsbJDT+/YgQl3VIJYKvFlNqj0hPoZ1BaIjdFmNxBAsOYNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042308; c=relaxed/simple;
	bh=LyFyc+RBXZjWswYqUO7+iPTq5eriUE506PGl8MlL3jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf1pkUF3XXFOgTnf6lzpC7lH6vojuYAJNjMMFC30Lgz9qHbldWaNrHrSyR7N/hwf2CR7/ZovHw+l4OBF7PDVqoYfDX/j3PZ4+52HTHPt6vdokbQDFHI8ym4gOTqiUqeDB9vl+9zgmDE/ah4pHRGq8t4FTiDTwTY7XnljDQHyBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNiRQzv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5B8C4CED3;
	Fri,  4 Oct 2024 11:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728042308;
	bh=LyFyc+RBXZjWswYqUO7+iPTq5eriUE506PGl8MlL3jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNiRQzv1zmTvqyRBrl6nazawZA6Z9fnRdwZcpvZW24KEYj/aU+Fxdsgr8GQ7GPSpS
	 Cwwbs5lLYHYhJNtiUI3ZPpTFnAWV7AyLaLYUoiLYJtk0i98FtQrzqneMctTg7p6fOt
	 Fj8ErwHnlRLAtIerDnC+++J9gN9arqFHS0tnnGZuM/06m3GID3CgNEv4RVUSWOJ0vE
	 Gsea+afGUHhHS3EQJyl+msg1gPZZiVWnhqqBqQDhPjw9ow9z+BYp/6wHW2POwF2x4A
	 uzf13W/CkUkGwFNcO8z+gZ9kydZiDH0Hayyw5KYi+236T7rgYj9I2IkDon6NCTxbAQ
	 Q3u6j1R8ihwrw==
Date: Fri, 4 Oct 2024 13:45:02 +0200
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
Message-ID: <Zv_VPioJgZWGhbna@ryzen.lan>
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

s/assumes//


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

Introduces a small helper which cleans up the code.


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

Why mention that it implements it for rk3588 ? (And why mention 64K?)
Patch 7 is not specific to rk3588. Better to mention that you implement
it for all DWC PCIe EP controllers, based on the iATU hardware requirements,
read from hardware registers (which is stored in pci->region_align), since
that is what the commit does.

You should probably also mention that as a result of this series, follow
up patches can remove alignment entries in drivers/misc/pci_endpoint_test.c


> 
> Changes from v2:
>  - Dropped all patches for the rockchip-ep. These patches will be sent
>    later as a separate series.
>  - Added patch 2 and 5
>  - Added review tags to patch 1

I think that you should have mentioned that this fixes quite a serious bug in
V2, that was reported here:
https://lore.kernel.org/linux-pci/eb580d64-1110-479a-9a0b-c2f1eacd23e7@kernel.org/


> 
> Changes from v1:
>  - Changed pci_epc_check_func() to pci_epc_function_is_valid() in patch
>    1.
>  - Removed patch "PCI: endpoint: Improve pci_epc_mem_alloc_addr()"
>    (former patch 2 of v1)
>  - Various typos cleanups all over. Also fixed some blank space
>    indentation.
>  - Added review tags
> 
> Damien Le Moal (7):
>   PCI: endpoint: Introduce pci_epc_function_is_valid()
>   PCI: endpoint: Improve pci_epc_mem_alloc_addr()
>   PCI: endpoint: Introduce pci_epc_map_align()
>   PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
>   PCI: endpoint: Update documentation
>   PCI: endpoint: test: Use pci_epc_mem_map/unmap()
>   PCI: dwc: endpoint: Define the .map_align() controller operation
> 
>  Documentation/PCI/endpoint/pci-endpoint.rst   |  33 ++
>  .../pci/controller/dwc/pcie-designware-ep.c   |  15 +
>  drivers/pci/endpoint/functions/pci-epf-test.c | 372 +++++++++---------
>  drivers/pci/endpoint/pci-epc-core.c           | 213 +++++++---
>  drivers/pci/endpoint/pci-epc-mem.c            |   9 +-
>  include/linux/pci-epc.h                       |  41 ++
>  6 files changed, 453 insertions(+), 230 deletions(-)
> 
> -- 
> 2.46.2
> 

