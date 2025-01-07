Return-Path: <linux-pci+bounces-19476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE422A04C8A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0863A59C6
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6995619E971;
	Tue,  7 Jan 2025 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEo1YU1M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E399190664;
	Tue,  7 Jan 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736289767; cv=none; b=JbSV2JIa3o6MYgBRbaPSH3rO1BaZ335uJ8s1Np7T1QuSdXGIY4iPFECQ8LNMjKiAKNjMIIEYZtP6hI4M46IE1F84+/lvimJn+dn1/tlzXD2xZcPeUGI7jM2WrPC/Qwd6SLtiKZq3jzN9/5wyfgSVy8qAq5Y6Qg8x2pNnhIGab3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736289767; c=relaxed/simple;
	bh=OAaF3t+3+AbOpQgAHh9T97TjVE9os6Ew4Mn69K/1Wxc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EKAo5xJm0Ir/5wQRScI788CEK6bC8Dkecl6Qcz5c2K5AiRcsnvw3k7aaa2FdXMiCRj16mpyt2PNIhccph97YK9zn0ZRrW23BauYArA/JCkbbPtCkBtez0F4GY0VQM40Y3e2tkdkoIirTjGOR/7NxUzIiK/ZEruXWw+ZF6y54FJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEo1YU1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8608DC4CEDE;
	Tue,  7 Jan 2025 22:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736289766;
	bh=OAaF3t+3+AbOpQgAHh9T97TjVE9os6Ew4Mn69K/1Wxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IEo1YU1M6xcnjl2DhgYfSrhtO4jyG4gPs0FmBg4oabm8aCweQjs0JpOWg3QG8UOBd
	 o5CLi09ZiuuXu5rZhxJJNJdasqeD6S4SFNw9L6QqhL1BKhbdxTWPIhl0dhM4rRTeo7
	 LKEidAtlfzpayBqCBnPe4NOaEWNH3erm2H15dCgTdEko9y8w39tGOV6jG+LZl44ImR
	 uK31BIQjQCg1J2OKpvGXWf+ZwtkKFizGDdNeJafSl2ZbjiUeBh0k3lysC7fZNZQTO0
	 oH7AL8vwAwk+s26jniRZtaCQWD0kn5UV3xlFEprX/f63esJVtu9jlmBQxfSfEUTUup
	 xv2FfsGBLTSlA==
Date: Tue, 7 Jan 2025 16:42:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Message-ID: <20250107224244.GA187680@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eysqoiiizunkjxqyvfaxbx4szwnz4osv42j7xr247irnthifwu@nhxytsl4brvu>

On Tue, Dec 24, 2024 at 11:49:42AM +0200, Dmitry Baryshkov wrote:
> On Tue, Dec 24, 2024 at 02:41:10PM +0530, Krishna Chaitanya Chundru wrote:
> > On 12/5/2024 2:55 AM, Bjorn Helgaas wrote:
> > > On Tue, Nov 12, 2024 at 08:31:33PM +0530, Krishna chaitanya chundru wrote:
> > > > Add binding describing the Qualcomm PCIe switch, QPS615,
> > > > which provides Ethernet MAC integrated to the 3rd downstream port
> > > > and two downstream PCIe ports.

> > > > +    pcie {
> > > > +        #address-cells = <3>;
> > > > +        #size-cells = <2>;
> > > > +
> > > > +        pcie@0 {
> > > > +            device_type = "pci";
> > > > +            reg = <0x0 0x0 0x0 0x0 0x0>;
> > > > +
> > > > +            #address-cells = <3>;
> > > > +            #size-cells = <2>;
> > > > +            ranges;
> > > > +            bus-range = <0x01 0xff>;
> > > > +
> > > > +            pcie@0,0 {
> > > > +                compatible = "pci1179,0623";
> > > > +                reg = <0x10000 0x0 0x0 0x0 0x0>;
> > > > +                device_type = "pci";
> > > > +                #address-cells = <3>;
> > > > +                #size-cells = <2>;
> > > > +                ranges;
> > > > +                bus-range = <0x02 0xff>;
> > > 
> > > This binding describes a switch.  I don't think bus-range should
> > > appear here at all because it is not a feature of the hardware (unless
> > > the switch ports are broken and their Secondary/Subordinate Bus
> > > Numbers are hard-wired).
> > > 
> > > The Primary/Secondary/Subordinate Bus Numbers of all switch ports
> > > should be writable and the PCI core knows how to manage them.
> > 
> > The dt binding check is throwing an error if we don't keep bus-range
> > property for that reason we added it, from dt binding perspective i think it
> > is mandatory to add this property.
> 
> Could you please provide an error message? I don't see any of the PCIe
> bindingins declaring bus-range as mandatory. I might be missing it
> though.

I think the warning message is like this:

  Warning (pci_device_bus_num): /soc@0/pcie@1c00000/pcie@0/wifi@0: PCI bus number 1 out of range, expected (0 - 0)

and only happens if there's a device below a Root Port or a Switch.
In that case the device "reg" property apparently has to include the
bus/device/function.

IIUC, in this case, we're describing a Switch with an integrated
Ethernet MAC:

  pcie@0 {
    device_type = "pci";
    reg = <0x0 0x0 0x0 0x0 0x0>;           # 00:00.0 RP to [bus 01-ff]
    bus-range = <0x01 0xff>;

    pcie@0,0 {
      compatible = "pci1179,0623";
      reg = <0x10000 0x0 0x0 0x0 0x0>;     # 01:00.0 Switch USP to [bus 02-ff]
      device_type = "pci";
      bus-range = <0x02 0xff>;

      pcie@1,0 {
        reg = <0x20800 0x0 0x0 0x0 0x0>;   # 02:01.0 Switch DSP to [bus 03-ff]
        device_type = "pci";
        bus-range = <0x03 0xff>;
        qcom,no-dfe-support;
      };

      pcie@2,0 {
        reg = <0x21000 0x0 0x0 0x0 0x0>;   # 02:02.0 Switch DSP to [bus 04-ff]
        device_type = "pci";
        bus-range = <0x04 0xff>;
        qcom,nfts = <10>;
      };

      pcie@3,0 {
        reg = <0x21800 0x0 0x0 0x0 0x0>;   # 02:02.1 Switch DSP to [bus 05-ff]
        device_type = "pci";
        bus-range = <0x05 0xff>;
        qcom,tx-amplitude-millivolt = <10>;

        pcie@0,0 {
          reg = <0x50000 0x0 0x0 0x0 0x0>; # 05:00.0 Ethernet MAC, I guess?
          device_type = "pci";
          qcom,l1-entry-delay-ns = <10>;
        };

        ...
      };
    };
  };

So I think the bus-range properties are needed to match the reg
properties of the downstream devices.

I do think the bus-ranges of the Switch Downstream Ports look bogus
because they all extend to bus ff, so they overlap.  The Switch
wouldn't know how to route config transactions to the correct DSP.
I suppose the PCI core would fix these overlaps at boot time, but 
it seems wrong to describe them this way here.

There's an example "reg" decoding and a couple URLs here:
https://lore.kernel.org/r/20250106230705.GA132316@bhelgaas

Bjorn

