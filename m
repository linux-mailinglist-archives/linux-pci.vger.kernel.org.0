Return-Path: <linux-pci+bounces-39981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8C4C271D1
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 23:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A9B1350EDE
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 22:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0195532AAC3;
	Fri, 31 Oct 2025 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoVKMCTz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E55405F7;
	Fri, 31 Oct 2025 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761948762; cv=none; b=BxfWZGivOHSvQ6sT+/oSqLUlx+oXkej1z0atVTUn03LZ8rp57N6qY3jU/o6xN/4u0CrqsTfv4keX/f8DQk8kL41lbEJu8je8fAX4UNAGbARvZX5pBT2e4egkX5VU9epAjne3Q4MUlf08tL+mlrYoSxEvMeS3c97glWoDvdVexAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761948762; c=relaxed/simple;
	bh=LQIGj4+GI8FzdEo/LJXVwpMQIkuBueWRToPygJMyxcw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sCT2Lfcrts4k5o/UtKBIaYPpqOHQsg/m7OoXXBbWMn7/527ZshSIfV7yJrXjUjcEw51jqJwGECszF5y+A3JKzC53UjushW4KHa58pWYdGie2obqy2lgs6JeA5hxo4VsRjFi3hta/Y0ulnJ6b4DeXthmUzz6AmtKYVuq0OvlPNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoVKMCTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1615AC4CEE7;
	Fri, 31 Oct 2025 22:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761948760;
	bh=LQIGj4+GI8FzdEo/LJXVwpMQIkuBueWRToPygJMyxcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EoVKMCTzxv2nuacn/UU+52fz6MBv1WkGlKNOZWwCbIFO0gvMUUnKN9/BsthrX+jZV
	 EXMFjRzBdyNy2KRko7eIC5TZhnnlCDZcPMzjR/eG0Cnq62UrySfCkIkEn5zJ4YAvp9
	 eUED6VQbIIykcvqFx9fg5k8/PYPXWZZOlg/fGxrY+u9gU+sCV0sfPVjH/8j1nV0Kv/
	 R4JLqQJIvc5TdCgdZtQ73BDMwTqrMH+XljQLBcVwP/soXPhJc9Kk+ApgkLp6O4kgGK
	 esQSy9BMALXliwhqE6T3A7XNMxPeGoDkpBmesmvqI3fF9fWzrxwEwQj5qzYSCLpThe
	 Pt2BA/t9Sd3NA==
Date: Fri, 31 Oct 2025 17:12:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 1/7] dt-bindings: PCI: Add binding for Toshiba TC9563
 PCIe switch
Message-ID: <20251031221238.GA1711866@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031220012.GA1711108@bhelgaas>

On Fri, Oct 31, 2025 at 05:00:13PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 31, 2025 at 04:41:58PM +0530, Krishna Chaitanya Chundru wrote:
> > Add a device tree binding for the Toshiba TC9563 PCIe switch, which
> > provides an Ethernet MAC integrated to the 3rd downstream port and
> > two downstream PCIe ports.

> > +                pcie@1,0 {
> > +                    compatible = "pciclass,0604";
> > +                    reg = <0x20800 0x0 0x0 0x0 0x0>;
> > +                    #address-cells = <3>;
> > +                    #size-cells = <2>;
> > +                    device_type = "pci";
> > +                    ranges;
> > +                    bus-range = <0x03 0xff>;
> > +
> > +                    toshiba,no-dfe-support;
> 
> IIUC, there are two downstream ports available for external devices,
> and pcie@1,0 is one of them.
> 
>   1) Putting "toshiba,no-dfe-support" in the pcie@1,0 stanza suggests
>   that it only applies to that port.
> 
>   But from tc9563_pwrctrl_disable_dfe() in "[PATCH v8 6/7] PCI:
>   pwrctrl: Add power control driver for tc9563", it looks like it's
>   applied to the upstream port and both downstream ports.  So I guess
>   my question is putting "toshiba,no-dfe-support" in just one
>   downstream port is the right place for it.

Oh, I see, never mind.  You keep track of ->disable_dfe on a per-port
basis, so each port has the *possibility* of using it, and you skip
programming it if the port doesn't have it.

I would assume the two downstream ports for external devices would be
identical, so I do still wonder why you would specify this for only
one of them.

>   2) I see a lookup of "qcom,no-dfe-support" in [PATCH v8 6/7] PCI:
>   pwrctrl: Add power control driver for tc9563; is that supposed to
>   match this "toshiba,no-dfe-support"?
> 
> > +                };
> > +
> > +                pcie@2,0 {
> > +                    compatible = "pciclass,0604";
> > +                    reg = <0x21000 0x0 0x0 0x0 0x0>;
> > +                    #address-cells = <3>;
> > +                    #size-cells = <2>;
> > +                    device_type = "pci";
> > +                    ranges;
> > +                    bus-range = <0x04 0xff>;
> > +                };
> > +
> > +                pcie@3,0 {
> > +                    compatible = "pciclass,0604";
> > +                    reg = <0x21800 0x0 0x0 0x0 0x0>;
> > +                    #address-cells = <3>;
> > +                    #size-cells = <2>;
> > +                    device_type = "pci";
> > +                    ranges;
> > +                    bus-range = <0x05 0xff>;
> > +
> > +                    toshiba,tx-amplitude-microvolt = <10>;

Same question here about whether "toshiba,tx-amplitude-microvolt" is
supposed to match the "qcom,tx-amplitude-microvolt" in the driver.

> > +                    ethernet@0,0 {
> > +                        reg = <0x50000 0x0 0x0 0x0 0x0>;
> > +                    };
> > +
> > +                    ethernet@0,1 {
> > +                        reg = <0x50100 0x0 0x0 0x0 0x0>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
> > 
> > -- 
> > 2.34.1
> > 

