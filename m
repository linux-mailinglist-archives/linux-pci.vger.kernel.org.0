Return-Path: <linux-pci+bounces-43527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38010CD653A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 15:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0E4730024A4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387BA2D12F3;
	Mon, 22 Dec 2025 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NitRYNPv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB88F283FDD;
	Mon, 22 Dec 2025 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766412469; cv=none; b=UgWZy672jSJTf2+iF/ibEh/A1C54RUxOaSmwZ0cCuFlPYlZ6t552dY9MVFabfDnHa1kEa6r/fK8NGjZ2uibNJV7gWEbb1A09JB097H94uAP/xWPGftQCYMq6HNcO9/cFHYLgM4wbLXyVRGFUcBQDS/mgmxh9F/7JqTuu7XlLy0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766412469; c=relaxed/simple;
	bh=UOGYbwV4khizIIRkAZEZ1DrHXk7kYjdhqrezBYqAA7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqWgM38/sZuTalGNcJF51FIHp5lVdBb4QFz0QYZg5jv3YC8KTCWOwb/LUQvL9QQT508oGOIg1itgh2xQG4wQf7eGtiWjXUvExO/W/gi+blT+zlrvMShmN0PYDsfLd7lOd6YXxvbRmV+o/MUonqcGBWlSrWmC1v53CaH2Qwg/mHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NitRYNPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CD4C4CEF1;
	Mon, 22 Dec 2025 14:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766412468;
	bh=UOGYbwV4khizIIRkAZEZ1DrHXk7kYjdhqrezBYqAA7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NitRYNPvIDex3swqylD4WNfRjVbR/bL6FXStoDH7LCIy4B+888HSCmpnVuf2RASRR
	 tKURip7NkNgixeDYA9a8FcqmQdidzevjjx0dxRhsqJDNW+pM2RJxH4h8tZVnS9C0Na
	 oioopBrRVbIXKkkJtRjcl7s1PzFFtYcBmPF37C5mVqF9WaXRB1U6D0clzDghYveDWm
	 Se4x2fakW8N7B4oJMLcVj0aI2MOSwDSVE8G32Vte+JbL/pkjGM5/0JhqEq/lsptzqx
	 Z9yeM4/+Nhul31zfAvGm41yePHjelZ4DCHesVf4L6zJc71PrEW8/M2rH6uCPrHj/Bg
	 R8OGyQTYCfRzg==
Date: Mon, 22 Dec 2025 19:37:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 00/10] Add support for handling PCIe M.2 Key E
 connectors in devicetree
Message-ID: <lrpxki6crdiezqam3nuw3pi45digirjpqxpvyjvwjugux6rjk5@3wpmtl77oj6f>
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
 <aSYKHjpJkXWUVIyo@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSYKHjpJkXWUVIyo@linaro.org>

