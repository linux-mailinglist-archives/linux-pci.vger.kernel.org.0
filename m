Return-Path: <linux-pci+bounces-42829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F059CAF305
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 08:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 239EC30109BD
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 07:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8872319644B;
	Tue,  9 Dec 2025 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+3TeinB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEDD22F01;
	Tue,  9 Dec 2025 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765266339; cv=none; b=hPTiIf/Srrs2M08SxuLFocX9O0d/LERQtT/XV4YTtrPKC3bZYu0s+ZiQe1Hbu9T8pMHcutuzm2DkF097v7qQely/AUgd7Yla6mABHC5aDgsU4zkdwnJ4/Gb6C9WNGN/TRsEdUjnezU7FI4MV/D0TVFSiU8xhpkv/Hqt6sfWn7fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765266339; c=relaxed/simple;
	bh=Yo7QujsU1IxW5dtrMTM5USn8VYa+1A0rsI10H/kNWL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1s5S2fCwmscz1tY0tNo/jpDdSei7XDVZdGCih9RsyfRfDs3cx3Bv3r0QwXkHrYqmQtea/gHHxaAvJaCA3R98JtWo1w4FrA9s7s7Aq8jfE3yzSjFdflzMoKLyJFynLuxdj78GqwfqZABDyWQPZkFk1VL7iDcie1zl8CoqaTXG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+3TeinB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12366C4CEF5;
	Tue,  9 Dec 2025 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765266338;
	bh=Yo7QujsU1IxW5dtrMTM5USn8VYa+1A0rsI10H/kNWL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+3TeinBB99sw9kcl6aOOCwj9AXTkaD3uxYmB2X125JZh+9UxFJ+0iKHgqosYTK0q
	 2SwmPPPGEgLhYdAJeMgT+RNmmvDG7uZipns26XEpYjh73lZY0kIl2Pj13x0U0GkL3o
	 IVcaQfsJx617QOL/Ev0hrJh2TbZWWNG9sMMpod9LXa30kg9sK/aOFIBWdngrCEdiBr
	 Dpvb2QahO4Q8PhsuL398NuRLSj6+MtcLr3cnukgX4MsaGvgpy+UKLHzzUgQIM4i2at
	 Ok52vwDD9ny7DQcU6DF+DpYcqRssMu+dcIZW5U2R2+bywkHYMfoUQOwt3Cx8NXNBoZ
	 yJPy3MA57uWHQ==
Date: Tue, 9 Dec 2025 08:45:33 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Val Packett <val@packett.cool>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki <naoki@radxa.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Make Link Up IRQ logic handle already
 powered on PCIe switches
Message-ID: <aTfTnZfLDlt24ZKw@ryzen>
References: <20251201063634.4115762-2-cassel@kernel.org>
 <5cdf685c-5a37-1b65-3e87-9262f3ed7bd4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cdf685c-5a37-1b65-3e87-9262f3ed7bd4@linux.intel.com>

Hello Ilpo,

On Tue, Dec 09, 2025 at 09:11:37AM +0200, Ilpo Järvinen wrote:
> 
> Now this patch looks interesting (and managed to catch my attention 
> despite being a controllers/ patch).
> 
> You're only talking about bus number allocations here but we did hit a 
> similar problem with bridge window allocations where not enough 
> information is available at the time of the initial scan + resource 
> allocation (currently it is one of the issues that prevents fixing one 
> resource overlap bug):
> 
> https://lore.kernel.org/linux-pci/8f9c9950-1612-6e2d-388a-ce69cf3aae1a@linux.intel.com/

I'm quite sure that Val's problem will be solved by applying:
https://lore.kernel.org/linux-pci/20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com/

If not, he could try applying the above series, and then this patch on top.


Kind regards,
Niklas


