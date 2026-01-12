Return-Path: <linux-pci+bounces-44476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A93D1119E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 09:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CDB83064AD6
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 08:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC633FE2E;
	Mon, 12 Jan 2026 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQ++uRTZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECCF33CEAA;
	Mon, 12 Jan 2026 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205066; cv=none; b=j1e4Ks4n8tYNVT3PIZNRWzeVG+f2mMVPtEBZDH3X6dy4fi7OK6UZFuGVFRaaGoF0eZu2EEOuVplPwU8aDya8W9F93QPX1ogLWcKCUrss5FH6pzdHQYKLDC4Reh2KSjzbbF+KtcAn/KxPt5LcWmlFa+b+8euadC9uWtJwpTremcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205066; c=relaxed/simple;
	bh=790gywg58VKfinQ7BOOrgq2qQPns1Fr3enaFCAJ1ggA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERDE+pqfXSH2sae7ha7fanmwnAwY5YiMS/2aMqPh0QTl89ZrajLnhaqHUMCuzqOk/NmPJ753jMoaGJvYkQ+8xsb/jw5DwUAs9RkIKJqQTeJNEQWcmMBHvpX1kMkgzwtjfZVmSeZNWsCv76Z5xl32T5akb/ctDeDud5Xg48h1LZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQ++uRTZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768205065; x=1799741065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=790gywg58VKfinQ7BOOrgq2qQPns1Fr3enaFCAJ1ggA=;
  b=SQ++uRTZl64zT1Ea9jQu99GqbAbTHGT/dvTFF1Jr1x96tBsaZdi9DT25
   Yy7tTo8XIaGWKKrNIi9mRkV9I96iKqIAOSc5DgNEZ78wIpj16cfeBeqxn
   OisWXKe1y4RuhhS2oglqqwxgEf2YupLrCIrFwXHUiWTfeeB5YBcpn6Gos
   sjldHNkWiNeK1gOYfN9hm9HMH2RSg+l3N6vXh07Fy2e+kl2yWjKG6Hvgn
   G/is1fwMKKr2Bz6NZLlLGiHcg4TCwZ37Sxa1D/dycY7xJb4Js+jvjZgt/
   Gzgl9UMlNSwUHST9sBts0BHET6V4cwtp9AHY0T3krsrj8NRnPRgyEsKdY
   Q==;
X-CSE-ConnectionGUID: V44PJAdRRLKwJUj4l1AgdA==
X-CSE-MsgGUID: ISlFfa0GRlm78rD8KxXxEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69525110"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69525110"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:04:24 -0800
X-CSE-ConnectionGUID: 4fKSH+BmSCeAQ73tY8pC6w==
X-CSE-MsgGUID: JcmglIdNQXmUo0y/QrgF8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208515204"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:04:17 -0800
Date: Mon, 12 Jan 2026 10:04:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v3 00/14] Add support for handling PCIe M.2 Key E
 connectors in devicetree
Message-ID: <aWSq_7_5kkQIv9Hc@smile.fi.intel.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jan 10, 2026 at 12:26:18PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series is the continuation of the series [1] that added the initial support
> for the PCIe M.2 connectors. This series extends it by adding support for Key E
> connectors. These connectors are used to connect the Wireless Connectivity
> devices such as WiFi, BT, NFC and GNSS devices to the host machine over
> interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds support for
> connectors that expose PCIe interface for WiFi and UART interface for BT. Other
> interfaces are left for future improvements.
> 
> Serdev device support for BT
> ============================
> 
> Adding support for the PCIe interface was mostly straightforward and a lot
> similar to the previous Key M connector. But adding UART interface has proved to
> be tricky. This is mostly because of the fact UART is a non-discoverable bus,
> unlike PCIe which is discoverable. So this series relied on the PCI notifier to
> create the serdev device for UART/BT. This means the PCIe interface will be
> brought up first and after the PCIe device enumeration, the serdev device will
> be created by the pwrseq driver. This logic is necessary since the connector
> driver and DT node don't describe the device, but just the connector. So to make
> the connector interface Plug and Play, the connector driver uses the PCIe device
> ID to identify the card and creates the serdev device. This logic could be
> extended in the future to support more M.2 cards. Even if the M.2 card uses SDIO
> interface for connecting WLAN, a SDIO notifier could be added to create the
> serdev device.
> 
> Open questions
> ==============
> 
> Though this series adds the relevant functionality for handling the M.2 Key M
> connectors, there are still a few open questions exists on the design. 
> 
> 1. I've used the DT compatible for the serdev swnode to match the existing OF
> device_id of the bluetooth driver. This avoids implementing custom serdev id
> matching as implemented till v2.

Yeah, swnodes are not designed to replace the real DT or other firmware
interface. The idea of swnodes is to have them providing quirks if needed (i.e.
fixing up the broken or missed FW device properties). This should not have been
done this way. Please, consider another approach, e.g. DT-overlay.

> 2. PCIe client drivers of some M.2 WLAN cards like the Qcom QCA6390, rely on
> the PCIe device DT node to extract properties such as
> 'qcom,calibration-variant', 'firmware-name', etc... For those drivers, should we
> add the PCIe DT node in the Root Port in conjunction with the Port node as
> below?
> 
> pcie@0 {
> 	wifi@0 {
> 		compatible = "pci17cb,1103";
> 		...
> 		qcom,calibration-variant = "LE_X13S";
> 	};
> 
> 	port {
> 		pcie4_port0_ep: endpoint {
> 			remote-endpoint = <&m2_e_pcie_ep>;
> 		};
> 	};
> };
> 
> This will also require marking the PMU supplies optional in the relevant ath
> bindings for M.2 cards.
> 
> 3. Some M.2 cards require specific power up sequence like delays between
> regulator/GPIO and such. For instance, the WCN7850 card supported in this series
> requires 50ms delay between powering up an interface and driving it. I've just
> hardcoded the delay in the driver, but it is a pure hack. Since the pwrseq
> driver doesn't know anything about the device it is dealing with before powering
> it ON, how should it handle the device specific power requirements? Should we
> hardcode the device specific property in the connector node? But then, it will
> no longer become a generic M.2 connector and sort of defeats the purpose of the
> connector binding.
> 
> I hope to address these questions with the help of the relevant subsystem
> maintainers and the community. 
> 
> Testing
> =======
> 
> This series, together with the devicetree changes [2] was tested on the
> Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the WCN7850 WLAN/BT
> 1620 LGA card connected over PCIe and UART.

-- 
With Best Regards,
Andy Shevchenko



