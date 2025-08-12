Return-Path: <linux-pci+bounces-33870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 223B7B22E14
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 18:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FE53B2AB0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17EB2FAC1F;
	Tue, 12 Aug 2025 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDGo2CNW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA3C2FA0FA;
	Tue, 12 Aug 2025 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016834; cv=none; b=SzVof/Fbj5ITX7NCgOCJlOZRSM6ReLIje8WEPYgtHu2YoxTrYEdCQFO6qEmSKTaJ/ccrI6PRstrCqMNelodRfLO/+Gpdu5NYfTDwjnuH2Z5gmL/HxWYMoufZCU+ZDq2tk86IJhAxnDmZLNXpd81C5FFbSuZS1IskHtj0RUWYsKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016834; c=relaxed/simple;
	bh=c0imZ72TUJ70OzV/83zxsZL4bXqGEF0O9JOXyLfWMgY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vaf3XKZri+8BALFvZ9qF92tc2kGonhe3exqirCG545m8EuLh1Mt4hplrmKQ6X0rbBttUxIezqdzzn/iyA8tDCqPvnnroaKwEUtlmbydwNnMONFpYpfzQEajUZwBtfUtEQ98Nw6Bvuojjte3Lcv4Chq9T48SZPN8Wo5s/UfqURhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDGo2CNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318FAC4CEF0;
	Tue, 12 Aug 2025 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755016834;
	bh=c0imZ72TUJ70OzV/83zxsZL4bXqGEF0O9JOXyLfWMgY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WDGo2CNWD1Bi+gY3wt+qreis05jO5RimzwXEGs3acdX6RAtHFtlQuV4lEyAZSyS/R
	 zWRqi351ysteb4BfND75gZkKyRcItV6BvEoGa9/2FsjIYm5/YnhXeach63vNJiw1Z6
	 F74DVKTxRMMSOh3qWAEKeaywAzVPYCHjZSW7h4VV8YBgry5Xh9lf+pVoGT/M06o8LW
	 LHmDOyKO9JjG7AHaXNSj10nUs9NeGTypfiqLeARh4qs4V/tg8Hlhw8MH+JMTJjJaAA
	 o3z/VQ3staVVr1j3uNMC7IW43prPdg6aJk53cS/lGek5OOFtu8DwtdUgM2IaqcXI+8
	 OL1elNUz5QZ9g==
From: Vinod Koul <vkoul@kernel.org>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, 
 mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 bhelgaas@google.com, johan+linaro@kernel.org, kishon@kernel.org, 
 neil.armstrong@linaro.org, abel.vesa@linaro.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
 quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
 Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
References: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v7 0/3] pci: qcom: drop unrelated clock and
 add link_down reset for sa8775p
Message-Id: <175501682675.633066.14367700051268770361.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 22:10:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 25 Jul 2025 18:22:28 +0800, Ziyue Zhang wrote:
> This series drop gcc_aux_clock in pcie phy, the pcie aux clock should
> be gcc_phy_aux_clock. And sa8775p platform support link_down reset in
> hardware, so add it for both pcie0 and pcie1 to provide a better user
> experience.
> 
> Have follwing changes:
>   - Update pcie phy bindings for sa8775p.
>   - Document link_down reset.
>   - Remove aux clock from pcie phy.
>   - Add link_down reset for pcie.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
      commit: aac1256a41cfbbaca12d6c0a5753d1e3b8d2d8bf

Best regards,
-- 
~Vinod



