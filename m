Return-Path: <linux-pci+bounces-29659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B95AD87B8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 11:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD3217C7D9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 09:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5DF25A321;
	Fri, 13 Jun 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNo4cM+5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441C24DD1A;
	Fri, 13 Jun 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806741; cv=none; b=KtONEp44NXAh5zIRoolr8SuDk5WFs6iwPfJtHdMMexvY5cg/gcYz1MdnCfoOLT/co1j4iMGfpnVgbtmnrdh+Osy8vrkLBWSRpZpObPrrtQ68myOtK57Rt+jzxEo7DcVcflZEK11MWKRS2SzYu63EZr9jVPWSX8AeSaP3zaHziQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806741; c=relaxed/simple;
	bh=Q79Q0wJ80wAUt812TKUrCQwFzZWf1wf8H78inR8+4Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1ghjK1nwhpSNWxjW8ftkSRV771uPu9d9Fa870g33IqPLzqzj013jujoI7aiHNMZKeXhl7dHOPGK27H12VsKb9RToelntPx1+O/A/SOxUtkGJTGnL5Defn59UG5eVeT3phoVfz/GFxAOIQYt7lqURmvMAHD8vY+z5Z0RV9y+yEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNo4cM+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AF0C4CEE3;
	Fri, 13 Jun 2025 09:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749806741;
	bh=Q79Q0wJ80wAUt812TKUrCQwFzZWf1wf8H78inR8+4Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNo4cM+5mzh5Qo9WBpVpnLDCpZnGTw020BZN/LZhvbCtkJMkhqZod3dbS0sx5dXMR
	 N5s1DCeCJZYeTqZESUszBvrWPcPUQ+w4jEQxetpKnzHr8JbNuOtbqmdgEcx++xMwe3
	 2y2Evq6gmIUF1yVjfTApds5GtoAWwb9DYZpKTfe7R8fn8/3NaBos9s59d3Vhmn1jjU
	 IWTq4nufDSmBJ8Q3nJSUN8X0BahLQuYDBfTKDtutvfmO/XmsTVjKdaYWcNs4CmYSF5
	 ZtjBCoVNrPmdyuU8bT9qyAhpNSG7ecC32hEOvjyuCsPkjgB1FJzjDPYUv8PSMFkRKK
	 1+ufqLRg5rKVQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: altera: remove unused 'node' variable
Date: Fri, 13 Jun 2025 14:55:28 +0530
Message-ID: <174980672103.33830.4953083744774912018.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521163329.2137973-1-arnd@kernel.org>
References: <20250521163329.2137973-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 21 May 2025 18:29:48 +0200, Arnd Bergmann wrote:
> This variable is only used when CONFIG_OF is enabled:
> 
> drivers/pci/controller/pcie-altera.c: In function 'altera_pcie_init_irq_domain':
> drivers/pci/controller/pcie-altera.c:855:29: error: unused variable 'node' [-Werror=unused-variable]
>   855 |         struct device_node *node = dev->of_node;
> 
> Use dev_fwnode() in place of of_node_to_fwnode() to avoid this.
> 
> [...]

Applied, thanks!

[1/1] pci: altera: remove unused 'node' variable
      commit: 693594d0e5d8d236fc4172c864afdcbe6993a2bd

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

