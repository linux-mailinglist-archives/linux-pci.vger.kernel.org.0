Return-Path: <linux-pci+bounces-34922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FEFB38435
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD49B1BA3556
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782F2356902;
	Wed, 27 Aug 2025 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZWrZIyf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD40350D6E;
	Wed, 27 Aug 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303126; cv=none; b=pe16pjojeUjoyJdFULLoxcOGSW1fM7qpGogNuDsSfaVxh0BrVCKRz0q7Ahq9aabibHVizJsOUWvwjDw+4k82+oXxJjd4oybow3OvQFEbxTU46NEKMTeEaEBPOLIf246QDnZROKCVyWg6azQKbauAINxXMi48X5wkv3H/PITEcXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303126; c=relaxed/simple;
	bh=UPsDLa+npxQf/r4sAPI8AxVrqWdXD+BKRi0Iv7NwMuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPsTAmxaQzMGzPEcbG3pZadfZxw65qjapL2RbMiCMV8Hxd8j7ldO83J6leaxr9/ZMHznJn1wbTUVpJ7Xa0IRXb6zD9JEVIeLus4dDnBh+qkivOCgIhSgkaK/vvHR8ScuJSXF07pY1lpfuAdpNs4WQewfVHSs8p12TIB6GFBh62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZWrZIyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40ADC4CEEB;
	Wed, 27 Aug 2025 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756303125;
	bh=UPsDLa+npxQf/r4sAPI8AxVrqWdXD+BKRi0Iv7NwMuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZWrZIyfUPGloGm2D5K/2w+Qw5nKlsALT7JUMbr8uprJJVv7RrEswAJD+4hzRS5Kg
	 fjhEcKFwTju15W2H2qzd/n2a83z+R+sesa2d5dovBknc+30TAI7XXKSyaYlLdfc9iv
	 XsXTYAK5gCW+KDtFq+v41z67emYARGVHAJmHAoCYxnEAln9QcsXW6kO6cYW4zqIkr5
	 WynVNmR0JqtAE0Z7G2RNwOoFoSDPNPUq/xHiS7/u+at0/aF1UD0ynJp9gBVk2bEE4s
	 cXkq08ugdyBMFtEkfEW8G/OzrlSR0hBmqRyS8JJIi6T0lawvEdHis13sC+hJ+qGOEA
	 P4mphxLcR8uhw==
Date: Wed, 27 Aug 2025 19:28:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, 
	sherry.sun@nxp.com, linux-pm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/3] PCI: Add support for PCIe WAKE# interrupt
Message-ID: <rybngetujsbwx7j7ibnqpkyqdhat3gkqjzephrmluirxtgartb@753pwgb3xmvq>
References: <b6b4tzs73n63d565k52pqbep4bqhctibjv5gzm2wenbf2ji45b@npgoqscnbbpn>
 <20250804155023.GA3627102@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250804155023.GA3627102@bhelgaas>

On Mon, Aug 04, 2025 at 10:50:23AM GMT, Bjorn Helgaas wrote:
> On Mon, Aug 04, 2025 at 03:45:05PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Aug 01, 2025 at 04:29:41PM GMT, Krishna Chaitanya Chundru wrote:
> > > PCIe WAKE# interrupt is needed for bringing back PCIe device state
> > > from D3cold to D0.
> > > 
> > > This is pending from long time, there was two attempts done
> > > previously to add WAKE# support[1], [2]. Those series tried to add
> > > support for legacy interrupts along with WAKE#. Legacy interrupts
> > > are already available in the latest kernel and we can ignore them.
> > > For the wake IRQ the series is trying to use interrupts property
> > > define in the device tree.
> > > 
> > > This series is using gpio property instead of interrupts, from
> > > gpio desc driver will allocate the dedicate IRQ.
> > > 
> > > According to the PCIe specification 6, sec 5.3.3.2, there are two
> > > defined wakeup mechanisms: Beacon and WAKE# for the Link wakeup
> > > mechanisms to provide a means of signaling the platform to
> > > re-establish power and reference clocks to the components within
> > > its domain. Adding WAKE# support in PCI framework.
> > > 
> > > According to the PCIe specification, multiple WAKE# signals can
> > > exist in a system. In configurations involving a PCIe switch, each
> > > downstream port (DSP) of the switch may be connected to a separate
> > > WAKE# line, allowing each endpoint to signal WAKE# independently.
> > > To support this, the WAKE# should be described in the device tree
> > > node of the upstream bridge to which the endpoint is connected.
> > > For example, in a switch-based topology, the WAKE# GPIO can be
> > > defined in the DSP of the switch. In a direct connection scenario,
> > > the WAKE# can be defined in the root port. If all endpoints share
> > > a single WAKE# line, the GPIO should be defined in the root port.
> > 
> > I think you should stop saying 'endpoint' here and switch to 'slot'
> > as that's the terminology the PCIe spec uses while defining WAKE#.
> 
> I think the main question is where WAKE# is terminated.  It's asserted
> by an "add-in card" (PCIe CEM r6.0, sec 2.3) or a "component" or
> "Function" (PCIe Base r7.0, sec 5.3.3.2).  A slot can provide a WAKE#
> wire, and we need to know what the other end is connected to.
> 
> AFAICS, WAKE# routing is unrelated to the PCIe topology *except* that
> in "applications where Beacon is used on some Ports of the Switch and
> WAKE# is used for other Ports," WAKE# must be connected to the Switch
> so it can translate it to Beacon (PCIe r7.0, sec 5.3.3.2).
> 
> So we can't assume WAKE# is connected to the Port leading to the
> component that asserts WAKE#.
> 

I've submitted a PR to add wake-gpios to the endpoint node:
https://github.com/devicetree-org/dt-schema/pull/170

- Mani

-- 
மணிவண்ணன் சதாசிவம்

