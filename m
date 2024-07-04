Return-Path: <linux-pci+bounces-9780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84278927068
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 09:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0565F1F24F3F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 07:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12F21A08B5;
	Thu,  4 Jul 2024 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNT6WK4U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87227200A3;
	Thu,  4 Jul 2024 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077608; cv=none; b=apCyaVXZiCzbb1paaQ5Y7OqCjydvwiigkpH9+7DedFU7vcSjMCPPURZobPjPOmALY/BnOxl8eE/z1nZeEq+NXY67SnCFjHyBuSWhvNWP2I/r1GFaVYLhRqdMMrZhG19mRaT4kFjShrciQIFEt0fWPTypTr2IGDMenwHZ+mAKmYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077608; c=relaxed/simple;
	bh=gHWMHslRI8lW3lNZ78emYfmyUUytiCwE7709u2zTBrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7RU9Fr2DEx+GH3jurJIFtXTO1Ej3WXWi2xnrAQg1D+R9ZGH0li3VZ69X+iIUfwR3NjpAePjdevu7A7BCSmO2W32NwaBBuQH9HKU5phHP+UZ5VjwotQPRtiqleeIYJetgz0em+A1wS2VUwBXQw5JLXHWkHD5+3jGyMR8WZ5jbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNT6WK4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD396C3277B;
	Thu,  4 Jul 2024 07:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720077608;
	bh=gHWMHslRI8lW3lNZ78emYfmyUUytiCwE7709u2zTBrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNT6WK4UoIx9eW8wzDWQWQ116qT3CSQP5OdnMPKH7ggRmT+GabHfL0lhNLrjkemuW
	 s1/qMAJDRHPhvkntupX+c6G0UvNikyH80tN+3t5a0G86vcf7zgOTs51NwLuo8VDHzV
	 SdHYico0DcSWJcY1iigrUWmZ49VRflnF+HsIFy5z9dz7tuWlrFU+ixSWVoi6voELIs
	 /z2/faRA+x721g/Mlr2ew8JSFwNxvACBMln+PJZoZkmuhHaxuZyDQv7fR7ud/vMJwK
	 NXafH5NnpTygo1VZbG57fSLDYMDUL6bVWBudWtg2Z/8RfSDqtBYOL/qvmJBKMQaEig
	 vHJ2m5Q1VcAag==
Date: Thu, 4 Jul 2024 16:20:06 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Abel Vesa <abel.vesa@linaro.org>, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, "Rob Herring (Arm)" <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [pci:dt-bindings 10/11]
 arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pci@1bf8000: reg: [[0, 29327360,
 0, 12288], [0, 1879048192, 0, 3869], [0, 1879052064, 0, 168], [0,
 1879052288, 0, 4096], [0, 1880096768, 0, 1048576]] is too short
Message-ID: <20240704072006.GA2768618@rocinante>
References: <202407041154.pTMBERxA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202407041154.pTMBERxA-lkp@intel.com>

