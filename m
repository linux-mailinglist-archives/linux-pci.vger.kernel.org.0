Return-Path: <linux-pci+bounces-39343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A680C0AD6A
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 17:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E033A5C1E
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF1D2222D8;
	Sun, 26 Oct 2025 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFBb/FfJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC3366;
	Sun, 26 Oct 2025 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496079; cv=none; b=C2GxMmtTJiPUD4xLD2nR+jpB+6ok+w2Xiocqh8ye5+17NM4as2ltn02qiXqBewwgcIFa1xS/pSocI9f/Ty1deb8UUaHKStdkNCudIQLDYCLROeumeEM4tomafQq/ehFaCjDthCtYfoYNqmLjuoI+PpOp2YK9f4T5Z9BYg3O8kXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496079; c=relaxed/simple;
	bh=8Rp4F3QbRPmzOvkK6zscPZ5G5tDnDNPqCHYmVjxd+L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VonqeeM0bqQfrCwx+59AB82GWq+gXbNPjzwn/hZ5pFSkZOnBtj5szR8oVJ4WzxkGDfym7JfspkleXG1dJpLkGNNCpF0glqnhIfS72ki+++TbcFjL7Nw6GvxhZ9D6Wi5jbA3RH28gXW0HOAsZvwmV0bReXs4RcHIIBjeRevQmQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFBb/FfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B1FC4CEE7;
	Sun, 26 Oct 2025 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761496079;
	bh=8Rp4F3QbRPmzOvkK6zscPZ5G5tDnDNPqCHYmVjxd+L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFBb/FfJ/slUWPYzJSDhwJfRoYgjbHs5LLb5NkmYapXVzBq6kR1erjVLhBhcJYePC
	 FCnpFOrIz1m/7S/YF/r2zt9Lw351ELrmgyTPxMXEfQqUDnxyccL1R+MK/Qu9gBbPWq
	 mQ1zFxTr27+IwO4g8GrdUVcArnI52FapPkZa86ApWpIQKhzlf5RbHGTwghjGcGX0Qj
	 MvmjhDiQl6qtQTB/835dmcWzk3avIG/hkwtg0Nk380Q67YW4vFbiUeKKdO8vL3eG5P
	 oOD0nfzXFt9qOQlyABZ493Rvm3ltP7fpQMgoV7wXCWNJ1P6bNI9VkcRfITj7iIs0rS
	 dBlpp3bkTjnFQ==
Date: Sun, 26 Oct 2025 21:57:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/5] OPP: Add support to find OPP for a set of keys
Message-ID: <eedvr7oojrp74opshopbjehiuqixa6q3a5tuxni6gni6bacexk@ktrsutu32tqs>
References: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>

On Mon, Oct 13, 2025 at 04:23:27PM +0530, Krishna Chaitanya Chundru wrote:
> The existing OPP table in the device tree for PCIe is shared across
> different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
> These configurations often operate at the same frequency, allowing them
> to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
> different characteristics beyond frequency—such as RPMh votes in QCOM
> case, which cannot be represented accurately when sharing a single OPP.
> 
> In such cases, frequency alone is not sufficient to uniquely identify
> an OPP. To support these scenarios, introduce a new API
> dev_pm_opp_find_key_exact() that allows OPP lookup for set of keys like
> frequency, level & bandwidth.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v5:
> - Add support for legacy devicetree's (Neil).
> - Update commit text and comments to use data rates instead of GEN (Mani).
> - Link to v4: https://lore.kernel.org/r/20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com
> 
> Changes in v4:
> - Included dtsi changes for all platforms.
> - Made the changes as requested by Viresh like adding comments, some
>   coding styles etc.
> - Link to v3: https://lore.kernel.org/r/20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com
> 
> Changes in v3:
> - Always check for frequency match unless user doesn't pass it (Viresh).
> - Make dev_pm_opp_key public and let user pass the key (Viresh).
> - Include bandwidth as part of dev_pm_opp_key (Viresh).
> - Link to v2: https://lore.kernel.org/r/20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com
> 
> Changes in v2:
> - Use opp-level to indentify data rate and use both frequency and level
>   to identify the OPP. (Viresh)
> - Link to v1: https://lore.kernel.org/r/20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (5):
>       arm64: dts: qcom: sm8450: Add opp-level to indicate PCIe data rates
>       arm64: dts: qcom: sm8550: Add opp-level to indicate PCIe data rates
>       arm64: dts: qcom: sm8650: Add opp-level to indicate PCIe data rates
>       arm64: dts: qcom: x1e80100: Add opp-level to indicate PCIe data rates
>       PCI: qcom: Use frequency and level based OPP lookup
> 
>  arch/arm64/boot/dts/qcom/sm8450.dtsi   | 55 +++++++++++++------
>  arch/arm64/boot/dts/qcom/sm8550.dtsi   | 79 +++++++++++++++++++--------
>  arch/arm64/boot/dts/qcom/sm8650.dtsi   | 79 +++++++++++++++++++--------
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 98 +++++++++++++++++++++++++++-------

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

