Return-Path: <linux-pci+bounces-10218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E86A893008D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 20:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AE80B227D4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B32618C08;
	Fri, 12 Jul 2024 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwgfdLSn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1779A2C6B7;
	Fri, 12 Jul 2024 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720810132; cv=none; b=ewwkjsCQws07JGEuz0itzVC0ch9T/zUCcV4yaTjLLZ2z1bwtrstBzwGrVtfmQkthk6S1xkuoJ+nGovhHG2TDm8E6nEZ3iv6Ty0N28S4v9l+BPtpwM1ryaBueA49PpczGHt/lHvMlDMQzz5o22E9YfQqNciblVHX2UzMF5LAc3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720810132; c=relaxed/simple;
	bh=gdz48EmSjgoy/izHwN+e2FaoXzRR7IwtCVpXbxR4jNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kReOD4NpX//EqNVz0+l7MHVv470RjFnyCBCUzfPZk+y+/pCQc0gvsWbJzssXXMqm6tmIYSGNVUYt8xWnN+Otat1yXWKQBBufKAUgpULJX8BWjHtprH2tf+xjBHFhewoZTXwYJctWa6KgCwLTVmwQ9GBiwufOb4fN9V+qQL0Uilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwgfdLSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6DDC32782;
	Fri, 12 Jul 2024 18:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720810131;
	bh=gdz48EmSjgoy/izHwN+e2FaoXzRR7IwtCVpXbxR4jNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MwgfdLSngAJm7yURAc4SXppRMHlTQEY1QwDeu8yJ5QAl+eUNgYr0Kb3ChYE1BlOxa
	 i16UNmPCS1L3cNiJxB/u8Z83Oa/GdVyRhhUr2uUWLQpv3yPibtSL8ZwR1pvLCMr2JS
	 QNV+ogiYb0+qDbl5jxOfBv9Ak4QSINyZgSWqRlswxuBusurJDmP9bpOc/oJ1EEpYCX
	 zIJciBobInXEx8PbnKk2vIoJHINughAaULKb2tF8I4SyO0YKl/XIjYUFS+YNaQ/t2r
	 EI9Pz3O0A/bqBfHSBb4+4kjPImrdubMa5z3OD2tOfscbnWziKSZTDfM1iUEO2nCL0r
	 1c9NXyLfziWZA==
Date: Fri, 12 Jul 2024 13:48:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lkp@intel.com,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4] Subject: PCI: Enable io space 1k granularity for
 intel cpu root port
Message-ID: <20240712184849.GA330337@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240702035649.26039-1-zhoushengqing@ttyinfo.com>

On Tue, Jul 02, 2024 at 03:56:49AM +0000, Zhou Shengqing wrote:
> This patch add 1k granularity for intel root port bridge. Intel latest
> server CPU support 1K granularity, And there is an BIOS setup item named
> "EN1K", but linux doesn't support it. if an IIO has 5 IOU (SPR has 5 IOUs)
> all are bifurcated 2x8.In a 2P server system,There are 20 P2P bridges
> present. if keep 4K granularity allocation,it need 20*4=80k io space,
> exceeding 64k. I test it in a 16*nvidia 4090s system under intel eaglestrem
> platform. There are six 4090s that cannot be allocated I/O resources.
> So I applied this patch. And I found a similar implementation in quirks.c,
> but it only targets the Intel P64H2 platform.

I think this has potential.  Can you include a more complete citation
for the Intel spec?  Complete name, document number if available,
revision, section?  Hopefully it's publically available?

> Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
> ---
>  drivers/pci/quirks.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 568410e64ce6..f30083d51e15 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2562,6 +2562,36 @@ static void quirk_p64h2_1k_io(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1460, quirk_p64h2_1k_io);
>  
> +/* Enable 1k I/O space granularity on the intel root port */
> +static void quirk_intel_rootport_1k_io(struct pci_dev *dev)
> +{
> +	struct pci_dev *d = NULL;
> +	u16 en1k = 0;
> +	struct pci_dev *root_port = pcie_find_root_port(dev);
> +
> +	if (!root_port)
> +		return;

This doesn't seem quite right to me.  The point is to set
dev->io_window_1k when "dev" is a Root Port itself and when the EN1K
bit is set in a [8086:09a2] device.

So I don't think we need to *look* for the Root Port, we just need to
check that "dev" itself *is* a Root Port, e.g.,

  if (!pci_is_pcie(dev) || pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
    return;

> +	/*
> +	 * Per intel sever CPU EDS vol2(register) spec,
> +	 * Intel Memory Map/Intel VT-d configuration space,
> +	 * IIO MISC Control (IIOMISCCTRL_1_5_0_CFG) — Offset 1C0h
> +	 * bit 2.
> +	 * Enable 1K (EN1K):
> +	 * This bit when set, enables 1K granularity for I/O space decode
> +	 * in each of the virtual P2P bridges
> +	 * corresponding to root ports, and DMI ports.
> +	 */
> +	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {

To be safe, "d" (the [8086:09a2] device) should be on the same bus as
"dev" (with VMD, I think we get Root Ports *below* the VMD bridge,
which would be a different bus, and they presumably are not influenced
by the EN1K bit.

> +		pci_read_config_word(d, 0x1c0, &en1k);
> +		if (en1k & 0x4) {
> +			pci_info(d, "INTEL: System should support 1k io window\n");

If we log this, I think it should be with "dev", not "d", since we
likely will have several Root Ports, and this would lead to several
identical messages.  Maybe something like this:

  pci_info(dev, "1K I/O windows enabled per %s EN1K setting\n", pci_name(d));

> +			dev->io_window_1k = 1;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,	quirk_intel_rootport_1k_io);
> +
>  /*
>   * Under some circumstances, AER is not linked with extended capabilities.
>   * Force it to be linked by setting the corresponding control bit in the
> -- 
> 2.39.2
> 

