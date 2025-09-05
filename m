Return-Path: <linux-pci+bounces-35498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92614B44CE7
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 06:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A686482FD5
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 04:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9741220F37;
	Fri,  5 Sep 2025 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pStKVpOQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9341DF985;
	Fri,  5 Sep 2025 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047851; cv=none; b=iXU+vnX6xwGyDqnT4B4xqt1tRTLDF4RzD8dLiE7uwhwr40Qkh7LYXftX3WdPOCB53zWeey+PaRPzFfdGsyLXDmQ7Ma7xjSwt7sJ2mbgpHsBGOneidRFBU7VICslAI7vTusLLYUF3eJzauPWtMJrJU7PrCtyN0USjsazvNTwgGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047851; c=relaxed/simple;
	bh=y/5a7k0wUPRODTgPuXBBRsBXnaLaZ7amN7FTAS0julE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rxerQ9r5xWDUA8USA56W3iXqcqbWkBHBzRc8/nXA4lTUoxBmJsY5z35pwvF/vLcJFB3H+4kWhK3fzefi4MKy1/8Am4fVjqqjRQR5bcJU1F8h0mZOSp4e+ZKYAmfjR9AZS/KvPSKPhH5nfrYl/6k/eUiyDjDP51Wy1Dzpp9sVqmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pStKVpOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5E8C4CEF1;
	Fri,  5 Sep 2025 04:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757047849;
	bh=y/5a7k0wUPRODTgPuXBBRsBXnaLaZ7amN7FTAS0julE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pStKVpOQSEipXtwkKTMPD0NGcQlfYLMrWCh4UsUVBIb4O6neA0b1XETdSZnYpbx2/
	 qBA85nn6Lu2V+hxKin6fTR4lmqfnT7qX4RbMlFxhWeqdX9Dn54nmmtPf49DaAEZq+R
	 v19NUgl5ItMBYA/Q3aSUaPlXPBvA7Y8aMAmtfzKuOHzFLvSCJE4eoRXvNF/SOev+kB
	 S1jf4UzJkQ33mtIAG6FO6PreKLPhdzRyy4pH1BAWcuKPYTb3npDft6u+U9Huo6MtKl
	 V7WagGFPJCMT3kyvxLm7NRwY+6KhZsKeyzOwtZCVvybgFRLosORX7RfEZe+KSa8jcl
	 1ZJwgIbAjno3Q==
From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
 Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250820022328.2143374-1-hongxing.zhu@nxp.com>
References: <20250820022328.2143374-1-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v5] PCI: imx6: Enable the vpcie3v3aux regulator when
 fetch it
Message-Id: <175704784338.6198.15508737938849793492.b4-ty@kernel.org>
Date: Fri, 05 Sep 2025 10:20:43 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 20 Aug 2025 10:23:28 +0800, Richard Zhu wrote:
> Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
> asserted by the Add-in Card when all its functions are in D3Cold state
> and at least one of its functions is enabled for wakeup generation. The
> 3.3V auxiliary power (+3.3Vaux) must be present and used for wakeup
> process.
> 
> When the 3.3V auxiliary power is present, fetch this auxiliary regulator
> at probe time and keep it enabled for the entire PCIe controller
> lifecycle. This ensures support for outbound wake-up mechanism such as
> WAKE# signaling.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Enable the vpcie3v3aux regulator when fetch it
      commit: c221cbf8dc547eb8489152ac62ef103fede99545

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


