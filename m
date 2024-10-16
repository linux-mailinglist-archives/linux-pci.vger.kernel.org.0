Return-Path: <linux-pci+bounces-14697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB7C9A1450
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 22:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97991280722
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 20:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEFD219C81;
	Wed, 16 Oct 2024 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r10X59Mr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893952194AD;
	Wed, 16 Oct 2024 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111367; cv=none; b=lBBmi6frqbG+4NsviAjq3OSL5fHj/eoJEp2DqO9PxvkgOH/U8SXSqmZUZaxDcS8DYFLLCu9lEk4xwMcg03OfuUvobkUKnBg1fTICzQ+N14IWOKLLgbE4gunuaF7iewhlNUioldYnMvD45TlixutmkGlb+tySYY4Fl31i0190Kas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111367; c=relaxed/simple;
	bh=PiQSeIyuBWjHxBu2Y+/WbYLVlqoMxUlByRGM/OSls+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaE5OE2SQRab21PKbUK5tACLYeyOpGATKg662TWq+9OOyZa6D1iE1jR+nbO7coPRr5fe2lcxAkMCtd6rbwkyXqSNKRuIRsEyGQOPS4isC55ik0luA9zyxCOGOKz6EKNgmJle48/cy8rZnMpZLvdsE0tpVaUpYYEPJCw4M7vugSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r10X59Mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFFAC4CEC5;
	Wed, 16 Oct 2024 20:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729111367;
	bh=PiQSeIyuBWjHxBu2Y+/WbYLVlqoMxUlByRGM/OSls+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r10X59MrCZwERelEOupxXB3E8ynZkfAZMPi2BzpYECt/P40j+ZWtlK9L99SPceDBU
	 2c7NVQywdvwZ41AtgsfLu5U70N7rtxSQPSO/XCUGkLcFhISHOJ1okw7KUb2BawC5v2
	 kUIeEK9n9xqDHjpAsXUUrtxv7N69VnP2w4vzie3l6P6nYxcDhio3+YzgF+k4cK2IEk
	 4Q1RckIc+g2CKaqLASQS2t+6W9eIElmqs09D87pN0J+Slj0ZfEkk1kyEzDVK//dZ8X
	 dGUBKpjOQmIPF5xJSPx3If4U+/MCCxDNnZ0iCme7HoVRdFKYnvk2uV14UYwL01oFKC
	 srDgJjCHugiJA==
From: Bjorn Andersson <andersson@kernel.org>
To: manivannan.sadhasivam@linaro.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	abel.vesa@linaro.org,
	quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com,
	Qiang Yu <quic_qianyu@quicinc.com>
Cc: dmitry.baryshkov@linaro.org,
	kw@linux.com,
	lpieralisi@kernel.org,
	neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH v6 0/8] Add support for PCIe3 on x1e80100
Date: Wed, 16 Oct 2024 15:42:31 -0500
Message-ID: <172911112246.3304.6611767988729887215.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
References: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 11 Oct 2024 03:41:34 -0700, Qiang Yu wrote:
> This series add support for PCIe3 on x1e80100.
> 
> PCIe3 needs additional set of clocks, regulators and new set of PCIe QMP
> PHY configuration compare other PCIe instances on x1e80100. Hence add
> required resource configuration and usage for PCIe3.
> 
> v5->v6:
> 1. Add Fixes tag
> 2. Split [PATCH v5 6/7] into two patches
> 3. Reword commit msg
> 4. Link to v5: https://lore.kernel.org/linux-pci/20241009091540.1446-1-quic_qianyu@quicinc.com/
> 
> [...]

Applied, thanks!

[5/8] clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks
      commit: bf0a800415a7397617765fe5f5278a645195c75a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

