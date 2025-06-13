Return-Path: <linux-pci+bounces-29755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BEFAD9265
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 18:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DE35A0FE2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC821FFC5F;
	Fri, 13 Jun 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0zzX3fP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7C18DB29;
	Fri, 13 Jun 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830384; cv=none; b=Cb4LsVGSWdB8eLViphRop0xfbJXH+wc9xwSHD7Uyn6D1WM0SJL4wBrdR6S7LuLP1EnvO4R1VrHZ2VtBS2712xe5ersF9Bo+q5acDjITFSijDMG4h/OD4Ro6vjwTl05bd0UtQ/6zsS1TZ02hyclni2m5u+0EpKc4wbYnkHitGBy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830384; c=relaxed/simple;
	bh=SQ7GUXRJXqTDf9P/Qm4haDbuby4wi4QGvJKfFQG9Ik8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uT6YdBZ3dVU0q0h0Ds2xhuHGemjwuFuC2D9FKovxbzWDHcMCuyGh7VzSgZepSiExn30gDv4AI9JdprXR2F50pioGPh7H8r3Ph07axWC/hi0LdaiuPiETvHW21D7q0ql7evSsFJl00jO4DCDXBQ/3GcymLDqDyzKLBcTzU7EWxwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0zzX3fP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8987AC4CEE3;
	Fri, 13 Jun 2025 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749830383;
	bh=SQ7GUXRJXqTDf9P/Qm4haDbuby4wi4QGvJKfFQG9Ik8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=n0zzX3fPoRLTKtU+Wvdnf5IHXCu+A8x1xZNu5w/6wgOQjGKbQFeV/0lZl7mE6OVIl
	 LL5aVqs62RYkY/233ZAY7Wker72IKkGxfsiesN+3BPeO4JGA4e1fzISkzQqpi4cp6V
	 m400saPoJCII944lgT4+iD0UphSshRlzWNtAaIkt7walOyIdybnhSOKR94PEl6pJeJ
	 TT87n7a6/GvYSEqItedZbj00JjeSYf/eYjB6Fd+43MQyY/xIR3zdgK1MxjBTdr5JPc
	 cPeXPYeWLBpoYGUAeXaYGSh1ZwK4TOVV2g7jHOzZhqLb3fbymJctUrPkqdw8pigTxU
	 HHOSLHP8++VnQ==
Date: Fri, 13 Jun 2025 10:59:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	vkoul@kernel.org, kishon@kernel.org, linus.walleij@linaro.org,
	p.zabel@pengutronix.de, linux-aspeed@lists.ozlabs.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, elbadrym@google.com, romlem@google.com,
	anhphan@google.com, wak@google.com, yuxiaozhang@google.com,
	BMC-SW@aspeedtech.com
Subject: Re: [PATCH 4/7] ARM: dts: aspeed-g6: Add AST2600 PCIe RC PERST ctrl
 pin
Message-ID: <20250613155942.GA962477@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613033001.3153637-5-jacky_chou@aspeedtech.com>

On Fri, Jun 13, 2025 at 11:29:58AM +0800, Jacky Chou wrote:
> Add pinctrl support for PCIe RC PERST pin.

s/PERST/PERST#/ (subject and commit log) to match spec usage.

