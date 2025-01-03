Return-Path: <linux-pci+bounces-19254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C47A00E58
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 20:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4145164533
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 19:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B070C1FCCE4;
	Fri,  3 Jan 2025 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FstYDClT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE361FCCFF;
	Fri,  3 Jan 2025 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931754; cv=none; b=OGX40JNfgC2yBVjebx9v+nQ4EG/+qFXFb50JBy+uJ3/Ct2nl5ZT3i5t/ZxUniPvpFspBGpAFadLbFxjIvPkl7zT9psb+HfPXH3MPm3mUvi2oVUwXK1bZ2LHH4JQslXAg/Fpr4wFYAKjHGc9dYDNC/UQWkxj8sh1kKoSY4Ev5oNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931754; c=relaxed/simple;
	bh=sODcHv3eD4DFTFR6HBxazkE3MPaF9Q0OqjaQHEMWwyI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TRMBm977KwzRntgTfzWYw8GLlxq+dclDEycwudrYlGgG6zAtFHn3pfRNRNKML19H2SNPjYjbliq7cOS48z21ELjukEiEIkbGcFJQQlCnUbp3J9scUB6jRaalQc/QNSJul1uEOzg5mevEHouWyk7aZZkHwmR6bUTnDMVY0rFhtGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FstYDClT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE907C4CECE;
	Fri,  3 Jan 2025 19:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735931753;
	bh=sODcHv3eD4DFTFR6HBxazkE3MPaF9Q0OqjaQHEMWwyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FstYDClT78aLopDhhGTjpE22UMeJMS6nhpxD/I9u8E4g8ZeOPXdR7pu8f0M3RI/Xa
	 hTa1+DRy5tOrJZUBUUOnOAeV5344cNtX4AI5Gzvwvy6pas6eUkhuFSuKC3j1yPrFpy
	 F1usUWT8OQpeCuT92Pwo5DmxdWTxQvv88VZi69R0oEm1QazYEXJh0SrgoMwcKLfvpS
	 3b66UB+Cqxr9B4CGtoNPQO19f85wgzZeke6bD2WgX0aI1P+NgoCaehWub0RbCahqk4
	 ke823l9BBvoWDxAqAXjIqVFfdQZ24v1bX7NuPXixtbzGY5sngx61rYScGjW8hb7JYC
	 Q6W7FWF/NDstw==
Date: Fri, 3 Jan 2025 13:15:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Xavier Chang <Xavier.Chang@mediatek.com>
Subject: Re: [PATCH 3/5] PCI: mediatek-gen3: Disable ASPM L0s
Message-ID: <20250103191552.GA4190763@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103060035.30688-4-jianjun.wang@mediatek.com>

On Fri, Jan 03, 2025 at 02:00:13PM +0800, Jianjun Wang wrote:
> Disable ASPM L0s support because it does not significantly save power
> but impacts performance.

This seems like a user/administrator decision, not a driver decision.

L0s reduces power at the cost of performance for *all* PCIe devices,
although the actual numbers may vary.

