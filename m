Return-Path: <linux-pci+bounces-14940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C79A6C6C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 16:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86DBB246EE
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158121F9AAF;
	Mon, 21 Oct 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l1NZndhc"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6485A26ACD;
	Mon, 21 Oct 2024 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521703; cv=none; b=Nr4Dc7ATvnq0FPPFfPRUY7LOq2d52pZiflgxC5DS92ZQEqEBs/BQzde9i80zggLjjoobwfmuEFl8GQD/R0HBOyaqDlghOCC/JVAiYsAs7yCbs4cu9wtD3oUE4vVK+KcT63oBmQEgIDH9Q7tzqAeApmNDVPVSV30cTxz4zNR4d60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521703; c=relaxed/simple;
	bh=oES9w02HsNO+wAdgGTKwa5IUNCRPd0m/e8VFJjy8Y6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOM/fs0DxDo82KcfjBwl5PSe2FSytOtNlqOFWO/yzYOGzHQj7YF9c0kKmOHeiDTKpCZxEDty54yhjRS4KazWNom0dbo9ueQQRLgouxfxzmTugA3ID1U5guE7MBvFZpk7eHjSOjwEGLXgzg4xLtGYuFzHPfFCMUC+ZiSTQPh+WPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l1NZndhc; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1E1660003;
	Mon, 21 Oct 2024 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729521698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWKKfevfqq3xTQx/qm5VhEu0R1W8s/2FfrkGVfXaCqU=;
	b=l1NZndhcmmiFNAfOeaopATuWCDhot1mJIYIJNqbwnUDhfcG+fSZwrPO3K+LKKi1VuAKCva
	F1XcD3cp8ikbu1KgiUyGHW3NhsuAi/a7L7vK5Ii0AMJYpEeBAWcMoNMTqSaLIkc3cDw1Vq
	o0ochi2t0hSFRAjfr531mBmOSYHH+I//wjmQNp3rDbDDpRiloKt/kLQZrYqZsAx1O886Wk
	L12XTFZMg0eHP4GXV8BWpe9YcF3nU1b+1pHbADu88IvXV/MWaEMs2xv0tF+LIvzb/vA3T6
	j0JE4uEgGi9icat4PhlAuxS+BDSDzDLoJEw71RmrQusyBk00/i3tW52e7My8ag==
Date: Mon, 21 Oct 2024 16:41:35 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, Lee Jones
 <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Derek Kiernan
 <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Herve Codina
 <herve.codina@bootlin.com>, Bjorn Helgaas <bhelgaas@google.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew
 Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v10 0/6] Add support for the LAN966x PCI device using a
 DT overlay
Message-ID: <20241021164135.494c8ff6@bootlin.com>
In-Reply-To: <20241014124636.24221-1-herve.codina@bootlin.com>
References: <20241014124636.24221-1-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Greg, Philip, Maintainers,

On Mon, 14 Oct 2024 14:46:29 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi,
> 
> This series adds support for the LAN966x chip when used as a PCI
> device.
> 
...

All patches have received an 'Acked-by' and I didn't receive any
feedback on this v10.

Is there anything that blocks the whole series merge?

Let me know if I need to do something else to have the series applied.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

