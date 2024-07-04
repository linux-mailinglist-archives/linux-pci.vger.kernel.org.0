Return-Path: <linux-pci+bounces-9781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5799270AD
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 09:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE881C23313
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 07:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AFD1A2C1A;
	Thu,  4 Jul 2024 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSWQ0XMp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2281A257F;
	Thu,  4 Jul 2024 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078327; cv=none; b=X0zek9a4pj+2KIUG5fBPkrIPEuiLHVrL56fmZImnrIe1PWeN9gLV6fZ8ovOBOHLtROYXJoYTx1ybVL9T+ZRKmlJ7Ge+7epZWD1zu15wL7hM06ZpLdgKt2NBsyyvC4mqC++7Ds60ZnpiyLNKk4AGIpDobCAcY+ce7DhTLl7v9AgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078327; c=relaxed/simple;
	bh=Ql1Em3h/0KA0urovhORf1G2Q9wT24RdY1/KPfejhN3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPssEKtVRllSlCpPzWY2YGhB9LLbFMaVbakMbHMbtLy4rw0MPiqPff7huv5b2ga2DXDxkpB8Kfm/NkpRTiXlSQMVCY09Kmm1pBb44kskiRR4mdFXHJYAiQrtvvljJD3d+Fb3QhoXBRdyUPqgtZb+n7WtnuLsz966t4XCT0XLGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSWQ0XMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5D9C3277B;
	Thu,  4 Jul 2024 07:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720078327;
	bh=Ql1Em3h/0KA0urovhORf1G2Q9wT24RdY1/KPfejhN3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XSWQ0XMpkbi4j9FXVi6kQN07A+41RHcrlbTwXIhugyGTJvDE+771gGMyoaITVvebR
	 QKWwqX1kNVshLeUELiAjfPKsY5nXPpea593Zv7lasqZPrQngsgjS9ubjNUYiLYdQ29
	 IyQC5gO3qtfy+Wxu0MtId+ffFN2lWZlonU4lvamiw470J1gX3s30gx29VnQWQXYmJR
	 owOQn1+hmuXMSbpuAHdzXk5cbBYIEIEwC57mXqpj6TpFe12uMjlE7a03lVHj/YDh9q
	 qOU3j74Wgh9hVNmyr2gU9sqFOkSdKWdFe6bgiNWS8GJmTcteUk/imiLQH3kkCCDxS3
	 Gf/RIawA0Zqww==
Message-ID: <bd96c9e5-9342-41b8-aa14-2db4828e37f3@kernel.org>
Date: Thu, 4 Jul 2024 09:32:01 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pci:dt-bindings 10/11]
 arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pci@1bf8000: reg: [[0, 29327360,
 0, 12288], [0, 1879048192, 0, 3869], [0, 1879052064, 0, 168], [0, 1879052288,
 0, 4096], [0, 1880096768, 0, 1048576]] is too short
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 kernel test robot <lkp@intel.com>
Cc: Abel Vesa <abel.vesa@linaro.org>, oe-kbuild-all@lists.linux.dev,
 linux-pci@vger.kernel.org, "Rob Herring (Arm)" <robh@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <202407041154.pTMBERxA-lkp@intel.com>
 <20240704072006.GA2768618@rocinante>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240704072006.GA2768618@rocinante>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2024 09:20, Krzysztof Wilczy=C5=84ski wrote:
