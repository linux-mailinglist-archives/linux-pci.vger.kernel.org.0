Return-Path: <linux-pci+bounces-4854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525AF87D16D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 17:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063751F26B17
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 16:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAFB3D579;
	Fri, 15 Mar 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYMrTgRi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD928F1;
	Fri, 15 Mar 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521264; cv=none; b=JntgiFsXtl7F824DeAECqn03nhkQWEmdwJGPjuRDRNhzvMm7+a25sADovINWZhA1Qk68cfgoa2mMfXkPmf/kyzC0e3fsBkIBMcJUlQB3BEVoMY9dVgbonZjaknDBXiO4OcDfoH9Qb1cQFwkDW6M3oyacP2suTNAB8YUR9x4legM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521264; c=relaxed/simple;
	bh=JL5eSL26L69YUqhQ5+zJQo9l0y8hKk3BZ+EnlZ3I0ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgX752XL4uINe/JMTIx/fTAia9Rmhmzv+1qLbDvVzIoOx0CQ3YAlt3JFlzjO+VuvVt/8IXIuQ3Qtf4rbQvrk2HnJgGPU7M8n+GoZFMAEX9bXXJSka5KWuDESQQ5wyxVdQEezJ+VcGZbK3RP1ql34dB40eOb72D6vd8HTKnjOj4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYMrTgRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA8AC433C7;
	Fri, 15 Mar 2024 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521263;
	bh=JL5eSL26L69YUqhQ5+zJQo9l0y8hKk3BZ+EnlZ3I0ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYMrTgRi1fAF0uJpaHYkRyXi7WMU9CRq/YAAwuGPJ96W4PBq+7ovToG4kCo/Wh9he
	 0FQhO8q2MPRkIiOYC/kBvrSn17yLoSkOuf8FKSraqnI1nDrVkmSWd3b9HAIjxCrUcW
	 GTxUZ399ds/6rak0w56+JGj/BG6zNMnfuW+UzYueaEGHBHoExb0TPtkcV3wbwpWsl6
	 DC4p1cxQETsHR1wh8l06vm6qbgmR+PM1DhCRCJlViSSpd4bvVAPp7WSIZTZiNxLqdi
	 +8v6sqK2++UPI8NRxHA+pHQBRnmAJnqj/speZyq2TwAD/ieIOKwMoDFbRCcM8YZN3A
	 UWzjd3bXJuYZg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rlAim-000000000Nn-3x3C;
	Fri, 15 Mar 2024 17:47:53 +0100
Date: Fri, 15 Mar 2024 17:47:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: qcom: Read back PARF_LTSSM register
Message-ID: <ZfR7uCcflCiFTvBh@hovoldconsulting.com>
References: <20240215161114.GA1292081@bhelgaas>
 <bc7d9859-f7ec-41c5-8a9e-170ccdfff46a@linaro.org>
 <Zc8GHrgdF7jJBgyu@hovoldconsulting.com>
 <c1f85249-32b1-41e2-adc3-5aa4ad7609b9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1f85249-32b1-41e2-adc3-5aa4ad7609b9@linaro.org>

On Fri, Mar 15, 2024 at 11:16:59AM +0100, Konrad Dybcio wrote:
> On 2/16/24 07:52, Johan Hovold wrote:

> > This makes no sense. As Bjorn already said, you're just polling for the
> > link to come up (for a second). And unless you have something else that
> > depends on the write to have reached the device, there is no need to
> > read it back. It's not going to be cached indefinitely if that's what
> > you fear.
> 
> The point is, if we know that the hardware is expected to return "done"
> within the polling timeout value of receiving the request to do so, we
> are actively taking away an unknown amount of time from that timeout.

We're talking about microseconds, not milliseconds or seconds as you
seem to believe.

> So, if the polling condition becomes true after 980ms, but due to write
> buffering the value reached the PCIe hardware after 21 ms, we're gonna
> hit a timeout. Or under truly extreme circumstances, the polling may
> time out before the write has even arrived at the PCIe hw.

So the write latency is not an issue here.

Johan

