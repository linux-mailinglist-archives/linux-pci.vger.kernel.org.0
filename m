Return-Path: <linux-pci+bounces-8256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93FE8FBA68
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 19:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F07288294
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321D5149C6E;
	Tue,  4 Jun 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6kbkbry"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF013C9C7;
	Tue,  4 Jun 2024 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522224; cv=none; b=HjDBNWwekx5O79QheQ2WKRFLUs+A7xvCk/l2yGsqFzLJmXe+6lvViEevF5XnNDyucmxyt/mi00bI0UcB2sNOZzfAwxUYGD+W2s9ALuqjbwA5IBWW9Kb2im1KXgyAoj6WfWbSCBnjeU0xpeiNnfcuIP0twJ7KftzrBK1Cfb9uL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522224; c=relaxed/simple;
	bh=kqXj1o9Fsay7aIOaaJ/crMyXrglXA8LEVq/ukbMHfR4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dQDb0IA6Hs3wS/8LeSJerVBXhgenNp9c3sIdPz80DqvxJwSlP2LFXECIj6Jm/R+ADr2m4GTvEuTmUxTyJDizIa3QdMtH9/8wIPHClSSwwRz33tZzCNWODDbkeD4f3/YSGe2yPOaZOfSpczR9Ue1JT/GkvaP9y22lU923+esHL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6kbkbry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2066AC2BBFC;
	Tue,  4 Jun 2024 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717522223;
	bh=kqXj1o9Fsay7aIOaaJ/crMyXrglXA8LEVq/ukbMHfR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F6kbkbrya+2QdXaJJxhMiNJEmPq6RWdGsdKv5Wt8MKfQPpRWECv0VxJIXccPoTR9K
	 JBP4aE+hxN7XKqav4/IiGnpp8KCM5EJVVVBq9b/OovAlL62hMnzOBnNDerMmKONKcy
	 45i9TGTWAO2jQ4cKDpSLbIlaiNIC1JLFgvUV4aZ9jOyh/xBQmRvMaXEqmF5m3yIyDJ
	 oE2X/FaMRR0V8QHBtM/DxaLSeFdn1lMIj6ckCem+zUxamxNWjVNe0jEmdnj3ETnWDL
	 ddlBOn4kunY2LkQjfLUOTc8cE42hWGoap49ZsdowxT92uOERhNiWaFrQgkTpuaYljK
	 +SJVeajyY0vSA==
Date: Tue, 4 Jun 2024 12:30:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@quicinc.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 01/17] regulator: dt-bindings: describe the PMU module
 of the QCA6390 package
Message-ID: <20240604173021.GA732838@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-pwrseq-v8-1-d354d52b763c@linaro.org>

On Tue, May 28, 2024 at 09:03:09PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The QCA6390 package contains discreet modules for WLAN and Bluetooth. They

s/discreet/discrete/

> are powered by the Power Management Unit (PMU) that takes inputs from the
> host and provides LDO outputs. This document describes this module.

LDO?  Again below, but maybe this is obvious to everybody.

"This document describes this module" seems possibly unnecessary.

> +description:
> +  The QCA6390 package contains discreet modules for WLAN and Bluetooth. They

s/discreet/discrete/

> +  are powered by the Power Management Unit (PMU) that takes inputs from the
> +  host and provides LDO outputs. This document describes this module.

> +  vddpcie1p3-supply:
> +    description: VDD_PCIE_1P3 supply regulator handle<S-Del>

s/<S-Del>// ?

