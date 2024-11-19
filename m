Return-Path: <linux-pci+bounces-17067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C83FE9D22A2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 10:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66BA2B21C64
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 09:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7591B654E;
	Tue, 19 Nov 2024 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnguySwH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995B1B4F1C
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009483; cv=none; b=tqhMPUxRA3Z7l/Wwj88qU9yMYwjOyLdVksgofqVocBOZES8t9nvDv+Rr9qXr94XHNIAu4jWGPEe4fYCMuNuqzNsmG6N05cFNTVk4Od0FC61Jyu3N0MwKUMNVMAFTpa4gpcvGH3MG6Hrhu6/XQa3DvVOwvEkRRqzSalNRmMv0/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009483; c=relaxed/simple;
	bh=dhLTeGIesvqz4h0uovukT8hecVNwnA+v2QmIoMYp0Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tjaugYnxKMmGKYlFv6sj3LoL3tmlhoil+aJ1QVx3xd7dVNJrDY4tzvSXB4LuWb1/uMWhWoDnqJhIft/d4tRvHzBEs4I4rUAVLKt3yUbXtMeWqljoV29gIUfiZUWzTWHjge0CnaM/k2rITYnWizkIOVIFf05pTfRtiWG5RZMAsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnguySwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D93C4CECF;
	Tue, 19 Nov 2024 09:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732009483;
	bh=dhLTeGIesvqz4h0uovukT8hecVNwnA+v2QmIoMYp0Gk=;
	h=Date:From:To:Cc:Subject:From;
	b=SnguySwHbjhAsbF+Y3daTuGSo3v5xVC5U46ZWlHsEfN/fk3WykJhGiZ4BZ+5aSWLL
	 q46Njl8Ylp3XIN8kqaODmHNjPd91gclMH98adQcb64ToFUyWD5vO+/50azchO1MmX/
	 J6y70mAEjG6TWfHnGQEypWBLs/Z7ox7ltm3yexVzi668Mot/SSumTCQdOqLT1uovSV
	 JP5tY3SiXmJ46GjfIpLlZ6QY/AH4CMsh+krxXsfTHsThwh6G6h5YDkN5WL3bjvOUiX
	 0Zn7HQcBN3EskIvXr4pGKoA/uPquSwBoJe38FtUM9vQUp0unole1HmISB+jnFTBd8Q
	 wW3wpRMYT4RFg==
Date: Tue, 19 Nov 2024 10:44:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Jon Mason <jdmason@kudzu.us>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org
Subject: DWC PCIe endpoint iATU vs BAR MASK ordering
Message-ID: <ZzxeBrjYRvYgMFdv@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello DWC PCIe endpoint developers,


As I wrote in patch [1] (please review):
The DWC Databook description for the LWR_TARGET_RW and LWR_TARGET_HW fields
in the IATU_LWR_TARGET_ADDR_OFF_INBOUND_i registers state that:
"Field size depends on log2(BAR_MASK+1) in BAR match mode."

I.e. only the upper bits are writable, and the number of writable bits is
dependent on the configured BAR_MASK.

While patch [1] is a nice fail-safe that we definitely want to have...
I can see that the DWC PCIe EP driver is currently broken (and has been
since the beginning).

We are programming the iATU _before_ configuring the BAR:
https://github.com/torvalds/linux/blob/v6.12/drivers/pci/controller/dwc/pcie-designware-ep.c#L232-L247

The problem is of course that the iATU registers depend on the BAR mask
(the number of read-only bits depends on the currently set BAR mask),
so the iATU registers should be done _after_ configuring the BAR.

Doing it in this was makes a lot of sense.
First you configure the BAR, then you configure the address translation
for that BAR. (Since the iATU in BAR match mode obviously depends on how
the BAR is configured.)


Now, I would like to send a patch to change this order, so that we actually
write things in the only order that makes sense, my problem is this line:
https://github.com/torvalds/linux/blob/v6.12/drivers/pci/controller/dwc/pcie-designware-ep.c#L236-L237

This code makes no sense to me whatsoever.

If I look at the commit that introduced this early return:
4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")

It is not signed off by any of the regular PCI maintainers, neither does it
have any Acked-by by any of the regular PCI maintainers, so I kind of wonder
why this patch is there is the first place...
(Taking something via a different tree is fine, but that would still require
an Acked-by by one of the maintainers for the tree which owns that file.)

While I am tempted to simply send a revert for this commit, so that we can
write the registers in the correct order (iATU after BAR mask), I still do
not want to regress the NTB EPF driver (even if the commit appears to have
bypassed the regular PCI maintainers).

Frank, since you are the author of:
4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")

Please advice on what to do here. The only thing that makes sense to me is
that dw_pcie_ep_set_bar() always writes the BAR MASK. If dw_pcie_ep_set_bar()
does NOT write the BAR MASK, we depend on whatever BAR MASK was there before
dw_pcie_ep_set_bar(), which no matter how I look at it, seems horribly wrong.


Kind regards,
Niklas

[1] https://lore.kernel.org/linux-pci/20241116163558.2606874-10-cassel@kernel.org/

