Return-Path: <linux-pci+bounces-35929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F522B53ABA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 19:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B278B1C84696
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3432E31E0EC;
	Thu, 11 Sep 2025 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTLyzh+a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1007541A8F
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613113; cv=none; b=roELSqJGcC7vrNU8apbxsh3VP7jDkZ0d1sgE2LBxXqMg9HRnHOd6BQgJ/fdg/3TFpRB8HM7Mb4YXIIAaaDHi+Gv2+EkUfwbJPUNObnC49BPFvg0J9igZMtAT1yIpI3uorATUPQe5KYHc5dyF9wFJzE33Vhq9FiU4xviJBijZJmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613113; c=relaxed/simple;
	bh=7WTALW7EhOWGhJPs59fIOBySNhqUqr19+3fqDaDwPZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AMnMy7NejRzcoWM0LbPjpLft9ROEFqnBXgN5dE5GWrsC+0/AKUUSxJiv3+vXAVAvUX24Ejv7nSGTYecNi59huWOYCDlqjacxeYgYws5urxvOSz44OJyCNOtFhyBwJVVIlOecz29YmyUI6kfZmQlmAp0CMwAG3/B24p7VFetB8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTLyzh+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239FBC4CEF0;
	Thu, 11 Sep 2025 17:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757613111;
	bh=7WTALW7EhOWGhJPs59fIOBySNhqUqr19+3fqDaDwPZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pTLyzh+a18lmv6TPScqDXPAF1uQKzHGp5IttyONW3nPdENvbp884frd8pLQDzGKBG
	 T0ocy6tr6IYEyUkQY3j4XXzlT0h6mL2+Bpw/ydTFzyQ/idZgQCWbCWwu43dUSU4ZP9
	 azMY6PmnePEFqLZxwUsoCj57sF6oshsyMSrGTkneTmISCIG6xP1GmROgBNfGRddTFz
	 aT9SNiCBvyXhE2IysbnC1iDtnnJEQ+/QpG2jRdTSpvH354+kk5zfaBhWqJ1b20qZWe
	 YN0ak5JvLMefWC7CR7+L7t6IqwvJbiv5FY/mzJELTqKI+hmfG7eJgUFbxR37NmPgb/
	 718Har2wbGFCg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 linux-pci@vger.kernel.org
In-Reply-To: <20250908165914.547002-3-cassel@kernel.org>
References: <20250908165914.547002-3-cassel@kernel.org>
Subject: Re: [PATCH 1/2] PCI: dwc: Cleanup dw_pcie_edma_irq_verify()
Message-Id: <175761310875.2542822.4150252355334050578.b4-ty@kernel.org>
Date: Thu, 11 Sep 2025 23:21:48 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 08 Sep 2025 18:59:15 +0200, Niklas Cassel wrote:
> dw_pcie_edma_irq_vector() requires either "dma" (if there is a single IRQ
> for all DMA channels) or "dmaX" (if there is one IRQ per DMA channel) to
> be specified in device tree.
> 
> Thus, it does not make any sense for dw_pcie_edma_irq_verify() to have a
> looser requirement than dw_pcie_edma_irq_vector(). (Since both functions
> will get called during the probe of the eDMA driver. First
> dw_pcie_edma_irq_verify(), then dw_pcie_edma_irq_vector().)
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: Cleanup dw_pcie_edma_irq_verify()
      commit: 35ddcfd49f1520a95db3aafdb5bd115e2fd075a4
[2/2] PCI: qcom-ep: Remove redundant edma.nr_irqs initialization
      commit: 9e495c2d7f38a6e256749a8466856dc711666f05

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


