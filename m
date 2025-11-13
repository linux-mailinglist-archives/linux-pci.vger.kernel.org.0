Return-Path: <linux-pci+bounces-41175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA783C59918
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2AE7354553
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943AF21773D;
	Thu, 13 Nov 2025 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sy4qYApc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E76635957;
	Thu, 13 Nov 2025 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059693; cv=none; b=t3jC18oK5/2jmZQs+uGs3g87EQrg3rMNMQi3tqazOp29fYxriPPhCu86xIZWZevPpuhDl0cdG4lvkQ70fUJXvtnAejun5UdbP5i+eA0C3V3QHuFh2NQBtVdRzDzExCirvIkYQkfq4uAoNaWU5U3gEFh6RZdf0t2CsXLbZKof+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059693; c=relaxed/simple;
	bh=ZruTlfRU5hPkW+XuRxMTGWrNG1rB4wG/83de4k1qrS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hhWXzjSMCcyiQBqN05fby+CZAt1evZmAlKBADeHb1xPL3cSTOr5WJgORX1PzjEQenNguhJkE1Z9Ze4xEIQS1WyKSTRzhnej12wyNf5scgf1peV/PqTJ2kiVi02D0wtpKDTLESzxsobQXPVMPjYbZZwGLcQYqwtjtWbv/UdNwjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sy4qYApc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72B3C4CEF1;
	Thu, 13 Nov 2025 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763059692;
	bh=ZruTlfRU5hPkW+XuRxMTGWrNG1rB4wG/83de4k1qrS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sy4qYApcRfWPdXBhESWfm2WIxzG2f+dLU4mU7qVwxV9KHviy8mqEr/qr+2JXYeMWm
	 pxsEZUKvWxfzR5xPwicrQB8YTiUUZZhuo64qwAqBT9K5V4lmK2SyHeaIxCoU3FYrcW
	 oF3proxO6XgPUej88gzvQVW58bGjOGfpvQs8Clkim9VEU+G/7OVS3uPTIOOVv9l3i/
	 DmCXwH6jLF6DjOdihR08DMmNq42TiYweRavxjI4NzlBQoe516yyuzevM0qTV6wrRSt
	 8lVLyxQl1AvrdlEEFCUumEx9r+KHNRdPFjTfnOYL/JSaybBZG6anH/eIVDFtrEonH4
	 30TIb15CGXSvA==
Date: Thu, 13 Nov 2025 12:48:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	christian.bruel@foss.st.com, krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com, shradha.t@samsung.com,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	fan.ni@samsung.com, cassel@kernel.org, kishon@kernel.org,
	18255117159@163.com, rongqianfeng@vivo.com, jirislaby@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v5 4/4] PCI: keystone: Add support to build as a loadable
 module
Message-ID: <20251113184811.GA2297285@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRYk4Xj1SNEFYW-J@shell.armlinux.org.uk>

On Thu, Nov 13, 2025 at 06:35:13PM +0000, Russell King (Oracle) wrote:
> On Thu, Nov 13, 2025 at 12:13:55PM -0600, Bjorn Helgaas wrote:
> > >  config PCI_KEYSTONE_HOST
> > > -	bool "TI Keystone PCIe controller (host mode)"
> > > +	tristate "TI Keystone PCIe controller (host mode)"
> > >  	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> > >  	depends on PCI_MSI
> > >  	select PCIE_DW_HOST
> > > -	select PCI_KEYSTONE
> > > +	select PCI_KEYSTONE if ARM
> > > +	select PCI_KEYSTONE_TRISTATE if !ARM
> > 
> > This is kind of a lot of dancing to make keystone built-in on ARM32
> > because hook_fault_code() is __init, while making it modular
> > everywhere else.
> > 
> > Is hook_fault_code() __init for some intrinsic reason?  All the
> > existing callers are __init, so that's one reason.  But could it be
> > made non-__init?
> 
> Yes. To discourage use in modules, because there is *no* way to safely
> remove a hook.
> 
> While one can call hook_fault_code() with a NULL handler, that doesn't
> mean that another CPU isn't executing in that function. If that code
> gets unmapped while another CPU is executing it (because of a module
> being unmapped) then we'll get another fault.
> 
> Trying to throw locks at this doesn't help - not without holding locks
> over the execution of the called function, which *will* be extremely
> detrimental on all fault handling, and probably introduce deadlocks.

Ah, thanks, I hadn't thought about the removal problem.

