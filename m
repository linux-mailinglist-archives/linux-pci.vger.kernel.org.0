Return-Path: <linux-pci+bounces-4264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8F886CD34
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 16:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD8C28316F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 15:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDA81468F6;
	Thu, 29 Feb 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKChcQAV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2E7143C48;
	Thu, 29 Feb 2024 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221040; cv=none; b=De0P/89cm9dSzN39sLVesky6AAytynUA2i4jxv2nAi4CStXEiPUv42iZzYEHS7kgXhjutZsBmzQqggdAFTqnz/ac+gUC+xoB7/l2AqsnN0DIb5sXQbaqGJKA74mrzPof89wGmUd6CrA58ojLAE+MxOUVGLHm1l1Ian0Vi5frFLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221040; c=relaxed/simple;
	bh=HlIBD1zLTo7ZQxtZ8wJ3+tqWu+7r6pbG1280u8gdayQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxYS7j8RyWT0ngCd8pbf6tTTxyWFeK7l1n0o04UKS/xNybFs2fzOVxlvaJeXOhOscP8SHRmU0g5KSUH46VqqqCjMMLVF3owsRvi3UP/UkMbY7rDWsdHHSrYAX1dDeLpxWDV3v+67SWzoqJEak7bNVdwqG4v0/hU8grLk3aL/b9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKChcQAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D35C433C7;
	Thu, 29 Feb 2024 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221039;
	bh=HlIBD1zLTo7ZQxtZ8wJ3+tqWu+7r6pbG1280u8gdayQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKChcQAVq4o7lwW456tEZ/9cxyRDYRjc6Xb/+ncbFU+rXQql+gqtq9K8uWANIB2LH
	 pzaJmlNXfRVurmknqnKyi6R3BHlGVz1JUc45jeExpCRRJIv/DtDMdF7lFtsY+5dGwO
	 PRt1MZFVWxwAPiZ8HtrQ5mA6g2UZps7ReU1YoJ97sVFHtTWmlS8A50Gr9ij0/EM7Kt
	 KVUjINJ9ZZsiMqOAw5SrJBaG0bze7fzyt+C6RgRlkIOLgBW60z33gEvMS3EKN6FUu0
	 HpTR84j4fykKEk3YqqPkQGN6Avj+m42tolX1pKRf7CNWhO1e+cthmZUIvhhjsT+47o
	 CFBNXz+tguR6w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rfiTP-0000000046Q-1OPR;
	Thu, 29 Feb 2024 16:37:28 +0100
Date: Thu, 29 Feb 2024 16:37:27 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <ZeCktwcEFAfCEVkV@hovoldconsulting.com>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
 <20240228220843.GA309344@bhelgaas>
 <20240229100853.GA2999@thinkpad>
 <ZeBbrJhks46XByMD@hovoldconsulting.com>
 <20240229122416.GD2999@thinkpad>
 <ZeCCPRVvYCNfMYnd@hovoldconsulting.com>
 <20240229135407.GE2999@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229135407.GE2999@thinkpad>

On Thu, Feb 29, 2024 at 07:24:07PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Feb 29, 2024 at 02:10:21PM +0100, Johan Hovold wrote:

> > I think that based on the available data it's reasonable to go ahead and
> > merge these patches. In the event that this turns out to be a
> > configuration issue, we can just drop the 'aspm-no-l0s' properties
> > again.
> 
> Well the problem is, if you are not sure, then adding the DT properties is
> certainly not correct. As that implies a hardware defect, but it may not be.
> So let's wait for some time to find out the actual issue.

Our devicetrees are always going to be a tentative description of the
hardware, and this especially true for Qualcomm that don't publish any
documentation so that people are forced to rely on informed guesses
based on downstream devicetrees and drivers and reverse engineering.

As far as I can tell, after having spent a lot of time on this and
checking with sources inside Qualcomm, the hardware is to blame here. If
this turns out not to be true, we can always revise later. We do this
all the time, as you know.

I'm all for digging further into this issue with the help of Qualcomm,
but I don't think that should block this series as that would leave the
link errors that we hit since 6.7 in place and effectively prevent us
from enabling the ITS in 6.9.

Johan

