Return-Path: <linux-pci+bounces-21881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 442AAA3D2DA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 09:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78B4178B5C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 08:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E30F1E9B3C;
	Thu, 20 Feb 2025 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mZLAKJD6"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FEB1E990A;
	Thu, 20 Feb 2025 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039148; cv=none; b=g5NLExFFD0jh5nUHbqfAjSTmBY0Mg4AYbSjROmxkILYrS2M2j3c+HArJZvhUa4zEf0yHLeurmPN/eBJDxR6uU+20aE9upiCj95IhPmJE48AFvbvPN59IQ3qXX6DWtzZBKby1V1jp4GHD2toji98HwmXeA56dRhKVH0Tq1SFEcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039148; c=relaxed/simple;
	bh=sx/l5xw2wcryA5zyymb0FQdxpg6mU8uQ9h43rl8QKZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4yerDOhoMSSQZp8iLLMYdeGMBezFL4NN13t3qYE4/FLewna2cRrlUPMeDI/vfqM2v+Gf6q4Oaygte1DN2WnvKCDn8pOx24IxK9Kio78WGdICzso1f1DXPNcp3RFcmxV1bkBNijiTuEQXIMSUFU3OAdDrQ5q43TiKL6ouniayTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mZLAKJD6; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95B084445A;
	Thu, 20 Feb 2025 08:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740039137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JowldrGEMn8XdXvVF14r75ec9GWZZFqficZlofDUto=;
	b=mZLAKJD6RL3HY1nJ0fHkfJpJZGIrCTrDl7T0xvkVYnQp5KMXdWwU+HkORhqT6YUe3flfl4
	ez23FtsPzEeuK5Ocq+rAZbO37PjicNu9Dc82vyhbEoA8P2UNVCpJ4+NVQmePSfApxMjkgC
	7qa5VrCCPee12hGnxaJD+333JsaUeGs/1O9kafJNY1eFSp3T9bKDUNLECXGdiyyRapIrL7
	gV+9eTC2pQOUlX3zT8uB/HQ2uxkTL3UrJjKORD6A29/a7iSigLv42QfJ8daofxSAAAIEYl
	rWSTfztFK5VE5aGd9OjrWCqliU8ovfpptCEC1i0dkiIWleCsC7TtSlSgPvSsvQ==
Date: Thu, 20 Feb 2025 09:12:15 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Rob Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 1/5] driver core: Introduce
 device_{add,remove}_of_node()
Message-ID: <20250220091215.41eeb5f9@bootlin.com>
In-Reply-To: <20250219155901.000009e4@huawei.com>
References: <20250204073501.278248-1-herve.codina@bootlin.com>
	<20250204073501.278248-2-herve.codina@bootlin.com>
	<20250219155901.000009e4@huawei.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheplfhonhgrthhhrghnrdevrghmvghrohhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihiihhhirdhhohhusegrmhgurdgtohhm
X-GND-Sasl: herve.codina@bootlin.com

Hi Jonathan,

On Wed, 19 Feb 2025 15:59:01 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

...

> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> A few passing comments. Not suggestions to actually change anything
> at this stage though. Maybe a potential follow up if you think it's
> a good idea.
> 
...

> > +void device_remove_of_node(struct device *dev)
> > +{
> > +	dev = get_device(dev);
> > +	if (!dev)
> > +		return;  
> Maybe use
> 	struct device *d __free(put_device) = get_device(dev);
> 
> 	if (!d->of_node);
> 		return;
> 
> Not a reason to respin though!
> 
> 
...

> > +int device_add_of_node(struct device *dev, struct device_node *of_node)
> > +{
> > +	int ret;
> > +
> > +	if (!of_node)
> > +		return -EINVAL;
> > +
> > +	dev = get_device(dev);  
> 
> Likewise could use __free() magic here as well for slight simpliciations.
> 

I see. Indeed, the __free(put_device) can be an improvement in core.c

I think that this has to be done out of this series in a more globally way
because put_device() is used in several place in this file and having a mix
between __free(put_device) and put_device() calls in a goto label is not the
best solution.

For this reason, as you proposed except if someone else pushes in the
__free(put_device) direction in functions introduced in this patch, I
prefer to keep this patch as it is.

Thanks for your feedback,
Hervé

