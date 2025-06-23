Return-Path: <linux-pci+bounces-30386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D4CAE3FFE
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BDE3BBD0A
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B27248F60;
	Mon, 23 Jun 2025 12:19:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F1E248F40;
	Mon, 23 Jun 2025 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681162; cv=none; b=bFUS/ePCG7wwvmNTh7yZAzRF07iq2CVUekQVZgtqRE0dl02lyWj+4LG6Z6VrTQzlPZkXTgUIvCt6tO0DsSn6p1gUv2HeN8SyoO1Zk3eMklyfJ/QXg0bbJhnPIxwd0XhzkDD9V5LCygctMGYZgGhKF5YKZilFYYhqIjVAYjhWd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681162; c=relaxed/simple;
	bh=shpeglIn36FKeBIw85IotOo/0D7/oiy7H7OZihX18HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCawbq99nzL2V+86H8M5QncpUBeOTMfqagSmF3OC3RU9ppl5IWGtd2+cqlnhExU1cQhYcG8WAkUA44wq9/fx/grXUaN6B3QoQhnyOQ/dOwioN2Sfq7Pu4XllfZlyGSPOHS63LZs6cHMQ8u2/rw/F9YHa2uaigFkxW+InHljqzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 933EE2C06663;
	Mon, 23 Jun 2025 14:19:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8120B40FCC; Mon, 23 Jun 2025 14:19:09 +0200 (CEST)
Date: Mon, 23 Jun 2025 14:19:09 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on
 device unplug
Message-ID: <aFlGPaITSa3IAB8s@wunner.de>
References: <20250620025535.3425049-3-superm1@kernel.org>
 <aFcCaw_IZr-JuUYY@wunner.de>
 <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
 <aFeJ83O9PRUrM2Ir@wunner.de>
 <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>
 <aFj3jUAM42lSyfpe@wunner.de>
 <aFkEI2jXg7YiwL7b@wunner.de>
 <aFkm8njX-NEIiTcv@wunner.de>
 <CAJZ5v0jfuAjhskbwG1XHByGpdgP1pSHwVSMnz3jcOy7VDyjnRQ@mail.gmail.com>
 <7dde3873-4239-4be8-801a-dcf37472664d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dde3873-4239-4be8-801a-dcf37472664d@kernel.org>

On Mon, Jun 23, 2025 at 06:37:33AM -0500, Mario Limonciello wrote:
> On 6/23/25 5:11 AM, Rafael J. Wysocki wrote:
> > On Mon, Jun 23, 2025 at 12:05???PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Mon, Jun 23, 2025 at 09:37:07AM +0200, Lukas Wunner wrote:
> > > > On Mon, Jun 23, 2025 at 08:43:25AM +0200, Lukas Wunner wrote:
> > > > > On Sun, Jun 22, 2025 at 01:39:26PM -0500, Mario Limonciello wrote:
> > > > > > I did this check and yes specifically on this PCIe port with
> > > > > > the underflow the d3 possible lookup returns false during
> > > > > > pcie_portdrv_remove().  It returns true during
> > > > > > pcie_portdrv_probe().
> > > > > 
> > > > > That's not supposed to happen.  The expectation is that
> > > > > pci_bridge_d3_possible() always returns the same value.
> > > > 
> > > > I'm wondering if the patch below fixes the issue?
> 
> Yes this works, thanks!

Could you still check what the value read from the Slot Capabilities
register is in pciehp_is_native() (if the patch is not applied)?

I guess it must be something else than "all ones" and I'd like to
understand why.

Thanks,

Lukas

