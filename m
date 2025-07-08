Return-Path: <linux-pci+bounces-31698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45465AFD4D0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96621893B31
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1CA2E49AF;
	Tue,  8 Jul 2025 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ63kEo0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B942E0405;
	Tue,  8 Jul 2025 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994417; cv=none; b=F91kucsr7hJB+aNZ8nL7Z9n17XF0eQwrXoprO7XSVsYlq6WhevT8+Nomy2j5sMV+8pHfOhSHdGYdATSgQG7TxEiFYwvtcJcr12/xjvAaB8WdmEhvX5SKvdDowRYfgdW4jeqCWpEPIkqfZt/g4pyCLjIJgN7rIXxMU4bnN28yoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994417; c=relaxed/simple;
	bh=aN2zG4WBE2tdLsmAtJ1Di+Fs/pqbZFINDwPFccXvSjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMfTmd1XAUm0HmVeTY0ZKqiKmUspIas2a+HLcyAEXW9xJoMbkTGnfaKMs7EyxE2cIGICm2iMjErRmlwKa1hsIvhS/oIB61CkZsOK0QdJ1Ejazq9nu7iPvRI8aXq0Ry273wODpEQuy6aSc4tgHOstzNdu5fEMBZKZWZpt06EZwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ63kEo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6E6C4CEED;
	Tue,  8 Jul 2025 17:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751994416;
	bh=aN2zG4WBE2tdLsmAtJ1Di+Fs/pqbZFINDwPFccXvSjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZ63kEo0NHPfeLjS52LdMC+jgOkd0Df5w5RMkKTgq7i5MWxNREoySR9j1ru+KoQG5
	 EUKZHH4HzzZcsNZtr8Y9qJKnOeqP1tBjg4IqCe+AFiVKvfGHYvHJTbYwhCqjVe2cz6
	 QcXdqkehTu51WSl3j0ic5v+kB9grgRuDgLGOh6K8Zgm9ywYBEpMKASrUggYQAFM4b0
	 2WOjtnesy1WSszA6aRPdjPHCTN0fOVxUO+au8spZ21w+U5arsyoN+ZR0w/SixORqML
	 d+7OKDjQBd0DrXRIC9ZynsimrOvhR4pZiIQrppZ3tW3nWugy86haZSFb+NEi/mIA9v
	 8JGKL4UFMjoEw==
Date: Tue, 8 Jul 2025 12:06:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Cyril Brulebois <kibi@debian.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	jim2101024@gmail.com, Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: brcm,stb-pcie: Add 74110 SoC
Message-ID: <175199441442.637518.17583955334373827745.robh@kernel.org>
References: <20250703215314.3971473-1-james.quinlan@broadcom.com>
 <20250703215314.3971473-2-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703215314.3971473-2-james.quinlan@broadcom.com>


On Thu, 03 Jul 2025 17:53:11 -0400, Jim Quinlan wrote:
> Adds BCM74110, a Broadcom SetTop box ARM64 based SoC.  Its
> inbound window may be set to any size, unlike previous STB
> SoCs whose inbound window size must be a power of two.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


