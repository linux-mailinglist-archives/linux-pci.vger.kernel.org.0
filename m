Return-Path: <linux-pci+bounces-9307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB31918278
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789432884EC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 13:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049EB185080;
	Wed, 26 Jun 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBtLFCCE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD1D1849CB;
	Wed, 26 Jun 2024 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408693; cv=none; b=QFAwSR7Kp7uZ2PBz+gcPg1UQeFfJekdjIlV5dMfxTvZpYZ48lplAohabTSObK3sKFHCNCmA8RGnLCvpaM1Mg7gFvAm4FE7Nyj48TBrUhMRSGixOHUszaKC0fUZWOu7Vt9MAhKRrx1tfdDZE+jjL2XlyPr+4AgGmk2xhSr/rj8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408693; c=relaxed/simple;
	bh=giXhCnsVoZ650ze2PoXjlVHEuytwY/dyarTP8oKdqw8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=cCqTnvLk+L4XVNoWxcy2knCH/9Od+K8sGKSc73nIxGbR8k0Fexbjn1vFIIltbJTlz94mXUfPSyU4TF5/9RYDJWbdqHeay7IYzm/DUCoNG2JWWTCifBRYQOJdw6ax+cOsINoCi0OT4oiE/AkAefCnn74kNUIDs12VP4Bj/f3FZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBtLFCCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4FEC4AF0C;
	Wed, 26 Jun 2024 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719408693;
	bh=giXhCnsVoZ650ze2PoXjlVHEuytwY/dyarTP8oKdqw8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rBtLFCCENjGh8d/4fkdzHlS/cuQEQSszQY0kBwX9o41KBHt7ZINsuho/Hb4MLy2Fz
	 7w8z7TE7N1GiP9CUJJaahJ6iNvqLz3Fahak+4vZpNlevyM5gZmNpx8lK1ljQHkIpTE
	 4s56O06lG2Eqz4K2T+f5+CY0QsccbVzSXdjalUe9hMadTzQIO4K0JopK4T3pGD2b5Z
	 eRcOd4PXfsn8cfrYYnYh6CpXoqFyVTxNwpSyrqD/YTQpTVSy0nvC+4GmNAEVIylwbR
	 yOZ/8HJWi01moJfFpxatd6Mx7RLJ0yAGpwlKYY1+PzaRSkuBPF5vBizvtTn/NPrVv/
	 1ktONF4l//XGQ==
Date: Wed, 26 Jun 2024 07:31:32 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org, 
 quic_vbadigan@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>, 
 linux-pci@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 quic_skananth@quicinc.com, devicetree@vger.kernel.org, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, quic_nitegupt@quicinc.com, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
Message-Id: <171940833120.2961439.17567783042891416848.robh@kernel.org>
Subject: Re: [PATCH RFC 0/7] PCI: enable Power and configure the QPS615
 PCIe switch


On Wed, 26 Jun 2024 18:07:48 +0530, Krishna chaitanya chundru wrote:
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
> disable unused port etc before link is established. These settings
> vary from platform to platform.
> 
> As the controller starts link training before the probe of pwrctl driver,
> the PCIe link may come up before configuring the switch itself.
> To avoid this introduce two functions in pci_ops to start_link() &
> stop_link() which will disable the link training if the PCIe link is
> not up yet.
> 
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
> In pci pwrctl driver use stop_link() to keep the link in D3cold and
> start_link() to bring back link to D0.
> 
> This series is developed on top the series:
> https://lore.kernel.org/lkml/20240612082019.19161-1-brgl@bgdev.pl/
> 
> we are sending this series to get coments on the usage of stop_link
> and start_link which is being add in this series.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> Krishna chaitanya chundru (7):
>       dt: bindings: add qcom,qps615.yaml
>       arm64: dts: qcom: qcs6490-rb3gen2: Add qps615 node
>       pci: Change the parent of the platform devices for child OF nodes
>       pci: Add new start_link() & stop_link function ops
>       pci: dwc: Add support for new pci function op
>       pci: qcom: Add support for start_link() & stop_link()
>       pci: pwrctl: Add power control driver for qps615
> 
>  .../devicetree/bindings/pci/qcom,qps615.yaml       |  73 ++++++
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |  55 ++++
>  drivers/pci/bus.c                                  |   5 +-
>  drivers/pci/controller/dwc/pcie-designware-host.c  |  19 ++
>  drivers/pci/controller/dwc/pcie-qcom.c             | 108 +++++++-
>  drivers/pci/pwrctl/Kconfig                         |   7 +
>  drivers/pci/pwrctl/Makefile                        |   1 +
>  drivers/pci/pwrctl/core.c                          |   7 +-
>  drivers/pci/pwrctl/pci-pwrctl-qps615.c             | 278 +++++++++++++++++++++
>  include/linux/pci.h                                |   2 +
>  10 files changed, 541 insertions(+), 14 deletions(-)
> ---
> base-commit: d737627471e5b3962eedae870aa0475d6c9bba18
> change-id: 20240624-qps615-faa0cc60dc74
> 
> Best regards,
> --
> Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y qcom/qcs6490-rb3gen2.dtb' for 20240626-qps615-v1-0-2ade7bd91e02@quicinc.com:

arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts:562.12-567.5: Warning (pci_device_reg): /soc@0/pcie@1c08000/pcie@0/qps615@0: PCI unit address format error, expected "2,0"
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts:560.3-27: Warning (pci_device_bus_num): /soc@0/pcie@1c08000/pcie@0/qps615@0:bus-range: PCI bus number 0 out of range, expected (1 - 255)
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: rsc@18200000: 'qps615-0p9-vreg', 'qps615-1p8-vreg', 'qps615-rsex-vreg' do not match any of the regexes: '^regulators(-[0-9])?$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#






