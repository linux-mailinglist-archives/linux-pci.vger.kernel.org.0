Return-Path: <linux-pci+bounces-3572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D8885769A
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 08:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3BF1F22E11
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 07:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A940914A9D;
	Fri, 16 Feb 2024 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alHXaPCN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596114A8D;
	Fri, 16 Feb 2024 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067543; cv=none; b=A9n51kLEy5N8PvcfjSl7ngi3iLJbyVZoCAIrVTLJ/5FX1mf9dx31lha/xU+O2YhtBtD3q4pweFbkgLj6ZLtzk5Rz/kldoT5QCQQgBhJZTCevLkju29qqGzt/b4KuxJszn4jHkekO46AMybk+doxuAeB+IQVyj7akx5wj8tLr2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067543; c=relaxed/simple;
	bh=HtwgK76BJgzohi2w2UJNqP9aZjmgBVag21pZ2hU95YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPDjDk/y5MKvY7R3ZhrJwbz6gKzZR3Q6k8bvUeqj9QAcQn54dVe5IBfaHdQgHOmgt+fSCvmfXUSH5LkhXRer2aBXV6ugL6nnyKrQ9gMYoP7qikmdswwv6WhSdRBsJZxx7WpRhFGZdnq2PdSdPHJXc6Wx0hmvatS+PNjOLOZVndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alHXaPCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBA7C433C7;
	Fri, 16 Feb 2024 07:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708067543;
	bh=HtwgK76BJgzohi2w2UJNqP9aZjmgBVag21pZ2hU95YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alHXaPCNsxUoOuKXujDeBdvf8UA1rowS1obpBU3eG71FeQ1/d7OWohJI7PEonR4Gt
	 oZSo4iq5D+yZiN/OMjirm7jHf2cnD8H+8BJOaISbD0fuCowvqUQENGWTXagnkXaV/O
	 r+Q5Tk1gCj6w4mFUQ1vBccpeA6m065snRq+inzFHS0rA26F6Dkzx7mOIGGp9/4mbJZ
	 9bF5nOUGMcApbbx6Oe0YbvcsvSvKYUvBctd5Zzfo+XfIE342vn5o/6x9n7creP0oXj
	 +8KqwLrAfpHlZXmN6R47xj87svi84n6NHqby8FscoHfpXVGf/XqOQjL5oNI9cg1dUK
	 igyMgPYzFiQ7Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rasOs-000000004Ug-1LYi;
	Fri, 16 Feb 2024 08:12:47 +0100
Date: Fri, 16 Feb 2024 08:12:46 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] arm64: dts: qcom: sc8280xp-crd: limit pcie4 link
 speed
Message-ID: <Zc8K7iiK4YbnadtQ@hovoldconsulting.com>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
 <20240212165043.26961-5-johan+linaro@kernel.org>
 <a2323580-6515-4380-a7d8-fd25818e9092@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2323580-6515-4380-a7d8-fd25818e9092@linaro.org>

On Thu, Feb 15, 2024 at 09:47:01PM +0100, Konrad Dybcio wrote:
> On 12.02.2024 17:50, Johan Hovold wrote:
> > Limit the WiFi PCIe link speed to Gen2 speed (500 GB/s), which is the
> 
> MB/s

Indeed, thanks for spotting that.

> > speed that Windows uses.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> 
> Hm.. I'dve assumed it ships with a WLAN card that supports moving
> more bandwidth.. Is it always at gen2?

I don't know how the Windows driver works, but the UEFI firmware has
brought the link up at Gen2 and that's also what Windows reported when I
checked. But I was not actually using the wifi when I did so.

But yes, it seems we may be limiting the theoretical maximum data rate
for the wifi this way.

As this appears to fix wifi startup issue reported by one user, and
allows us to enable ITS and AER reporting, perhaps that's acceptable
until the Linux driver can manage to scale the link speed (or we figure
out a more elaborate way of restarting the link at boot).

The PCIe link errors could also indicate that the wifi can not be run
any faster than this on these machines even if my guess is something is
wrong with ASPM implementation. Hopefully Qualcomm will be able to shed
some light on that.

Johan

