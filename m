Return-Path: <linux-pci+bounces-20439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAF4A20505
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 08:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1AC1660AC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 07:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20E41A7044;
	Tue, 28 Jan 2025 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXeAVvjm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B97383A5;
	Tue, 28 Jan 2025 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738049258; cv=none; b=s02UfudNg/ZXVsKZ09blwKDUXdYkEaOWQ5wk0mI1BdLzawhI513AMwzMh08FtVo20RoYid1IaG2/Amm5eifdasc9dwhHu1bfHF0C5CedmdfnLaXrab6zxzYWvvtAW9mHrXXWU8S/2cyL0ezBumXeif902Vs2wsOxbjGr8Bo0//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738049258; c=relaxed/simple;
	bh=+sa8ABbz7eaRoFnDc8THWn9YGk3681ZYFZ8XGntL9lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vo6tsVY9e2Zg7pSay+ExYfVHJd1QqgT7Uy6Dxo8gblipD/FLu08PTACrWZAHKH1LUbTHG/62pGJImyAcr7qXex69ieITUiJIMl2DKDQiQ0hzvsiWlyvP3jb00Hvg2DxH9UmdYJNGcOQABwBWhsCSpY3NZyrxW4D0qqffcAQcL1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXeAVvjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11601C4CED3;
	Tue, 28 Jan 2025 07:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738049257;
	bh=+sa8ABbz7eaRoFnDc8THWn9YGk3681ZYFZ8XGntL9lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXeAVvjmyuQzKycAAB4vYhkz618HYojLKROyvVNIz6gW5RbcWYRCqTJCjUB3ZdHU8
	 5jX+bGVaTjIns86RhL+l5RtMdsQIhjmvkpQJqDarfFPIkMDWw8lHoXiITg6fxytWh6
	 hY3gV6aXcbTSmmWyWOp5FRAcQInjLf+UymGZAp9JjyusvT0bgUUvBoPOLV6kdt9YVT
	 T+KIAgbNyhxOjTgwSur+7Wi2oqWFtq7BqAKAwG8AchHOfDUeQem6FY1/BSYeG29/Of
	 XrKXKnTgj5OzdcqZOpTJZqvi4U1h3OsTcCnUh5uflGgWCy49RDQlnwjK0sbg2YjftJ
	 IrzEXJAu32ROw==
Date: Tue, 28 Jan 2025 08:27:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v9 5/7] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe
 controller
Message-ID: <20250128-astonishing-kingfisher-of-skill-babe3e@krzk-bin>
References: <20250128062708.573662-1-quic_varada@quicinc.com>
 <20250128062708.573662-6-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250128062708.573662-6-quic_varada@quicinc.com>

On Tue, Jan 28, 2025 at 11:57:06AM +0530, Varadarajan Narayanan wrote:
> Document the PCIe controller on IPQ5332 platform. IPQ5332 will
> use IPQ9574 as the fall back compatible.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v9: Remove superfluous ipq5332 constraint since the fallback is present
> 
> v8: Use ipq9574 as fallback compatible for ipq5332 along with ipq5424
> 
> v7: Moved ipq9574 related changes to a separate patch
>     Add 'global' interrupt
> 
> v6: Commit message update only. Add info regarding the moving of
>     ipq9574 from 5 "reg" definition to 5 or 6 reg definition.
> 
> v5: Re-arrange 5332 and 9574 compatibles to handle fallback usage in dts
> 
> v4: * v3 reused ipq9574 bindings for ipq5332. Instead add one for ipq5332
>     * DTS uses ipq9574 compatible as fallback. Hence move ipq9574 to be able
>       to use the 'reg' section for both ipq5332 and ipq9574. Else, dtbs_check
>       and dt_binding_check flag errors.
> ---

Same problems as ipq5424.

What's more, you are doing the same, so this is a conflicting change
coming from the same company or even the same team.

It is not the open source community's job, not the maintainer's job to
coordinate tasks and teams in Qualcomm. Qualcomm people should
coordinate their teams.

It's merge window, you and your colleagues keep sending new versions of
big patchsets with conflicting changes, without any coordination. Amount
of patches is just overwhelming. Lack of coordination and any reflection
is just discouraging.

Can you slow down and actually sync to send something reasonable?

And not during the merge window?

Best regards,
Krzysztof


