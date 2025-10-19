Return-Path: <linux-pci+bounces-38656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5A9BEDF25
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 08:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A891A34AE3D
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 06:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822E72036FE;
	Sun, 19 Oct 2025 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMqNhywC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53190178372;
	Sun, 19 Oct 2025 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760856408; cv=none; b=sXCVBd//OUisGTh2CbsIuO+D34H0+PI1BHT5bu6vipK/XIpG815dENEhYys9X+wrJ2KcAlTD7b/4Obive4Dgqe5EiyhDRxgRwzKAlOyW7TKTtyvzcp+osFnmBXPsV59XuR405sPcjLNci2bGYQoj5AHUXmIAo7gyfaLLbEtrlcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760856408; c=relaxed/simple;
	bh=+a+2hCN0GD5orS5JrZMFWqnSdCPfMOObGECdOlF/YN8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jvUhqdbuW1TCW9LbsV8aleKPg5czFHVro4w3WxxiqmvZJixS1MqWGO+ZjCgaEQBv+aiqsXQ02/2iBLQtTIcu2sDwT8o9mIdcNvalOjjgiuaYkaQcWCkZ9iq14wHp9Vwuuo1m9zH49p++P8iiv6qKL9zpWVOeEZ5o7AcWmpiS+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMqNhywC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AEBC4CEE7;
	Sun, 19 Oct 2025 06:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760856408;
	bh=+a+2hCN0GD5orS5JrZMFWqnSdCPfMOObGECdOlF/YN8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TMqNhywCW0j0gr+EVC6Q8qsF30M2Gyvdxr11ywRpofXBeFofDxgeupde2Zp2j0hag
	 PU3jp4JzMkkaDx07u16quNHT0hyGYr2GVQsGJloGcoyOON29mN1E3tQVeRlcVYP8wI
	 1LHai7ybNXEMzZ9+F0/A3IEa5+Br/LLChYULjhDGs6ySp5JLF5gs+FuK97gV7m5cZg
	 4H5JHZbJ1Gidk9EB/BxiuDcyPza9Lh4O1Fr4IxVmk+12xte/wWWJgXQh0Sy/mAdvN2
	 pkp6MXFgt+U3uEoTmgS1nctWpJJnfasbbFsfUvFzj+XY8AcB8SYd3XjTnFyCCZ5eR0
	 9+6y5b/x0xR6g==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>, 
 Yao Zi <ziyao@disroot.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>, 
 Chukun Pan <amadeus@jmu.edu.cn>
In-Reply-To: <20250918153057.56023-1-ziyao@disroot.org>
References: <20250918153057.56023-1-ziyao@disroot.org>
Subject: Re: (subset) [PATCH v2 0/3] Add PCIe Gen2x1 controller support for
 RK3528
Message-Id: <176085639822.11982.1205401883779675228.b4-ty@kernel.org>
Date: Sun, 19 Oct 2025 12:16:38 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 18 Sep 2025 15:30:54 +0000, Yao Zi wrote:
> Rockchip RK3528 ships one PCIe Gen2x1 controller that operates in RC
> mode only. The SoC doesn't provide a separate MSI controller, thus the
> one integrated in designware PCIe IP must be used. This series documents
> the PCIe controller in dt-binding and describes it in the SoC devicetree.
> 
> Radxa E20C board is used for testing, whose LAN GbE port is provided
> through an RTL8111H chip connected to PCIe controller. Its devicetree
> is adjusted to enable the controller, and IPERF3 shows the interface
> runs at full-speed. A typical result looks like
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: PCI: dwc: rockchip: Add RK3528 variant
      commit: dfbf19c47a01eda5df4d476d64a273e1188ea5a1

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


