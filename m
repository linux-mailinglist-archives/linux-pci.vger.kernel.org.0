Return-Path: <linux-pci+bounces-13439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C149847A7
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 16:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AAA282A14
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C521AAE28;
	Tue, 24 Sep 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqCIafE2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC01A726D;
	Tue, 24 Sep 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188004; cv=none; b=Plfpv+34c6XPCdQwXsUqaQqSswt8GCpXYEw/15rKIUqOr/9i6ZVMyaArEG8gOcLVzgXM08YM1xEu7dyTq2H4AMNL6RX/8i1nhNnJwygg7NRxTQXu+zEpfR+88SKn3U4E7zLwGmj9v8NgswY0bOSQS+O4uUHnceMsJScu46oVwE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188004; c=relaxed/simple;
	bh=owLHBep2qxd2QdjxXGESTjGFlLOvLH5ifMDxPIDYmjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxOezdwY5mS5qxLgb9eO2W0eJa6O8w68Xnp34szvTD+9Q1CKn39oorHTCSB7R50JvboOn8wSauwvKWD7Qa05KcfOx+ZKQErIhNFZxAzJ2qVL+0QCSSVpFxw9RR76VnfrE4ac4c59T7xa8QQFdtYYGiUZcqG/COHWUcwXASlCjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqCIafE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FDBC4CEC4;
	Tue, 24 Sep 2024 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727188004;
	bh=owLHBep2qxd2QdjxXGESTjGFlLOvLH5ifMDxPIDYmjA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CqCIafE280oGO0sFkIcWMJ+dIS3ZxvIdSp7UlGHkL3420uZqrF9MQv7jlCYFjUO2H
	 E0eL00nUUexPHzcCedFkExJK/npdT2Ix8c5U94p7OOQMdPepdCQaPa+bNypuPZrcYG
	 kr21Zk77y/cnbg6Zpa+t9hrbhWB+zXe3DnxmiN5hzxkSBOABWo06ZnI09i233fHGtd
	 2RSDh7UQZD9VNm1WI3DrqliDwnkurf5nNDksi/RLZrfTlNpQc4clA1IVy7k/ZRaT4R
	 PhpB2rC/6iVVNuDDj0uIAWeWEegnmhrxwZxBzse3aHBEYMqIhVmDmkJocUdHTYmBqb
	 NciAKsIHUhFug==
Message-ID: <9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org>
Date: Tue, 24 Sep 2024 16:26:34 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
To: Qiang Yu <quic_qianyu@quicinc.com>, manivannan.sadhasivam@linaro.org,
 vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org,
 quic_msarkar@quicinc.com, quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
 neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-7-quic_qianyu@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240924101444.3933828-7-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24.09.2024 12:14 PM, Qiang Yu wrote:
> Describe PCIe3 controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe3.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Qiang, Mani

I have a RTS5261 mmc chip on PCIe3 on the Surface Laptop.
Adding the global irq breaks sdcard detection (the chip still comes
up fine) somehow. Removing the irq makes it work again :|

I've confirmed that the irq number is correct

Konrad

