Return-Path: <linux-pci+bounces-11307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1837F947D7D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 17:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3491C22203
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366E15EFB7;
	Mon,  5 Aug 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMW4bezK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6324C15EFA5;
	Mon,  5 Aug 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870017; cv=none; b=BrY0N9zmNQyOb1N40jkV4mEaj/P3LOgW1qY0jZBscOP+z7jNYm72ftEnqDwP8KKBcd05c7WcrH5WkE8jSM01XRaeowsGYESd1otLJNno0RQIkOuK/3nhAGiPin6sx7tYWeooVELqvQ4LNH8uX44trD6pO1MKBjldaSGryN2zS/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870017; c=relaxed/simple;
	bh=WTJSrdytZtczOAu4LbWjwl1Y2flV6/wovwmFy4Bx0Wk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=WezzaWqzl5PQ5KlLbZHl6bwygCBgeyS4uuB5xSAa2ZV5m5qH4/F41sOJNulAKVEsF+Cjar2e0uIpU2CzSyaiyXhfLn9LbO4SvVQJXigKjpAAXIiFzAMQ1v2VnU7iQ7OTm2NVbb821JqXVr9Tz8a3SH/wJFvy8lZFYEItvHe2X/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMW4bezK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6B0C32782;
	Mon,  5 Aug 2024 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722870017;
	bh=WTJSrdytZtczOAu4LbWjwl1Y2flV6/wovwmFy4Bx0Wk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mMW4bezKqanqD7Sd7Tr7JRWAez79nOSPB9FO7I4nQnncT+L8XxsN2dCnAQbBIKPvH
	 aco+9QNqllOW0zusnraUNN/LULkYH9dEBRnLHdgBOu8gkQdKZ5jmlqXzPhOPyUD79i
	 Q3NIVLnRLH5enRSVX0ZUwZPRSDI424YhMzlEoMW+UmqkkqFb+c6qzlRkf9lTG2U2Vg
	 hcSfVR/wH3g+QWiRCJIa3jydLc0pd5k2KbaJSGwjkRmI4l3q2QWptgJwNv1A+89Jgo
	 Zj3KOkNHz4vLGlG/r96mfXVJunFfqdS+oE7VciNyW85IwgoY2c/lhTvCpOYhxUyaHD
	 IaaogWLpfp1AQ==
Date: Mon, 05 Aug 2024 09:00:15 -0600
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
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, quic_vbadigan@quicinc.com, 
 linux-arm-msm@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 linux-pci@vger.kernel.org, andersson@kernel.org, devicetree@vger.kernel.org, 
 cros-qcom-dts-watchers@chromium.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
Message-Id: <172286967047.2709959.5792292507196710539.robh@kernel.org>
Subject: Re: [PATCH v2 0/8] PCI: Enable Power and configure the QPS615 PCIe
 switch


On Sat, 03 Aug 2024 08:52:46 +0530, Krishna chaitanya chundru wrote:
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


New warnings running 'make CHECK_DTBS=y qcom/qcs6490-rb3gen2.dtb' for 20240803-qps615-v2-0-9560b7c71369@quicinc.com:

arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts:746.12-753.5: Warning (pci_device_bus_num): /soc@0/pcie@1c08000/pcie@0/pcie@0,0/pcie@1,0: PCI bus number 2 out of range, expected (0 - 0)
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts:755.12-762.5: Warning (pci_device_bus_num): /soc@0/pcie@1c08000/pcie@0/pcie@0,0/pcie@2,0: PCI bus number 2 out of range, expected (0 - 0)
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts:764.12-786.5: Warning (pci_device_bus_num): /soc@0/pcie@1c08000/pcie@0/pcie@0,0/pcie@3,0: PCI bus number 2 out of range, expected (0 - 0)
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts:771.13-777.6: Warning (pci_device_bus_num): /soc@0/pcie@1c08000/pcie@0/pcie@0,0/pcie@3,0/pcie@0,0: PCI bus number 5 out of range, expected (0 - 0)
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts:779.13-785.6: Warning (pci_device_bus_num): /soc@0/pcie@1c08000/pcie@0/pcie@0,0/pcie@3,0/pcie@0,1: PCI bus number 5 out of range, expected (0 - 0)






