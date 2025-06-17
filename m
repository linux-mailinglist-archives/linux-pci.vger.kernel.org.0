Return-Path: <linux-pci+bounces-29948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A690ADD705
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 18:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6696519E4373
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F2236453;
	Tue, 17 Jun 2025 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfgI3HFf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7592221F14;
	Tue, 17 Jun 2025 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177420; cv=none; b=fLhggOPk57CrZtUEfPaBVH/ZCHxGB+ORTBvsTlqk3T5zoNpi5w23q8khaqW4jX9RjNPmHWZ9XNqCcwzhVagME4x+kEyxmgP7zJJ0jYYpy+4AShFnGyv5nbzUo8nOMR7WeGBX1MRR21R5cBfS8t520FzTB+7Dou8rjOti0WUf8S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177420; c=relaxed/simple;
	bh=V8t5bo5FF6oerOdwGkDXKtDkx0wzlN6pNvzLOhsekAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOeQQM1CLbHx58aR6eUVYi/sq43uUdgQwVl/oa1GggNK4q5sq4AZlsqRIB2a8TDzWlnDEm2c60J3ChW6P/VaPozce7LNBgB9x0iBaoCThTQNNNwlnP2qVOk5KMkmh+i0VgDWM/gUbmt+OJJPYlG5OtXJHHrSYftW2Yn/PbLeGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfgI3HFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B54C4CEE3;
	Tue, 17 Jun 2025 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750177420;
	bh=V8t5bo5FF6oerOdwGkDXKtDkx0wzlN6pNvzLOhsekAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfgI3HFf4DEK5tMMrbCmXDo5gMBLSPmrFShaTkHn2SAYErrKEoooB22PsftEu4Dn6
	 gd/vU85cZRp54Nkmkt8VCBy+Mobpj/xQ27uts5EZWwRstndjB5Mbpms0JmfsNhJVoN
	 U/YRwgamazLTUCw5K7qGQlE77O6v4EgbH+X1tYTXbMNySQPZC4rzZiaX9FPI97Kkc+
	 h0Bl2j/VYdgEtIZmIiWxxfPyAlaCwyZZF+QpOCIMQQ2koP3yAm5llS8cj9Bz3HKRbW
	 9m80iAeyOKXvCBxxi27V0NdXOKVLYqwEbvZB9/MZAu3tt4Y8TFqQKGhd5pT/AeKmSx
	 SclUXo7xd5Psg==
Date: Tue, 17 Jun 2025 21:53:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v5 0/4] pci: qcom: Add QCS615 PCIe support
Message-ID: <t6bwkld55a2dcozxz7rxnvdgpjis6oveqzkh4s7nvxgikws4rl@fn2sd7zlabhe>
References: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
 <d67ba247-6b2d-4f2e-9583-ddbe375bf08d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d67ba247-6b2d-4f2e-9583-ddbe375bf08d@quicinc.com>

On Tue, Jun 17, 2025 at 06:34:03PM +0800, Ziyue Zhang wrote:
> 
> On 5/27/2025 3:20 PM, Ziyue Zhang wrote:
> > This series adds document, phy, configs support for PCIe in QCS615.
> > 
> > This series depend on the dt-bindings change
> > https://lore.kernel.org/all/20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com/
> > 
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> > ---
> > Have following changes:
> > 	- Add a new Document the QCS615 PCIe Controller
> > 	- Add configurations in devicetree for PCIe, including registers, clocks, interrupts and phy setting sequence.
> > 	- Add configurations in devicetree for PCIe, platform related gpios, PMIC regulators, etc.
> > 
> > Changes in v5:
> > - Drop qcs615-pcie.yaml and use sm8150, as qcs615 is the downgraded
> >    version of sm8150, which can share the same yaml.
> > - Drop compatible enrty in driver and use sm8150's enrty (Krzysztof)
> > - Fix the DT format problem (Konrad)
> > - Link to v4: https://lore.kernel.org/all/20250507031559.4085159-1-quic_ziyuzhan@quicinc.com/
> > 
> > Changes in v4:
> > - Fixed compile error found by kernel test robot(Krzysztof)
> > - Update DT format (Konrad & Krzysztof)
> > - Remove QCS8550 compatible use QCS615 compatible only (Konrad)
> > - Update phy dt bindings to fix the dtb check errors.
> > - Link to v3: https://lore.kernel.org/all/20250310065613.151598-1-quic_ziyuzhan@quicinc.com/
> > 
> > Changes in v3:
> > - Update qcs615 dt-bindings to fit the qcom-soc.yaml (Krzysztof & Dmitry)
> > - Removed the driver patch and using fallback method (Mani)
> > - Update DT format, keep it same with the x1e801000.dtsi (Konrad)
> > - Update DT commit message (Bojor)
> > - Link to v2: https://lore.kernel.org/all/20241122023314.1616353-1-quic_ziyuzhan@quicinc.com/
> > 
> > Changes in v2:
> > - Update commit message for qcs615 phy
> > - Update qcs615 phy, using lowercase hex
> > - Removed redundant function
> > - split the soc dtsi and the platform dts into two changes
> > - Link to v1: https://lore.kernel.org/all/20241118082619.177201-1-quic_ziyuzhan@quicinc.com/
> > 
> > Krishna chaitanya chundru (2):
> >    arm64: dts: qcom: qcs615: enable pcie
> >    arm64: dts: qcom: qcs615-ride: Enable PCIe interface
> > 
> > Ziyue Zhang (2):
> >    dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
> >      for QCS615
> >    dt-bindings: PCI: qcom,pcie-sm8150: document qcs615
> > 

Applied to pci/dt-bindings, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

