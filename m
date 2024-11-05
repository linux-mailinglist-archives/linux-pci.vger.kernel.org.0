Return-Path: <linux-pci+bounces-16063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BC39BD26C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 17:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F191C22102
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92A11D79B6;
	Tue,  5 Nov 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DS5KC+qU"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F581154BEE;
	Tue,  5 Nov 2024 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824549; cv=none; b=tY3hPhAVsH/dPVyZ6KPhVnU5gqNLBl24rTZIKq5vzwacWCaU7DoAQ0WlWFO3Lzjh7hF1GAZxjCFd6wArPuJvsNFAx1jtktRKsZx6IuXpbirG7xbrOVNYE6PTimYZPGTbkwQXjz0HE1t6tguFbY/IDgrKLm1+r/dy/B5/k5sI2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824549; c=relaxed/simple;
	bh=CYrFlovR3vFVZgIKj0oZuwKO3I1GgWBQu+qCaTOMHcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EVEd/oHUtCqvkw4hjwZwlU1VwXJ/V0PVB7Dpvpy+PXpxV5lCJNjU0XIhpLom/My6hUQVLRkJi4XoCSdFaUGwMk5V+TeVLMeWWmZiQsRM4OIAY63TIDQLioTct5HVd+AMJ3Xg3lEHd7H6wVIAot3pAoJeW5TVChU0Lo5G64CP6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DS5KC+qU; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB4171C0006;
	Tue,  5 Nov 2024 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730824545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GFYxahzirE6xdiyeGH3LETsNUHcbUtzdb/pIKjdqig=;
	b=DS5KC+qUXGA3nvrDlc6Sm1mphO9DGRaz2Yr7ZMy7ha6c0BSub0HnPLgo9ldDj2JVxU9Kk3
	4TNsQR3GWmONhLuMxHe3FvdSqYrlOU3Bew98WJUTD/ShzbhAkBp90ajgNTj8SQ9FYJdH6s
	FFCUKqeE3p4D1fk59aaoxVzNhJEdG1V82Nrx/vAAexB+EZtw+CB8bse6eB9aG31LaIpwOm
	odU5ectv1VSm14vuoeaV/IwbIHvfdv1pmh7gFF1VWvtry+IqDWyV8vzhtH2X0dqkTnO3dX
	nTJ2L+62YWQVdoUElH6iXQdPAsmNdMdN9WJj2dIE0KAX9Bhh64UjMcQI6r54+Q==
Date: Tue, 5 Nov 2024 17:35:44 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 5/6] of: Use the standards compliant default address
 cells value for x86
Message-ID: <20241105173544.5b5ff50b@bootlin.com>
In-Reply-To: <CAL_JsqLd1YezwczSsE7vFjxQ4C5VHQaG4nL3OTXA+QcXX+pxqw@mail.gmail.com>
References: <20241104172001.165640-1-herve.codina@bootlin.com>
	<20241104172001.165640-6-herve.codina@bootlin.com>
	<CAL_JsqLd1YezwczSsE7vFjxQ4C5VHQaG4nL3OTXA+QcXX+pxqw@mail.gmail.com>
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

On Mon, 4 Nov 2024 14:07:59 -0600
Rob Herring <robh@kernel.org> wrote:

...
> 
> I prefer the default to just be wrong. My intention is to get rid of
> the defaults (at least for all FDT, not OF) and walking up parent
> nodes. My first step was to add warnings[1] and see who complained.
> 
> The base tree needs to be populated with #address-cells/#size-cells.
> I'd be fine if we say those are always 2 to keep it simple.
> 

Right in that case, I could add the #address-cells/#size-cells in the empty
node (empty_node.dts) used on all architecture when ACPI is enabled or the
bootloader doesn't provide a fdt.

Best regards,
Hervé

