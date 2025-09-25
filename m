Return-Path: <linux-pci+bounces-37005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF12BA0A7E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 18:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9492C56369C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7661BD9D0;
	Thu, 25 Sep 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psUXOQTt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF523BCE7;
	Thu, 25 Sep 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818374; cv=none; b=qeTYSlmELAy0RwsSPdqG6n1OVL0NFThMAaSgJwPH1otW0h2Gphxw9O1zt6hCnDBYdShPlB+uORvvINYLEqp7Ffwtwbjw+gsIlR9HF4U3oHSw1F5hamVb+K0B1W6Ynpt00R25spmoBjc5rUbeeW4DOyDRk/vD94bNbK+cjx0HnOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818374; c=relaxed/simple;
	bh=Ilf+Vb676vEdQyNSBMyQj0ESSBZnu1xY7B5KeRVx3Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYBG83nR88O0gWN0wK8Is29Hy71ys/bXuHFow+uzTBLrfcVEsDVayf4xg9SGwf+e6wE+4Ma7s1ASsUlfFoGOBasdoDx2IG7L5vDB+3vTtYP1ILhcrsEtMvEXadzNAL9Tc+f8Telmnu7qPbOAW8WsS16XTR7prFZYmCfBZCvofUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psUXOQTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FA1C4CEF0;
	Thu, 25 Sep 2025 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758818374;
	bh=Ilf+Vb676vEdQyNSBMyQj0ESSBZnu1xY7B5KeRVx3Nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psUXOQTtM+NUn4mfZKS2Md3BpoAHHABhIWA3RJV/azLjMmX2lX0Q8KQXMsDbR6h2i
	 pazOGy9j5t3I9f9codrL53iYEeDgUvQSwL4Dglro4/wDE8OTVeA4MSYHmPyHxzCiJm
	 G0ZtlS7qT4U0KpChstzt2vJSXG45F+mrUAVdpw+EPmBsUKlCIG+ads43saSXDntiW1
	 vx0Cy8NcncjQvZtUHuXEUDdH0nWKpdER1jjJo3OTopMsxnnKUcd9QzYRcwQfDr3R14
	 n/wSSETUgmAQzru6oPaidj29v0rH7psGvWIqO/jdAm8EwNqNFog5g83bjExTBJJWiC
	 dgLTxEabV16Iw==
Date: Thu, 25 Sep 2025 22:09:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	linux-pci@vger.kernel.org, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar-gen4: Assure reset occurs before DBI access
Message-ID: <7zvgozty4aplgcp6zndfl42bhc5v3csvuo6c4mkwz45qlnqxr6@hs2nijoldqcr>
References: <20250924005610.96484-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdW1efNhhW1ROSULP2WGBKiUDiCDHd5KHPa8RS-5tUqZww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW1efNhhW1ROSULP2WGBKiUDiCDHd5KHPa8RS-5tUqZww@mail.gmail.com>

On Thu, Sep 25, 2025 at 03:41:14PM +0200, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Wed, 24 Sept 2025 at 02:56, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
> > Assure the reset is latched and the core is ready for DBI access.
> > On R-Car V4H, the PCIe reset is asynchronized and does not take
> > effect immediately, but needs a short time to complete. In case
> > DBI access happens in that short time, that access generates an
> > SError. Make sure that condition can never happen, read back the
> > state of the reset which should turn the asynchronized reset into
> > synchronized one, and wait a little over 1ms to add additional
> > safety margin.
> >
> > Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Thanks for your patch!
> 
> I have tested this on White Hawk, with (in any order) and without[1],
> with and without CONFIG_DEBUG_LOCK_ALLOC.
> 
> > NOTE: This fix could be removed once the matching fix lands in linux-clk
> >       https://patchwork.kernel.org/project/linux-clk/patch/20250922162113.113223-1-marek.vasut+renesas@mailbox.org/
> >       This fix is implemented to assure PCIe is not broken in case the
> >       fix sent to linux-clk is applied asynchronized.
> 
> Indeed.
> 
> Note that to avoid regressions, this patch ("[PATCH] PCI: rcar-gen4:
> Assure reset occurs before DBI access ") must be applied _before_ [1].
> 

I've applied by this order:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/rcar-gen4

- Mani

-- 
மணிவண்ணன் சதாசிவம்

