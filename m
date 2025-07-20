Return-Path: <linux-pci+bounces-32604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13547B0B94C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 01:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D716218982A0
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 23:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E12F1E1DE5;
	Sun, 20 Jul 2025 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABLkidrE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E189984D02;
	Sun, 20 Jul 2025 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753054985; cv=none; b=hFIHe/yx8gaKgCKJygp9jJvmsBQ3x3WfM88KV+iDhhWxKfFJT/G5ktlBoyJOsgI9cNF2V4B4XxDTtHrR3uvftTr39LWHuwf3bOQnEyv2ELD2FKpYYqNB0mex9NZU5gaNYtLb3gx3qPxDlYsZOJ6NzjfIZZn3shPMJ6G0hIQqK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753054985; c=relaxed/simple;
	bh=hi1P1Md3lx0mFctv/IZEeLMfN66v8OwqSqJnjru2AKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9XHC58MZk2yGrOuKGsPBJYejfMc42nkwcYT0kNjEA9HvHnqkPGkcn6/vK9MEh87eik47+LCfwnNIWOiuj80e+fQTCjovXdT0iya9BuvW9hEeqTmI4UgEQwqIeg4oZ431TKih2fuq+8eUuf/Kd+JVKuDr7CZK841KUXBNG2Xj7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABLkidrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30910C4CEF1;
	Sun, 20 Jul 2025 23:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753054984;
	bh=hi1P1Md3lx0mFctv/IZEeLMfN66v8OwqSqJnjru2AKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABLkidrEM2saNjFzmOPHi29nSFhi1ImiUstYIa9yWmskrhoktNS5WuZjis65jTXRz
	 EKhBUHbQbM7wE+228YJdxf53icCDaPhE6RyY7JHHEWJ9u+BS1lwFX86/0myp3zyBqu
	 Mt4GYUjy4msPoJe2Z9JFKjXlB3lSfPnG6CZOj8lIApsV9xKadTvLKiVtuo+wUfMXnx
	 aWFRM71T9t7WhjFLb1Q4/RVPP9stBFqHPL4jiR69gVan7MbPsdz9THwJUtT995xlHB
	 aff7lL8tlUBv0Xx4k8QZPGMSbwLtIkj2nRavbC14DeD4vBniYJfOL3yMCAeJOAhjsT
	 EgYnWx+7oM20w==
Date: Sun, 20 Jul 2025 18:43:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: conor+dt@kernel.org, quic_krichai@quicinc.com, vkoul@kernel.org,
	bhelgaas@google.com, lpieralisi@kernel.org, krzk+dt@kernel.org,
	jingoohan1@gmail.com, qiang.yu@oss.qualcomm.com,
	abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org, kw@linux.com,
	neil.armstrong@linaro.org, mani@kernel.org,
	devicetree@vger.kernel.org, johan+linaro@kernel.org,
	andersson@kernel.org, linux-pci@vger.kernel.org,
	kwilczynski@kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, kishon@kernel.org,
	konradybcio@kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
Message-ID: <175305498292.3083407.12105009386525845667.robh@kernel.org>
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


On Fri, 18 Jul 2025 16:17:16 +0800, Ziyue Zhang wrote:
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
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml    | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


