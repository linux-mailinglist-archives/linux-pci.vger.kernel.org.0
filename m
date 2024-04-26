Return-Path: <linux-pci+bounces-6707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2494D8B4256
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 00:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2979A1C21DFA
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 22:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B38727721;
	Fri, 26 Apr 2024 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifll98HQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C073987B;
	Fri, 26 Apr 2024 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171668; cv=none; b=ChnUGvBYDptmesORhvfgr09ii7U5ypJeeaI+xMD/voO7oNAyjY4g9gJI9qDHmWmYktct4l7gUjAnnn59cfe00pl0oU8nQi8yfaWwIxUxPa5Kfd+UFT19+fPIv9NP6b3MqVobwdqR9DZisd7lzuXzXgNv6Xo4CfBEzk/7TQGGte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171668; c=relaxed/simple;
	bh=yQE9PcLddlqN+PjCL2wReDNOleVRYw7TxRmvpGTP2kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X30lyTFI5CvuVREGFAweZv4qcZdiWJ9XiEWWTugx3HdejCmtlTAN+nhIn9rAJ5giYI21+txk35KYklBsixPoLiD2ld8oQDB3y6zzURbrsoPeDInXEQd8hPCqEdKxLm4OlReRBahPiaUZSJZU8+WtYGih8QvMRBRofzlZqneaoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifll98HQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C906C113CD;
	Fri, 26 Apr 2024 22:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714171667;
	bh=yQE9PcLddlqN+PjCL2wReDNOleVRYw7TxRmvpGTP2kQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ifll98HQNoPtaFrvJKYgNdp1fbYND85HXjZGlEB8//OewHQRBhyw8SH2woc5dB4OH
	 Lnu90GwsjucyG5unuHJrLCu5J9OhMWCT2fehQGrdgcyaGLrwR58+3FYQs5e/uc6+3m
	 QY4n2PBYcTe3Cw0/38IQsAJhUn7qenmF95d/BsUvsZ20XxjGafYloHeUvyW+hf8KJK
	 28s7ZXajI9iuEMxLXcwLXnEkUxV9bP132JTnKg7vM6P+a9qrQCnt03hJEMqZdfbw79
	 Vxy2iQBLE1AQIn3RxSjRKji3vZUS+dS6h15y696/ulumtlRnFdMVW6AJKRhdLQOVK6
	 ZjYBOFOIUT4jA==
Date: Fri, 26 Apr 2024 17:47:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Aleksandr Mishin <amishin@t-argos.ru>, Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] PCI: dwc: keystone: Fix potential NULL dereference
Message-ID: <20240426224746.GA611050@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63b89455-3e30-421a-a082-00d39e836e20@intel.com>

On Thu, Apr 25, 2024 at 03:00:14PM +0200, Alexander Lobakin wrote:
> From: Aleksandr Mishin <amishin@t-argos.ru>
> Date: Thu, 25 Apr 2024 12:21:35 +0300
> 
> > In ks_pcie_setup_rc_app_regs() resource_list_first_type() may return
> > NULL which is later dereferenced. Fix this bug by adding NULL check.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Please stop spamming with "potential fixes" made mechanically from
> static analyzer reports without looking into the code flow. These
> patches are mostly incorrect and may hurt.
> Either have a stable repro and then fix the real bug or don't touch
> anything at all.

Did you look at the actual patch?  I'm not a keystone expert, but this
patch looks reasonable to me.

It might still be the case that we're guaranteed to have an
IORESOURCE_MEM window by other code, but it looks like a real hassle
to prove that.

> > Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
> > Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> 
> Thanks,
> Olek

