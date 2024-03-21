Return-Path: <linux-pci+bounces-4975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F85886050
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 19:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD6DB22A00
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E351332B8;
	Thu, 21 Mar 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZwHZa4D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5CC1332A6;
	Thu, 21 Mar 2024 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044454; cv=none; b=UNPWmesNqp+gpAmZ1LCVzNd8w9x/u/FaHuxhiArQtiejVzR63YdHuRWC3SNCqMZyJQXODgHXLI9frfLMhz2kBT6gO8E0C1s6q6YTQZNqB8Wj9q81HkbRgs/N/Rg3fDF2yWBfI55PV4yzv1M/MXmLYjdk0Er1cI3BH1BUKFONCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044454; c=relaxed/simple;
	bh=Vre0bbpj/RHcM0b8xIt3T8ZHT/uKOL2/xho9jNKOy7I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qZ+yyuSn4m/hcoORSrvY7QiXwtfiZh+25PavHOxZN1Bc9BrjUHK7o51X2kKXx6oGg39MDly7lzUuiR1/x0S/J5Ed5EO4+F2NIpMx7k8U4sscbSqSjQAGds8Q6IF7fv/BbudPCM4KbxBwjkNIHAGkOlu83L0UZ0keKJJzB+xhQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZwHZa4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600ECC433F1;
	Thu, 21 Mar 2024 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711044454;
	bh=Vre0bbpj/RHcM0b8xIt3T8ZHT/uKOL2/xho9jNKOy7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bZwHZa4DGdc1+POLrg1fU5cxYlcVXhNYn2Q8g7wr0BHoyw7DlTGMU9Si9QxGJrezN
	 0N1NXNbHW7h19po3hbpHk5A9b66DFGlyRzCh84lo/BLGpIO0AiwD2ETbAMvhV8pK2s
	 T1ZSXNGLmLdKt9Qz+YsiI+yrgOogPxYs/L0wdJ8FZ4jFl4+9paHHZMFfgPyDjQqkqn
	 D3LWXMWloKiEwsU8yx8OjQr6PEUI9XHHgkvLh3u3DrDg8GrMmu2u5innfjvE+3sDQQ
	 MsqzEVTEN0gLMrQOW+jVKjOrfUkgfruSZLqK2WTwLnuLNTGbOcTtO54Hifq7eV0FJI
	 9OFEWmR2jJXvw==
Date: Thu, 21 Mar 2024 13:07:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, niklas.cassel@wdc.com, bhelgaas@google.com,
	gustavo.pimentel@synopsys.com, imx@lists.linux.dev,
	jdmason@kudzu.us, jingoohan1@gmail.com, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <20240321180732.GA1329092@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321171345.GA2385@thinkpad>

On Thu, Mar 21, 2024 at 10:43:45PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 04, 2024 at 05:46:16PM -0500, Frank Li wrote:
> > dw_pcie_ep_inbound_atu()
> > {
> > 	...
> > 	if (!ep->bar_to_atu[bar])
> > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > 	else
> > 		free_win = ep->bar_to_atu[bar];
> > 	...
> > }
> > 
> > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > will return 6 when second time call into this function if atu is 0. Suppose
> > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > 
> > Change 'bar_to_atu' to free_win + 1. Initialize bar_to_atu as 0 to indicate
> > it have not allocate atu to the bar.
> 
> I'd rewrite the commit message as below:
> 
> "The mapping between PCI BAR and iATU inbound window are maintained in the
> dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for a
> BAR, dw_pcie_ep_inbound_atu() API will first check for the availability of the
> existing mapping in the array and if it is not found (i.e., value in the array
> indexed by the BAR is found to be 0), then it will allocate a new map value
> using find_first_zero_bit().
> 
> The issue here is, the existing logic failed to consider the fact that the map
> value '0' is a valid value for BAR0. Because, find_first_zero_bit() will return
> '0' as the map value for BAR0 (note that it returns the first zero bit
> position).
> 
> Due to this, when PERST# assert + deassert happens on the PERST# supported
> platforms, the inbound window allocation restarts from BAR0 and the existing
> logic to find the BAR mapping will return '6' for BAR0 instead of '0' due to the
> fact that it considers '0' as an invalid map value.
> 
> So fix this issue by always incrementing the map value before assigning to
> bar_to_atu[] array and then decrementing it while fetching. This will make sure
> that the map value '0' always represents the invalid mapping."

This translates C code to English in great detail, but still doesn't
tell me what's broken from a user's point of view, how urgent the fix
is, or how it should be handled.

DMA doesn't work because ATU setup is wrong?  Driver MMIO access to
the device doesn't work?  OS crashes?  How?  Incorrectly routed access
causes UR response?  Happens on every boot?  Only after a reboot or
controller reset?  What platforms are affected?  "PERST# supported
platforms" is not actionable without a lot of research or pre-existing
knowledge.  Should this be backported to -stable?

Bjorn

