Return-Path: <linux-pci+bounces-43614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA3FCDA231
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 18:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FE83309F691
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDA42F2604;
	Tue, 23 Dec 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9SlRoip"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BE5347FD7;
	Tue, 23 Dec 2025 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511230; cv=none; b=PTQSTu+TTkoVb0kPwWZd/CC11RuSAW+9NppTIviN1usI09GhrYlZUOC7FsEMRzclF2Qg0+ufFxyQpPZY1nTUfFFgnFh2iOWYVEzkwp/dLukz37fCp21EJ2AL50yUtZDyh/KahmxOSNdezSOCwJleBzRuVmYIUBd3WKMWlpxIz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511230; c=relaxed/simple;
	bh=j4KsScsG1hqXyQGukCHfOZAZLrJ9X3MMZqwShsIdJyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sjtjqM+xpLShRkarJv2M/Qr6uh4e0lOoxv4QtenRiLeJ6gYNWY0vCf2JQVQ6H/+IaCSxtqXeHkp35t8F39MNCTK6LHwZwzqpZ2qurDbwduzNC0CsUOgJUbd/N0dnSrmEM/3vtth4OYixhMCQQUhwW/lpnVsSJa4UXnwCYPYzqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9SlRoip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4219FC113D0;
	Tue, 23 Dec 2025 17:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766511228;
	bh=j4KsScsG1hqXyQGukCHfOZAZLrJ9X3MMZqwShsIdJyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e9SlRoip9YzcvFE9Od0JKeiTvWcHKTv2tyxqTe/aBpKuDHdHAocPSidEmxIw1nZQk
	 sNQ2j8SX5Afv5buWq0KL0qfKOrbcUMw5CR+qJ7RfUfWOBigXI8Dveg0W8dQxZDl2tx
	 UHdMVj/gdFRNqNEJi6rXfmf4YzTf0YijO3g9THLoKYj8XiWb+4wv6Q2YgMdvPoU6xU
	 ONFFM2npal8IzciF/NAarx+40JjrEgcPjafExcM0Qdvhu0SPdjwofb+BZifFT9/uyV
	 tBpaKtG6t4K/dswictauUte0tnbk045G5pj4UeCAP7CUDB+LTEkkgmoemvUs5MR08B
	 0vSdGw2lurMLw==
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
In-Reply-To: <20251128104928.4070050-1-ziyue.zhang@oss.qualcomm.com>
References: <20251128104928.4070050-1-ziyue.zhang@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v15 0/6] pci: qcom: Add QCS8300 PCIe support
Message-Id: <176651122191.749296.15336587657057030247.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 23:03:41 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 28 Nov 2025 18:49:22 +0800, Ziyue Zhang wrote:
> This series adds document, phy, configs support for PCIe in QCS8300.
> It also adds 'link_down' reset for sa8775p.
> 
> Have follwing changes:
> 	- Add dedicated schema for the PCIe controllers found on QCS8300.
> 	- Add compatible for qcs8300 platform.
> 	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings for qcs8300
      commit: 393e132efcc5e3fc4ef2bd9bbed2a096096c9359

Best regards,
-- 
~Vinod



