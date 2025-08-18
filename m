Return-Path: <linux-pci+bounces-34201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C079DB2ABBC
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 16:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5E17B0E1B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8307A233707;
	Mon, 18 Aug 2025 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNlWJ/O/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937F23505E;
	Mon, 18 Aug 2025 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528891; cv=none; b=ppJdnZW7wmkg2G3l3BvHrZQA6Sb7oHyROu+kd1nvkdhzolU2q9m4s8/nptg/N4SVpbQfeFjLx6P644tv6PqpcCri3QC43E5Q8uqqMXXOYr6fO/982nJEkej11B1udiTcvX6INx8D2E7tVGCVOGRrdiA3g5VT+5zHSuoyJClOC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528891; c=relaxed/simple;
	bh=cuZ1pa9bmDYPYfV+jIPPjvIT7gQMFovHPkrwyoJxtVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQM/7rVIZWavOZTf5gaKukf+6+5F7VMma0Zm7ejPaCvVC6QZNbPDKfGMXug9LfO9m4rTdATHXQdZDfazejmsA41+r/wy4m668Zftjbi3vhONXvt/94+HOtDmv3UffkXzLozWDcBH6Mqokc1TcCmiLIclKO7EanUPt2c6D2WT4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNlWJ/O/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5DEC4CEEB;
	Mon, 18 Aug 2025 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755528891;
	bh=cuZ1pa9bmDYPYfV+jIPPjvIT7gQMFovHPkrwyoJxtVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GNlWJ/O/Q9mNZZxVdOxN36kc2Wb8xQlyD8sQdQMc9boQzjkddfNyqDREgvi82T4WE
	 Y/NXGhdUdvQ2L+f2gKz9zYAyTtR2F66evnQ1o3DmM7dn63trsb+5DrEfiek+CJTwmG
	 WtKT039P9KdoARyi/NrvQywbZcpbRcLmuQVUnqsGPhGRkH8wjdRsHDQ5puS2DPqaY8
	 4p9MgLtMn/8HJhXZIw2W/d2iuziRosoQYwkayfF/QwmuVODvoJXZ7dptIyeifcAWzj
	 Zlf4YKlr6kBP5Fp9xmqmh8SbHmFOoPpaXXLM/R760Si+3dU8wKDdt+9tDGhl0KwFDS
	 n2Mm2ZpfseCRg==
Date: Mon, 18 Aug 2025 09:54:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org,
	quic_vbadigan@quicinc.com, linux-kernel@vger.kernel.org,
	quic_mrana@quicinc.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: PCI: qcom,pcie-sm8550: Add SM8750
 compatible
Message-ID: <175552888940.1212051.15924500632335799397.robh@kernel.org>
References: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
 <20250809-pakala-v1-3-abf1c416dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809-pakala-v1-3-abf1c416dbaa@oss.qualcomm.com>


On Sat, 09 Aug 2025 15:29:18 +0530, Krishna Chaitanya Chundru wrote:
> On the Qualcomm SM8750 platform the PCIe host is compatible with the
> DWC controller present on the SM8550 platorm.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


