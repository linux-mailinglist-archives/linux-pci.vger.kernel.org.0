Return-Path: <linux-pci+bounces-3445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490BE8549BA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 13:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD0228B43D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C653393;
	Wed, 14 Feb 2024 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz26F2Iq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65F52F81;
	Wed, 14 Feb 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915248; cv=none; b=AHxQFi4E1Dj5HZ2r9YIngRy6kqJBAhE40+yPFch5stzKFhoEdZezGe+skRMmCca4bcwxaJiAeuS7CqlASRw6uEOcoy9mJpeQ+Sq4fvd26seI6u96VyjCZOxQCxt7snID4pFut64bTOskrayPs6aBzEv5RUARmVX5GHLi5wFOWXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915248; c=relaxed/simple;
	bh=Jra6v3PLuIdfTUMCLPbuHtEJrWWs298/umdqjKiHzfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Twut/MN4dAa5BQwbdXzWJR6FzxUpw9T+MGkHwwI1Qga47iS3v/OgVIdq7mhF9tE7Meso5Onhan/NgHmzvxdNR75o5x3p344Njy/O5z/Oacf9nYiTqC6SCkXB5SyrvaJHDL37n3mMLm8wzVqTbroQqs9/DoMEhPKPpSWKAEv5x0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz26F2Iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CA9C433F1;
	Wed, 14 Feb 2024 12:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707915248;
	bh=Jra6v3PLuIdfTUMCLPbuHtEJrWWs298/umdqjKiHzfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lz26F2IqlJ/5YiIBXs3eQoGhiILAbJAbFe0tmJbbCql8OHSUkDsZ6D4G5DljflMgn
	 swWwAjpgkM/Rnb1FUzmq9FWeZtXDjVHPz30TRZjgyUPZuqxj3MPeWV0pvTAfz1Ar+R
	 ZiKBvgcQwtPSFme842EZE3BkesKCb+b1yLSpZE/y7tgDPPS/1R8NYOkFa2sB9A8KhX
	 +uFPu625QKMKaDf0YKYDObARIK6u4f8hnk6Tk8PYfJzhCYDU0Cp59PfwwNr8HJMkaI
	 m63+0x6X1UPNhvLkehCQt9eMr1KEbngXEzrCiL/OSrTQ/NvUpXUZcDAJb6PAFOeAfF
	 KWBc6fb/Yobsw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1raEmQ-000000004oS-1O2K;
	Wed, 14 Feb 2024 13:54:27 +0100
Date: Wed, 14 Feb 2024 13:54:26 +0100
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: PCI: qcom: Do not require
 'msi-map-mask'
Message-ID: <Zcy4Atjmb6-wofCL@hovoldconsulting.com>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
 <20240212165043.26961-3-johan+linaro@kernel.org>
 <e396cf20-8598-4437-b635-09a4a737a772@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e396cf20-8598-4437-b635-09a4a737a772@linaro.org>

On Wed, Feb 14, 2024 at 01:01:20PM +0100, Krzysztof Kozlowski wrote:
> On 12/02/2024 17:50, Johan Hovold wrote:
> > Whether the 'msi-map-mask' property is needed or not depends on how the
> > MSI interrupts are mapped and it should therefore not be described as
> > required.
> 
> I could imagine that on all devices the interrupts are mapped in a way
> you need to provide msi-map-mask. IOW, can there be a Qualcomm platform
> without msi-map-mask?

I don't have access to the documentation so I'll leave that for you guys
to determine. I do note that the downstream DT does not use it and that
we have a new devicetree in linux-next which also does not have it:

	https://lore.kernel.org/r/20240125-topic-sm8650-upstream-pcie-its-v1-1-cb506deeb43e@linaro.org

But at least the latter looks like an omission that should be fixed.

Johan

