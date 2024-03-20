Return-Path: <linux-pci+bounces-4939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF456880D37
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 09:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5011C20321
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAE4374C3;
	Wed, 20 Mar 2024 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABH2SvNM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E122079;
	Wed, 20 Mar 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924035; cv=none; b=K5pr/3Ui7GD9qzyPPfAumhT3VkuVSLZt4QQeectsewMu8gojB+k2WZhqsn2opH4IOhYF6YT5W7RG6UU+FXcdLvKa7hvoZSX1xCNhhW4kU23Iws7sY/NJZYi8y6y8EtE3zpt/Er9VaFA4WPNkl53cWy8GJTw+/DvXQiXkHiGJ2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924035; c=relaxed/simple;
	bh=EP6W5CkU5wj8hYaU2zzpBiXnfR5QSHzPvzGI68agMwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMFWUSR5rmTs8QTtN92UCgYwQIgq83mSCL/j2/kjOEgl9mx1EP7cQHhy/42WWpkLHr3cntT6jB7tHpgt3GEWPPCPIrFH80BdbIeyIMeM9SKyqSNS4/BklTX01vPak2sGmKZuv21YkDGdyptr+O/UavR/lGMBIcrf/ORFzGnDQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABH2SvNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527ABC433C7;
	Wed, 20 Mar 2024 08:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710924034;
	bh=EP6W5CkU5wj8hYaU2zzpBiXnfR5QSHzPvzGI68agMwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABH2SvNMymYgmtJ6ajtj9ila2dD/mori48MEJ9dIAMWSzUv+ba0K/iefBWK6zD1at
	 WcsrU0uB/z+xEOoU3hAXLeBgfRwAfGuJWZlAG7hgXD2zuQvqkZrNJD6Cd8ZzHyR82j
	 R5xdLZ0oMDHz4IYLD4FthcLeHeL6a1ccigN2bg5gNGtTkNMYfJC8tsj6AVFo9Kzsvn
	 dAGHCfNOtHXiNUA9aZkkZ6MvtDWlWYCLwJ5vBin6+lPsAYV/TGXtBujcQDEXQioG7x
	 qVOrWn01xElhqX+5HU0ndTfnGyCZ+9+rkNmHDL5t7RH7BC5YJUNRFAerVTvlZTZs83
	 /7LPob9MpugOw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmrV2-000000004B1-2Gwb;
	Wed, 20 Mar 2024 09:40:41 +0100
Date: Wed, 20 Mar 2024 09:40:40 +0100
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/5] arm64: dts: qcom: sc8280xp: PCIe fixes
 and GICv3 ITS enable
Message-ID: <ZfqhCKoEL4XGRs7T@hovoldconsulting.com>
References: <20240306095651.4551-1-johan+linaro@kernel.org>
 <171081652637.198276.6219023769904423414.b4-ty@kernel.org>
 <Zfk98hYPn7kiFGkt@hovoldconsulting.com>
 <9b475e13-96b9-4bce-8041-e0d8e5a332a1@linaro.org>
 <Zfqb8jPK50vlqu5Q@hovoldconsulting.com>
 <baf9c1bd-84ef-4ecb-b229-51a83fe82c3f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baf9c1bd-84ef-4ecb-b229-51a83fe82c3f@linaro.org>

On Wed, Mar 20, 2024 at 09:24:54AM +0100, Krzysztof Kozlowski wrote:
> On 20/03/2024 09:18, Johan Hovold wrote:

> > Perhaps you should not comment before reading up on the history of this
> > series.
> > 
> > This was all intended for 6.9, but merging was stalled for a number of
> > reasons so here we are. The patches were also going in through different
> > trees, so patch 4/5 is the first Qualcomm SoC patch.
> 
> Again, well, you sent it at few days before merge window, so how do you
> imagine this being applied for v6.9 and still fulfilling "few linux-next
> cycles before merge window" requirement? Especially that arm-soc cut off
> is much earlier :/. I talk about patch 5, of course, because that is not
> a fix (at least not marked as one). Don't expect in general a arms-co
> patch to be applied four days before merge window, thus the actual fix -
> patch #4 - should be split.

At the time there was still hope that there may be an rc8, and the patch
in question had been used by a large number of X13s users for several
weeks, which is a lot more testing than the average Qualcomm patch
receives, whether it's in linux-next or not.

And patch 5 depends on the earlier patches in the series so it belongs
in the series, which was also initially posted long before the merge
window.

I'm sure Bjorn A can handle this in general, even if he failed to notice
the CC stable tag or had other reasons for applying the fix for 6.10
instead of 6.9.

Johan