On Tue, Nov 25, 2025 at 08:57:18PM +0100, Stephan Gerhold wrote:
> On Tue, Nov 25, 2025 at 08:15:04PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > This series is the continuation of the series [1] that added the initial support
> > for the PCIe M.2 connectors. This series extends it by adding support for Key E
> > connectors. These connectors are used to connect the Wireless Connectivity
> > devices such as WiFi, BT, NFC and GNSS devices to the host machine over
> > interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds support for
> > connectors that expose PCIe interface for WiFi and UART interface for BT. Other
> > interfaces are left for future improvements.
> > 
> > Serdev device support for BT
> > ============================
> > 
> > Adding support for the PCIe interface was mostly straightforward and a lot
> > similar to the previous Key M connector. But adding UART interface has proved to
> > be tricky. This is mostly because of the fact UART is a non-discoverable bus,
> > unlike PCIe which is discoverable. So this series relied on the PCI notifier to
> > create the serdev device for UART/BT. This means the PCIe interface will be
> > brought up first and after the PCIe device enumeration, the serdev device will
> > be created by the pwrseq driver. This logic is necessary since the connector
> > driver and DT node don't describe the device, but just the connector. So to make
> > the connector interface Plug and Play, the connector driver uses the PCIe device
> > ID to identify the card and creates the serdev device. This logic could be
> > extended in the future to support more M.2 cards. Even if the M.2 card uses SDIO
> > interface for connecting WLAN, a SDIO notifier could be added to create the
> > serdev device.
> > 
> > Open questions
> > ==============
> > 
> > Though this series adds the relevant functionality for handling the M.2 Key M
> > connectors, there are still a few open questions exists on the design. 
> > 
> > 1. I've used the M.2 card model name as the serdev device name. This is found
> > out by comparing the PCIe VID:PID in the notifier. Is this approach acceptable?
> > I did not use the PID as the serdev name since it will vary if the SDIO
> > interface is used in the future.
> > 
> > 2. PCIe client drivers of some M.2 WLAN cards like the Qcom QCA6390, rely on
> > the PCIe device DT node to extract properties such as
> > 'qcom,calibration-variant', 'firmware-name', etc... For those drivers, should we
> > add the PCIe DT node in the Root Port in conjunction with the Port node as
> > below?
> > 
> > pcie@0 {
> > 	wifi@0 {
> > 		compatible = "pci17cb,1103";
> > 		...
> > 		qcom,calibration-variant = "LE_X13S";
> > 	};
> > 
> > 	port {
> > 		pcie4_port0_ep: endpoint {
> > 			remote-endpoint = <&m2_e_pcie_ep>;
> > 		};
> > 	};
> > };
> > 
> > This will also require marking the PMU supplies optional in the relevant ath
> > bindings for M.2 cards.
> > 
> > 3. Some M.2 cards require specific power up sequence like delays between
> > regulator/GPIO and such. For instance, the WCN7850 card supported in this series
> > requires 50ms delay between powering up an interface and driving it. I've just
> > hardcoded the delay in the driver, but it is a pure hack. Since the pwrseq
> > driver doesn't know anything about the device it is dealing with before powering
> > it ON, how should it handle the device specific power requirements? Should we
> > hardcode the device specific property in the connector node? But then, it will
> > no longer become a generic M.2 connector and sort of defeats the purpose of the
> > connector binding.
> > 
> > I hope to address these questions with the help of the relevant subsystem
> > maintainers and the community. 
> > 
> > Testing
> > =======
> > 
> > This series, together with the devicetree changes [2] was tested on the
> > Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the WCN7850 WLAN/BT M.2
> > card connected over PCIe and UART.
> > 
> > [2] https://github.com/Mani-Sadhasivam/linux/commit/acbee74a5c90fc8839bb7b6f326c677ee1c0d89c
> 

Sorry for the delay!

> Thanks for working on describing the M.2 connectors properly in the
> device tree!
> 
> I haven't had time to look into this in detail yet, but a quick look at
> the dt-bindings and examples looks good to me! Thanks for keeping the
> bindings as generic as possible.
> 

Thanks for pushing me too ;)

> I have a small nitpick for the specific example you have here: The
> Lenovo ThinkPad T14s does not actually have a "M.2 Mechanical Key E
> connector". If you look at a picture of the mainboard [1], the WLAN/BT
> module is "soldered-down" (look on the right, on the right side next to
> the large copper bracket). In the M.2 specification, "soldered-down"
> modules do not have a "key", they have a specific pinout that is
> followed (see section 5.4). The power sequencing etc and the set of pins
> is quite similar/the same though.
> 

Oh, I was shared one schematics internally and told that it was the mirror of
the T14s and it had the M.2 slot. So I just went with that. I didn't dare to
open the cover of my corporate laptop ;)

But this is a good info, thanks!

> My notes (from a few months ago) suggest the T14s probably uses a
> non-standard M.2 Type 1620 LGA pinout. I don't remember the exact chain
> of thought behind that, but you can find similarly looking modules with
> this type, e.g. https://www.sparklan.com/product/wnsq-290be/. There is a
> 1620 *BGA* pinout in the M.2 specification, but a 1620 *LGA* pinout does
> not exist there. Interestingly, in the block diagram of the module in
> the link above this type is called *Q*M.2 1620 LGA 168 pin, as if this
> is some Qualcomm-specific form factor.
> 

But the spec uses 1620 BGA for defining the SSD pinout. So 1620 LGA indeed looks
like a custom one.

> A real mechanical key E connector can be found e.g. in the X1E CRD, X1E
> Devkit, or I think some of the X1E-based HP laptops (would need to check
> which one exactly).
> 
> I'm not sure if it's really appropriate modeling the "soldered-down"
> variant as "Mechanical Key E connector" in the DT. We might need
> a separate compatible for this. Do you have any thoughts about that?
> 

I think having a separate compatible that uses the same binding should be
sufficient since the interfaces are almost the same.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

