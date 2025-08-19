Return-Path: <linux-pci+bounces-34309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5957B2C788
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 16:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBEB3A8C89
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306092773EA;
	Tue, 19 Aug 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhmxpjrC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0381125DCEC;
	Tue, 19 Aug 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615072; cv=none; b=KPO7OMgxXywTysK5CJDL+xhYT6ns3TiBZ3XUlz217ZkjsSxB0UhIE5R/CWSbNFaW6JnucAIF5aYHCHzbIrWx6x88S2QVkE67+KRuveWtOBUL74EqgZwFAInh+bRynj/THvYZ8aS1oa4VSvQjVlAKhOhgolU/EQ+F8tplcITy9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615072; c=relaxed/simple;
	bh=Semh9vh6H26pGxI4SeIgYYwW2rQqCSzaKGfXow3uekg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av+XnuTPWZR9UsnevD9lFFKTeaDeu6kxVsi4uR1MN0ADtx63iJHfM03oIhbU9y8eMHu8JCKoUmc8bYW8hKYdczzZVcY8gTekFM/LdL8Vek0jkd78uBQ0E8AcPlHOOW+fhLyf+J7dRYP3FPD5GRs/aOV9NfvG10ziqz2ri7qPG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhmxpjrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65888C113D0;
	Tue, 19 Aug 2025 14:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755615071;
	bh=Semh9vh6H26pGxI4SeIgYYwW2rQqCSzaKGfXow3uekg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AhmxpjrCi5Uiw+pSebpXvR0j7wId/VxhsnbpudwSHuSzKTtEpDF2S0C+UkFs9IzV+
	 lV16LMp8+jVpqfIORdL2Y+kwaBgqQCMK4silBvtsg6cew6vABb8k6/3j493js7v9MT
	 09Ay7rJ77H9C2ZGPxTntJIT7WlwX7Tvj/E63cCk73Rq5vlYiItgmzi9FeUgdnp/7Lr
	 RvM+kPPY7tmZrSZZpUg8dawKe+Ng82wq5ZS9W5aNfO4oKexiNBKCjErbQplrEpgnB2
	 hi6a5fMA9xspM0fOEJH7Klmdd2g5Km+2iyZ1Sea2vV1rodJ3DPrrOGfaXorbDpfcq/
	 XBsTCrfyqL7ew==
Date: Tue, 19 Aug 2025 20:21:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/3] PCI: brcmstb: Add 74110a0 SoC configuration
Message-ID: <wxrnpfu7ofpvrwxxiyj4am73xcruooc4kaii2zgziqs4qbwhgj@7t3txfwl24tu>
References: <20250703215314.3971473-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703215314.3971473-1-james.quinlan@broadcom.com>

On Thu, Jul 03, 2025 at 05:53:10PM GMT, Jim Quinlan wrote:
> This series enables a new SoC to run with the existing Brcm STB PCIe
> driver.  Previous chips all required that an inbound window have a size
> that is a power of two; this chip, and next generations chips like it, can
> have windows of any reasonable size.
> 
> Note: This series must follow the commits of two previous and pending
>       series [1,2].
> 
> [1] https://lore.kernel.org/linux-pci/20250613220843.698227-1-james.quinlan@broadcom.com/
> [2] https://lore.kernel.org/linux-pci/20250609221710.10315-1-james.quinlan@broadcom.com/

Have you considered my comment on this series?
https://lore.kernel.org/linux-pci/a2ebnh3hmcbd5zr545cwu7bcbv6xbhvv7qnsjzovqbkar5apak@kviufeyk5ssr/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

