Return-Path: <linux-pci+bounces-19011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C649C9FBFA1
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 16:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900DC1650E8
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D9C1DA62E;
	Tue, 24 Dec 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzd2AjG4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B31D79B6;
	Tue, 24 Dec 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735053929; cv=none; b=EcnwQED9mjnfdPRvzLOZNsgZo2tIMjuPwcn3x2hk6jXHmNT4hd1x7WMI+J/oTO7P+wJeniCqZSqQdaAYVPXgI7fMzdURQx1oZUVwDsBFTba6gTh/6+RX8j059yMZaMRBqvM6rvzYqNcrEXNzaD4p9igawTf1XGbNXp1070FZMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735053929; c=relaxed/simple;
	bh=P75T60ObovkCRBQsZ7WvanBGGd4jp9pTkykBw9rzs/E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UU9booCs2IUYKtg48Br6Apaf5buZv5vb6jvHSwmwFWuSIDjGkEPZcT+cx8skKsKjVO7DZ7Z09AsJcLUr1CwWPKAW65p1mOJKC4ilNxb31F8H6sZVbGrPjLodIABcHYh1ZiSKs1ZV7kWA8mARgBT5aVbjRB4ZiVOALkCtLlIAsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzd2AjG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DF7C4CEDC;
	Tue, 24 Dec 2024 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735053929;
	bh=P75T60ObovkCRBQsZ7WvanBGGd4jp9pTkykBw9rzs/E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gzd2AjG48t36e4QBIUVCQZMoszxAQMsjXRRKkTbgEtjDw9qX+uMPAh0i0yTXpZbkD
	 rYS+ukGirvETZuVZK4g/7tL0N1XEJm/As3+cJPcCe0dORR5frS3fWCJJSJorLxfokz
	 rqD7M2MEl8lGGwE1Txie0f0IoIt3kx9jENlrDGXzD0HMQEeflt/BIkMbYcf7jAyNvL
	 joREUhbdOJAh0ZK2pw9bec/xOpC5M8SJ7nbHKGzUQRXaldJS8rv+sGzpFxMwWVp+6q
	 eyCMQqYY6bk8X6TjocmQZuusSgbqlMXcfAA+HEWE7eoZ05RRUEB3OAS0VGM4psjA+t
	 nHyzRGc/Axu7A==
From: Vinod Koul <vkoul@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
 manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, kishon@kernel.org, andersson@kernel.org, 
 konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
In-Reply-To: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
References: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
Subject: Re: (subset) [PATCH 0/4] Add PCIe support for IPQ5424
Message-Id: <173505392409.950293.14320055264182377571.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 20:55:24 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 13 Dec 2024 19:19:46 +0530, Manikanta Mylavarapu wrote:
> This series adds support for enabling the PCIe host devices (PCIe0,
> PCIe1, PCIe2, PCIe3) found on IPQ5424 platform. The PCIe0 & PCIe1
> are 1-lane Gen3 host and PCIe2 & PCIe3 are 2-lane Gen3 host.
> 
> Depends On:
> https://lore.kernel.org/linux-arm-msm/20241205064037.1960323-1-quic_mmanikan@quicinc.com/
> https://lore.kernel.org/linux-arm-msm/20241213105808.674620-1-quic_varada@quicinc.com/
> 
> [...]

Applied, thanks!

[2/4] dt-bindings: phy: qcom,ipq8074-qmp-pcie: Document the IPQ5424 QMP PCIe PHYs
      commit: 879ae4f226d82a2f0e452f14542efdbccf249286

Best regards,
-- 
~Vinod



