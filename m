Return-Path: <linux-pci+bounces-37014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4F4BA0BD4
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 19:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90E23A8DB1
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 17:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDFC304BA9;
	Thu, 25 Sep 2025 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0whetM5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AE219F40B;
	Thu, 25 Sep 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819911; cv=none; b=mlL4y0VYtKW6RNGui/1M9nH4LEqnTymuTIwQVZ29z7Y5iDp1P7jFL34Bl0MYGXeNM3STHaHIUR0V3l3by7lwfhjmYmFgMsvzQF3k0U0eqDapAf3mYrDusF0CLfhroFQvhZhVmb7LB0Zqo0TBzip4LhFJArWGAT9gWHnm4aLJ+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819911; c=relaxed/simple;
	bh=LiqXXsioRh4a6BaPKJmLKa3mWFCksTvXxuDRwrP9b84=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Foc4lQ4uF3JCgj2isbUQHN4tGk9cvxdCkanyVM/amW+pOwbEejxsW0oVnFvJwGeKrBLFMfdqasybh5JPgBqXfbEpuCv772K3zB+SDMyu5PxjXpi5oxndgRqW8Aq2lOwe48oFdVRYgq8+PEA+UHL3OBayUfqf8yZkR4iu0TbIGAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0whetM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1758C4CEF0;
	Thu, 25 Sep 2025 17:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758819910;
	bh=LiqXXsioRh4a6BaPKJmLKa3mWFCksTvXxuDRwrP9b84=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=i0whetM5glZXecBehF4IA10tgLqJ3l80Bs0zH+sw0sCCjJyBA8uzJevBKBEHvua+w
	 dVNKpkBGITnUp44lN9rtOT1TncqjPQ/IqRUT2MgpxUsmTBmuX1j1nr5Cek7mGSDeuj
	 a175Ms4RJR4An80EjBmH7dG/RtleO7UAmLr2wcbZYnFGSlQXWJv2KLL6xf/VrCfSwe
	 0RmrNhW6K/M6z8v+EnkY/YORlbIT8c7xKLnKYIsqMSzXJBLx8n1SCUI9Pn8dQb0vEV
	 4dw0Fiw0BCTHV01jxhhHoHQ8SGoqKq+wix0sgj7FNJ83echucxEM1rpd8g7+122lNG
	 wt2qw8vHvmI8Q==
From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
 lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, 
 Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20250923073913.2722668-1-hongxing.zhu@nxp.com>
References: <20250923073913.2722668-1-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v5 0/2] PCI: imx6: Add a method to handle CLKREQ#
 override
Message-Id: <175881990427.392988.6937520327985325506.b4-ty@kernel.org>
Date: Thu, 25 Sep 2025 22:35:04 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 23 Sep 2025 15:39:11 +0800, Richard Zhu wrote:
> The CLKREQ# is an open drain, active low signal that is driven low by
> the card to request reference clock. It's an optional signal added in
> PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be driven low if it's
> reserved.
> 
> Since the reference clock controlled by CLKREQ# may be required by i.MX
> PCIe host too. To make sure this clock is ready even when the CLKREQ#
> isn't driven low by the card(e.x the scenario described above), force
> CLKREQ# override active low for i.MX PCIe host during initialization.
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
      commit: 27afd094ea4be542594058d685c7af4654ab8de7
[2/2] PCI: imx6: Add a method to handle CLKREQ# override active low
      commit: dc853fb85d6b90e0805660c1dbb38ef7641af839

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


