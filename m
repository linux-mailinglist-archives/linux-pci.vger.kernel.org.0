Return-Path: <linux-pci+bounces-41523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7C8C6B44A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 19:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D25142923D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FE0225390;
	Tue, 18 Nov 2025 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olkFA1QK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB520C48A;
	Tue, 18 Nov 2025 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491530; cv=none; b=ZtToJLGKRaGWSJD7pmUnf9EWcIdIYAjrQMavVXIe3VN3VawKyBKrSodn4JncYea2huSzkf6KxTO7XyHogS7VYv9gZB8zzBH6sSB68Dd0aeNia8Gc6J/OIIV0Jt5FT94wVvGWVhpdwTnUQXCjL6DfNRyJONN4ckxT5i1/ZkltXGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491530; c=relaxed/simple;
	bh=6f58PRvKFkPh7LpJwZK27THW4/eyjaxEvpsou4a3DUg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MyCL/w8nxBAIbOBkSwbqVZT29lVlJ2oFpAHUC5YL8bz7mugGjDfRLRrilqYhmuWPVNl1Z+w/VkE8vDyMqvZd7P8zf48wHsvIM5vnwedhgBYeUnMDcFmLzpMzd1b852f+nAtZE50ir9T5/lWjnkOv0B3s+kPhkOpdIy9KudOtCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olkFA1QK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67F4C2BCB4;
	Tue, 18 Nov 2025 18:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763491528;
	bh=6f58PRvKFkPh7LpJwZK27THW4/eyjaxEvpsou4a3DUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=olkFA1QKiEIh54DeHw/MOZ/H3l+sy0QX7HyWDXfdbKT/kaGlM3jXV2FIuKZgHnXtl
	 lAMKO0msifxm+HUaTZqfmdOhlG72ti8GM1/00Tn34+h4NpZYxMYx8knYHsIZeeObfe
	 W/KOwikIqx4vNEnYM08zyOkAtKqB7ManqociEuZd7+2sqPdvDDyP8ecED2vfxa6IPB
	 BFyYWfULA1Tu8c075zX0q1xyIsR6O84zzZ/iBJePyZFODcGNWbhgojY4PoXbdhZ04m
	 CPjP/AO96vjL+91E4697K7oIrfjSm5AT6b9ElT3XVUC2m6/SpPY6E9isFnb8axyoKr
	 uUTUWVEVXwoKw==
Date: Tue, 18 Nov 2025 12:45:25 -0600
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
	linux-arm-msm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/7] PCI: Enable Power and configure the TC9563 PCIe
 switch
Message-ID: <20251118184525.GA2583175@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>