> Hello,
>=20
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt=
-bindings
>> head:   a50a3d6870292c08a4e941449ba4ddc8339a2b14
>> commit: 9d02ca5cda560bdce0f349bece5204bdae339f8f [10/11] dt-bindings: =
PCI: qcom: x1e80100: Make the MHI reg region mandatory
>> config: arm64-randconfig-051-20240704 (https://download.01.org/0day-ci=
/archive/20240704/202407041154.pTMBERxA-lkp@intel.com/config)
>> compiler: aarch64-linux-gcc (GCC) 13.2.0
>> dtschema version: 2024.6.dev3+g650bf2d
>> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/ar=
chive/20240704/202407041154.pTMBERxA-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new v=
ersion of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202407041154.pTMBERxA-=
lkp@intel.com/
>>
>> dtcheck warnings: (new ones prefixed by >>)
>>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: phy@fd5000: 'vdda-pll-su=
pply' is a required property
>>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-q=
mp-usb43dp-phy.yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: phy@fda000: 'vdda-phy-su=
pply' is a required property
>>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-q=
mp-usb43dp-phy.yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: phy@fda000: 'vdda-pll-su=
pply' is a required property
>>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-q=
mp-usb43dp-phy.yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: phy@fdf000: 'vdda-phy-su=
pply' is a required property
>>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-q=
mp-usb43dp-phy.yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: phy@fdf000: 'vdda-pll-su=
pply' is a required property
>>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-q=
mp-usb43dp-phy.yaml#
>>>> arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pci@1bf8000: reg: [[0, 29=
327360, 0, 12288], [0, 1879048192, 0, 3869], [0, 1879052064, 0, 168], [0,=
 1879052288, 0, 4096], [0, 1880096768, 0, 1048576]] is too short
>>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80=
100.yaml#
>>>> arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pci@1bf8000: reg-names: [=
'parf', 'dbi', 'elbi', 'atu', 'config'] is too short
>>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80=
100.yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: usb@a2f8800: interrupt-n=
ames: ['pwr_event', 'dp_hs_phy_irq', 'dm_hs_phy_irq'] is too short
>>    	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#=

>>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pmic@7: compatible:0: 'q=
com,smb2360' is not one of ['qcom,pm2250', 'qcom,pm6125', 'qcom,pm6150', =
'qcom,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b=
', 'qcom,pm7550ba', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm=
8009', 'qcom,pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,=
pm8150', 'qcom,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', '=
qcom,pm8350', 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8450', 'qcom,pm8550=
', 'qcom,pm8550b', 'qcom,pm8550ve', 'qcom,pm8550vs', 'qcom,pm8841', 'qcom=
,pm8909', 'qcom,pm8916', 'qcom,pm8937', 'qcom,pm8941', 'qcom,pm8950', 'qc=
om,pm8953', 'qcom,pm8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmc8180',=
 'qcom,pmc8180c', 'qcom,pmd9635', 'qcom,pmi632', 'qcom,pmi8950', 'qcom,pm=
