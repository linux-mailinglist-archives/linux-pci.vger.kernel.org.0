Return-Path: <linux-pci+bounces-32517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DABDAB0A03A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 11:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7C67B6E90
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D535B29B782;
	Fri, 18 Jul 2025 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXHLIMzU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3C2951C8;
	Fri, 18 Jul 2025 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832761; cv=none; b=Dc+YrykyBafNKFeibIInSs9jKP8CR2NwTsKVMSMEKbqCChsbdMFLJnakwtO5tqENT9mP7VIls2iDQ1sZjKi7roDhzRq4+Q0vOi5x4xTc1N+mKwFnjLdn3Q8Smmx+EcVaU/mTKit2ARk+f0toAQlN8xN9efIuYs8EAgDhRHQcQnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832761; c=relaxed/simple;
	bh=eMUkr54lkYoKQmZN2GMHBPpSnw2Q4SW0POsRqEonAvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkZWYTQmiqMDGPQFePHUWBf2KswSMviCZGB8AmvYxSUBJyLtjUZdYj/QucGe1lJ2W8EKEdpspe9N3LgXHTALlknIy1Cl+o0DsBKjLE3QapR0TKHwbUtd1Q/3wd4RwIKijT3uYaoxJmraph/lDqISRmQqOpnFt5xtvYM1e6+1LC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXHLIMzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2836DC4CEEB;
	Fri, 18 Jul 2025 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752832761;
	bh=eMUkr54lkYoKQmZN2GMHBPpSnw2Q4SW0POsRqEonAvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXHLIMzUaarVTFKEETAaC4ekSCt5drsqnhxPQifyVVyWq7T/5RNlRKBqlaSOdKvf+
	 mcRV25NMpnoijDgs/TS0Unz2p8L7xJHlREJMq0xDDw6dkWuRSyVVm3T3F/rZg7D9UO
	 8EqD1OVMuXipifavTghH3kykTdG4eXWrLsipdcDlR1rabHasR98YNsoADfSDVp5tE4
	 V0XARyBzKjeclZEvAyUn+CF9/+k+ErzJAH9ZEm3a7r6tlA0TnxDkdf3XQOj2yGTNU5
	 emguyoscBqB/X06asclvbcuNq0+IQaABRmTpPfMAm5zdCdf5DEQQ9yFqmyO8Yb/1k1
	 aHTar4JaaiGqg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uchs1-000000007oH-1DEc;
	Fri, 18 Jul 2025 11:59:13 +0200
Date: Fri, 18 Jul 2025 11:59:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v5 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
Message-ID: <aHoa8fgIsPY3no3Q@hovoldconsulting.com>
References: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
 <20250718081718.390790-3-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718081718.390790-3-ziyue.zhang@oss.qualcomm.com>

On Fri, Jul 18, 2025 at 04:17:16PM +0800, Ziyue Zhang wrote:
> Each PCIe controller on SA8775P includes a 'link_down' reset line in
> hardware. This patch documents the reset in the device tree binding.
> 
> The 'link_down' reset is used to forcefully bring down the PCIe link
> layer, which is useful in scenarios such as link recovery after errors,
> power management transitions, and hotplug events. Including this reset
> line improves robustness and provides finer control over PCIe controller
> behavior.
> 
> As the 'link_down' reset was omitted in the initial submission, it is now
> being documented. While this reset is not required for most of the block's
> basic functionality, and device trees lacking it will continue to function
> correctly in most cases, it is necessary to ensure maximum robustness when
> shutting down or recovering the PCIe core. Therefore, its inclusion is
> justified despite the minor ABI change.
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

