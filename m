Return-Path: <linux-pci+bounces-18761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FAD9F77DC
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 10:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CBF16AC0F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15E421D003;
	Thu, 19 Dec 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="olSO8Phh"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16842165E4;
	Thu, 19 Dec 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734598801; cv=none; b=m1SdVGYhGmgYSlnd3Zbz4nX5MIE4wr3ixSh+dAL0gM81s9bNuIYdyh7bDWrLi1BRx6f808Yfs/f39zN7sxmtDBdGHD5EXnwaEKUOtsLaNWXP+0OTC7MoBg26vcU3CoWlGq4J0yZfkblX1lSPbNM0H4likPJ8oAj7nnyAQ4gKKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734598801; c=relaxed/simple;
	bh=jTmSlx8GDZQDKvAZw1h8ubP9h/bedd9nyUEfEr3zI0c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1N598kOMbNMazSoDUJHJp5zuQlwRjxjrwSIWBcgQgoPNWM1fSwng4vtS1XV2SvfIBVk8OJkjZHxSASYEnjs92GswRm7XFUvAH6tairbjk+bGX5U6psvBZ/EY/ZYPzyh2cIRLVL8HgtkWYf60Qm2Yt1RbD34fo8D+4kdmtKIuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=olSO8Phh; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ8xcPC044798;
	Thu, 19 Dec 2024 02:59:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734598778;
	bh=/LGNL7rxnITISaykKCoSQ4leRTbo2NuexQJLKGse51s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=olSO8PhhatKnzVbrAyLjKdSB5ZUzbl3YCAFRO7YzYVZ+oN3/WAoZwHxjcJUA3Oapi
	 PiiFm1EWsHykdzsKOzLXueRS58rrXcVYg5rB5IvXNeWL3Ri1rQYK2Xee14Z+2aUHzI
	 ZEGLOLKYndwEysTc7viCJRhxQHRws+BZ4oeSXFLA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ8xcqh112600;
	Thu, 19 Dec 2024 02:59:38 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Dec 2024 02:59:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Dec 2024 02:59:38 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ8xbn5072279;
	Thu, 19 Dec 2024 02:59:37 -0600
Date: Thu, 19 Dec 2024 14:29:36 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Hans Zhang <18255117159@163.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <thomas.richard@bootlin.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rockswang7@gmail.com>
Subject: Re: [PATCH] PCI: cadence: Fixed cdns_pcie_host_link_setup return
 value.
Message-ID: <v623jkaz4u4dpzlr5dtnjfolc5nk7az24aqhjth4lpjffen4ct@ypjekbr4o54q>
References: <20241219081452.32035-1-18255117159@163.com>
 <hldbrb5rgzwibq3xiak2qpy5jawsgmhwjxrhersjwfighljyim@noxzbf4cre3m>
 <999ad91d-9b61-b939-a043-4ab3f07c72a1@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <999ad91d-9b61-b939-a043-4ab3f07c72a1@163.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Dec 19, 2024 at 03:49:33AM -0500, Hans Zhang wrote:
> 
> On 12/19/24 03:33, Siddharth Vadapalli wrote:
> > On Thu, Dec 19, 2024 at 03:14:52AM -0500, Hans Zhang wrote:
> > > If the PCIe link never came up, the enumeration process
> > > should not be run.
> > The link could come up at a later point in time. Please refer to the
> > implementation of:
> > dw_pcie_host_init() in drivers/pci/controller/dwc/pcie-designware-host.c
> > wherein we have the following:
> > 	/* Ignore errors, the link may come up later */
> > 	dw_pcie_wait_for_link(pci);
> > 
> > It seems to me that the logic behind ignoring the absence of the link
> > within cdns_pcie_host_link_setup() instead of erroring out, is similar to
> > that of dw_pcie_wait_for_link().
> > 
> > Regards,
> > Siddharth.
> > 
> > 
> > If a PCIe port is not connected to a device. The PCIe link does not
> > go up. The current code returns success whether the device is connected
> > or not. Cadence IP's ECAM requires an LTSSM at L0 to access the RC's
> > config space registers. Otherwise the enumeration process will hang.

The ">" symbols seem to be manually added in your reply and are also
incorrect. If you have added them manually, please don't add them at the
start of the sentences corresponding to your reply.

The issue you are facing seems to be specific to the Cadence IP or the way
in which the IP has been integrated into the device that you are using.
On TI SoCs which have the Cadence PCIe Controller, absence of PCIe devices
doesn't result in a hang. Enumeration should proceed irrespective of the
presence of PCIe devices and should indicate their absence when they aren't
connected.

While I am not denying the issue being seen, the fix should probably be
done elsewhere.

Regards,
Siddharth.

