Return-Path: <linux-pci+bounces-27635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9094BAB54C5
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 14:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E9C7A06D9
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDC818027;
	Tue, 13 May 2025 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVlriGcx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B97483;
	Tue, 13 May 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139484; cv=none; b=a5wOIbBVVaRsHFEghIqrmRa6UgzuNDu6/RxFWbrKX+NiL7XL5DOdC/YdeFlSXEHcdQZKXW0DiMSh3OSx+JgWigsOp1Q2M9rNl8Th/zt5I+gj0amNxl91J/PNjYwDbjRyuCHu0WVMzpJXOFw2MZY806YuSwLvKhH+YHtUN8PjU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139484; c=relaxed/simple;
	bh=DeY+hySG4/vlZF1lPxJl4qMkf2CDQ8EAbK3bVeOGHAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTDGK18KAuOpcoVDoM5sT+Rwj/fv1Sl8LvKczYtHfD+zfxyMcG+wXY1Nc9SvGRhX5a/+cehSxg4DbaCm4IQ47CH836YDlfeDRz/uqrll4qhYcZpX6yv8kXINrPKLhtDF4DzIV//gH/qLTAa/wnn/tbS/6u0T5uIyucnE669V188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVlriGcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320A0C4CEE4;
	Tue, 13 May 2025 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747139483;
	bh=DeY+hySG4/vlZF1lPxJl4qMkf2CDQ8EAbK3bVeOGHAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVlriGcxrn6kEgjdgOKyrKHwccz1+cZOFXkU2nKKKywUk1pIXfEI+8YAh7XYN8+6n
	 cHFlQ84+FvT8uZ9L/b5bMWKYaGszXZOqB06nHo6I3iOmjTHEq0KK1ZN5IIxNjMQaJK
	 P13Zgszs/BO2TBJoaEI6mgL9rhVSSWD6uIybhNty0g4OrSlUxHULUuF+zUPI5bKLUK
	 AYQzG1ojTNtKzWNEj2p//dlGBQZ6C/q1aPJNmu15pE2mCVKfV9XWctceIymB5nqkZE
	 xHLRjDxxlym0TadfaNEQgQRSMz5Ev3ipIT1huPuK/MQfaRHpQIzOLX4u6GnPzdXE61
	 MorJGUO+o8mkA==
Date: Tue, 13 May 2025 14:31:17 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Alan Douglas <adouglas@cadence.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/6] PCI: endpoint: IRQ callback fixes and cleanups
Message-ID: <aCM7lWQiwJBwamEp@ryzen>
References: <20250513073055.169486-8-cassel@kernel.org>
 <20250513102522.GB2003346@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250513102522.GB2003346@rocinante>

On Tue, May 13, 2025 at 07:25:22PM +0900, Krzysztof Wilczyński wrote:
> Hello,

Hello

> 
> >   PCI: dwc: ep: Fix broken set_msix() callback
> >   PCI: cadence-ep: Fix broken set_msix() callback
> >   PCI: endpoint: cleanup get_msi() callback
> >   PCI: endpoint: cleanup set_msi() callback
> >   PCI: endpoint: cleanup get_msix() callback
> >   PCI: endpoint: cleanup set_msix() callback
> 
> Note that PCI prefers to capitalise first letter of the subject.

Do I need to resend or can some of the maintainers fix this up while applying?

