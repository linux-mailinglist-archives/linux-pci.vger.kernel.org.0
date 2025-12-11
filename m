Return-Path: <linux-pci+bounces-42967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DDFCB677D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 17:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E716300161E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1692D6E6A;
	Thu, 11 Dec 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbSW91Af"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7382F2603
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765470594; cv=none; b=JoovqcckBDUjD4oS6SJ6MtJubBy9YD2npGV8oQ3idIHF7b0pK+c4KQafG8rzqSWf48IDmNkZhKwQWtSzcoklhCyrRurmDep32IJ7/wxNKV1RMEsvD8Fmd3yzaqnXHRCq9rHXFmRWAMS/7yM7TjJ3PWgVe8VQFucAksEzMMJqg2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765470594; c=relaxed/simple;
	bh=pePWAhUbegTiF58KkopomVFzJg4Dey8vXHM+/TnrM/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l+vScQqZqf/3eGJHH/CNoamDI7nsNBSQlSvy+w7gsGJAUqGoeajMmsSLWW0g487211UO7F48iYryHVJCHumSnwaR7b/fcAvmow4S1Mou2/b4HyFirgKwM79J6aaDXTMyxYUf8rLOCRU8PhIZz9QkxuisSPjkH+2JiJNFe6qEEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbSW91Af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F088C4CEF7;
	Thu, 11 Dec 2025 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765470593;
	bh=pePWAhUbegTiF58KkopomVFzJg4Dey8vXHM+/TnrM/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KbSW91AfhvgfAAy3su1kYwsH6vNlhe/0ACfaXr4F7jsCuRtc7TL3U2F842AHK3ixO
	 nCc2lb+pb3vyLY9EAEilB4KQw39hIEezdk771qhVIZ29xsC40NysKLdByzOFNAzpTM
	 jMGMEOjrf6bxefaxdDKpREppCHvK9tyuEcYGqFrb3VsY4Mmk8PlPp80G3HgXLlCa28
	 qMhv2dP2yLQVa+XhYtB5xnCp5jUNMlcq9TJkeN6tw5HsElM1JhP5EfpdRG0Bqqz89R
	 VXMGCorV8esN6wSz2QbrBl78j3/jGKcRTIitHLHgwGIn1x5FY2JdmHPo/LVk4PsEqa
	 wP7d77zS932Rw==
Date: Thu, 11 Dec 2025 10:29:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add L1ss context to ltssm_status of debugfs
Message-ID: <20251211162952.GA3595469@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1764035632-180821-1-git-send-email-shawn.lin@rock-chips.com>

On Tue, Nov 25, 2025 at 09:53:51AM +0800, Shawn Lin wrote:
> dwc core couldn't distinguish ltssm status among L1.0, L1.1 and L1.2.
> But the variant driver may implement additional register to tell them
> apart. So this patch adds two pseudo definitions for variant drivers to
> transltae their internal L1 substates for debugfs to show.

s/L1ss/L1 Substates/ in subject
s/ltssm/LTSSM/
s/transltae/translate/

Use imperative mood:
  https://chris.beams.io/posts/git-commit/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v6.14#n134

In this case, imperative mood means:

  s/So this patch adds/Add/

> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -380,6 +380,10 @@ enum dw_pcie_ltssm {
>  	DW_PCIE_LTSSM_RCVRY_EQ2 = 0x22,
>  	DW_PCIE_LTSSM_RCVRY_EQ3 = 0x23,
>  
> +	/* Variant drivers provide pseudo L1 substates from get_ltssm()*/

Add space before "*/".

> +	DW_PCIE_LTSSM_L1_1 = 0x141,
> +	DW_PCIE_LTSSM_L1_2 = 0x142,
> +
>  	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
>  };
>  
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

