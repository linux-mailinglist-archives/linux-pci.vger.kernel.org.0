Return-Path: <linux-pci+bounces-9374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0708791A655
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 14:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377931C20F7E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 12:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D7414D6F5;
	Thu, 27 Jun 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CIEhVqdt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GJg7dpZ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378414882B;
	Thu, 27 Jun 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490354; cv=none; b=ePF0nvsbW9COZj2QwuiXvnQr4JkYJkWBoCFi10vRN7IhYZEkfEaF0t9EcMJU0w57vRo1pex+UuLkabivml3i3TiJ0hLjXHLE0wvjRBhMjbrVHAoTlof2dXofX75WApt0Pkr/zwdZ3QWwmasVSxEJM+lvA4ulPq2E6EpE/awKui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490354; c=relaxed/simple;
	bh=b1eJkVWH5I+FUx6yRzUDP3FwJvWxBdtCyQ2yKGc6SEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UKe9Ut1lyVt+uE5Wy/whmU+2Za9Bod+fIMMSqVREfUrW2PHY7BSjDa62NGtKGevTqYfut6IkKRZrhEDefCFjyvyH/UnT0TkGokfrQhLIGMEU5CZ9xjAF6fNHimELVdqYzKuF/N4NKcTPF3QpiWAF/uomFfjLMKaBqOB0Dq5T5aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CIEhVqdt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GJg7dpZ8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719490349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GO3gpCVWm/z2htSk74hw4M+cH+jE0XOChRhSMs+cTOk=;
	b=CIEhVqdtaeFXTLOkp3GBiPQ4tnnzjNSy+VrM1XMQ4BMDbi/XzVrXbhz/qRcdX1dZXeyv6E
	75qwrl/imoXvlF1UuE3aUXUxCHwAQKMSDXTztmuCz4iWWAvc7hzuOu1rftoBbgRa/1S9h0
	4Z3fME4WyEFpF87YW9n2lcQUnQWPLghdQ1uukwUAzWqSBk7yje5kzxxmHCDfB9gHXTKn+W
	Gow1p9Bis0gCJ6qkKj9aZLr5XV2aYArCJJKHbWzghmKNk5WMYhVARgukWxcIuYIlm8olR8
	yVQJ8ftLzGhwHQD3uMPqs6pgNTx82Nfd+G2TFPIbnuKKDP1I2cs0fRt0kQ+Ztg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719490349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GO3gpCVWm/z2htSk74hw4M+cH+jE0XOChRhSMs+cTOk=;
	b=GJg7dpZ8ZikQL7a9qM1OPRXoFHHXj6nz/OrOedS5bDqOJr9YH6Amm/gmmZLByJu0d1lbTt
	/CO5DvgCaEhDxSBA==
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 kw@linux.com, Philipp Zabel <p.zabel@pengutronix.de>, Andrea della Porta
 <andrea.porta@suse.com>, Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>
Subject: Re: [PATCH 3/7] irqchip: Add Broadcom bcm2712 MSI-X interrupt
 controller
In-Reply-To: <20240626104544.14233-4-svarbanov@suse.de>
References: <20240626104544.14233-1-svarbanov@suse.de>
 <20240626104544.14233-4-svarbanov@suse.de>
Date: Thu, 27 Jun 2024 14:12:29 +0200
Message-ID: <87ikxu1t5e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stanimir!

On Wed, Jun 26 2024 at 13:45, Stanimir Varbanov wrote:
> Add an interrupt controller driver for MSI-X Interrupt Peripheral (MIP)
> hardware block found in bcm2712. The interrupt controller is used to
> handle MSI-X interrupts from peripherials behind PCIe endpoints like
> RP1 south bridge found in RPi5.
>
> There are two MIPs on bcm2712, the first has 64 consecutive SPIs
> assigned to 64 output vectors, and the second has 17 SPIs, but only
> 8 of them are consecutive starting at the 8th output vector.

This is going to conflict with:

  https://lore.kernel.org/all/20240623142137.448898081@linutronix.de/

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-arm-v4-1

Can you please have a look and rework it to the new per device MSI
domain concept?

The series shows you how to convert it over. If you need help, please
let me know.

Thanks,

        tglx

