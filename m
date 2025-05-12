Return-Path: <linux-pci+bounces-27595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A622AB3E87
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 18:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0685519E706A
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401932550B9;
	Mon, 12 May 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xof2zoF9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB319DF5F
	for <linux-pci@vger.kernel.org>; Mon, 12 May 2025 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068998; cv=none; b=dkTWLNYmpjRTvRgD2DEkhrEnqJZC7vAopadmM6sMFSYi9t+YugrDL4zRFdl9R/gFasGfn58ogJxH6qQLGOluQIwhB5wdWOzSi8xq1CAr7EswsW194eRRY9N0TBxUNEWe8Anw5pd84ovc7PONDfh1tLldixsCq9ZCpUgEQf2EgMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068998; c=relaxed/simple;
	bh=UeaLOSPUx4RzD0GIMXirZzXMi49139CMlUy1uiBn+WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixquoivmn5pZZUGuMiOyvRUdpYOHGyFGh7KMnN07tKLnexyJIyNhtCtMANSFBd7KlOsi+rpGHZhKcKp75aZRYT/0HQkS64XGQkme5SQn9isWp2dOoCTWpci1bFnkyZls4Tq2ADYheBWh45dPRxIfPs5wt3bkkmnfMCnH5c8yICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xof2zoF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2C9C4CEE7;
	Mon, 12 May 2025 16:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747068997;
	bh=UeaLOSPUx4RzD0GIMXirZzXMi49139CMlUy1uiBn+WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xof2zoF9YhwBWvY13M0P5qLpKL1xjfCgd6REGHqHnYiENsEVA4UWnXYemWB6T3Dlk
	 scioDPEVNYOuLPApHWiZalsbh//1ZvMxFlEwufcdws31zmu+EenvN6xzqeYOU+XXTz
	 Q3VB1IarqQ32CnwcimNUiOMZgAiwQL66E2Q2/OX9XifQErSO7vUuTSL1O2tBh7SFT8
	 fx33f8kJkpeIePtr77Te8JC2MOJzHc5Ae0J5vaFMWywUQhp01klpelAhPjf/bv4OJs
	 WBD96O2l0HLVvLXDe1Nu1jnNQg+32ieNjnQnA0256QO+o/yTLEdlH7Y3R6xmkoTWNc
	 wbEVqEH9oOLNA==
Date: Mon, 12 May 2025 18:56:32 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>, dlemoal@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix broken set_msix() callback
Message-ID: <aCIoQFmr3ebXepzd@ryzen>
References: <20250430123158.40535-3-cassel@kernel.org>
 <tmtm4od4paptgbiodq5cezltsy6njoyeet7mcsq7rq3m7zcz5z@thpqdtzpskgx>
 <aB8762GD_iI5G5LY@ryzen>
 <kgw4y5mrvt3g6vnnkiaicufticbpyc5vmhbo6ee4g7ayg2hntt@fogtz5lizk5f>
 <aCG_PC3llyx3bs34@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCG_PC3llyx3bs34@ryzen>

On Mon, May 12, 2025 at 11:28:33AM +0200, Niklas Cassel wrote:
> 
> (Would be nice to get this fixed queued first though, so cleanup patches can
> come on top.)

I'm done with the cleanups,
but since you wanted me to rewrite the commit message,
let me send out a V2 which has the strict fix as the first two patches
(i.e. the two patches in this series),
and then put the cleanups on top, so that it will be a single series.


Kind regards,
Niklas


