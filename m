Return-Path: <linux-pci+bounces-5400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA8C891AEC
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 14:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8893DB262E1
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 13:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5890A161323;
	Fri, 29 Mar 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCoS01yL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F116131F
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715617; cv=none; b=JAtVtMROqZ3OhiJTYvU4WS2BbzwDJ6kPtWypCwCO6r9oN61Itx6RMvAxMoX2z04AHmdHWWgMq6z1CP1ZM7J3g1e8VdH5S54n/D+lO1o9z0G6YI7iZcdwzxn36nYYLWSpPJufnbwC5VjdXaqQocNHL/HzHEi61JFbJ2swSAiEFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715617; c=relaxed/simple;
	bh=0t7MXM/aLNu5a23txLPE25mlHB94/qJWGAlsmICZDFw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=APOvnGb+m1j/BZSAlluGxpUBIfgMLoBQv8GQ+vbfQMzt7HXLJw6veR91k1NQ9L1FYG8W0Vm53OQDl8Y1f6zutAcgOLPpEuAxQcC90+RQAe/LkK9Q9Q1fFs1hapHOHzoo7LOuNz80BUidRySRVAbYqfq1A5WAU+b/WsAqj0TF6b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCoS01yL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB992C433F1;
	Fri, 29 Mar 2024 12:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715617;
	bh=0t7MXM/aLNu5a23txLPE25mlHB94/qJWGAlsmICZDFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rCoS01yLhRpHwD3y+xUjTocfIjUpKz+FM2UZyiztDCo6bgH/jOeBctL4k8F28Mxu9
	 PoOTzHcMCAV3rXPpXgP/MoqLV4qsoCXP8Dkl9sVR9FHwdEmI806TJpQNFsj+0rvzFe
	 4OKWLO7PIXrFhnR4kUCIs4UpEl5SahkBf246+AoyfG5fqnfTYXakoA6fEgsjMZ6V7L
	 MiyWGnzwADiL3gOqXBaO3V4QcQP6S5ZgIZe6HDsLNAUmweYO2TZYSLdoxlpRImzD42
	 UEgcBoG3sS3XFYm8sM4/U5EcT8a5jgN3AEzYd3ecehz88fK5JRa3wz178rGE28W0a7
	 3neMCygCaWmtw==
Date: Fri, 29 Mar 2024 07:33:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 01/19] PCI: endpoint: Introduce pci_epc_check_func()
Message-ID: <20240329123335.GA1638817@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329090945.1097609-2-dlemoal@kernel.org>

On Fri, Mar 29, 2024 at 06:09:27PM +0900, Damien Le Moal wrote:
> Introduce the small epc core helper function pci_epc_check_func() to
> check that an epc pointer, a physical function number and a virtual
> function number are all valid. This avoids repeating the code pattern:

Can you rename pci_epc_check_func() to something that suggests an
assertion that can be either true or false?  "Check" doesn't give a
hint about what a "true" return means.  Maybe "valid_func" or similar?

Bjorn

