Return-Path: <linux-pci+bounces-29041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5017ACF3BD
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D6B164AD3
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57731E1DE2;
	Thu,  5 Jun 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QopZvHAL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC07462;
	Thu,  5 Jun 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139665; cv=none; b=Lnrn9Bjpy4yo6Ecl8Bd8n7ZSGdoM/vWFQgaR6C9uxKy8pQTOM3naiU+fmHsiOpoazb0YsHTO5bSCthRwV4MK7B7MVRd8FD7oLsBRSQWeXOb+8xK1xzGESwBRRmC0c9rOE9DeFD2ZWyL4nJEgM/1HnpzLUtHkI5eTzoEJh4zCG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139665; c=relaxed/simple;
	bh=OPJKuWVQNZ87kw/DDHJ1LZybURzSip0724Cgv5OPuU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKWL/Hq+Q/RJLhtL5eX1t8kHLiYl2KRL1Nn1J5n5llWJLyks6NOAtakDSoO82YwgHpW1pv8qCYgjKOeBYqLKmo7/DLyemOWbJZO76wjUNuHEUfnCfNzm+9X2Xaz8piGqqE/SsPTgao8h45uOJ1zzp4fPTRYbp427lgcjGpdtUH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QopZvHAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0241C4CEE7;
	Thu,  5 Jun 2025 16:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749139665;
	bh=OPJKuWVQNZ87kw/DDHJ1LZybURzSip0724Cgv5OPuU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QopZvHALoKpRAkdmCGxSWJmi2eNK3nKXYAe4E87SpEgewC2J8g+kEUgdboWzvtQ26
	 J87PLNpC9Pn+3sSrT2uJHG1rS3PvKIpru4Usygb0iwR4JfG7xHWizQjfEC8hhFwj6m
	 kQTJORdLv3OapsVePhso+Gl1ZzJEyYUYxd2OXYwUoPci+1PGfnC2p/FeKBiNnLb9nf
	 Pu2yAEi8WIfTPv0x34jnLITdAnJtqHeoOFkPCk7JanNBMbiXTmU4dMGoE06YTB+MNe
	 UmW4K0hpsRkVjhO7/wiJowAPSoZ+8KuHhizSKu2t1IJv3AgNi2aWRKiOhZx1Jw30zi
	 YV+DYiOsZB1CQ==
Date: Thu, 5 Jun 2025 11:07:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, abel.vesa@linaro.org, quic_vbadigan@quicinc.com,
	linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	kw@linux.com, quic_krichai@quicinc.com, krzk+dt@kernel.org,
	kishon@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
	konradybcio@kernel.org, devicetree@vger.kernel.org,
	neil.armstrong@linaro.org, kwilczynski@kernel.org,
	bhelgaas@google.com, linux-phy@lists.infradead.org,
	lpieralisi@kernel.org, linux-pci@vger.kernel.org,
	quic_qianyu@quicinc.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 2/6] dt-bindings: PCI: qcom,pcie-sa8775p: document
 qcs8300
Message-ID: <174913966072.2690296.797135460368939393.robh@kernel.org>
References: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
 <20250529035635.4162149-3-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529035635.4162149-3-quic_ziyuzhan@quicinc.com>


On Thu, 29 May 2025 11:56:31 +0800, Ziyue Zhang wrote:
> Add compatible for qcs8300 platform, with sa8775p as the fallback.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml         | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


