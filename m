Return-Path: <linux-pci+bounces-3366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77840851E90
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 21:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2C92810B8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 20:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6067F47F7A;
	Mon, 12 Feb 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4QvecTe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167247F57;
	Mon, 12 Feb 2024 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769249; cv=none; b=mBKK+rhKrwAXIh3U0Y/VoZtytsezM/ssjrqOO4HzDARyF88w1MYNRkuP6VROnl27bGkCl4aHVmjdjeBe/kUocdUM6eFyToVMS/WPI8d8Kt6ou1NHyl2JKDtvmpDJAnZ2AlFF2zvQkTvCF3/ziZbASOJkrJByZ7nIPM/vWVBz9k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769249; c=relaxed/simple;
	bh=oUjbrDmniQ+EFskc10CnC4NdjvgqsalVpw5wauw1cbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRfs8by8ggc6d+u+OPs2KS4Jf8qa6oelWD516INSFI3b1jtgneSEExQKs16A6hMCiMg2cxerGywigsVKoiepntou5/gENsu+YP0p+7Z0pnzYMW9LSG79mnq96smEHaF6jgH0ofrm9mkSaw9ZRFVh2YwLI5oidPuvWuc3+2mPnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4QvecTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B3AC433C7;
	Mon, 12 Feb 2024 20:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707769248;
	bh=oUjbrDmniQ+EFskc10CnC4NdjvgqsalVpw5wauw1cbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4QvecTeIBMe3ssFDbxNf7NyaOIAYCsk9qUMXn9v+GcfTCp6io+XKMoLgSWw8aZ9F
	 pfpkfwWAIwMDkx4c+sqJyM9Yy/Hus0ruw3u1XvlW5QH7sFrO2hzUubi1Jb9H5C6qaF
	 d9Q9ypA7DwtmZ2RmCBb4q9qJ8dbHPVtLIkvqCeLRBbp2B3QCJ7qDoL1S0e2e9pDUIy
	 rdFu2aPD/lf6nS6o6L+yIKVMkgzIDmXZUcG6FUdfTwp5yxX4PcUn6xgIzLGQ7vs4r6
	 05joV5xyFD8u47NV43I9UL0uD90h9tmjXOX8IE8TlUa7uYsb4PnKBv9XaaCI2WqetW
	 Y/7jsHATDb9Ig==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rZcnW-000000002DP-3BVc;
	Mon, 12 Feb 2024 21:21:02 +0100
Date: Mon, 12 Feb 2024 21:21:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [RFC 08/10] PCI: qcom: Add support for disabling ASPM L0s in
 devicetree
Message-ID: <Zcp9riZvhfjr0j9G@hovoldconsulting.com>
References: <20240212165043.26961-9-johan+linaro@kernel.org>
 <20240212193449.GA1142362@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212193449.GA1142362@bhelgaas>

On Mon, Feb 12, 2024 at 01:34:49PM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 12, 2024 at 05:50:41PM +0100, Johan Hovold wrote:
> > A recent commit started enabling ASPM unconditionally when the hardware
> > claims to support it. This triggers Correctable Errors for some PCIe
> > devices on machines like the Lenovo ThinkPad X13s, which could indicate
> > an incomplete driver ASPM implementation or that the hardware does in
> > fact not support L0s.
> 
> I think it would be useful for debugging purposes to identify the
> specific commit.  Maybe it's 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for
> platforms supporting 1.9.0 ops") ?
> 
> > Add support for disabling ASPM L0s in the devicetree when it is not
> > supported on a particular machine and controller.
> > 
> > Note that only the 1.9.0 ops enable ASPM currently.
> > 
> > Fixes: a9a023c05697 ("PCI: qcom: Add support for disabling ASPM L0s in devicetree")
> 
> I don't see this SHA1 in the PCI tree; is it a stable SHA1 from
> somewhere else?

Yes, sorry, this was indeed supposed to say

Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")

as it would be a dependency for the follow-on fixes.

Johan

