Return-Path: <linux-pci+bounces-3747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E8585B419
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 08:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5911C224F5
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21155A4E9;
	Tue, 20 Feb 2024 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY6Toh2B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907DE3D69;
	Tue, 20 Feb 2024 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414887; cv=none; b=GWWopRcUQ2NL5qXo0PmaSGAcKmSw3JYFE5OKmGQMkbA07JYdfXCwepNF0hcXawkiW2qJ/a6SX+R1ciqXgBvdmfAB4zKScK7Ws3YgfB/f5Hg+TlyOfyedJqXowyQXBg7kvwRY+hQGN7eAT+Au9DMWqD8+yMYBmsKpfVQPGLDFjWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414887; c=relaxed/simple;
	bh=J+HORaFB9BevhmkmzQueEU/imUrqvh0T/whWu92LpyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY1Mm5o8Hj8sRU0MFp7KVrz1FGtSY25wSATmpN9kPALc1WLJ708GIzpi7u+/4tl2BjYrZH/pqS0+xMFBgjJ3yL7XnHqtlYRTnakmhm2TKrP23GeRdTM9N4MK6lxlsudG7W+ejnc2Am67FlbtOnjVPyhDcFwhsTEfr0X5oOeIFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY6Toh2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AFCC433F1;
	Tue, 20 Feb 2024 07:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708414887;
	bh=J+HORaFB9BevhmkmzQueEU/imUrqvh0T/whWu92LpyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JY6Toh2BDGiFy9xwulIfY5B+iEbVfcXmqWyqe7oWtbzY3v+xzOZXGq0iK1CxtaOBv
	 spxKlF7t3ceCJTFb1AREMYL7HmtcjbTmoRS4AmCMTtAV7OcQOahZuYr9WlngZAc/CO
	 3Q47hDZdH+upXWEmzmw/NvDczUwSdMjHE7TDFxDcTrmZOraP8O+AxcvxA/FBvQQzeZ
	 xcVmpoCEP83w2bGGijXyXcsoOs/hGCs/M8APdaf8b0T2bbWMMCRPtvVPFQq+koQeQE
	 VXkD5kfl/d8OjC+o2IFGEQFIeFIxUu0ruJYG5aNbtzjf/EERMaiHHFIPCP5f0xzA76
	 K7A+KE27Ib9ug==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rcKkn-000000002Ca-2uih;
	Tue, 20 Feb 2024 08:41:25 +0100
Date: Tue, 20 Feb 2024 08:41:25 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: PCI: qcom: Do not require
 'msi-map-mask'
Message-ID: <ZdRXpQnbDbojlMkV@hovoldconsulting.com>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
 <20240212165043.26961-3-johan+linaro@kernel.org>
 <e396cf20-8598-4437-b635-09a4a737a772@linaro.org>
 <Zcy4Atjmb6-wofCL@hovoldconsulting.com>
 <59bd6e54-0d5d-4e1a-818a-475a96c223ff@linaro.org>
 <20240216165406.GD39963@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216165406.GD39963@thinkpad>

On Fri, Feb 16, 2024 at 10:24:06PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 14, 2024 at 02:38:57PM +0100, Krzysztof Kozlowski wrote:
> > On 14/02/2024 13:54, Johan Hovold wrote:
> > > On Wed, Feb 14, 2024 at 01:01:20PM +0100, Krzysztof Kozlowski wrote:
> > >> On 12/02/2024 17:50, Johan Hovold wrote:
> > >>> Whether the 'msi-map-mask' property is needed or not depends on how the
> > >>> MSI interrupts are mapped and it should therefore not be described as
> > >>> required.
> > >>
> > >> I could imagine that on all devices the interrupts are mapped in a way
> > >> you need to provide msi-map-mask. IOW, can there be a Qualcomm platform
> > >> without msi-map-mask?
> > > 
> > > I don't have access to the documentation so I'll leave that for you guys
> > > to determine. I do note that the downstream DT does not use it and that
> > > we have a new devicetree in linux-next which also does not have it:
> > > 
> > > 	https://lore.kernel.org/r/20240125-topic-sm8650-upstream-pcie-its-v1-1-cb506deeb43e@linaro.org
> > > 
> > > But at least the latter looks like an omission that should be fixed.
> > 
> > Hm, either that or the mask for sm8450 was not needed as well. Anyway,
> > thanks for explanation, appreciated!
> 
> msi-map-mask is definitely needed as it would allow all the devices under the
> same bus to reuse the MSI identifier. Currently, excluding this property will
> not cause any issue since there is a single device under each bus. But we cannot
> assume that is going to be the case on all boards.

Are you saying that there is never a use case for an identity mapping?
Just on Qualcomm hardware or in general?

It looks like we have a fairly large number of mainline devicetrees that
do use an identity mapping here (i.e. do not specify 'msi-map-mask') and
the binding document also has an explicit example of this.

	Documentation/devicetree/bindings/pci/pci-msi.txt

> I will submit a patch to fix SM8650.

Johan

