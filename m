Return-Path: <linux-pci+bounces-29677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EB4AD8A61
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 13:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202B317A654
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 11:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2212D5C99;
	Fri, 13 Jun 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE1svWma"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D7E2D5C94
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749813768; cv=none; b=V5kKTlAJyKaszj3xipO0yIf69OJNxXWAjYGAbCOq2wYh56CInYqV0A77/LIXj3TaCewUc65D7lZns+SRoTXTCHhJuQU2pnPrilMrAk3Ur8P0hTPz2qaJiwnfKbjOOOQQ8HRef3iO7qMW8CPqjRbqUl4Hm8SO3zulFaJ90kQ/+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749813768; c=relaxed/simple;
	bh=5rxzVe3Ow+D6PP7e26gxm2BHAwg7Xs8xFPoeYwGwIMk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PEDL3v0K922br8u1VKgb9nNegtXRndTpzXNLEaE+uo6vfRA8aLaCp5h8TKpLfFyWYcT9piMA/MEQ3iLR84zjgZ2ouzORJqj2VH5l1IIwEsLi4Wl3NxiCfbBpPkyJ6xwYDM92eyDABFuxPs/IC0Lg2Yf2xDiVfHhrJ3wta8jBQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE1svWma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7174C4CEE3;
	Fri, 13 Jun 2025 11:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749813767;
	bh=5rxzVe3Ow+D6PP7e26gxm2BHAwg7Xs8xFPoeYwGwIMk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NE1svWmagWMxeZM77Y3Xv2bWeIm5O6825UTWoqiVxpHm/8aD1cOwbkD4BzKC4LTcK
	 KvJ9sjONO7KAf/4C0i/lCYjDMGi8IKiIC/AXVcPlcIpS7zB4ZyuztQMwRHCCqE3IsH
	 DYqPgOY+qQSP5xbU/940AE0XLq+RDGN0ChENch/EJmbeIYu0UsPD3D19/F0anAFeWw
	 apAl8vKK4vfAZg4PjA1UFv9TMEdHphvcLKzZwGomh9x6LchEtOWOHxxhNb45Kpj6QL
	 7Um/DAUObxd00UaeXa5fA7gF16U9EGsHbnBAAGbj050vKZql1RVysAgLQPi01HMWq3
	 BdcFHPDeifJeA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
In-Reply-To: <20250613101908.2182053-2-cassel@kernel.org>
References: <20250613101908.2182053-2-cassel@kernel.org>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Delay link training after hot
 reset in EP mode
Message-Id: <174981376322.39040.626028156798612367.b4-ty@kernel.org>
Date: Fri, 13 Jun 2025 16:52:43 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 13 Jun 2025 12:19:09 +0200, Niklas Cassel wrote:
> RK3588 TRM, section "11.6.1.3.3 Hot Reset and Link-Down Reset" states that:
> """
> If you want to delay link re-establishment (after reset) so that you can
> reprogram some registers through DBI, you must set app_ltssm_enable =0
> immediately after core_rst_n as shown in above. This can be achieved by
> enable the app_dly2_en, and end-up the delay by assert app_dly2_done.
> """
> 
> [...]

Applied, thanks!

[1/1] PCI: dw-rockchip: Delay link training after hot reset in EP mode
      commit: dcca6051a220484f0c1a5cb018f3012735067254

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


