Return-Path: <linux-pci+bounces-34883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F992B37BDD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 09:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286F9368181
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 07:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C818319843;
	Wed, 27 Aug 2025 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNgH2UHX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9C931815E;
	Wed, 27 Aug 2025 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280126; cv=none; b=rJ3ZRgRpswPCT0HJouxrpWYmyoyCpGY7TwoWfvwyX/SfIN5i3YLFLyHya37T/k8KniVk/fR5Msfn90jRXXN4j+9YHzhvUx/rJW5graqtL6vZB3LumuzzgJlvwaJ/oG/NOcdLxkX0/r9Ihp7B/4BSGq2VvBiFCruH5B9eUOQfoAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280126; c=relaxed/simple;
	bh=AspSVR0eMQ6PQqSK0Xx59pbMGvoJbIyd4x3sjipnc9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TS2p2Y7fdF782zv+TRDsD7uoYeA7kOpUW04mibny3Gym52jutFowrkR96KC2SYBhbvOb1mFpmhVPW4OQ4WV5eVX3XlISU3BVmwjcXAvP+8GqC3kalRHPY0skusJ8IZqpJNChxp8XjEof9tJrKp2LFyARiNwusv+XfXG1UZY+qFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNgH2UHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B796BC113D0;
	Wed, 27 Aug 2025 07:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756280125;
	bh=AspSVR0eMQ6PQqSK0Xx59pbMGvoJbIyd4x3sjipnc9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lNgH2UHXztSjsT5DcAw1b14gkUsYs0n14fpqN/b2rOQB0OKbDF0ylQgVBSL4fGrih
	 Q/LqKrFdbfUPcNIdiVxrYeHIGVGwb9Gyj9WlGyLA341vzrSr84IlyHQgnB9y65Ldzr
	 LuhETjtFk2i49sASLuESVf3nymIOaje/mZ/lioLoNv/OlfV4vh6/d68bC1a+r3/Rgc
	 XojyFnNQJABTNJJoGMCyUnM/oB/hYR9NeQ5abHKk20uNvZmPU3UOfstSNEGG+5pJLU
	 8dPVk/+d0jai9uH2eVkvOriqkS1mnwBc7sHU6+ALXMyflxLLxOVe3E+v479rEe0oh8
	 Of5SdAyq23i7Q==
From: Manivannan Sadhasivam <mani@kernel.org>
To: marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, 
 lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, geert+renesas@glider.be, magnus.damm@gmail.com, 
 namcao@linutronix.de, tglx@linutronix.de, 
 Claudiu <claudiu.beznea@tuxon.dev>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250809144447.3939284-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250809144447.3939284-1-claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH] PCI: rcar-host: Use proper IRQ domain
Message-Id: <175628012135.5887.9279606030719322172.b4-ty@kernel.org>
Date: Wed, 27 Aug 2025 13:05:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 09 Aug 2025 17:44:47 +0300, Claudiu wrote:
> Starting with commit dd26c1a23fd5 ("PCI: rcar-host: Switch to
> msi_create_parent_irq_domain()"), the MSI parent IRQ domain is NULL because
> the object of type struct irq_domain_info passed to:
> 
> msi_create_parent_irq_domain() ->
>   irq_domain_instantiate()() ->
>     __irq_domain_instantiate()
> 
> [...]

Applied, thanks!

[1/1] PCI: rcar-host: Use proper IRQ domain
      commit: d3fee10e40a938331e2aae34348691136db31304

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


