Return-Path: <linux-pci+bounces-33576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B80B1DCEA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 20:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C368584DDA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438B62248A0;
	Thu,  7 Aug 2025 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6L1f8U+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1933C20299E;
	Thu,  7 Aug 2025 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754590284; cv=none; b=jnT3bR+iK1SIKimQDtR1Fa1VmprwIQBVNWv4WlbGA2NBSaMqkSnmo85oH/7QR51WcZAUTif3fOuWaKEUouwx2ozZBAMnogKgmQ5E0/Mv7T/+6BxWYOWV/39lVoqHoj0+LwAZ/gpPdZGlxQOXOfpIBeL6gH/mD1ZRtM/iHumix+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754590284; c=relaxed/simple;
	bh=xYKMRGF+npUG0YmQN3j4LieNx47aVz79YZ3+BU+U2XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KHHs3w7wyM2UfMYgbb8b6rY0+p9ulY1xTyuKln9xbIXGaxTpBGqFLe8n04HKJSTLIBuKkfWW6q4wxqYHbJnDO3IA/XlU8PVxeWfKuk3QjAIfqU99ryNpWYFlH0jPtOnIeZHgpoBnhKSRmBjDk91CX0fSvUp1OZRq6/WANznpibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6L1f8U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76902C4CEEB;
	Thu,  7 Aug 2025 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754590283;
	bh=xYKMRGF+npUG0YmQN3j4LieNx47aVz79YZ3+BU+U2XQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=J6L1f8U+iPfrHHaPtLzL5WzcH7WJCH2Hl3wLSKlgy4gEyZUkQCCuxhz9MM43kakV7
	 rG2aKkFUnkBptkdYe8Ba2GxKgJavLwCiY9pDrIW62nprT8kWYEwGpmdQPhfsx0blbR
	 XY1fktlq8EPPh40Jqtqz+kOUnreGGuH6ONEasTcRcmutxsfgF0xP1cDikL2VjegbLz
	 l1UKkc+lbhzr7XDoHrtXxb0rqtVW7+o+mJCoe7LRFe/9DLZ6zNC6ZY8f060qRI5X29
	 6D5Z25cFPIZg6Ba22e8zEDpOleBopDouRRuoQ9vNLurTkIRcp2pOUk2FABfdbKBuUv
	 B4E5BJIxaeGPg==
Date: Thu, 7 Aug 2025 13:11:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kenneth Crudup <kenny@panix.com>,
	Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH v2] PCI: vmd: Fix wrong kfree() in vmd_msi_free()
Message-ID: <20250807181120.GA57051@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjorxc22.fsf@yellow.woof>

On Thu, Aug 07, 2025 at 07:43:17PM +0200, Nam Cao wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> > On Thu, Aug 07, 2025 at 10:10:51AM +0200, Nam Cao wrote:
> >> vmd_msi_alloc() allocates struct vmd_irq and stashes it into
> >> irq_data->chip_data associated with the VMD's interrupt domain.
> >> vmd_msi_free() extracts the pointer by calling irq_get_chip_data() and
> >> frees it.
> >> 
> >> irq_get_chip_data() returns the chip_data associated with the top interrupt
> >> domain. This worked in the past, because VMD's interrupt domain was the top
> >> domain.
> >> 
> >> But since commit d7d8ab87e3e7 ("PCI: vmd: Switch to
> >> msi_create_parent_irq_domain()") changed the interrupt domain hierarchy,
> >> VMD's interrupt domain is not the top domain anymore. irq_get_chip_data()
> >> now returns the chip_data at the MSI devices' interrupt domains. It is
> >> therefore broken for vmd_msi_free() to kfree() this chip_data.
> >> 
> >> Fix this issue, correctly extract the chip_data associated with the VMD's
> >> interrupt domain.
> ...
> >
> > Applied to pci/for-linus for v6.17, thanks!
> >
> > I assume you checked the other msi_create_parent_irq_domain() changes
> > for similar problems?
> 
> Not before you reminded me :(
> 
> But yes, none of the similar PCI patches has the same problem.

Great, thanks for checking!  I'll try to get this in before v6.17-rc1
since many people will start using that.

Bjorn

