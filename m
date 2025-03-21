Return-Path: <linux-pci+bounces-24372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 819ABA6BFF5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF12A7A3D70
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A9E1C5D4B;
	Fri, 21 Mar 2025 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWoVjPcU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D09146A68;
	Fri, 21 Mar 2025 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574762; cv=none; b=U4J3AJLQEOE7WVu13UOPcncBvx9hs0o8SKEdc/ctZZDWdbYOz6snkt+0WguADdMVN656NMzM8byq/dpFVvIxm18Q8jMgLB9+Dmh6/mhZdqhaXD84jzhcE6JNLvGjfwU6F65VrMnDmSicHiJoON7Q42UxD5kaSW7uYPYkcM7lxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574762; c=relaxed/simple;
	bh=BqNAlk7rXAlcVOFBgEHRS+hiVmaJg6AYHU2f42U4Q6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=m/t8ABOe72Gp0xvv9qiezi0rx/2AbpxFPW2Jjk30O4OIT8HRObL/rii85a+W9nZeioeJYitY2V068YOaMMnrfVk6fSSrxHgDZ+rrV9RRU2IfbdoUuixjr7OAnoxHp97wm9rT6tYvy1lneKYcZ3evbMGnKwLVI4ndKUbfV0w12B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWoVjPcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8A2C4CEE3;
	Fri, 21 Mar 2025 16:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742574762;
	bh=BqNAlk7rXAlcVOFBgEHRS+hiVmaJg6AYHU2f42U4Q6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GWoVjPcUuHiSvan9BqoVytjybeH1rUYg6Q+hO/Vd8LJ81fsr9P2d4YUocxgn0yxOZ
	 vczmYLN/eMzwLzMenjR6rL9ISgVan1byWsapnm7/+8jovi5/0TVoqOBzphXfdRZP/9
	 w+hwUmW8i4EEd0yY3RiyZkFu9lz2xJVZwyv2ES9vVQuf6Lm2/kBK81xGm5Pwrkm1uY
	 4f+tNNn3LiTNdgSJWwIb+XaXhGXbSVt3Vldxsng0Q2xexz7cGxbu1Ykk7VDMy6U4Pz
	 66ndKB4t+2pqvev2lAQwD9ltJHIZmKS5WyIyZdgCMEdKE+ve/LRVNWSdJhzdeDZcFT
	 kQeu5OA4CGdZg==
Date: Fri, 21 Mar 2025 11:32:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Toan Le <toan@os.amperecomputing.com>,
	Joyce Ooi <joyce.ooi@intel.com>, Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Michal Simek <michal.simek@amd.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 07/57] irqdomain: pci: Switch to of_fwnode_handle()
Message-ID: <20250321163240.GA1130095@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319092951.37667-8-jirislaby@kernel.org>

On Wed, Mar 19, 2025 at 10:29:00AM +0100, Jiri Slaby (SUSE) wrote:
> of_node_to_fwnode() is irqdomain's reimplementation of the "officially"
> defined of_fwnode_handle(). The former is in the process of being
> removed, so use the latter instead.

I'm fine with these and happy to apply via the PCI tree, but it sounds
like you're planning a v3 with a few updates, so I'll hold off for
now:

https://lore.kernel.org/r/4bc0e1ca-a523-424a-8759-59e353317fba@kernel.org

