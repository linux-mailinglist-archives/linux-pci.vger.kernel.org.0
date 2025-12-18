Return-Path: <linux-pci+bounces-43309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 011E1CCC86A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 16:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDE6B3015ECF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 15:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021953587D9;
	Thu, 18 Dec 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhYJc/l4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2770357A30;
	Thu, 18 Dec 2025 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072472; cv=none; b=cITchcpHQy8K0w1m60T/PUekRVEGSGmXIPD73z+A1MvCutKqkgPvD4uotjN79AL2JG3Bmb/xgsv8V58llqyZ7FVlNWA7Y1UzyGTubbPa4X85wAZohn3OgLjk6+XPlBcabGdceyK9GUsr85ZTg+gFDxJnDf2JZ/1xRF9OBRs1dZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072472; c=relaxed/simple;
	bh=W9X5c1LzJsuY9znr1H3pHj+tNmZNhoP/XwEHJ03ZGj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsYFjFZWXhvrcDn2o23mnrymPp19fmigBxmINr5RfYFR4FvYSnrDmAwR03oXqOczs//EnEwfwUFjMnWhxUDF7V25w6wq56fTeCTtuxvA55fFMq+VTNtEQ35j/OlhWSMKjBroIbINrxraOjCNvNsqDfGA97ILdtAJQ1cvmUFGdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhYJc/l4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96087C4CEFB;
	Thu, 18 Dec 2025 15:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766072471;
	bh=W9X5c1LzJsuY9znr1H3pHj+tNmZNhoP/XwEHJ03ZGj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YhYJc/l4o5EDDfgFSlWf9fAKO8E6m0xtTUL/moHdnqV/aIqwZHu66JWsYADvb13Fu
	 pPstxk2WEyXABjJvmslBTcudXXvTqWXgxzFlHfjEGN3FLsdlouMmSCddp4iaZjFjMR
	 8kDaKjMb82LbDTngX/LAsS/fNjIkwFGzoMKiLttBNJqB1HzQoRoaq2gN78+zTkkNZb
	 Xyib8YbJi9FZ/VRTMfduVZ3+1sjKn/ObAFaRQdQ8cYrktTqvydeAndocLmQvTngR7i
	 0Uw5MaO1v+In0KmGyxC5n9LKQSQQAyJMUJGycxnZkwD7AfRNf4fYL8d9DvaMgIFWRf
	 8n2uSGS0pav/Q==
Message-ID: <39f420d6-f9f5-45b4-9e33-16a283564215@kernel.org>
Date: Thu, 18 Dec 2025 16:41:01 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: qcom,pcie-ep-sa8255p: Document
 firmware managed PCIe endpoint
To: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rama Krishna <quic_ramkri@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
 quic_shazhuss@quicinc.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 linux-pci@vger.kernel.org, konrad.dybcio@oss.qualcomm.com,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Nitesh Gupta <quic_nitegupt@quicinc.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 quic_vbadigan@quicinc.com
References: <20251217-firmware_managed_ep-v3-0-ff871ba688fb@oss.qualcomm.com>
 <20251217-firmware_managed_ep-v3-1-ff871ba688fb@oss.qualcomm.com>
 <176597111816.570337.1780092644304118894.robh@kernel.org>
 <CAMyL0qOEzqKTJuZRuopGioZRk3DzYoeyRZjNB6JLa8yQEBedLQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAMyL0qOEzqKTJuZRuopGioZRk3DzYoeyRZjNB6JLa8yQEBedLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/12/2025 10:44, Mrinmay Sarkar wrote:
> On Wed, Dec 17, 2025 at 5:02 PM Rob Herring (Arm) <robh@kernel.org> wrote:
>>
>>
>> On Wed, 17 Dec 2025 15:42:45 +0530, Mrinmay Sarkar wrote:
>>> Document the required configuration to enable the PCIe Endpoint controller
>>> on SA8255p which is managed by firmware using power-domain based handling.
>>>
>>> Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
>>> ---
>>>  .../bindings/pci/qcom,pcie-ep-sa8255p.yaml         | 110 +++++++++++++++++++++
>>>  1 file changed, 110 insertions(+)
>>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.example.dtb: pcie-ep@1c10000 (qcom,pcie-ep-sa8255p): compatible: 'oneOf' conditional failed, one must be fixed:
>>         'qcom,pcie-ep-sa8255p' does not match '^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+(pro)?-.*$'
>>         'qcom,pcie-ep-sa8255p' does not match '^qcom,sar[0-9]+[a-z]?-.*$'
>>         'qcom,pcie-ep-sa8255p' does not match '^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$'
>>         'qcom,pcie-ep-sa8255p' does not match '^qcom,(glymur|milos)-.*$'
>>         'qcom,pcie-ep-sa8255p' does not match '^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$'
>>         'qcom,pcie-ep-sa8255p' does not match '^qcom,gcc-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$'
>>         'qcom,pcie-ep-sa8255p' does not match '^qcom,mmcc-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$'
>>         'qcom,pcie-ep-sa8255p' does not match '^qcom,pcie-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+.*$'
>>         'qcom,pcie-ep-sa8255p' does not match '^qcom,rpm-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$'
>>         'qcom,pcie-ep-sa8255p' does not match '^qcom,scm-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+.*$'
>>         'qcom,pcie-ep-sa8255p' is not one of ['qcom,dsi-ctrl-6g-qcm2290', 'qcom,gpucc-sdm630', 'qcom,gpucc-sdm660', 'qcom,lcc-apq8064', 'qcom,lcc-ipq8064', 'qcom,lcc-mdm9615', 'qcom,lcc-msm8960', 'qcom,lpass-cpu-apq8016', 'qcom,usb-ss-ipq4019-phy', 'qcom,usb-hs-ipq4019-phy', 'qcom,vqmmc-ipq4019-regulator']
>>         'qcom,pcie-ep-sa8255p' is not one of ['qcom,ipq806x-gmac', 'qcom,ipq806x-nand', 'qcom,ipq806x-sata-phy', 'qcom,ipq806x-usb-phy-ss', 'qcom,ipq806x-usb-phy-hs']
>>         from schema $id: http://devicetree.org/schemas/arm/qcom-soc.yaml
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.kernel.org/project/devicetree/patch/20251217-firmware_managed_ep-v3-1-ff871ba688fb@oss.qualcomm.com
>>
>> The base for the series is generally the latest rc1. A different dependency
>> should be noted in *this* patch.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit after running the above command yourself. Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your schema.
> 
> 
> Hi Krzysztof,
> 
> As per our discussion in V1, you mentioned dt binding filename must
> match the compatible
> and I should rewrite compatible to match filename.
> 
> V1 discussion: https://lore.kernel.org/all/CAMyL0qO2FPBe7N6Q=hW-ymeiGDhABsU+VCj25jzcoQRhBoWbDA@mail.gmail.com/

You should respond to that discussion. When you question reviewers
comment, you respond to that comment, not somewhere else. That way I
have entire context and I already told you that when you were poking me
on private channels.

Bindings do not allow old (or incorrect) naming scheme for EP and I
already see EP compatibles were named with the proper new style, so
let's switch to that one - qcom,sa8255p-pcie-ep



Best regards,
Krzysztof

