Return-Path: <linux-pci+bounces-36943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4799CB9F6A2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 15:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A8B17D280
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C711FF1AD;
	Thu, 25 Sep 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQrG8RUh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9D1137923;
	Thu, 25 Sep 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805607; cv=none; b=hO8HL9U1abxTFJxGUiQFQV0c4enoEx3yYFoWsWoxhcixDQBJjLicFjxr1dhO0m9PuO+zRA00cdZyyzI0M6v92VW/Ws4vq+bxnREo4FGVHym76+WuDqyXuCRb+Tw8FU4AsMPz+5Q43GlEsDUt5BjH7Hw81aBmg/HNDWLZJy2RbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805607; c=relaxed/simple;
	bh=tqHiPuaWvPkWNyWSejFJnXiHQaUaHLR+Dsrl+qUoonE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgBw1qsvxeHeB9slQXjQ/EOnGhUxpvNEHuw3QRzq9B9GIgy7H72bgaCgLERfhHXj2jC6Qs9ZYvy2h6hIxHWTy9B6B2lk2eZZPeuS0lb3EoaitPdhOJtwzt/nwG5kfA3MsitV04UiI1kFqviGJMu73RrNcmudcgHie7I8+ttjguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQrG8RUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920D7C113D0;
	Thu, 25 Sep 2025 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758805607;
	bh=tqHiPuaWvPkWNyWSejFJnXiHQaUaHLR+Dsrl+qUoonE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQrG8RUhEmZDzFq7uUXrW2aUzU/juCKW/Z0JZX4mnIHFCAL6KODWeh4dB6AQLe6xc
	 PfTNxofgZFn89DvL3mZLIRwlAly3B2gydD1YejNSWbYD/KV0SDt1uvMcQRRLaMLwtQ
	 +8sMFXWtkbVqMLsTdaUtt1DH0fVU1UR3YmCk3AgoIJgXuMaLo5iGBTMy8UPyUr2PgM
	 UQl41Q9MTh7Vn6O08eEOe+v5UjEYvbunuUT6kNGuoHvq1G0jiDKO2C/E8yCaGgHwxB
	 5Jzp+QsnsbT7ljExB8ER52wfMKfndh3GlRPPivYMCuvdBclDMeUI1o1BCCb5jrtvzR
	 2wyZH1ZSnLBAg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jonathan Chocron <jonnyc@amazon.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH v10 0/4] PCI: dwc: Add ECAM support with iATU configuration
Date: Thu, 25 Sep 2025 18:36:36 +0530
Message-ID: <175880556056.15879.13833041080045099781.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923-controller-dwc-ecam-v10-0-e84390ba75fa@kernel.org>
References: <20250923-controller-dwc-ecam-v10-0-e84390ba75fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 23 Sep 2025 16:56:50 +0530, Manivannan Sadhasivam wrote:
> The current implementation requires iATU for every configuration
> space access which increases latency & cpu utilization.
> 
> Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
> which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
> would be matched against the Base and Limit addresses) of the incoming
> CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
> 
> [...]

Applied to pci/controller/qcom, thanks!

[1/4] PCI: dwc: Add support for ELBI resource mapping
      commit: c96992a24beca0768c1c42ad25d6a466e17ec70f
[2/4] PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'
      commit: f6fd357f7afbeb34a633e5688a23b9d7eb49d558
[3/4] PCI: qcom: Prepare for the DWC ECAM enablement
      commit: 4660e50cf81800f82eeecf743ad1e3e97ab72190
[4/4] PCI: dwc: Support ECAM mechanism by enabling iATU 'CFG Shift Feature'
      commit: 0da48c5b2fa731b21bc523c82d927399a1e508b0

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

