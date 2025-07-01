Return-Path: <linux-pci+bounces-31180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1763AEFC50
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 16:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1823B8976
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E11275869;
	Tue,  1 Jul 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ffssx2JQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0F274FFC;
	Tue,  1 Jul 2025 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380048; cv=none; b=jrcyzuaNJh4FshpcCVCsOzPc33zcE8GK+0UouyY4ETut1NBCSDGYTXBSrmA+3C9bl0Hic47DQQlIIhPiajnYSCqIB0TA0DKACY2ABFWE7kqPoEc/YW4i3wsdvCUqyThPvKv/RbLbO06VmuAPeVJIGNVdPjRBQ02XBRbG/WlIb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380048; c=relaxed/simple;
	bh=bDi0f6jCqN5KhrDrpJjcKcdCYvPKH5IumG0nhtrSL1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D8nY2S/v8/t29+gG6sqWhVRA2T+Xu3+dtdETCxTliP4ve6qzg0RAcg7d5hGc2AN/YVva3ahKjsSenRttzXCdPGnRuZJ2A4KZOSvbHqTpvIuBMkrAvnB4mdjtYCqTw9ko8E7fNqUtiM+1bBLljER3AZmSbvdLWWROJ/YPllE6USU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ffssx2JQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E6DC4CEED;
	Tue,  1 Jul 2025 14:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751380048;
	bh=bDi0f6jCqN5KhrDrpJjcKcdCYvPKH5IumG0nhtrSL1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ffssx2JQhDwOAEgEZh55mWefbI/oPxPsCnWY+hPApIsAEAHc8lOPpqQA5FKceyq6z
	 aL4F2WIlYe1X62eMs7AOeD/RjB8CCBAEuwQtVp8kdKc+heW/ZRIqQF7THSIJ3MidFZ
	 fUjnfqRk2hcCVGXC9anCKQ7wWzlH0PU3J8SHeYKGYyc57e2mEm8GPY1N1vPD03eAZP
	 fma2/85RMWZasI91scxvzITAa5++wnjuVcLsbeciSe+7WpJq6Kcudippz1mYmUATEg
	 8JW1csptA3d5e6lUCWsv6gPuqU9qhJ9Ng3AqRzszmU/iwMd9qqFstfpR3jeG7xPoHz
	 3BAzFm9gftUJw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20250617073441.3228400-1-hongxing.zhu@nxp.com>
References: <20250617073441.3228400-1-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Correct the epc_features of i.MX8M chips
Message-Id: <175138004317.29152.1836707203802204355.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 19:57:23 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 17 Jun 2025 15:34:41 +0800, Richard Zhu wrote:
> i.MX8MQ PCIes have three 64-bit BAR0/2/4 capable and programmable BARs.
> But i.MX8MM and i.MX8MP PCIes only have BAR0/BAR2 64bit programmable
> BARs, and one 256 bytes size fixed BAR4.
> 
> Correct the epc_features for i.MX8MM and i.MX8MP PCIes here. i.MX8MQ is
> the same as i.MX8QXP, so set i.MX8MQ's epc_features to
> imx8q_pcie_epc_features.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Correct the epc_features of i.MX8M chips
      commit: 66ee525537be816b2accf4ad28ad33cd299ea492

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


