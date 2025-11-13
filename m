Return-Path: <linux-pci+bounces-41050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1510C55A7A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 05:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC463B58C0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 04:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8D9279DAD;
	Thu, 13 Nov 2025 04:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HABoALIm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD142AA6;
	Thu, 13 Nov 2025 04:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763008308; cv=none; b=UmwHUrUYLj8dez/79ugrQy37SNEcc9DOS+oldFtUyYmmzH3h8nA7Ux7WV4RnIUvUcgXlALGfcbhymeVBMw3sIJnV6lfkinz4+frcWlkGGdxvgO6ZqtWY3kle1wfMKKPGt/fVWEi1f+e++I/6SQRr2ShE6mguVoVWYUwnmSwJwoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763008308; c=relaxed/simple;
	bh=W1I2daDfVKFQU/rdShLXBgDAcqN0GlQzlMwKnl3A5/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWz+r32Q/RoDWpWHmyGY8UoKm++s+hCeKqMpNIk0jkSjKq6uqw0rFYMnulPGcsygl77Mxtwx3JQuoNaGGaR+IxkxEgJwE+ggu/EYX3WhpsAXxuPuf1dyYfmFRYLPWOErBopj84YiaMv31dUfr0KD16RX3vLdKkcQdEi7DLjESqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HABoALIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF68C4CEFB;
	Thu, 13 Nov 2025 04:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763008307;
	bh=W1I2daDfVKFQU/rdShLXBgDAcqN0GlQzlMwKnl3A5/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HABoALImoG/gljY8NXBN05LfI15RwSI4UcjJJ5asP90W+FUpV6ieJU68aLr3Xoa5l
	 BTFpSkMUZHFFuHIX/sw1uvg6in0msI6M4/UPJPMBHMdd6p/UkZ0PKLnu+pimBQ6QGL
	 EgzTl60REqtcgD7Q3vCevco21tKm7UW+oe+wZwpU6CK/5UoMvhNHxRsAiwm9BMkKFM
	 bOkyD9iXITlL+B0mCVrLZZ5Qd0BNAWwVmqUdvj975ZCpDU17+0vGoGiMtYAJm6orCG
	 pZM5siC8UJS5EUwApdxPEHcASw7IWQtl7TO5OeGIXmEt7QGz63kYADAVtzs5DP96S1
	 SiAeykQXtXX+w==
Date: Thu, 13 Nov 2025 10:01:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org, 
	krzk@kernel.org, helgaas@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org, 
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2] schemas: pci: Document PCIe T_POWER_ON
Message-ID: <enri4affdgq4q5mibnmhldhqqoybqbdcswohoj5mst2i77ckmu@dwlaqfxyjy3w>
References: <20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com>
 <aRHdiYYcn2uZkLor@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRHdiYYcn2uZkLor@wunner.de>

On Mon, Nov 10, 2025 at 01:41:45PM +0100, Lukas Wunner wrote:
> On Mon, Nov 10, 2025 at 04:59:47PM +0530, Krishna Chaitanya Chundru wrote:
> > From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
> 
> Please use the latest spec version as reference, i.e. PCIe r7.0.
> 
> > minimum amount of time(in us) that each component must wait in L1.2.Exit
> > after sampling CLKREQ# asserted before actively driving the interface to
> > ensure no device is ever actively driving into an unpowered component and
> > these values are based on the components and AC coupling capacitors used
> > in the connection linking the two components.
> > 
> > This property should be used to indicate the T_POWER_ON for each Root Port.
> 
> What's the difference between this property and the Port T_POWER_ON_Scale
> and T_POWER_ON_Value in the L1 PM Substates Capabilities Register?
> 
> Why do you need this in the device tree even though it's available
> in the register?
> 

Someone needs to program these registers. In the x86 world, BIOS will do it
happily, but in devicetree world, OS has to do it. And since this is a platform
specific value, this is getting passed from devicetree.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