On Sat, Nov 01, 2025 at 09:29:31AM +0530, Krishna Chaitanya Chundru wrote:
> TC9563 is the PCIe switch which has one upstream and three downstream
> ports. To one of the downstream ports ethernet MAC is connected as endpoint
> device. Other two downstream ports are supposed to connect to external
> device. One Host can connect to TC956x by upstream port.
> 
> TC9563 switch power is controlled by the GPIO's. After powering on
> the switch will immediately participate in the link training. if the
> host is also ready by that time PCIe link will established. 
> 
> The TC9563 needs to configured certain parameters like de-emphasis,
> disable unused port etc before link is established.
> 
> As the controller starts link training before the probe of pwrctl driver,
> the PCIe link may come up as soon as we power on the switch. Due to this
> configuring the switch itself through i2c will not have any effect as
> this configuration needs to done before link training. To avoid this
> introduce assert_perst() which asserts & de-asserts the PERST# which helps
> to stop switch from participating from the link training.
> 
> Note: The QPS615 PCIe switch is rebranded version of Toshiba switch TC9563 series.
> There is no difference between both the switches, both has two open downstream ports
> and one embedded downstream port to which Ethernet MAC is connected. As QPS615 is the
> rebranded version of Toshiba switch rename qps615 with tc9563 so that this driver
> can be leveraged by all who are using Toshiba switch.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v9:
> - Change driver to align with dt properties (Bjorn).
> - Link to v8: https://lore.kernel.org/r/20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com
> 
> Changes in v8:
> - Rebase on the pci branch (Bjorn)
> - Change order of the patch (Dmitry)
> - Couple of nits pointed by (Ilpo)
> - Change reset-gpios to resx-gpios (Mani)
> - Link to v7: https://lore.kernel.org/r/20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com
> 
> Changes in v7:
> - Rename stop_link() & start_link() to asser_perst() and change all
>   occurances  (Bjorn).
> - Remove PCIe link is active check & relevent patch,  assume this driver will
>   be for the swicth connected directly to the root port, if it is
>   connected in the DSP of another switch we can't control the link so driver will not have any impact
>   we need make them as fixed regulators for now.
> - Link to v6: https://lore.kernel.org/r/20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com
> 
> Changes in v6:
> - Took v10 patch  https://lore.kernel.org/all/1822371399.1670864.1756212520886.JavaMail.zimbra@raptorengineeringinc.com/
>   to my series as my change is dependent on it.
> - Add Reviewed-by tag by Rob on dt-binding patch.
> - Add Reviewed-by tag by Dmitry on devicetree.
> - Fixed compilation errors.
> - Fixed n-fts issue point by (Bjorn Helgaas).
> - Fixed couple of nits by (Bjorn Helgas).
> - Link to v5: https://lore.kernel.org/r/20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com
> Changes from v4:
> - Rename tc956x to tc9563, instead of using x which represents overlay board one
>   use actual name (Konrad & Krzysztof).
> - Remove the patches 9 & 10 from the series and this will be added by mani
> - Couple of nits by Konrad
> - Have defconfig change for TC956X by Dmitry
> - Change the function name pcie_is_link_active to pcie_link_is_active
>   replace all call sites of pciehp_check_link_active() with a call
>   to the new function. return bool instead of int (Lukas)
> - Add pincntrl property for reset gpio (Dmitry)
> - Follow the example-schema order, remove ref for the
>   tx-amplitude-microvolt, change the vendor prefix (Krzysztof)
> - for USP node refer pci-bus-common.yaml and for remaining refer
>   pci-pci-bridge.yaml(Mani)
> - rebase to latest code and change pci dev retrieval logic due code
>   changes in the latest tip.
> - Link to v4: https://lore.kernel.org/r/20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com
> changes from v3:
> - move common properties like l0s-delay, l1-delay and nfts to pci-host-common.yaml (bjorn H)
> - remove axi-clk-frequency property (Krzysztof)
> - Update the pattern properties (Rob)
> - use pci-pci-bridge as the reference (Rob)
> - change tx-amplitude-millivolt to tx-amplitude-microvolt  (Krzysztof)
> - rename qps615_pwrctl_power_on to qps615_pwrctl_bring_up (Bart)
> - move the checks for l0s_delay, l1_delay etc to helper functon to
>   reduce a level of indentation (Bjorn H)
> - move platform_set_drvdata to end after there is no error return (bjorn H)
> - Replace GPIOD_ASIS to GPIOD_OUT_HIGH (Mani)
> - Create a common api to check if link is up or not and use that to call
>   stop_link() and start_link().
> - couple of nits in comments, names etc from everyone
> Link to v3: https://lore.kernel.org/all/20241112-qps615_pwr-v3-3-29a1e98aa2b0@quicinc.com/T/
> Changes from v2:
> - As per offline discussions with rob i2c-parent is best suitable to
>   use i2c client device. So use i2c-parent as suggested and remove i2c
>   client node reference from the dt-bindings & devicetree.
> - Remove "PCI: Change the parent to correctly represent pcie hierarchy"
>   as this requires seperate discussions.
> - Remove bdf logic to identify the dsp's and usp's to make it generic
>   by using the logic that downstream devices will always child of
>   upstream node and dsp1, dsp2 will always in same order (Dmitry)
> - Remove recursive function for parsing devicetree instead parse
>   only for required devicetree nodes (Dmitry)
> - Fix the issue in be & le conversion (Dmitry).
> - Call put_device for i2c device once done with the usage (Dmitry)
> - Use $defs to describe common properties between upstream port and
>   downstream properties. and remove unneccessary if then. (Krzysztof)
> - Place the qcom,qps615 compatibility in dt-binding document in alphabatic order (Krzysztof)
> - Rename qcom,no-dfe to describe it as hardware capability and change
>   qcom,nfts description to reflect hardware details (Krzysztof)
> - Fix the indentation in the example in dt binding (Dmitry)
> - Add more description to qcom,nfts (Dmitry)
> - Remove nanosec from the property description (Dmitry)
> - Link to v2: https://lore.kernel.org/r/linux-arm-msm/20240803-qps615-v2-0-9560b7c71369@quicinc.com/T/
> Changes from v1:
> - Instead of referencing whole i2c-bus add i2c-client node and reference it (Dmitry)
> - Change the regulator's as per the schematics as per offline review
> (Bjorn Andresson)
> - Remove additional host check in bus.c (Bart)
> - For stop_link op change return type from int to void (Bart)
> - Remove firmware based approach for configuring sequence as suggested
> by multiple reviewers.
> - Introduce new dt-properties for the switch to configure the switch
> as we are replacing the firmware based approach.
> - The downstream ports add properties in the child nodes which will
> represented in PCIe hierarchy format.
> - Removed D3cold D0 sequence in suspend resume for now as it needs
> separate discussion.
> - Link to v1: https://lore.kernel.org/linux-pci/20240626-qps615-v1-4-2ade7bd91e02@quicinc.com/T/
> 
> ---
> Krishna Chaitanya Chundru (7):
>       dt-bindings: PCI: Add binding for Toshiba TC9563 PCIe switch
>       PCI: Add assert_perst() operation to control PCIe PERST#
>       PCI: dwc: Add assert_perst() hook for dwc glue drivers
>       PCI: dwc: Implement .assert_perst() hook
>       PCI: qcom: Add support for assert_perst()
>       PCI: pwrctrl: Add power control driver for TC9563
>       arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563 PCIe switch node
> 
>  .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 179 ++++++
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       | 128 ++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
>  drivers/pci/controller/dwc/pcie-designware-host.c  |   9 +
>  drivers/pci/controller/dwc/pcie-designware.h       |   9 +
>  drivers/pci/controller/dwc/pcie-qcom.c             |  13 +
>  drivers/pci/pwrctrl/Kconfig                        |  14 +
>  drivers/pci/pwrctrl/Makefile                       |   2 +
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 648 +++++++++++++++++++++
>  include/linux/pci.h                                |   1 +
>  10 files changed, 1004 insertions(+), 1 deletion(-)

Applied to pci/pwrctrl-tc9563 for v6.19, except for the
arch/arm64/boot/dts/qcom/ patch, which I assume will be handled
elsewhare (note the apparent typo in that patch pointed out by
Konrad).

