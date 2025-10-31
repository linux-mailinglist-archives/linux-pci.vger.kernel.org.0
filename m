Return-Path: <linux-pci+bounces-39980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10024C27171
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 23:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C92A1B22F96
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 22:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70826329E5E;
	Fri, 31 Oct 2025 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quF/zU/Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51A2E092D;
	Fri, 31 Oct 2025 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761948014; cv=none; b=NjOQPFR3lEtUxDX3HVtk7IEMS0nnLxccrOOJ+Uji83hv2XqPS6R+px2oxXXPd0di6nWsjIOmqmp50fW61CiGSwiDY10zzfKTapKi3vVevT0ifBFads+4Jr325IhCL9iSCuTm8I5Ty8P6mM9myHkzX3RSN71xY5/6vyJkKDAXFBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761948014; c=relaxed/simple;
	bh=O0fhSqjLTinpVRH+cK6fr7ALKjje1XRwe9Px2Bt83Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ig+OfkFIEsHr00Aa7//uErOOXCUKM3IUe7GB5FOrb749l0np27R1Kfx7doJa2CUwIFRUxWOFTptb8E1tSH/7JZ8CPSbOXTw9r0dkZD6yPCrVP7ut6IcPN04zxYKcMbBfbKd80fuYzj4uqqUanA+MLtXH93aZxg9aRspbAD/S8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quF/zU/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95548C4CEE7;
	Fri, 31 Oct 2025 22:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761948013;
	bh=O0fhSqjLTinpVRH+cK6fr7ALKjje1XRwe9Px2Bt83Tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=quF/zU/YfBROOIbiQp5K1GKS/F5/XE7EaFei9v05twKPYSXRdSLZSzygogRRigvgz
	 mX2H4q2mlyw8xrPEbUGRj5lTk4Lw/kPfgA5oAOt9/njm3wckJFsDKjK73CbZdEK4C6
	 mE5q2Sd3dW8iBHU7O5YaPVuHhnzP0aQQ1fKmfftNEUKyVo7J9ZHPuJorVjI1Rx10Pa
	 sE56HW4fI8K1D06g+B5nTIU9pj+CW2dghqzwT1vuFrTZyiskm+z85luhki4G4rR/Nv
	 R1Vk1r+rBzLdCPIK73uy03Yv21epedexkYwogeNfNLgalsMDHKmS8Zo5w7oAOj5mUE
	 Xryox64cfj0Lg==
Date: Fri, 31 Oct 2025 17:00:12 -0500
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
Message-ID: <20251031220012.GA1711108@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-tc9563-v8-1-3eba55300061@oss.qualcomm.com>

On Fri, Oct 31, 2025 at 04:41:58PM +0530, Krishna Chaitanya Chundru wrote:
> Add a device tree binding for the Toshiba TC9563 PCIe switch, which
> provides an Ethernet MAC integrated to the 3rd downstream port and
> two downstream PCIe ports.

> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> @@ -0,0 +1,178 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/toshiba,tc9563.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba TC9563 PCIe switch
> +
> +maintainers:
> +  - rishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

s/rishna/Krishna/ ?

> +  i2c-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A phandle to the parent I2C node and the slave address of the device
> +      used to do configure tc9563 to change FTS, tx amplitude etc.

s/used to do/used to/

> +patternProperties:
> +  "^pcie@[1-3],0$":
> +    description:
> +      child nodes describing the internal downstream ports
> +      the tc9563 switch.

s/ports/ports of/ ?

> +      toshiba,no-dfe-support:
> +        type: boolean
> +        description:
> +          Disable DFE (Decision Feedback Equalizer), which mitigates
> +          intersymbol interference and some reflections caused by impedance mismatches.

Wrap to fit in 78 columns

> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        pcie@0 {
> +            device_type = "pci";
> +            reg = <0x0 0x0 0x0 0x0 0x0>;
> +
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            ranges;
> +            bus-range = <0x01 0xff>;
> +
> +            pcie@0,0 {
> +                compatible = "pci1179,0623";
> +
> +                reg = <0x10000 0x0 0x0 0x0 0x0>;
> +                device_type = "pci";
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                ranges;
> +                bus-range = <0x02 0xff>;
> ...

> +                pcie@1,0 {
> +                    compatible = "pciclass,0604";
> +                    reg = <0x20800 0x0 0x0 0x0 0x0>;
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    device_type = "pci";
> +                    ranges;
> +                    bus-range = <0x03 0xff>;
> +
> +                    toshiba,no-dfe-support;

IIUC, there are two downstream ports available for external devices,
and pcie@1,0 is one of them.

  1) Putting "toshiba,no-dfe-support" in the pcie@1,0 stanza suggests
  that it only applies to that port.

  But from tc9563_pwrctrl_disable_dfe() in "[PATCH v8 6/7] PCI:
  pwrctrl: Add power control driver for tc9563", it looks like it's
  applied to the upstream port and both downstream ports.  So I guess
  my question is putting "toshiba,no-dfe-support" in just one
  downstream port is the right place for it.

  2) I see a lookup of "qcom,no-dfe-support" in [PATCH v8 6/7] PCI:
  pwrctrl: Add power control driver for tc9563; is that supposed to
  match this "toshiba,no-dfe-support"?

> +                };
> +
> +                pcie@2,0 {
> +                    compatible = "pciclass,0604";
> +                    reg = <0x21000 0x0 0x0 0x0 0x0>;
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    device_type = "pci";
> +                    ranges;
> +                    bus-range = <0x04 0xff>;
> +                };
> +
> +                pcie@3,0 {
> +                    compatible = "pciclass,0604";
> +                    reg = <0x21800 0x0 0x0 0x0 0x0>;
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    device_type = "pci";
> +                    ranges;
> +                    bus-range = <0x05 0xff>;
> +
> +                    toshiba,tx-amplitude-microvolt = <10>;
> +
> +                    ethernet@0,0 {
> +                        reg = <0x50000 0x0 0x0 0x0 0x0>;
> +                    };
> +
> +                    ethernet@0,1 {
> +                        reg = <0x50100 0x0 0x0 0x0 0x0>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> 
> -- 
> 2.34.1
> 

