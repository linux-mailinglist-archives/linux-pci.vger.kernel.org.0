Return-Path: <linux-pci+bounces-34404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2A7B2E4B4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 20:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB1A3B83AF
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C632F26F2BC;
	Wed, 20 Aug 2025 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8gjU6a9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993CF36CE0C;
	Wed, 20 Aug 2025 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713447; cv=none; b=VxL6PQDYlusfJ0BHBzU6e5vAIX4WTUvy8S3UE1NYowVopj5O815wTWG7bKWgQRRlRlGb5JZXJo6+bcoScIbSjeQJZ7ilQ6W3OE8Mm5JAzjTOeXkV86DGOjo6UDn1jrwVckxBeJTSbmeJLEkKM0bqZ4cZ/AAk3YnfEQTdceJoOaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713447; c=relaxed/simple;
	bh=dhLdG+B/qqIKsNIOpmDMrekjcCjsTEeLUNAtyAFWLp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxXbb/oWy8BTBzfvdm9fw7cwGKM/kIayxEdA/1bGYG1ovR0w4Cc0/3ftZUOI5Tk2ykfSKcMsSw+SK6W+swYG1Nb7iRSCTsKGBbm6iPYkSjXYehUa+mk9rw4mjciuhPHMHP5NTl8tfR2X1Va/FYa1YERLqjIJC4wjbfKEkg+sh5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8gjU6a9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA50C4CEE7;
	Wed, 20 Aug 2025 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755713447;
	bh=dhLdG+B/qqIKsNIOpmDMrekjcCjsTEeLUNAtyAFWLp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8gjU6a9is/YEO6ukBdCLUYoyhrtKoNGY4ZkAhgvlHdgCNrK08OADxsr3Y029eVut
	 20aOGUHZ4/TAZsHRAETzFqxFGnFg5MAXBgBG8eOf1yPHXXWlEXn6+uk9+h+P4UAf7c
	 kQv8kfC95wMtBVolXzn3t/+2V0tf9W/rwvYzYBZMxxur7YBFhJ3GkeyDqzx0zzt/9s
	 J3IHjDroCTuVQiKypsAVwl/nVjk+DxQwgkkdXolO0GnR9gEDc7A2h7d+5sxmuxnWHZ
	 Ra4kJfvkgOQvXtr5eYUMsXtpJ35dxcc2bwn81R9ASc1Um003fyX19EZiZZ1dnhAb0u
	 VJObWf+atZN9Q==
Date: Wed, 20 Aug 2025 23:40:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/3] PCI: brcmstb: Add 74110a0 SoC configuration
Message-ID: <l6szj4z4u4vhhacnwqvb2j6s562kgns5m2fspoxjggda4v22wv@65n2y56ake2r>
References: <20250703215314.3971473-1-james.quinlan@broadcom.com>
 <wxrnpfu7ofpvrwxxiyj4am73xcruooc4kaii2zgziqs4qbwhgj@7t3txfwl24tu>
 <CA+-6iNw6t36LogOroyQ8wNLOrSYPOJB0nxijbzcs2UWjwFkMXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNw6t36LogOroyQ8wNLOrSYPOJB0nxijbzcs2UWjwFkMXQ@mail.gmail.com>

On Wed, Aug 20, 2025 at 01:08:41PM GMT, Jim Quinlan wrote:
> On Tue, Aug 19, 2025 at 10:51 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Thu, Jul 03, 2025 at 05:53:10PM GMT, Jim Quinlan wrote:
> > > This series enables a new SoC to run with the existing Brcm STB PCIe
> > > driver.  Previous chips all required that an inbound window have a size
> > > that is a power of two; this chip, and next generations chips like it, can
> > > have windows of any reasonable size.
> > >
> > > Note: This series must follow the commits of two previous and pending
> > >       series [1,2].
> > >
> > > [1] https://lore.kernel.org/linux-pci/20250613220843.698227-1-james.quinlan@broadcom.com/
> > > [2] https://lore.kernel.org/linux-pci/20250609221710.10315-1-james.quinlan@broadcom.com/
> >
> > Have you considered my comment on this series?
> > https://lore.kernel.org/linux-pci/a2ebnh3hmcbd5zr545cwu7bcbv6xbhvv7qnsjzovqbkar5apak@kviufeyk5ssr/
> 
> Hi Mani,
> I'm sorry, I thought I replied to this but obviously I did not.
> 

No issues!

> Your points are valid.  Our PCIe HW block keeps on mutating, and each
> time it does we add new code that is triggered off of the soc_base
> config setting.  The end result is not easy on the eyes.
> 
> I  also have submitted the series "PCI: brcmstb: Include cable-modem
> SoCs".  I don't think it has review comments yet, but I am guessing
> that you will make the same points.
> 

Yes. I intentionally didn't give any comments or merge it since I have the same
refactoring comments.

> So it looks like what you are asking for is a refactoring of the
> driver and, AFAICT, I need to first submit separate series that does
> this before submitting the this and the cable modem submission.  Do
> you agree with that?
> 

Yes, I agree. Refactoring will make life easier for both you and me :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

