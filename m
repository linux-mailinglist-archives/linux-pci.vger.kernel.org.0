Return-Path: <linux-pci+bounces-33389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A03AB1AA41
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 22:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599293A83E3
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 20:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98588238172;
	Mon,  4 Aug 2025 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn3KehDz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AFF2376FD;
	Mon,  4 Aug 2025 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754341024; cv=none; b=B/fJL3NGR5DirEW4596Cp7gu1ObhjXfihh1CKoTNrkpwj3IPSvHo7gL2qoorgjvDXQBy3ylPC+nwRYpbl1Hs6CiSMjIrnGUqaLaAEDErWePRejvstm/8npUPesCpZG8dDWmjRDxs8OEl6/4xuYjgQ+oi+jxnmYd2sDFCGb6DXCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754341024; c=relaxed/simple;
	bh=uD/eeGs14/ke/E/bSE2APe5YyfCJ6APCOIGAkSrY6QI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ekIXNuAaGROcD8ewSfA3tLVyCpBa/ayBaRvFlqzto/vyauTDJt/CYv65B2wdSD48onP6sp8jhVaueSjqGV8VZTqlTPwtor/Ug4kz32NGgk6WrirWDPGXnB4a1Y/pJszwntOF9sIumTaGwCz9oGKtF1IYaafWRnyjR1uLvgLWhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn3KehDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BA6C4CEE7;
	Mon,  4 Aug 2025 20:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754341023;
	bh=uD/eeGs14/ke/E/bSE2APe5YyfCJ6APCOIGAkSrY6QI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pn3KehDz6hnfQNL9lCppU6ubjpm163ZJONZVfmrgEDCSs6JOQfAAlLT51JlHTqE6V
	 kXJo3zGFUhjSXrs7Klsv/9RETgVrSBOtJRfHAhEFO4Yxq2Us1wjLz1qgOtn9+UtAjn
	 M32YqOR2RfvLLkPfUMbij5O+XaR+r/qcZCn7dN71jQY3OQkq6iIWIJNE9IGPiPLqs+
	 i1xMUGUzF8Ri+nFRwWOq3vTY3ZptxV37GY2Mxv8RicrufjWxpO/ZuU6dvzdhlSWK0k
	 WC63rBwdcBuaX/8Gv+ZHvj0j7qaVWJUTShBX6IVZDANNqwkJUR9LH3Mcwa9p5iVua7
	 dSgR+OIiN/c1Q==
Date: Mon, 4 Aug 2025 15:57:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Brian Norris <briannorris@chromium.org>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Frank Li <Frank.Li@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] pci: nwl: Unhandled AER correctable error
Message-ID: <20250804205702.GA3640524@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53f6d267-62af-4dad-8fa7-a2a497b22636@linux.dev>

[+cc more folks who might be interested in AER with non-standard
interrupts]

On Fri, Aug 01, 2025 at 01:43:19PM -0400, Sean Anderson wrote:
> Hi,
> 
> AER correctable errors are pretty rare. I only saw one once before and
> came up with commit 78457cae24cb ("PCI: xilinx-nwl: Rate-limit misc
> interrupt messages") in response. I saw another today and,
> unfortunately, clearing the correctable AER bit in MSGF_MISC_STATUS is
> not sufficient to handle the IRQ. It gets immediately re-raised,
> preventing the system from making any other progress. I suspect that it
> needs to be cleared in PCI_ERR_ROOT_STATUS. But since the AER IRQ never
> gets delivered to aer_irq, those registers never get tickled.
> 
> The underlying problem is that pcieport thinks that the IRQ is going to
> be one of the MSIs or a legacy interrupt, but it's actually a native
> interrupt:
> 
>            CPU0       CPU1       CPU2       CPU3       
>  42:          0          0          0          0     GICv2 150 Level     nwl_pcie:misc
>  45:          0          0          0          0  nwl_pcie:legacy   0 Level     PCIe PME, aerdrv
>  46:         25          0          0          0  nwl_pcie:msi 524288 Edge      nvme0q0
>  47:          0          0          0          0  nwl_pcie:msi 524289 Edge      nvme0q1
>  48:          0          0          0          0  nwl_pcie:msi 524290 Edge      nvme0q2
>  49:         46          0          0          0  nwl_pcie:msi 524291 Edge      nvme0q3
>  50:          0          0          0          0  nwl_pcie:msi 524292 Edge      nvme0q4
> 
> In the above example, AER errors will trigger interrupt 42, not 45.
> Actually, there are a bunch of different interrupts in MSGF_MISC_STATUS,
> so maybe nwl_pcie_misc_handler should be an interrupt controller
> instead? But even then pcie_port_enable_irq_vec() won't figure out the
> correct IRQ. Any ideas on how to fix this?
> 
> Additionally, any tips on actually triggering AER/PME stuff in a
> consistent way? Are there any off-the-shelf cards for sending weird PCIe
> stuff over a link for testing? Right now all I have 

This is definitely a problem.  We have had some discussion about this
in the past, but haven't quite achieved critical mass to solve this in
a generic way.  Here are some links:

  https://lore.kernel.org/linux-pci/20250702223841.GA1905230@bhelgaas/t/#u
  https://lore.kernel.org/linux-pci/1464242406-20203-1-git-send-email-po.liu@nxp.com/