Hello,

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bi=
ndings
> head:   a50a3d6870292c08a4e941449ba4ddc8339a2b14
> commit: 9d02ca5cda560bdce0f349bece5204bdae339f8f [10/11] dt-bindings: PCI=
: qcom: x1e80100: Make the MHI reg region mandatory
> config: arm64-randconfig-051-20240704 (https://download.01.org/0day-ci/ar=
chive/20240704/202407041154.pTMBERxA-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> dtschema version: 2024.6.dev3+g650bf2d
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240704/202407041154.pTMBERxA-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407041154.pTMBERxA-lkp=
@intel.com/
>=20
> dtcheck warnings: (new ones prefixed by >>)
>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: phy@fd5000: 'vdda-pll-suppl=
y' is a required property
>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-=
usb43dp-phy.yaml#
>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: phy@fda000: 'vdda-phy-suppl=
y' is a required property
>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-=
usb43dp-phy.yaml#
>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: phy@fda000: 'vdda-pll-suppl=
y' is a required property
>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-=
usb43dp-phy.yaml#
>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: phy@fdf000: 'vdda-phy-suppl=
y' is a required property
>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-=
usb43dp-phy.yaml#
>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: phy@fdf000: 'vdda-pll-suppl=
y' is a required property
>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-=
usb43dp-phy.yaml#
> >> arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pci@1bf8000: reg: [[0, 2932=
7360, 0, 12288], [0, 1879048192, 0, 3869], [0, 1879052064, 0, 168], [0, 187=
9052288, 0, 4096], [0, 1880096768, 0, 1048576]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100=
=2Eyaml#
> >> arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pci@1bf8000: reg-names: ['p=
arf', 'dbi', 'elbi', 'atu', 'config'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100=
=2Eyaml#
>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: usb@a2f8800: interrupt-name=
s: ['pwr_event', 'dp_hs_phy_irq', 'dm_hs_phy_irq'] is too short
>    	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pmic@7: compatible:0: 'qcom=
,smb2360' is not one of ['qcom,pm2250', 'qcom,pm6125', 'qcom,pm6150', 'qcom=
,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b', 'qco=
m,pm7550ba', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm8009', 'q=
com,pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,pm8150', 'q=
com,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', 'qcom,pm8350',=
 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8450', 'qcom,pm8550', 'qcom,pm8550=
b', 'qcom,pm8550ve', 'qcom,pm8550vs', 'qcom,pm8841', 'qcom,pm8909', 'qcom,p=
m8916', 'qcom,pm8937', 'qcom,pm8941', 'qcom,pm8950', 'qcom,pm8953', 'qcom,p=
m8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmc8180', 'qcom,pmc8180c', 'qc=
om,pmd9635', 'qcom,pmi632', 'qcom,pmi8950', 'qcom,pmi8962', 'qcom,pmi8994',=
 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', 'qcom,pmk8550', 'qcom,pmm8=
155au', 'qcom,pmm8654au', 'qcom,pmp8074', 'qcom,pmr735a', 'qcom,pmr735b', '=
qcom,pmr735d', 'qcom,pms405', 'qcom,pmx55', 'qcom,pmx65', 'qcom,pmx75', 'qc=
om,smb2351']
>    	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yam=
l#
>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: /soc@0/arbiter@c400000/spmi=
@c432000/pmic@7: failed to match any schema with compatible: ['qcom,smb2360=
', 'qcom,spmi-pmic']
>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pmic@a: compatible:0: 'qcom=
,smb2360' is not one of ['qcom,pm2250', 'qcom,pm6125', 'qcom,pm6150', 'qcom=
,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b', 'qco=
m,pm7550ba', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm8009', 'q=
com,pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,pm8150', 'q=
com,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', 'qcom,pm8350',=
 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8450', 'qcom,pm8550', 'qcom,pm8550=
b', 'qcom,pm8550ve', 'qcom,pm8550vs', 'qcom,pm8841', 'qcom,pm8909', 'qcom,p=
m8916', 'qcom,pm8937', 'qcom,pm8941', 'qcom,pm8950', 'qcom,pm8953', 'qcom,p=
m8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmc8180', 'qcom,pmc8180c', 'qc=
om,pmd9635', 'qcom,pmi632', 'qcom,pmi8950', 'qcom,pmi8962', 'qcom,pmi8994',=
 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', 'qcom,pmk8550', 'qcom,pmm8=
155au', 'qcom,pmm8654au', 'qcom,pmp8074', 'qcom,pmr735a', 'qcom,pmr735b', '=
qcom,pmr735d', 'qcom,pms405', 'qcom,pmx55', 'qcom,pmx65', 'qcom,pmx75', 'qc=
om,smb2351']
>    	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yam=
l#
>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: /soc@0/arbiter@c400000/spmi=
@c432000/pmic@a: failed to match any schema with compatible: ['qcom,smb2360=
', 'qcom,spmi-pmic']
>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pmic@b: compatible:0: 'qcom=
,smb2360' is not one of ['qcom,pm2250', 'qcom,pm6125', 'qcom,pm6150', 'qcom=
,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b', 'qco=
m,pm7550ba', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm8009', 'q=
com,pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,pm8150', 'q=
com,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', 'qcom,pm8350',=
 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8450', 'qcom,pm8550', 'qcom,pm8550=
b', 'qcom,pm8550ve', 'qcom,pm8550vs', 'qcom,pm8841', 'qcom,pm8909', 'qcom,p=
m8916', 'qcom,pm8937', 'qcom,pm8941', 'qcom,pm8950', 'qcom,pm8953', 'qcom,p=
m8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmc8180', 'qcom,pmc8180c', 'qc=
om,pmd9635', 'qcom,pmi632', 'qcom,pmi8950', 'qcom,pmi8962', 'qcom,pmi8994',=
 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', 'qcom,pmk8550', 'qcom,pmm8=
155au', 'qcom,pmm8654au', 'qcom,pmp8074', 'qcom,pmr735a', 'qcom,pmr735b', '=
qcom,pmr735d', 'qcom,pms405', 'qcom,pmx55', 'qcom,pmx65', 'qcom,pmx75', 'qc=
om,smb2351']
> --
>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: phy@fd5000: 'vdda-pll-suppl=
y' is a required property
>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-=
usb43dp-phy.yaml#
>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: phy@fda000: 'vdda-phy-suppl=
y' is a required property
>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-=
usb43dp-phy.yaml#
>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: phy@fda000: 'vdda-pll-suppl=
y' is a required property
>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-=
usb43dp-phy.yaml#
>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: phy@fdf000: 'vdda-phy-suppl=
y' is a required property
>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-=
usb43dp-phy.yaml#
>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: phy@fdf000: 'vdda-pll-suppl=
y' is a required property
>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-=
usb43dp-phy.yaml#
> >> arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bf8000: reg: [[0, 2932=
7360, 0, 12288], [0, 1879048192, 0, 3869], [0, 1879052064, 0, 168], [0, 187=
9052288, 0, 4096], [0, 1880096768, 0, 1048576]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100=
=2Eyaml#
> >> arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bf8000: reg-names: ['p=
arf', 'dbi', 'elbi', 'atu', 'config'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100=
=2Eyaml#
>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: usb@a2f8800: interrupt-name=
s: ['pwr_event', 'dp_hs_phy_irq', 'dm_hs_phy_irq'] is too short
>    	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pmic@7: compatible:0: 'qcom=
,smb2360' is not one of ['qcom,pm2250', 'qcom,pm6125', 'qcom,pm6150', 'qcom=
,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b', 'qco=
m,pm7550ba', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm8009', 'q=
com,pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,pm8150', 'q=
com,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', 'qcom,pm8350',=
 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8450', 'qcom,pm8550', 'qcom,pm8550=
b', 'qcom,pm8550ve', 'qcom,pm8550vs', 'qcom,pm8841', 'qcom,pm8909', 'qcom,p=
m8916', 'qcom,pm8937', 'qcom,pm8941', 'qcom,pm8950', 'qcom,pm8953', 'qcom,p=
m8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmc8180', 'qcom,pmc8180c', 'qc=
om,pmd9635', 'qcom,pmi632', 'qcom,pmi8950', 'qcom,pmi8962', 'qcom,pmi8994',=
 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', 'qcom,pmk8550', 'qcom,pmm8=
155au', 'qcom,pmm8654au', 'qcom,pmp8074', 'qcom,pmr735a', 'qcom,pmr735b', '=
qcom,pmr735d', 'qcom,pms405', 'qcom,pmx55', 'qcom,pmx65', 'qcom,pmx75', 'qc=
om,smb2351']
>    	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yam=
l#
>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: /soc@0/arbiter@c400000/spmi=
@c432000/pmic@7: failed to match any schema with compatible: ['qcom,smb2360=
', 'qcom,spmi-pmic']
>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pmic@a: compatible:0: 'qcom=
,smb2360' is not one of ['qcom,pm2250', 'qcom,pm6125', 'qcom,pm6150', 'qcom=
,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b', 'qco=
m,pm7550ba', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm8009', 'q=
com,pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,pm8150', 'q=
com,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', 'qcom,pm8350',=
 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8450', 'qcom,pm8550', 'qcom,pm8550=
b', 'qcom,pm8550ve', 'qcom,pm8550vs', 'qcom,pm8841', 'qcom,pm8909', 'qcom,p=
m8916', 'qcom,pm8937', 'qcom,pm8941', 'qcom,pm8950', 'qcom,pm8953', 'qcom,p=
m8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmc8180', 'qcom,pmc8180c', 'qc=
om,pmd9635', 'qcom,pmi632', 'qcom,pmi8950', 'qcom,pmi8962', 'qcom,pmi8994',=
 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', 'qcom,pmk8550', 'qcom,pmm8=
155au', 'qcom,pmm8654au', 'qcom,pmp8074', 'qcom,pmr735a', 'qcom,pmr735b', '=
qcom,pmr735d', 'qcom,pms405', 'qcom,pmx55', 'qcom,pmx65', 'qcom,pmx75', 'qc=
om,smb2351']
>    	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yam=
l#
>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: /soc@0/arbiter@c400000/spmi=
@c432000/pmic@a: failed to match any schema with compatible: ['qcom,smb2360=
', 'qcom,spmi-pmic']
>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pmic@b: compatible:0: 'qcom=
,smb2360' is not one of ['qcom,pm2250', 'qcom,pm6125', 'qcom,pm6150', 'qcom=
,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b', 'qco=
m,pm7550ba', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm8009', 'q=
com,pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,pm8150', 'q=
com,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', 'qcom,pm8350',=
 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8450', 'qcom,pm8550', 'qcom,pm8550=
b', 'qcom,pm8550ve', 'qcom,pm8550vs', 'qcom,pm8841', 'qcom,pm8909', 'qcom,p=
m8916', 'qcom,pm8937', 'qcom,pm8941', 'qcom,pm8950', 'qcom,pm8953', 'qcom,p=
m8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmc8180', 'qcom,pmc8180c', 'qc=
om,pmd9635', 'qcom,pmi632', 'qcom,pmi8950', 'qcom,pmi8962', 'qcom,pmi8994',=
 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', 'qcom,pmk8550', 'qcom,pmm8=
155au', 'qcom,pmm8654au', 'qcom,pmp8074', 'qcom,pmr735a', 'qcom,pmr735b', '=
qcom,pmr735d', 'qcom,pms405', 'qcom,pmx55', 'qcom,pmx65', 'qcom,pmx75', 'qc=
om,smb2351']

I removed this patch from the dt-bindings branch for the time being.

	Krzysztof

