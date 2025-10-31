Return-Path: <linux-pci+bounces-39937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAE8C257AB
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 15:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18582560064
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D8B34BA5F;
	Fri, 31 Oct 2025 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csFRQq5m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA9521FF25;
	Fri, 31 Oct 2025 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919449; cv=none; b=FZlFIXpaztEdcWUJfnarPSvmf7+G1fXHbx/WyAbP2ppuU5IHG73QGVmEPRbe4a2Zr+qYjo5UvrpoJsi+10fEjzfxeC60fSPTxKSJEtYSX1QHnwATrYrfQlzlBuTlTQzCBUimCCzQVUpp+fs8nLq0SH9qDleh1sE98/U+HZ7mVuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919449; c=relaxed/simple;
	bh=uh/vIkS+8oLR/VFGSz+aNEFVesB8Edk9qotYTWYHoCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luXpmENhf0a4UviP408bkssW8JXnsIGpAcp0SkZ1tHulIl9EC7suw+6/v8p6MAdPVG39dA5MmJGPVO2gqzWyUKPWLeXMHC5JhQHQfW8c8q7om0Mtxq6GRTRYWxnIRG9ude1xVXb9vNVzZBW25dNys/OE4xoDPDCD6o1PgFVP0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csFRQq5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD99C4CEE7;
	Fri, 31 Oct 2025 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761919448;
	bh=uh/vIkS+8oLR/VFGSz+aNEFVesB8Edk9qotYTWYHoCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csFRQq5mNf3uyJvXxgKc2IXQuPc+Q0ODYGDrSPrgUHOgmot5b4GKMf3p+MuvjwGjK
	 EszzGYjKsAuCSuSxV6cIHLs2GUsL0a/W/fQhX3lYki6Y29YQt60PaUfdKLgwlupYI3
	 u3qg9LNm9lcrAGkN5eG5hE1gIdARc0agWndUb36yeWIRicFar7UYt42400/LvKijmH
	 KmUGy1VLbkDwC2jDbpCHuCtGrFPZmmGJtRzyRee+SmrbugyAHQHt9U88BDk1lTVrZT
	 viW6g8jWYj74LgUQF7e6DHgMtaoF1r64IfhGJfjI6CQk/uZ1uh/kD3s1aK/K/VIIae
	 72u1nLP8MDoxA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vEpjl-000000007o0-3v0V;
	Fri, 31 Oct 2025 15:04:17 +0100
Date: Fri, 31 Oct 2025 15:04:17 +0100
From: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 9/9] dt-bindings: PCI: qcom,pcie-x1e80100: Add missing
 required power-domains
Message-ID: <aQTB4dt-Oi1JCGFf@hovoldconsulting.com>
References: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
 <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-9-da7ac2c477f4@linaro.org>
 <aQJE5kkOGh76dLvf@hovoldconsulting.com>
 <20251030180827.GA110725-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030180827.GA110725-robh@kernel.org>

On Thu, Oct 30, 2025 at 01:08:27PM -0500, Rob Herring wrote:
> On Wed, Oct 29, 2025 at 05:46:30PM +0100, Johan Hovold wrote:
> > On Wed, Oct 29, 2025 at 04:40:46PM +0100, Krzysztof Kozlowski wrote:
> > > Power domains should be required for PCI, so the proper SoC supplies are
> > > turned on.
> > > 
> > > Cc: <stable@vger.kernel.org>
> > 
> > I have a feeling I've pointed this out before, but these kind of binding
> > patches really does not seem to qualify for stable backporting (e.g.
> > does not "fix a real bug that bothers people").
> 
> Presumably if someone omits power-domain and the driver doesn't work, 
> then it's a bug affecting them.

Yeah, and any such devicetree source fix would be a candidate for stable
backporting.
 
> I'm fine with dropping the stable tag because it will still most likely 
> get picked up with the Fixes tag. :)

Heh. I skimmed the 6.16 stable branch and it seems it was mostly
explicitly tagged binding patches that ended up being backported.

Johan