i8962', 'qcom,pmi8994', 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', '=
qcom,pmk8550', 'qcom,pmm8155au', 'qcom,pmm8654au', 'qcom,pmp8074', 'qcom,=
pmr735a', 'qcom,pmr735b', 'qcom,pmr735d', 'qcom,pms405', 'qcom,pmx55', 'q=
com,pmx65', 'qcom,pmx75', 'qcom,smb2351']
>>    	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.=
yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: /soc@0/arbiter@c400000/s=
pmi@c432000/pmic@7: failed to match any schema with compatible: ['qcom,sm=
b2360', 'qcom,spmi-pmic']
>>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pmic@a: compatible:0: 'q=
com,smb2360' is not one of ['qcom,pm2250', 'qcom,pm6125', 'qcom,pm6150', =
'qcom,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b=
', 'qcom,pm7550ba', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm=
8009', 'qcom,pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,=
pm8150', 'qcom,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', '=
qcom,pm8350', 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8450', 'qcom,pm8550=
', 'qcom,pm8550b', 'qcom,pm8550ve', 'qcom,pm8550vs', 'qcom,pm8841', 'qcom=
,pm8909', 'qcom,pm8916', 'qcom,pm8937', 'qcom,pm8941', 'qcom,pm8950', 'qc=
om,pm8953', 'qcom,pm8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmc8180',=
 'qcom,pmc8180c', 'qcom,pmd9635', 'qcom,pmi632', 'qcom,pmi8950', 'qcom,pm=
i8962', 'qcom,pmi8994', 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', '=
qcom,pmk8550', 'qcom,pmm8155au', 'qcom,pmm8654au', 'qcom,pmp8074', 'qcom,=
pmr735a', 'qcom,pmr735b', 'qcom,pmr735d', 'qcom,pms405', 'qcom,pmx55', 'q=
com,pmx65', 'qcom,pmx75', 'qcom,smb2351']
>>    	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.=
yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: /soc@0/arbiter@c400000/s=
pmi@c432000/pmic@a: failed to match any schema with compatible: ['qcom,sm=
b2360', 'qcom,spmi-pmic']
>>    arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pmic@b: compatible:0: 'q=
com,smb2360' is not one of ['qcom,pm2250', 'qcom,pm6125', 'qcom,pm6150', =
'qcom,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b=
', 'qcom,pm7550ba', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm=
8009', 'qcom,pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,=
pm8150', 'qcom,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', '=
qcom,pm8350', 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8450', 'qcom,pm8550=
', 'qcom,pm8550b', 'qcom,pm8550ve', 'qcom,pm8550vs', 'qcom,pm8841', 'qcom=
,pm8909', 'qcom,pm8916', 'qcom,pm8937', 'qcom,pm8941', 'qcom,pm8950', 'qc=
om,pm8953', 'qcom,pm8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmc8180',=
 'qcom,pmc8180c', 'qcom,pmd9635', 'qcom,pmi632', 'qcom,pmi8950', 'qcom,pm=
i8962', 'qcom,pmi8994', 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', '=
qcom,pmk8550', 'qcom,pmm8155au', 'qcom,pmm8654au', 'qcom,pmp8074', 'qcom,=
pmr735a', 'qcom,pmr735b', 'qcom,pmr735d', 'qcom,pms405', 'qcom,pmx55', 'q=
com,pmx65', 'qcom,pmx75', 'qcom,smb2351']
>> --
>>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: phy@fd5000: 'vdda-pll-su=
pply' is a required property
>>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-q=
mp-usb43dp-phy.yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: phy@fda000: 'vdda-phy-su=
pply' is a required property
>>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-q=
mp-usb43dp-phy.yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: phy@fda000: 'vdda-pll-su=
pply' is a required property
>>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-q=
mp-usb43dp-phy.yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: phy@fdf000: 'vdda-phy-su=
pply' is a required property
>>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-q=
mp-usb43dp-phy.yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: phy@fdf000: 'vdda-pll-su=
pply' is a required property
>>    	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-q=
mp-usb43dp-phy.yaml#
>>>> arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bf8000: reg: [[0, 29=
327360, 0, 12288], [0, 1879048192, 0, 3869], [0, 1879052064, 0, 168], [0,=
 1879052288, 0, 4096], [0, 1880096768, 0, 1048576]] is too short
>>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80=
100.yaml#
>>>> arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bf8000: reg-names: [=
'parf', 'dbi', 'elbi', 'atu', 'config'] is too short
>>    	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80=
100.yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: usb@a2f8800: interrupt-n=
ames: ['pwr_event', 'dp_hs_phy_irq', 'dm_hs_phy_irq'] is too short
>>    	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#=

>>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pmic@7: compatible:0: 'q=
com,smb2360' is not one of ['qcom,pm2250', 'qcom,pm6125', 'qcom,pm6150', =
'qcom,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b=
', 'qcom,pm7550ba', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm=
8009', 'qcom,pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,=
pm8150', 'qcom,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', '=
qcom,pm8350', 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8450', 'qcom,pm8550=
', 'qcom,pm8550b', 'qcom,pm8550ve', 'qcom,pm8550vs', 'qcom,pm8841', 'qcom=
,pm8909', 'qcom,pm8916', 'qcom,pm8937', 'qcom,pm8941', 'qcom,pm8950', 'qc=
om,pm8953', 'qcom,pm8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmc8180',=
 'qcom,pmc8180c', 'qcom,pmd9635', 'qcom,pmi632', 'qcom,pmi8950', 'qcom,pm=
i8962', 'qcom,pmi8994', 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', '=
qcom,pmk8550', 'qcom,pmm8155au', 'qcom,pmm8654au', 'qcom,pmp8074', 'qcom,=
pmr735a', 'qcom,pmr735b', 'qcom,pmr735d', 'qcom,pms405', 'qcom,pmx55', 'q=
com,pmx65', 'qcom,pmx75', 'qcom,smb2351']
>>    	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.=
yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: /soc@0/arbiter@c400000/s=
pmi@c432000/pmic@7: failed to match any schema with compatible: ['qcom,sm=
b2360', 'qcom,spmi-pmic']
>>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pmic@a: compatible:0: 'q=
com,smb2360' is not one of ['qcom,pm2250', 'qcom,pm6125', 'qcom,pm6150', =
'qcom,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b=
', 'qcom,pm7550ba', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm=
8009', 'qcom,pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,=
pm8150', 'qcom,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', '=
qcom,pm8350', 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8450', 'qcom,pm8550=
', 'qcom,pm8550b', 'qcom,pm8550ve', 'qcom,pm8550vs', 'qcom,pm8841', 'qcom=
,pm8909', 'qcom,pm8916', 'qcom,pm8937', 'qcom,pm8941', 'qcom,pm8950', 'qc=
om,pm8953', 'qcom,pm8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmc8180',=
 'qcom,pmc8180c', 'qcom,pmd9635', 'qcom,pmi632', 'qcom,pmi8950', 'qcom,pm=
i8962', 'qcom,pmi8994', 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', '=
qcom,pmk8550', 'qcom,pmm8155au', 'qcom,pmm8654au', 'qcom,pmp8074', 'qcom,=
pmr735a', 'qcom,pmr735b', 'qcom,pmr735d', 'qcom,pms405', 'qcom,pmx55', 'q=
com,pmx65', 'qcom,pmx75', 'qcom,smb2351']
>>    	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.=
yaml#
>>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: /soc@0/arbiter@c400000/s=
pmi@c432000/pmic@a: failed to match any schema with compatible: ['qcom,sm=
b2360', 'qcom,spmi-pmic']
>>    arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pmic@b: compatible:0: 'q=
com,smb2360' is not one of ['qcom,pm2250', 'qcom,pm6125', 'qcom,pm6150', =
'qcom,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,pm7250b=
', 'qcom,pm7550ba', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm=
8009', 'qcom,pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,=
pm8150', 'qcom,pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', '=
qcom,pm8350', 'qcom,pm8350b', 'qcom,pm8350c', 'qcom,pm8450', 'qcom,pm8550=
', 'qcom,pm8550b', 'qcom,pm8550ve', 'qcom,pm8550vs', 'qcom,pm8841', 'qcom=
,pm8909', 'qcom,pm8916', 'qcom,pm8937', 'qcom,pm8941', 'qcom,pm8950', 'qc=
om,pm8953', 'qcom,pm8994', 'qcom,pm8998', 'qcom,pma8084', 'qcom,pmc8180',=
 'qcom,pmc8180c', 'qcom,pmd9635', 'qcom,pmi632', 'qcom,pmi8950', 'qcom,pm=
i8962', 'qcom,pmi8994', 'qcom,pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', '=
qcom,pmk8550', 'qcom,pmm8155au', 'qcom,pmm8654au', 'qcom,pmp8074', 'qcom,=
pmr735a', 'qcom,pmr735b', 'qcom,pmr735d', 'qcom,pms405', 'qcom,pmx55', 'q=
com,pmx65', 'qcom,pmx75', 'qcom,smb2351']
>=20
> I removed this patch from the dt-bindings branch for the time being.


These reports are useless. I suggest ignore all of them...

Best regards,
Krzysztof


