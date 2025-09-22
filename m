Return-Path: <linux-pci+bounces-36638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05182B8F8E7
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 10:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A5718949D2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CCA280317;
	Mon, 22 Sep 2025 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGW/pN/N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9FF27A10D;
	Mon, 22 Sep 2025 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529975; cv=none; b=p9pteEym5K5arJ9Uj3KFhvJPMPVWvBtZzoLpQ0YiFNToRprsyYvmtTBnTwkvMideQeG5w4qwCmsg6qsnvKen0I6BZpOC2XBbPeyzY3kndv9umSFQWvbKFYva9PUhMdlAszPJNv0hC2gWrrkgT8alu+USiaZqXG7F1DO8cIWE52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529975; c=relaxed/simple;
	bh=e4T4XJtILjw3AWw7ksxXP2XAAsN4pB2E1LrEQPZKKeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujSbUPvSTD0SR/aeW86itS7DPnnlpFRHlujpmQFHm1Me5FXi8M7smXwCO3w3yq8fmObA+EKVYrqM4KcgxoIbZRFAnAQDDq/J94w8MH43J5cmM1vZwEqZ+qb5FdmzsQbhTRpe+xpY7mDpkRUmniWskPBHT+t0DtGUa9IAj71YAsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGW/pN/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1FDC4CEF0;
	Mon, 22 Sep 2025 08:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529975;
	bh=e4T4XJtILjw3AWw7ksxXP2XAAsN4pB2E1LrEQPZKKeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGW/pN/Nc8u6WGuyuaDQQtAJjQTFBK/gPiG754tikHXuBFbLcQLqNF1LrO96YKYYR
	 Ux+rbMUD8vYAYlMKX6y4A86wxUTjHFOexdXUUCy3nuFgqi33mWmR6uGJQk2H4fHJur
	 LV7+UQfQrEiCyV6tlsEmnLft4QWdjvztTi9MoJU6et5siqBqyw65XlBMuNIOPbKGmj
	 dbEBn2ArMC8h4fexKLrFc/HIhrfwcXpOoEUDiKgR1QqpERnMnZA5zsqkgkMgARyj/i
	 nmOLH7Mr0W3KdSfhq90VBQu4b2IMIsfXx9vzlLhP+SGQhv4BOu3kxRD2343pBiQSV3
	 aZx5A/+9kLzSg==
Date: Mon, 22 Sep 2025 14:02:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, christian.bruel@foss.st.com, 
	quic_wenbyao@quicinc.com, inochiama@gmail.com, mayank.rana@oss.qualcomm.com, 
	thippeswamy.havalige@amd.com, shradha.t@samsung.com, cassel@kernel.org, kishon@kernel.org, 
	sergio.paracuellos@gmail.com, 18255117159@163.com, rongqianfeng@vivo.com, jirislaby@kernel.org, 
	Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v3 0/4] PCI: Keystone: Enable loadable module support
Message-ID: <3sjuplupmdoxqhyz2i2p4he5vw7krqokixoy6ddoiox6p536n6@xzfcyhwjx3hv>
References: <20250922071222.2814937-1-s-vadapalli@ti.com>
 <175852954905.18749.5091036983349477093.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175852954905.18749.5091036983349477093.b4-ty@kernel.org>

On Mon, Sep 22, 2025 at 01:56:08PM +0530, Manivannan Sadhasivam wrote:
> 
> On Mon, 22 Sep 2025 12:42:12 +0530, Siddharth Vadapalli wrote:
> > This series enables support for the 'pci-keystone.c' driver to be built
> > as a loadable module. The motivation for the series is that PCIe is not
> > a necessity for booting Linux due to which the 'pci-keystone.c' driver
> > does not need to be built-in.
> > 
> > Series is based on commit
> > dc72930fe22e Merge branch 'pci/misc'
> > of pci/next.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/4] PCI: Export pci_get_host_bridge_device() for use by pci-keystone
>       commit: c514ba0fa8938ae09370beecb77257868c1568a7
> [2/4] PCI: dwc: Export dw_pcie_allocate_domains() and dw_pcie_ep_raise_msix_irq()
>       commit: db9ff606a5535aee94bf41682f03aba500ff3ad6
> [3/4] PCI: keystone: Exit ks_pcie_probe() for invalid mode
>       commit: 76d23c87a3e06af003ae3a08053279d06141c716
> [4/4] PCI: keystone: Add support to build as a loadable module
>       commit: e82d56b5f3844189f2b2240b1c3eaeeafc8f1fd2
> 

I just noticed the build dependency mentioned in the cover letter after applying
the series. This is problematic since there is no guarantee that the dependent
commit will reach mainline first. So if this series gets applied by Linus first,
then building this driver as module will break the build. We should not have the
build error at any cost.

So I'm dropping this series now. Please repost once the fix is in mainline
(which will be next cycle).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

