Return-Path: <linux-pci+bounces-44841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C714D21091
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 423A8301BCEB
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569D8349B16;
	Wed, 14 Jan 2026 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E07QDrLE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7334CFB2
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768419026; cv=none; b=UR30LbKgj+OKzzXO2prRkVdq1AfbPE1yDoJzyzEcfiADi3zROjSOJ/CD/o2rZHvxMUjO8nThWB3hqJZGE915mV7ND2lNMwrWbu+MZ8T7hJ/FlBrwFfmrHVAzjhX74OIfAQ2ihkkHa7F636priYqTk0hwuo/hTSvIsMgv7Dk+rYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768419026; c=relaxed/simple;
	bh=IM7H/ZQgqjJxBEG5s3Aii6NpGMyiQs2dtjYKAYkjjMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aU3y3z7TlhjET1eXA1DRcobOYBCZVwLpn63aF/Gd5K6TxOZQSfB0ulKz8Z0ddfrP56K47QLgc4yxZvZRuRgl4M9reaIPFbn/2aXs97fBYchMVBoW9Hl08DRacJIhJ4/XnSHCHDYseAq40VWUuAbIxfPROHPqKG+oPjIweSgyDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E07QDrLE; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b19939070fso395479eec.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 11:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768419023; x=1769023823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgKGq9opOB0J5kc1IsRO+3fBF7gaT8B4jDYyPKNcgiE=;
        b=E07QDrLEuZv5Te/DdarHvzkmPImCUsnJ1wKHW47ps+c9me4Mpky6dtJ7nTOVCzmrKD
         YYHGtymwQUJvfjaxXVWe4DE2kd5x5lCuyp6pOExIF9SDmz15OIP6arYdXBAfNzN2k5T/
         sgPX5DxasIFDbfXHgXF50XaNen/dAte/eGa1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768419023; x=1769023823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgKGq9opOB0J5kc1IsRO+3fBF7gaT8B4jDYyPKNcgiE=;
        b=VCstIiOzgJ07bI9rpLTldXVQNJ1UUVvXIxheWBu5goxVvcW4iL0DStBcC6oORi+hIj
         EhOZ5M/aJTSJiA+HZEf/RREVHzfP1yntF0XlBqkttX32wCMHh7iO2h2RCYOCxouVENdJ
         nUa99NVrY7pBOQVs4gWP3L6+4tO6S/u6u37Me4UtAxegqGoM2ofKLn3T/IV44P/ze0zT
         14/ueeS4b3ydxJu4A42ctAiT08VfxMhIKV0AvuMh5rU4LjrFf8nhNSbIc/bHHz3ygKcK
         GkgLLkhWb2ONt/me6AWHoFpafkJfWyJm0YX91FbiRRQcj4tDaH/wFKTK0xQtWYYtLJoZ
         smgg==
X-Forwarded-Encrypted: i=1; AJvYcCUrUw9mCVO+Ig2Cv7+ES5/OxMBIOXrpTB63DR34BnnNTnwoTtRr1TA/z4MIEtCdXaLWyZE+d6vOqW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtirxk61r9V/teUdicp/esi7Lw7w7oIdrmrYdEPSOiu2JdfTzN
	Kko30TCTtr3Si3yxpAJk8pCyLYs8/vhIUB/5Yqd79lKniCwpn0wm05Gb+EnIEp884g==
X-Gm-Gg: AY/fxX4qAYfWxeqJlirnKuvs4y3u/S07FiQPPVkJXwLh6zJ2tyMV6ycBbxD56KR1dHa
	yMW2HZQasYN7MCejsy4OEkXRaD1NnCoH2iPx/1WTHZ4p3d2sDu6Q+tUAg7fhHFmh1Af+gUvMqnA
	QksaHtf3jQnGAvghEu3voJOlOBBBopVnReqt/1KH+9wAMEHjhww952zdQAdrADoYwjUJcV+288H
	mg1Rt6jx1Msl1aDMwmmm6Ei7UgI+yDuTG+rVMNEtSHKxC/S13bjlxmuhOU9Jg255R7c0g1J0IrV
	ziODIwhwIYulbQmrc2ActY7QgmNSvH43FGY3lai0vnvK+3BWzu9ANcLX1lNGlNDLFe2jbxS+K/U
	rFDPjRFbJsx95DTsmA8x0tngB53szkdfZaeskngjIEoi4aoBtU+/vaBYFb130bpLt4D2L1KqpRS
	KrtDpKvpRZz4ts2Olz1NwH72KvW4SFezgxv/qKqroKq5KbcQP4NQ==
