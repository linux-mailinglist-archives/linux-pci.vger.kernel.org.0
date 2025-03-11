Return-Path: <linux-pci+bounces-23423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A453A5BFA3
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 12:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB4F176A67
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 11:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC22255E3D;
	Tue, 11 Mar 2025 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAjSqMl+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE12255E37;
	Tue, 11 Mar 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693634; cv=none; b=gjo4WUqQ9RDtAJb+5gEAdNROBW2yEfnTce279JjAZognJ57SF+SJM0GgAhoS3i5W2KTtVtEwiUUrLQeKXEJ4hylczDvOuO+MLTW/ddPh/YNGKsJphTWp2v2xv9HIU+bCV7gXksMciOzYajTWJknpiX3H23kDkPQWA/32JmDwx50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693634; c=relaxed/simple;
	bh=vKafTPWUZwnre114AfisoCJLv7ctbKCeoyZ23jWCfP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R5AKcm7/gr9kPUO36oS55MxlYBt44x+gIxdlGSvwE9c2HZXLyo5kUr/hlGkySaVRaZPln7Qc5RdUsTxwOJUE6502faDOXZLcAmkt89VcM3Bra8oavEa+EHOoIoawG94U70Q0gAD8NgWseXv917VtCirZVFIE1X/OUdRyi6+18Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAjSqMl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A590C4CEE9;
	Tue, 11 Mar 2025 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741693633;
	bh=vKafTPWUZwnre114AfisoCJLv7ctbKCeoyZ23jWCfP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QAjSqMl+Bocy4nrBZxi3De4ggP6nCKCuyti0A6sD7KTDHBXXaVnnU3oZ+2OyJFvPQ
	 KD84WVjtZJ6s0+1lcPsO7dcRfu8BqlAQYglNvW4lJ1CIzWACXDF/R4JKx6RQnLs0qo
	 kwRlgdSL1k75S+naDGcHqgALXK/obCIHLw2xFaNxuNGqCTxBzlHToBFseN+aUzfmSl
	 rys6MHzRrxN5SSqM/tU47ZWN6dE1ijgaVwGc6qV/2xLnYSGu8tl5Q19PBTA151H1Ua
	 ZKUi1WCTzt4GJdbO54KfuPLhwTfc2a58dG2YE+WXfMpxRjzLE9GRHSeX/oQ4DJrwSG
	 GoMQWM2l3atDw==
From: Vinod Koul <vkoul@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
 manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, kishon@kernel.org, andersson@kernel.org, 
 konradybcio@kernel.org, dmitry.baryshkov@linaro.org, 
 neil.armstrong@linaro.org, abel.vesa@linaro.org, 
 Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: quic_qianyu@quicinc.com, quic_krichai@quicinc.com, 
 johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20250310063103.3924525-1-quic_ziyuzhan@quicinc.com>
References: <20250310063103.3924525-1-quic_ziyuzhan@quicinc.com>
Subject: Re: (subset) [PATCH v4 0/8] pci: qcom: Add QCS8300 PCIe support
Message-Id: <174169362764.507381.11220476979416149386.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 12:47:07 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 10 Mar 2025 14:30:55 +0800, Ziyue Zhang wrote:
> This series adds document, phy, configs support for PCIe in QCS8300.
> The series depend on the following devicetree.
> 
> PCIe SMMU:
> https://lore.kernel.org/all/20250206-qcs8300-pcie-smmu-v1-1-8eee0e3585bc@quicinc.com/
> 
> Have follwing changes:
> 	- Document the QMP PCIe PHY on the QCS8300 platform.
> 	- Add dedicated schema for the PCIe controllers found on QCS8300.
> 	- Add compatible for qcs8300 platform.
> 	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS8300 QMP PCIe PHY Gen4 x2
      commit: e46e59b77a9e6f322ef1ad08a8874211f389cf47
[2/8] phy: qcom-qmp-pcie: add dual lane PHY support for QCS8300
      commit: ebf198f17b5ac967db6256f4083bbcbdcc2a3100

Best regards,
-- 
~Vinod



