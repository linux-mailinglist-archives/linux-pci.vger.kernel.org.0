Return-Path: <linux-pci+bounces-33379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB153B1A6AF
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 17:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7081887823
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018CC26FA67;
	Mon,  4 Aug 2025 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGeLwnV0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99221C9E7;
	Mon,  4 Aug 2025 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322625; cv=none; b=AuRht6vQRFToPQuF0STPdj0aiVLRlSPvziLeEuPl+BZwfpBTkXWAD+OOdpFPCpcr+oHpvxqRdzDmtgA2CsHHW4g8gCaElbSSmGpz/52ucWQ1zwrzGQV58yuJdnqzLcmN+fI1b1qll1pjzaHSLcM4YJPSqHmSiET1pSMEWGLoe6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322625; c=relaxed/simple;
	bh=V58lDgP5AWQy83/5MeJGYisxvWdLT++8TBgZ54D2ns4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=U2CODAYHdfbzzqs+DpUzULLnfhFgUoygxXSfKa6scJqYit5WQN84Co0aaMTg5MJj9hOWj71NkYJkz9XNTBNpCXBo81TDItHY9KAItbjD4cTIWcryVNX3UBRqxPwhzOabmBrzKs4UDaTweVy1kvS+oVTDRCJ2Rbj5Dw/Si1Nz8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGeLwnV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215F0C4CEE7;
	Mon,  4 Aug 2025 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754322625;
	bh=V58lDgP5AWQy83/5MeJGYisxvWdLT++8TBgZ54D2ns4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EGeLwnV0pxsNDLv+Cf1tZJ9MWDQuOgD3lHsI5WU8icltefawfV+ZdQJxs44GeFn2z
	 MF1kyoUD/FteQy5z6pN43VVp8Ps/MindS7wyWvuRMejJW0/+8ftKtpMtSB7TfSpxSB
	 9MkZfcRl08319WCYMqKdsSC5hKbJFZZi5JZmVCJHtGhdpy3md3ZfM2i+xOyRgXGK10
	 kByfmTJ5b741wONAtCUp5New16QBiEh7c8Bpl5ndyUWo8O3mcMwDnStBtPD0wpHWJX
	 ptkyo6sJSkb+fxXJTENuTTADPf+HjYFTWQRXJVN1i+NGumAWRXmlUkynnyrY4x5KRY
	 83MMK8a/L04kw==
Date: Mon, 4 Aug 2025 10:50:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, sherry.sun@nxp.com,
	linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/3] PCI: Add support for PCIe WAKE# interrupt
Message-ID: <20250804155023.GA3627102@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6b4tzs73n63d565k52pqbep4bqhctibjv5gzm2wenbf2ji45b@npgoqscnbbpn>

On Mon, Aug 04, 2025 at 03:45:05PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Aug 01, 2025 at 04:29:41PM GMT, Krishna Chaitanya Chundru wrote:
> > PCIe WAKE# interrupt is needed for bringing back PCIe device state
> > from D3cold to D0.
> > 
> > This is pending from long time, there was two attempts done
> > previously to add WAKE# support[1], [2]. Those series tried to add
> > support for legacy interrupts along with WAKE#. Legacy interrupts
> > are already available in the latest kernel and we can ignore them.
> > For the wake IRQ the series is trying to use interrupts property
> > define in the device tree.
> > 
> > This series is using gpio property instead of interrupts, from
> > gpio desc driver will allocate the dedicate IRQ.
> > 
> > According to the PCIe specification 6, sec 5.3.3.2, there are two
> > defined wakeup mechanisms: Beacon and WAKE# for the Link wakeup
> > mechanisms to provide a means of signaling the platform to
> > re-establish power and reference clocks to the components within
> > its domain. Adding WAKE# support in PCI framework.
> > 
> > According to the PCIe specification, multiple WAKE# signals can
> > exist in a system. In configurations involving a PCIe switch, each
> > downstream port (DSP) of the switch may be connected to a separate
> > WAKE# line, allowing each endpoint to signal WAKE# independently.
> > To support this, the WAKE# should be described in the device tree
> > node of the upstream bridge to which the endpoint is connected.
> > For example, in a switch-based topology, the WAKE# GPIO can be
> > defined in the DSP of the switch. In a direct connection scenario,
> > the WAKE# can be defined in the root port. If all endpoints share
> > a single WAKE# line, the GPIO should be defined in the root port.
> 
> I think you should stop saying 'endpoint' here and switch to 'slot'
> as that's the terminology the PCIe spec uses while defining WAKE#.

I think the main question is where WAKE# is terminated.  It's asserted
by an "add-in card" (PCIe CEM r6.0, sec 2.3) or a "component" or
"Function" (PCIe Base r7.0, sec 5.3.3.2).  A slot can provide a WAKE#
wire, and we need to know what the other end is connected to.

AFAICS, WAKE# routing is unrelated to the PCIe topology *except* that
in "applications where Beacon is used on some Ports of the Switch and
WAKE# is used for other Ports," WAKE# must be connected to the Switch
so it can translate it to Beacon (PCIe r7.0, sec 5.3.3.2).

So we can't assume WAKE# is connected to the Port leading to the
component that asserts WAKE#.

> > During endpoint probe, the driver searches for the WAKE# in its
> > immediate upstream bridge. If not found, it continues walking up
> > the hierarchy until it either finds a WAKE# or reaches the root
> > port. Once found, the driver registers the wake IRQ in shared
> > mode, as the WAKE# may be shared among multiple endpoints.
> 
> I don't think we should walk the hierarchy all the way up to RP. If
> the slot supports WAKE#, it should be defined in the immediate
> bridge node of the endpoint (as DT uses bridge node to described the
> slot). Otherwise, if the slot doesn't use WAKE#, walking up till RP
> may falsely assign wake IRQ to the endpoint.

I don't think we can walk the PCIe hierarchy because in general WAKE#
routing is not related to that hierarchy.

Bjorn

