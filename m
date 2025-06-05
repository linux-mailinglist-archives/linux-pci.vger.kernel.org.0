Return-Path: <linux-pci+bounces-29060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 639BAACF9BC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 00:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182533B0386
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 22:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0DA27E7DA;
	Thu,  5 Jun 2025 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI97G40w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34F17548;
	Thu,  5 Jun 2025 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749162966; cv=none; b=OzVSdfySU0m8NeiI38iiw96D4lvUUmdzv7hb3HBBp74ucA0gcJxncP7/Ed/TZTDpR357V4+1zR1lxLXgh13gk/aH2aBDtVgfnaazcmatKuRdY+ntexcDQT4yodBSTns2KzR/9gllV/E8S50mAza7CNhn2MpGWfD/Vv3cfa/5r6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749162966; c=relaxed/simple;
	bh=1Jbyu6lBg3cYdJFmXVp6tcUglO4vtoW6ecMJkoWr3Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMXJ2/F3zWI2s8yVz5MiUm5KlcDnJFzuQO7dyc82oPjXpV4kOeUjxe8LmzO3m5kJ1tpTl9LIFRxmi8v+yLe4ErNtmwkN5tx7eM0gxMZ+Q8u82b8thuPABN3ZYyBw9xqRMJsFTKSbBX7KcpHrevv3jzpTRZQvn5w+kv0XaWatlME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI97G40w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8C2C4CEE7;
	Thu,  5 Jun 2025 22:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749162965;
	bh=1Jbyu6lBg3cYdJFmXVp6tcUglO4vtoW6ecMJkoWr3Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GI97G40wn+NwPG+muuWyuZ+k5CAX2GTR5U1pKevTXMAB1l/zytenR8dLG303w8nm8
	 /lQ5wbzVqL8RVMqg28CYTp3o6XX6Oh8du6nxJ6Y3C6AC/9w1bSARIWm4asoir85iQq
	 Tr/aljwW+wh3Iwsdg05AC3MUAMj6WSqJnYGCpCWl0cZMRBZTuWYiH6kI7DEdfV+Qyu
	 wZ/8yINzrom+p78SpH0KT+ef3QcaHXqfePHwTN7evo0O2GaGeoaFnDBxFlRby+lKhF
	 y6J7yjh3uRkCaRQe05VgfsY2Un70OWq6w5iDQO3TL89evBzvjrQ/ujajwrqR/A26uN
	 1l7Bpl/+/oagw==
Date: Thu, 5 Jun 2025 17:36:03 -0500
From: Rob Herring <robh@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: brcm,stb-pcie: Add num-lanes
 property
Message-ID: <20250605223603.GA3375348-robh@kernel.org>
References: <20250530224035.41886-1-james.quinlan@broadcom.com>
 <20250530224035.41886-2-james.quinlan@broadcom.com>
 <6c3ec1c3-8f62-4d76-86d3-c1bbe3e1418f@broadcom.com>
 <2f79ae4e-6349-472c-b0cc-ea774b8ac7cf@broadcom.com>
 <CA+-6iNz48EFUGUOiHCSaqgsU_tKGV1=Xvw4fjoUS_AMhUHAi6w@mail.gmail.com>
 <3037cd65-89e8-4029-9ee2-4695db5987ad@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3037cd65-89e8-4029-9ee2-4695db5987ad@broadcom.com>

On Tue, Jun 03, 2025 at 10:17:26AM -0700, Florian Fainelli wrote:
> On 6/3/25 10:16, Jim Quinlan wrote:
> > On Tue, Jun 3, 2025 at 12:24 PM Florian Fainelli
> > <florian.fainelli@broadcom.com> wrote:
> > > 
> > > On 5/30/25 16:32, Florian Fainelli wrote:
> > > > On 5/30/25 15:40, Jim Quinlan wrote:
> > > > > Add optional num-lanes property Broadcom STB PCIe host controllers.
> > > > > 
> > > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > 
> > > > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > 
> > > Sorry I take that back, I think this should be:
> > > 
> > > num-lanes:
> > >     enum: [ 1, 2, 4 ]
> > > 
> > > We are basically documenting the allowed values, not specifying that we
> > > can repeat the num-lames property between 1 and 4 times.

Are you confused with maxItems?

> > 
> > num-lanes is already defined as
> > 
> >      enum: [ 1, 2, 4, 8, 16, 32 ]
> 
> Right, but then we need to re-define it with our own specific constraints,
> still, don't we?

It is correct as-is.

Rob