X-Received: by 2002:a05:7301:7bc3:b0:2ae:5be6:f47a with SMTP id 5a478bee46e88-2b486c9600fmr5116768eec.17.1768419022747;
        Wed, 14 Jan 2026 11:30:22 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ae4d:1d26:39a5:d7ab])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b4549fc8e9sm4624393eec.28.2026.01.14.11.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 11:30:21 -0800 (PST)
Date: Wed, 14 Jan 2026 11:30:19 -0800
From: Brian Norris <briannorris@chromium.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Allow probing even without child services
Message-ID: <aWfuyw3JHD-1F5uZ@google.com>
References: <20260109152013.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
 <aWHtbGzVRRpa9kd0@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWHtbGzVRRpa9kd0@wunner.de>

Hi Lukas,

(FYI, I missed your email earlier because of errant spam filters. I'm
sure that's on my end somewhere, or maybe some over-eager DKIM stuff.
I only noticed when I checked lore... I'll try to keep my eyes open.)

On Sat, Jan 10, 2026 at 07:10:52AM +0100, Lukas Wunner wrote:
> On Fri, Jan 09, 2026 at 03:20:13PM -0800, Brian Norris wrote:
> > @@ -355,29 +355,18 @@ static int pcie_port_device_register(struct pci_dev *dev)
> >  	if (status) {
> >  		capabilities &= PCIE_PORT_SERVICE_HP;
> >  		if (!capabilities)
> > -			goto error_disable;
> > +			return 0;
> >  	}
> 
> This will keep the Bus Master Enable bit set (see call to
> pci_set_master() further up in the function), even though
> no MSIs are expected from the device.  (I *think* these
> would be the only memory writes that a port would perform.)
> 
> That doesn't seem right.  If there are no services, it seems
> prudent to clear Bus Master Enable again (as is done by
> pci_disable_device() right now).
> 
> >  	/* Allocate child services if any */
> > -	status = -ENODEV;
> > -	nr_service = 0;
> >  	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
> >  		int service = 1 << i;
> >  		if (!(capabilities & service))
> >  			continue;
> > -		if (!pcie_device_init(dev, service, irqs[i]))
> > -			nr_service++;
> > +		pcie_device_init(dev, service, irqs[i]);
> >  	}
> > -	if (!nr_service)
> > -		goto error_cleanup_irqs;
> 
> Same here.  Why keep Bus Master Enable bit set and MSIs requested
> if none of the port services probed successfully?

Seems like a reasonable suggestion. I'll try pci_clear_master() in some
of these no-op non-failure cases.

Do you have the same concerns if pcie_init_service_irqs() falls back to
INTx but does not fail? It seems like a potentially fraught exercise to
guess what child services might need bus mastering though, so maybe it's
better to limit this only to nr_service==0 cases?

> > The PCIe port driver fails to probe if it finds no child services,
> > presumably under the assumption that the driver is not useful in that
> > case. However, the driver *can* still be useful for power management
> > support -- namely, it still configures the port for runtime PM / D3,
> > which may be important for allowing a bridge to enter low power modes.
> > 
> > Thus, we allow probe to succeed even if no IRQs and no child services
> > are available. This also mirrors existing behavior for ports that have
> > no PCIe capabilities, where we'd also probe successfully.
> 
> Nit:  Please use imperative mood, i.e. "Thus, allow probe to succeed..."

Ack.

Brian

