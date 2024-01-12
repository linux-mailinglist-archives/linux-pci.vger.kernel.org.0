Return-Path: <linux-pci+bounces-2115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E33382C3D6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 17:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EF8B20C26
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA5D77622;
	Fri, 12 Jan 2024 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQf+km32"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636A7691B
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 16:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0A7C433C7;
	Fri, 12 Jan 2024 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705077669;
	bh=7w/LvlQ9s6P3Hf20yrIMzzAiJl1JDTKFW3alsqOC8Hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GQf+km32SQbPqKrfYTuUTASOXNYPsNLUASY4Nv6GYorIHUZ+/l93xrdxqWSkgI5aL
	 VwGJOGwmWv/cIKoGG7UnnZVSVA6/ltJotuEw13LQ+IlA8Pmn65r3tcTJ3808xJjh83
	 JKYJySLyQ9D0T3thzwN9hg7QmTO2r9i9faANNfdsbxRtMKC16QENplZEWyML/CLwlb
	 qnhvOIphoRYc9+MlGK9PdLJ7RVFoAZOKYPArYi9ZycoytQY/9o/zy5RJmLVvaTgZ/u
	 bQiaKdp4r2R9463FPttYFe28nRXKQs7NVKdTXV2jCXLNjxQs5w4P9xNhO7+jF63sdG
	 U9uf9I7qbPchw==
Date: Fri, 12 Jan 2024 10:41:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Cc: linux-pci@vger.kernel.org, chao.p.peng@linux.intel.com,
	chao.p.peng@intel.com, erwin.tsaur@intel.com,
	feiting.wanyan@intel.com, qingshun.wang@intel.com
Subject: Re: [PATCH 0/4] pci/aer: Handle Advisory Non-Fatal properly
Message-ID: <20240112164107.GA2271345@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111073227.31488-1-qingshun.wang@linux.intel.com>

On Thu, Jan 11, 2024 at 03:32:15PM +0800, Wang, Qingshun wrote:
> According to PCIe specification 4.0 sections 6.2.3.2.4 and 6.2.4.3,
> certain uncorrectable errors will signal ERR_COR instead of
> ERR_NONFATAL, logged as Advisory Non-Fatal Error, and set bits in
> both Correctable Error Status register and Uncorrectable Error Status
> register. Currently, when handling AER event the kernel will only look
> at CE status or UE status, but never both. In the Advisory
> Non-Fatal Error case, bits set in UE status register will not be
> reported and cleared until the next Fatal/Non-Fatal error arrives.
> 
> For instance, before this patch series, once kernel receives an ANFE
> with Poisoned TLP in OS native AER mode, only status of CE will be
> reported and cleared:
> 
> [  148.459816] pcieport 0000:b7:02.0: AER: Corrected error received: 0000:b7:02.0
> [  148.459858] pcieport 0000:b7:02.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
> [  148.459863] pcieport 0000:b7:02.0:   device [8086:0db0] error status/mask=00002000/00000000
> [  148.459868] pcieport 0000:b7:02.0:    [13] NonFatalErr           
> 
> If the kernel receives a Malformed TLP after that, two UE will be
> reported, which is unexpected. Malformed TLP Header was lost since
> the previous ANF gated the TLP header logs:
> 
> [  170.540192] pcieport 0000:b7:02.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
> [  170.552420] pcieport 0000:b7:02.0:   device [8086:0db0] error status/mask=00041000/00180020
> [  170.561904] pcieport 0000:b7:02.0:    [12] TLP                    (First)
> [  170.569656] pcieport 0000:b7:02.0:    [18] MalfTLP       
> 
> To handle this case properly, this patch set adds additional fields
> in aer_err_info to track both CE and UE status/mask and UE severity.
> This information will later be used to determine the register bits
> that need to be cleared. Additionally, adds more data to aer_event
> tracepoint, which would help to better understand ANFE and other errors
> for external observation.
> 
> In the previous scenario, after this patch series, both CE status and
> related UE status will be reported and cleared after ANFE:
> 
> [  148.459816] pcieport 0000:b7:02.0: AER: Corrected error received: 0000:b7:02.0
> [  148.459858] pcieport 0000:b7:02.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
> [  148.459863] pcieport 0000:b7:02.0:   device [8086:0db0] error status/mask=00002000/00000000
> [  148.459868] pcieport 0000:b7:02.0:    [13] NonFatalErr           
> [  148.459868] pcieport 0000:b7:02.0:   Uncorrectable errors that may cause Advisory Non-Fatal:
> [  148.459868] pcieport 0000:b7:02.0:    [18] TLP

Thanks for the overview here.  It would be good to put some of these
details in the commit logs of the patches that implement this, because
this cover letter is not preserved when the series is merged.

If/when you do, remove the timestamps because they're not relevant and
are merely distracting.  Indent quoted material a couple spaces.

Update the citations to a current spec revision (PCIe r6.0, or maybe
PCIe r6.1).  The section numbers are probably the same, but there's no
point in citing a revision that's 6.5 years old when newer ones are
available.

Bjorn

