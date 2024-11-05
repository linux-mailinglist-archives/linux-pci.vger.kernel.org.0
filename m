Return-Path: <linux-pci+bounces-16061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 143519BD21A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 17:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B25B21EFE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37645170A2A;
	Tue,  5 Nov 2024 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZfgdHdL0"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4513E3EF;
	Tue,  5 Nov 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823422; cv=none; b=cs5u18JSxuUMblj948cBXm5auw/KiJakkd4CFho/YyW69mROSqALvdWvWhWxYuXlpJJv8Kh0xrPotph+s/huSfQbGMOn5tCf+p4OcGoQqOQ0bwGd2KAFlAaRdNl9ScHS+8vQi+jhMToB8zganCDgcspQixtZlDlZuizY0Mnn/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823422; c=relaxed/simple;
	bh=r1tcWWlCoiF7Her/h61mI6QbANQB+2UXYZ63skQz0jk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJEUtP87VF0yUbrnjoxnOCn72oZOxJC8wQAUR2GhKWtL4nib5+S6LSQZulOQLcGIX804bCX562n4Mvs4S+HeI18/wOLhFqudpW1kjs05+xSKnktyUmcefE6F7QoRLnb5JpRouDlxyMI+gpgQbKEDJegzUMejXxL2aFGT95Mw1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZfgdHdL0; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D741DC0002;
	Tue,  5 Nov 2024 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730823415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9i1yywh+snSHoIlcvM9qG34+tz1N/7OY25hu/QBJ3s=;
	b=ZfgdHdL0YSm0aQHA/bZ2tNWpbxLtSOSTU1WoOJrA6XZOxkyL9kUpHIyR5/5Y8mM7jrCbz6
	DbVC1Itgpu5qGotLJMyW5FJzO2bsi26OU7pRBWMucG0EWFiR+h4kggVoFA6JiwP1nCg4L3
	+l08sMlkw45HFTOizi3s3ocrTuvv2G+FSFFu/zbCvlpxR82Gs17HUvvaadDBOjitqU+tqL
	hckqk0cMESGnE9a81dF3cnPE4T4p5wcneVlU2yR6p0grolRNZWVRIHOXZJQCFx4Bbz4DlE
	FgwGXgXqKZJGZu9AtprrgXcs08OBLCvqC8x0lmRdcu7muMLMWuMlA6FT/zpEDQ==
Date: Tue, 5 Nov 2024 17:16:54 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI: of: Use device_{add,remove}_of_node() to
 attach of_node to existing device
Message-ID: <20241105171654.3c45c80e@bootlin.com>
In-Reply-To: <20241104202008.GB361448-robh@kernel.org>
References: <20241104172001.165640-1-herve.codina@bootlin.com>
	<20241104172001.165640-3-herve.codina@bootlin.com>
	<20241104202008.GB361448-robh@kernel.org>
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

Hi Rob,

On Mon, 4 Nov 2024 14:20:08 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, Nov 04, 2024 at 06:19:56PM +0100, Herve Codina wrote:
> > The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> > creates of_node for PCI devices. The newly created of_node is attached
> > to an existing device. This is done setting directly pdev->dev.of_node
> > in the code.
> > 
> > Even if pdev->dev.of_node cannot be previously set, this doesn't handle
> > the fwnode field of the struct device. Indeed, this field needs to be
> > set if it hasn't already been set.
> > 
> > device_{add,remove}_of_node() have been introduced to handle this case.
> > 
> > Use them instead of the direct setting.
> > 
> > Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> > Cc: stable@vger.kernel.org  
> 
> I don't think this is stable material. What exactly would is broken 
> which would be fixed by just the first 2 patches?

Hum indeed, I haven't observed a broken behavior in current kernel.
I will remove Fixes and Cc in the next iteration.

Best regards,
Hervé

