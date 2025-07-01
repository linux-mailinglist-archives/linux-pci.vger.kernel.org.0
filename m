Return-Path: <linux-pci+bounces-31206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005FAAF0592
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 23:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AD63B441C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 21:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FC125F793;
	Tue,  1 Jul 2025 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0S06LPy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1723E352;
	Tue,  1 Jul 2025 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405166; cv=none; b=G2yFQxaQC/ZMKyCJuHL6cxKQyC4IKv2xeB/UtshjDOm3Q20Y7U58mKFvn0SYcR88BpckEGRZ0ojaEb1bgsQQ/pp3aqsMO80jKMrxbHgK7aqpib9eaGe4AVLtbvObHGYLL3yTNyxLD3rVB6IU5cfyYxdcZX0FGWDnC56MDe2QmDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405166; c=relaxed/simple;
	bh=KJPoiJp8Xs5EFr8OYmrMsidZWaeMkK33X3MmFE3donQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OyOwK7qWf/aKgQL3PO4avhqpNnfKN+A1Ss4ABBJy2vAqlzdKhD17PhnbK0rUpnptZwcx6sTLXPoX2yqIzFslUNP50WioRL4jop60FkJr0Shd1T7VPYXRcYb6fm+PV1fdD90FcZ/AAVso5c1bXHB6CmO9lX7e+lfoNO0n1cMVZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0S06LPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0315C4CEEB;
	Tue,  1 Jul 2025 21:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751405166;
	bh=KJPoiJp8Xs5EFr8OYmrMsidZWaeMkK33X3MmFE3donQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f0S06LPyPjp97OE84+3315uvqkYWHcYTd7VCv+Dme04ALdaSAXPjm4GGdND8u/xfW
	 3rE5w98QqPE50OefJBx4Rr+Q4+M1Iy6tn+XCd5ErSOs3dy1cSgpGTQAHwJSn7EhcSs
	 NQZN3IRtjM5WNf4DSghc/in+29rFy6Hl3WsQX9w4HKfk4kwYNyBmYB48x88Hsdyv0Q
	 jrYOllkXThypgVnqIenKINkRWCr4rs44aLYBthrfew5XdFOdo+fmS2z7dh6fkAjy8Q
	 R/xsJ4e1AMv4AYnyEs76RfNGTd/XcDkrwLK3tu8PIWJEhllc7T8T/kN0dGyKo/c8Os
	 GxZx7KuFeGBWg==
Date: Tue, 1 Jul 2025 16:26:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mayank Rana <mayank.rana@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, will@kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	andersson@kernel.org, mani@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_ramkri@quicinc.com, quic_shazhuss@quicinc.com,
	quic_msarkar@quicinc.com, quic_nitegupt@quicinc.com,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 3/4] dt-bindings: PCI: qcom,pcie-sa8255p: Document
 ECAM compliant PCIe root complex
Message-ID: <20250701212604.GA1850816@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89ded76a-8bd7-43b5-932d-f139f4154320@oss.qualcomm.com>

[+cc Rob]

On Tue, Jul 01, 2025 at 01:21:29PM -0700, Mayank Rana wrote:
> On 7/1/2025 9:52 AM, Bjorn Helgaas wrote:
> > On Mon, Jun 16, 2025 at 03:42:58PM -0700, Mayank Rana wrote:
> > > Document the required configuration to enable the PCIe root complex on
> > > SA8255p, which is managed by firmware using power-domain based handling
> > > and configured as ECAM compliant.
> > 
> > > +    soc {
> > > +        #address-cells = <2>;
> > > +        #size-cells = <2>;
> > > +
> > > +        pci@1c00000 {
> > > +           compatible = "qcom,pcie-sa8255p";
> > > +           reg = <0x4 0x00000000 0 0x10000000>;
> > > +           device_type = "pci";
> > > +           #address-cells = <3>;
> > > +           #size-cells = <2>;
> > > +           ranges = <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>,
> > > +                    <0x43000000 0x4 0x10100000 0x4 0x10100000 0x0 0x40000000>;
> > > +           bus-range = <0x00 0xff>;
> > > +           dma-coherent;
> > > +           linux,pci-domain = <0>;
> > > ...
> > 
> > > +           pcie@0 {
> > > +                   device_type = "pci";
> > > +                   reg = <0x0 0x0 0x0 0x0 0x0>;
> > > +                   bus-range = <0x01 0xff>;
> > 
> > This is a Root Port, right?  Why do we need bus-range here?  I assume
> > that even without this, the PCI core can detect and manage the bus
> > range using PCI_SECONDARY_BUS and PCI_SUBORDINATE_BUS.
>
> On Qualcomm SOCs, root complex based root host bridge is connected to single
> PCIe bridge
> with single root port. I have added bus-range based on discussion on this
> thread https://lore.kernel.org/all/20240321-pcie-qcom-bridge-dts-
> 2-0-1eb790c53e43@linaro.org/

I think you mean
https://lore.kernel.org/all/20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org/
so I assume you're looking at the conversation at
https://lore.kernel.org/all/20250103210531.GA3252@bhelgaas/t/#u.

So I guess the answer to my question is basically "to shut up DTC
check":

  Some DT for qcom,pcie-sa8255p might describe an Endpoint below this
  Root Port, and the Endpoint's 'reg' property includes a bus number
  determined by the Root Port configuration.

  DTC check validates the Endpoint's bus number by comparing it with
  the parent's 'bus-range', so it complains unless the Root Port
  includes a 'bus-range' property.

This might be the best we can do for now, but it's incomplete because
the Root Port's secondary bus number is programmable, and Linux can
assign whatever it wants.  We currently assume the secondary bus
number is 1, i.e., the root bus number plus 1, which generally
"should" be true.

But it all falls apart if we have multiple Root Ports because there's
no obvious secondary bus number for the second, third, etc., Root
Ports.

Bjorn

