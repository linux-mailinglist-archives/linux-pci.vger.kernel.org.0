Return-Path: <linux-pci+bounces-37002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2DBA0A18
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 18:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDE0562FD2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18DB2DE710;
	Thu, 25 Sep 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6qokEIv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B01C75E2;
	Thu, 25 Sep 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818170; cv=none; b=g4M6W28khkwC9Amm18UfUJbQJmDrHcptqNPYG2z18e6hCoNE/IwInc9x9Vlu1gfZmjnkIUE1o1ONpZtiVnu4sZkhyzaT0rL304JS+hoEMDC0XEwh+cXiUhLrHCaZMimdvbY+i/0JSifPuPhcnUEgIUb2pzTm7taFeyQTCNGIsIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818170; c=relaxed/simple;
	bh=7YEGA7SbY+4O0JF7l/TjXzQu3nhr8ONYOk1hLtgh9wM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UgHQMrNS84Ook5a8CdkVLy6yoz0XWTEuhrOq3DHpvMI2X8CyZcs3V9Rdi1/yDltkMyJAQITVjH8AEZI0+fMdRPpHyRXv9HzITeo7bgtwkvvE4I021C4v7E63VrCIFyIlzIKehOQecUrtlpu2haok3lpxbNju3urhu2KfsNZqi1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6qokEIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9553C4CEF0;
	Thu, 25 Sep 2025 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758818170;
	bh=7YEGA7SbY+4O0JF7l/TjXzQu3nhr8ONYOk1hLtgh9wM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H6qokEIvfHEsCr9l09IM2QHfQqY8wfa33iD1Kn6b3dfFyevURQx2T5EfW+ja9LdeH
	 f4Nz87crvL+/2eMRNNxZ8skXiQMPulvz/+bDj/E7ZKt4rs5Bc06eDylXNU9SSmcY99
	 bX2DnJ94qebg+vEGXD7SOC/IibL7nMuwma78tsA/qwVgc9MpPbVaDSI7eji0CacNWn
	 ekBgtbR+a89cRrgAVIzRi8ZSEuuOQiZwe6F3lZLJdi/D3MvAqyrqKHL3CKwbIeb0Gq
	 X9tDHNn+UhYdTT8SW6rHB/emAwq5xFoiULOtwTj4n4o6MU3fAv5WpXS9wfmt9dP3dg
	 CTPe770dJChhA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20250919134644.208098-1-marek.vasut+renesas@mailbox.org>
References: <20250919134644.208098-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3] PCI: rcar-gen4: Add missing 1ms delay after PWR
 reset assertion
Message-Id: <175881816532.390261.12261046517724113630.b4-ty@kernel.org>
Date: Thu, 25 Sep 2025 22:06:05 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 19 Sep 2025 15:45:58 +0200, Marek Vasut wrote:
> R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 585
> Figure 9.3.2 Software Reset flow (B) indicates that for peripherals in HSC
> domain, after reset has been asserted by writing a matching reset bit into
> register SRCR, it is mandatory to wait 1ms.
> 
> Because it is the controller driver which can determine whether or not the
> controller is in HSC domain based on its compatible string, add the missing
> delay into the controller driver.
> 
> [...]

Applied, thanks!

[1/1] PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
      commit: 23291403391180b0312405bb3d8fa8546124c643

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


