Return-Path: <linux-pci+bounces-3856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B3485F4B2
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 10:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7716028705A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA91374E6;
	Thu, 22 Feb 2024 09:41:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277EB38F88;
	Thu, 22 Feb 2024 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594864; cv=none; b=igT+ptz4Szek3FSkHL3ngfu2lot0aEIrYt7Dokmz/mVYC/jCgCwcTDynINjbSrGlE0tVhhKiCzBAY+oPjBLsD+8Os2Zo9DG63EEuG/KI4eSOtlQmmGRm4V7jsFocJdKiD+lBahXRtHT8T3iKkotdnk9ULaflxc14qJbj6YsKj5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594864; c=relaxed/simple;
	bh=izL9Oq4UHurOw7CRpcyqlGslqY6aPINI+2U4okB5bTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC726LSgCorZvBJ2nw/nOuMqBvPyBoCQzTS1WCv3P17tnZ/+qnPks/w4bSdbtagWwq0/3QwQY3W/zakON9AfGt8W/CLtOcxc0yah5ZVBnutP2sJNaxTIHu7E+UYq8Ri28G1Pk8AdT5SG18toyzjQ5c/ydVG45nHcfzS4tJ/BO40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 55813100DE9CD;
	Thu, 22 Feb 2024 10:40:52 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2F84A3210D; Thu, 22 Feb 2024 10:40:52 +0100 (CET)
Date: Thu, 22 Feb 2024 10:40:52 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240222094052.GA25101@wunner.de>
References: <20240221051958.GA11693@thinkpad>
 <20240221182000.GA1533634@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221182000.GA1533634@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 21, 2024 at 12:20:00PM -0600, Bjorn Helgaas wrote:
>   1) D3hot doesn't work per spec.  This sounds like a hardware
>      defect in the device that should be a quirk based on
>      Vendor/Device ID, not something in DT.  I don't actually know if
>      this is common, although there are several existing quirks that
>      mention issues with D3.

My recollection is that putting Root Ports into D3hot on older x86
systems would raise MCEs, which is why pci_bridge_d3_possible() only
allows D3hot in cases which are known to work (e.g. Thunderbolt
controllers, machines with a recent BIOS).  It was a conservative
policy chosen to avoid regressions.

I don't know if similar issues exist on non-ACPI systems.  If they
don't exist, platform_pci_bridge_d3() could just return true for
all devicetree-based systems.  Might be worth testing if any systems
can be found which exhibit issues with such a policy.  That would
obviate the need to specify "supports-d3" in the devicetree.
Quite the opposite, ports which are known not to work could be
blacklisted.  Of course if it turns out that's the majority then
whitelisting via "supports-d3" is a better option.


>   2) The platform doesn't support putting the bridge in D3cold and
>      back to D0.  I don't understand this either because I assumed DT
>      would describe *hardware*, and "supports-d3" might imply the
>      presence of hardware power control, but doesn't tell us how to
>      operate it, and it must be up to a native driver to know how to
>      do it.

I think we're putting devices into D3hot first before cutting power
(i.e. putting them into D3cold), so knowing that D3hot is safe is
basically a prerequisite for D3cold.

Thanks,

Lukas

