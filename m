Return-Path: <linux-pci+bounces-44552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E03ED1515D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 20:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C78AD304890F
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 19:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB3322B94;
	Mon, 12 Jan 2026 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3gndHcM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C0F320CD5;
	Mon, 12 Jan 2026 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768246194; cv=none; b=CyDtNkP0SKwnanIrFm+OIAeVzguLg3tVYy5GMCMBHnN4NCm6Sl8Pc+PEeKfFYILG3RUmbp3wOmdVVNbdL17PQsUd4BiPPE/vlmhjOWn0ZojIxqZNBOfGBBfvbTzTKWfBUFQgF70Xh7Gm1JFAgX5hScwz1NlxF2frfEkd37dOBZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768246194; c=relaxed/simple;
	bh=/FNl+yM0hGl4sB95N++ILsrhRRKe3muJ5CSF6Ts1Pxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvcdvy4EY84TCctN8KQmQJB7NHqQbPQN/uusZXNigckaABwXazjSc+/2sz85faC0pkGrexZvkJmGyeD7VBOjd+08O1bgrYB3S5vbyKCCuOEDu17U5cVrorcKF3BbYkjOtk74ic/zcq1dSrxfDWpm90/PMYUriYJvvSk0/YIHHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3gndHcM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768246193; x=1799782193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/FNl+yM0hGl4sB95N++ILsrhRRKe3muJ5CSF6Ts1Pxg=;
  b=a3gndHcMrUEeiZ7O7PW5KERg9+HO9xUyrDv6zXdJa+KWbkIfcUsmbp3f
   qVhd2bAx3LPMJ0R5fM6QE8UqCDIrPFneGN8W7/XyzyjGhar59cv2Iu6AX
   E6B11ykn9h2hASa/bAStYCOro1+ueOCPFA/gu7rjk7ahER/yzM3wq+MtO
   Fy/hcHKJi4QotePt3bEHnLVobaJFS8+2cX5Wh61MMwaoEL0LM1fw2fQWr
   +9KvtUNIPalFzxlWqLX4dvGycumU5ZiHzGdp+YCllD1ABxF3GMq/BeoV8
   Aqz2nULxqXRS5Md/TG/KPI5v3MAbezDjD5QFOAHj055/u65I7Ky1Co1eO
   g==;
X-CSE-ConnectionGUID: KImT7tFCTBGTgmRB3HqYFg==
X-CSE-MsgGUID: GZfGabTmRcK2CXO4z9IfQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73370489"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="73370489"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 11:29:53 -0800
X-CSE-ConnectionGUID: DtpOCRNwS4WSwE7pSA5Krw==
X-CSE-MsgGUID: nPyjcCCJQMqWwjQygcO+BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="208646824"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 11:29:46 -0800
Date: Mon, 12 Jan 2026 21:29:44 +0200
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 0/9] Add support for handling PCIe M.2 Key E
 connectors in devicetree
Message-ID: <aWVLqEV4hTzlRYLu@smile.fi.intel.com>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 12, 2026 at 09:55:59PM +0530, Manivannan Sadhasivam via B4 Relay wrote:

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
> 1. Created a dynamic 'bluetooth' node with the compatible property matching the
> WCN7850 device and attached it to the serdev device. This allowed reusing the
> existing OF based BT driver without much modifications.

And now I like the solution, thanks!

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
> 
> Dependency
> ==========
> 
> This series is dependent on the M.2 Key M series [1] on top of v6.19-rc1.
> 
> [1] https://lore.kernel.org/linux-pci/20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com
> [2] https://github.com/Mani-Sadhasivam/linux/commit/753033861360171f2af1fdd56e8985ff916e1ac2
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v4:
> - Switched to dynamic OF node for serdev instead of swnode and dropped all
>   swnode related patches

Yep, and I even won't insist on fwnode API in serdev as now OF one makes more
sense. OTOH, most of the handling on pwrseq and serdev can be rewritten using
fwnode in principle.

> - Link to v3: https://lore.kernel.org/r/20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com


-- 
With Best Regards,
Andy Shevchenko



