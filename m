Return-Path: <linux-pci+bounces-3042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DFE8479BA
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 20:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF751F27ABD
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 19:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A35915E5D7;
	Fri,  2 Feb 2024 19:33:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4B15E5A5;
	Fri,  2 Feb 2024 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902411; cv=none; b=XSDtU3RGbWNdktWxV8vatCFOoFrrViXqd8DTY172DJphJnhQa9l6b0d55NiU4MaAaZWpZ2Fz65srPeafu6AABflaAMIT7IPO0fsVKx9D/90T6qE/xg4xG/K4fy9RbY+ehoApQfF9yezzB0z5ZJw7Qtc/O5dYUTYrj/ZFNSsVaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902411; c=relaxed/simple;
	bh=3dZeOsFXiecrBV5F+z7IGlq533Nw04Zs9kPXrW3vdFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmPCefRhF/Ug9CyXCX2ydowMg9XasP8wiAUv3vCcNaDStj5crsgvK9vaXCYDxDxErBLkRN0s17xZ8qZlBHRMKMidSdZfCJ3zaDKwwxtJnueZPrLfRduUrKZQC80iPBHPC1Lt1nSXREueqrIB99IjxHbKuA+2hF3Zm5MwA0gwDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 71A0B3000C980;
	Fri,  2 Feb 2024 20:33:26 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 63DB1418804; Fri,  2 Feb 2024 20:33:26 +0100 (CET)
Date: Fri, 2 Feb 2024 20:33:26 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] Enable D3 support for Qualcomm bridges
Message-ID: <20240202193326.GA29000@wunner.de>
References: <20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org>
 <20240202090033.GA9589@wunner.de>
 <20240202100041.GB8020@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202100041.GB8020@thinkpad>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 02, 2024 at 03:30:41PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Feb 02, 2024 at 10:00:33AM +0100, Lukas Wunner wrote:
> > Please amend platform_pci_bridge_d3() to call a new of_pci_bridge_d3()
> > function which determines whether D3 is supported by the platform.
> > 
> > E.g. of_pci_bridge_d3() could contain a whitelist of supported VID/DID
> > tuples.  Or it could be defined as a __weak function which always
> > returns false but can be overridden at link time by a function
> > defined somewhere in arch/arm/, arch/arm64/ or in some driver
> > whose Kconfig option is enabled in Qualcomm platforms.
> 
> Hmm. If we go with a DT based solution, then introducing a new property like
> "d3-support" in the PCI bridge node would be the right approach. But then, it
> also requires defining the PCI bridge node in all the DTs. But that should be
> fine since it will help us to support WAKE# (per bridge) in the future.

I'm not sure whether a "d3-support" property would be acceptable.
My understanding is that capabilities which can be auto-sensed by
the driver (or the PCI core in this case), e.g. by looking at the
PCI IDs or compatible string, should not be described in the DT.

My point was really that this should be determined by
platform_pci_bridge_d3(), that's what the function is for,
instead of inventing a new mechanism.  Exactly how the capability
is detected by of_pci_bridge_d3() is up to DT schema maintainers.

A DT property does have the advantage of better maintainability,
unlike a whitelist which may need to constantly be extended.

Thanks,

Lukas

