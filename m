Return-Path: <linux-pci+bounces-11364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B77E6949473
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 17:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7662885F2
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 15:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AA82A1CA;
	Tue,  6 Aug 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgWJN4FZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D029422;
	Tue,  6 Aug 2024 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957878; cv=none; b=sfjtUWUt+/rFQ8EU1fCvAu4s40URQgGybd3PiFyX80jRQ2VqxijQ4XVMWCTjddhK82ri3RhtNewxLTjfFIiEgDFbSvxcKF9k3haHKM6H2hVU/leGuqeaItRs2omUhgqlXdGz9rKIqCe3m/2goyvZCbf7vcTvNQrrhQwhrUT+fgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957878; c=relaxed/simple;
	bh=cHoGW2bSRG+At92kJxjnX7sq3vyRzPsHjO31vLo1vkI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=b7rEHbxd3rfhahvqkevjyyYBIlS3tz2kyBZ42qXPMV10/hkJPQfdtS7A6LQ0WFMWvZpjs0BPSMy7wDFtvn7Wdzs5C5EqlUYDN4i7fCs3jUtajP2Y2FUDn+LWr+3EmzfBBJu365WDVX7yKW0u8ceTQFexDFsvFaLb3UYs66LdENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgWJN4FZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722957877; x=1754493877;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cHoGW2bSRG+At92kJxjnX7sq3vyRzPsHjO31vLo1vkI=;
  b=PgWJN4FZxqZdrZFZPGD8MxklIDW3Kv6cLCXDyQwP7B98u4nb7lu18Ps+
   bjm/GB89SpxkKBBoDh3P5jbXtNenWk7xVxLJJgJ/X9hIH7gOo4mdO9nc1
   XjncLp8WVcTnPdRH9SReJLjnXUVgXkmoByzmQcgTAfAd7fMu+Y5RHOg/w
   ZBQRYhgUrnQxcNanaX7UIHmKkLvQmC9r1KhYcoDWrhcCnFKgESndPtNnz
   LOdhNF1+qzunl/kWHGUVBqnQKWH3qQUOyNxuwXkUUyoxzyQ3BotPLdWay
   kJjDxIOzxQmfm0EZA/HH/LmMVmUP6LYd30AMUc656EiVGdCIQKI6+1GAT
   Q==;
X-CSE-ConnectionGUID: oLGx2vbwQhWtk6mMboxKXQ==
X-CSE-MsgGUID: WBXMfaSgT1mGWyIXS2ECmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="23897074"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="23897074"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:24:36 -0700
X-CSE-ConnectionGUID: oP9xTk7ZTrW4WS64qv3ivQ==
X-CSE-MsgGUID: JCS2pyk0T5OFgqyooeC4Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61177807"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:24:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Aug 2024 18:24:26 +0300 (EEST)
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, 
    cros-qcom-dts-watchers@chromium.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
    Jingoo Han <jingoohan1@gmail.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    andersson@kernel.org, quic_vbadigan@quicinc.com, 
    linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 0/8] PCI: Enable Power and configure the QPS615 PCIe
 switch
In-Reply-To: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
Message-ID: <f2cbdd06-0318-4be1-e8dc-b91ce103b34c@linux.intel.com>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 3 Aug 2024, Krishna chaitanya chundru wrote:

> QPS615 is the PCIe switch which has one upstream and three downstream
> ports. One of the downstream ports is used as endpoint device of Ethernet
> MAC. Other two downstream ports are supposed to connect to external
> device. One Host can connect to QPS615 by upstream port.
> 
> QPS615 switch power is controlled by the GPIO's. After powering on
> the switch will immediately participate in the link training. if the
> host is also ready by that time PCIe link will established. 
> 
> The QPS615 needs to configured certain parameters like de-emphasis,
> disable unused port etc before link is established.
> 
> The device tree properties are parsed per node under pci-pci bridge in the
> devicetree. Each node has unique bdf value in the reg property, driver
> uses this bdf to differentiate ports, as there are certain i2c writes to
> select particulat port.
>  
> As the controller starts link training before the probe of pwrctl driver,
> the PCIe link may come up before configuring the switch itself.
> To avoid this introduce two functions in pci_ops to start_link() &
> stop_link() which will disable the link training if the PCIe link is
> not up yet.

???

This paragraph contradicts with itself. First it says link training starts 
and the link may come up, and then it says opposite, that is, disable the 
link training if the link is not up yet. So which way it is?

If link can come up, why do you need to disable link training at all? 
Cannot you just trigger another link training after the configuration has 
been done so the new configuration is captured? If not, why?

-- 
 i.

> Now PCI pwrctl device is the child of the pci-pcie bridge, if we want
> to enable the suspend resume for pwrctl device there may be issues
> since pci bridge will try to access some registers in the config which
> may cause timeouts or Un clocked access as the power can be removed in
> the suspend of pwrctl driver.
> 
> To solve this make PCIe controller as parent to the pci pwr ctrl driver
> and create devlink between host bridge and pci pwrctl driver so that
> pci pwrctl driver will go suspend only after all the PCIe devices went
> to suspend.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> Changes in V1:
> - Fix the code as per the comments given.
> - Removed D3cold D0 sequence in suspend resume for now as it needs
>   seperate discussion.
> - change to dt approach for configuring the switch instead of request_firmware() approach
> - Link to v1: https://lore.kernel.org/linux-pci/20240626-qps615-v1-4-2ade7bd91e02@quicinc.com/T/
> ---
> 
> ---
> Krishna chaitanya chundru (8):
>       dt-bindings: PCI: Add binding for qps615
>       dt-bindings: trivial-devices: Add qcom,qps615
>       arm64: dts: qcom: qcs6490-rb3gen2: Add node for qps615
>       PCI: Change the parent to correctly represent pcie hierarchy
>       PCI: Add new start_link() & stop_link function ops
>       PCI: dwc: Add support for new pci function op
>       PCI: qcom: Add support for host_stop_link() & host_start_link()
>       PCI: pwrctl: Add power control driver for qps615
> 
>  .../devicetree/bindings/pci/qcom,qps615.yaml       | 191 ++++++
>  .../devicetree/bindings/trivial-devices.yaml       |   2 +
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       | 121 ++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
>  drivers/pci/bus.c                                  |   3 +-
>  drivers/pci/controller/dwc/pcie-designware-host.c  |  18 +
>  drivers/pci/controller/dwc/pcie-designware.h       |  16 +
>  drivers/pci/controller/dwc/pcie-qcom.c             |  39 ++
>  drivers/pci/pwrctl/Kconfig                         |   7 +
>  drivers/pci/pwrctl/Makefile                        |   1 +
>  drivers/pci/pwrctl/core.c                          |   9 +-
>  drivers/pci/pwrctl/pci-pwrctl-qps615.c             | 638 +++++++++++++++++++++
>  include/linux/pci.h                                |   2 +
>  13 files changed, 1046 insertions(+), 3 deletions(-)
> ---
> base-commit: 1722389b0d863056d78287a120a1d6cadb8d4f7b
> change-id: 20240727-qps615-e2894a38d36f
> 
> Best regards,
> 

