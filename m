Return-Path: <linux-pci+bounces-42871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D644ECB1507
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 23:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B74EB30D2E15
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 22:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132122ED165;
	Tue,  9 Dec 2025 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leHe4lqq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F223717F;
	Tue,  9 Dec 2025 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765319995; cv=none; b=NrQc3xD0ZeMkmkFblzqQ8tTji4RsthSbY29B3YKHASy09c9BEQypEncL/dvRVuYQTVbUYx942/nV092WUGRnup9QnKkmt4kw/3QVT9VeFwrHvhI6bBBM48vusqOcSu17xWjaUIoxuXDhUsOHOX3FFPynJZkgzLt9Lq9InRWq98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765319995; c=relaxed/simple;
	bh=ABERVRepkPXCovsg5r9VdsLy2Fz/IAePmzBL1ZJjkG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rb8HqFTXAeq8axTMm6IF709qUv9pjERu4mnbANC6ym/1k9qn8wMH/SafvSlsDoXOna4/SeaYzbXNuj6ZpTOlQ5Y/hV2csb9Yk1XkDmqf+ymrpPnAdY1JAf3b42ad8HWVrU7xv+5Vi0j3MhWpJGF111Ya4pC7WzZjjyEmwinEB6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leHe4lqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCEBC19423;
	Tue,  9 Dec 2025 22:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765319994;
	bh=ABERVRepkPXCovsg5r9VdsLy2Fz/IAePmzBL1ZJjkG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=leHe4lqqqj2Hh5PPQ60ZsOUSKwM3XGJlUvIgbmsFN1BCo95ElmsayH8o06hPVsNZe
	 zW46quX6Y5LiE6iLuhgkqy2RiHPg2MRYuNjPSjlPojS+TacFRqUqcYxf+nlDyje7lE
	 z3K2C+xe6SJFK839cSWjV8a+tkI3LUYSlkWXdyCRatvk4Kq3PZbNH1kUq+ciw/Zeaq
	 9Dh7SULyp4/xlnPWaB4xsLV0R6Dqdu69h+glumZH7h6vgmxannp+L8pXPpwV/P3hfZ
	 86wsHl+kHIs57LT0bEe8gDNDskkmYl8Idttw0GkuDkjVyNbmUL9kAXST2aMI12ZhTD
	 zfl3Kc1hqAoKQ==
Date: Tue, 9 Dec 2025 16:39:51 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yao Zi <me@ziyao.cc>
Cc: linux-pci@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
	devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, loongarch@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: PCI: loongson: Document msi-parent
 property
Message-ID: <176531999095.1292172.5473670665283409608.robh@kernel.org>
References: <20251209140006.54821-1-me@ziyao.cc>
 <20251209140006.54821-3-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209140006.54821-3-me@ziyao.cc>


On Tue, 09 Dec 2025 14:00:06 +0000, Yao Zi wrote:
> Loongson PCI controllers found in LS2K1000/2000 SoCs
> (loongson,ls2k-pci), 7A1000/2000 bridge chips (loongson,ls7a-pci), and
> RS780E bridge chips (loongson,rs780e-pci) all have their paired MSI
> controllers.
> 
> Though only the one in LS2K2000 SoC is described in devicetree, we
> should document the property for all variants. For the same reason, it
> isn't marked as required for now.
> 
> Fixes: 83e757ecfd5d ("dt-bindings: Document Loongson PCI Host Controller")
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>  Documentation/devicetree/bindings/pci/loongson.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


