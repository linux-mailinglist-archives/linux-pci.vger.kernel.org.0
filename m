Return-Path: <linux-pci+bounces-31517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCDEAF8B44
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 10:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670D816B859
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0582FE37D;
	Fri,  4 Jul 2025 08:03:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1682A2FE386
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751616221; cv=none; b=uELFocfOPYezjRwFpiyPeBrWuVSLQ9ePDr2n5wENhLmBY1eCzdRfq+Cdpe2UjLQ4SzSXziGMByyCLxqyzZ2ZAxx62Jdy+AxWo/TTlySJrkR7BYhG1HWgkTc64hy0sMiWvXp4tkzAE3CDthvMnGHI9sbheTCpeoU1T115mZt6beE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751616221; c=relaxed/simple;
	bh=YHuvEfsn+r8sJnV0EWVD6EUyr85tNjGvnStjCakRGZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSXYVCd4PN8TM/yLtXnzcuPG57t8oWShvQ8T/teby2w2cXSpjSMIuWtpta6/TrckQHJtoqZCyX3KRuqhnBACc8cjOUkzg/T3S/bq+avqJeOtURBLqFKOlVhCSmzpLOoV2uX71PQMUn+f80q9TzAq3Z4Wre5iRf2KxVD/bk4w84A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 78AA72C05696;
	Fri,  4 Jul 2025 10:03:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4548E41719E; Fri,  4 Jul 2025 10:03:30 +0200 (CEST)
Date: Fri, 4 Jul 2025 10:03:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@kernel.org>
Cc: "Jozef Matejcik (Nokia)" <jozef.matejcik@nokia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci_probe called concurrently in machine with 2 identical PCI
 devices causing race condition
Message-ID: <aGeK0lgzJOp7BBqR@wunner.de>
References: <AS4PR07MB85085806C2BF5CC518D52808937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
 <aF04PxJ5WqIA7Je0@wunner.de>
 <AS4PR07MB8508CA1516E932B243AC5139937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
 <aF08kFNy8qrI8LvD@wunner.de>
 <aF1qRv0XlT4EDN-Y@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF1qRv0XlT4EDN-Y@kbusch-mbp>

On Thu, Jun 26, 2025 at 09:41:58AM -0600, Keith Busch wrote:
> On Thu, Jun 26, 2025 at 02:26:56PM +0200, Lukas Wunner wrote:
> > On Thu, Jun 26, 2025 at 12:20:48PM +0000, Jozef Matejcik (Nokia) wrote:
> > > However, I think this can happen in any machine with 2 identical
> > > PCI devices, because as far as I know, existing PCI drivers usually
> > > do not assume that probe function can be called from multiple threads.
> > 
> > That can happen all the time and it would be a bug in the driver
> > if it caused issues.
> 
> Wait, is that true? I thought that would only happen if the driver
> indicated probe_type PROBE_PREFER_ASYNCHRONOUS. The default appears to
> still be the same as PROBE_FORCE_SYNCHRONOUS.

You're right, and additionally PROBE_PREFER_ASYNCHRONOUS is only honored
on deferred probing.  It appears Jozef is using an out-of-tree driver,
so it's unclear if those conditions are met, but if they are, then the
driver's ->probe() hook may be executed multiple times concurrently.
I guess I went out on a limb with the above-quoted statement, so I
apologize for that.

I've just submitted a patch to honor PROBE_PREFER_ASYNCHRONOUS also on
initial probing:

https://lore.kernel.org/r/53abe6f5ac7c631f95f5d061aa748b192eda0379.1751614426.git.lukas@wunner.de

Would you mind giving it a spin to ascertain that initial probing does
happen asynchronously with it?  The nvme driver (which you co-maintain)
already opts in to async probing, so should take advantage of it right
away.  GPU drivers seem particularly guilty of lengthy probe times,
so you might want to test async probing with those as well, in order to
have quicker booting on machines used for training neural networks.

Thanks!

Lukas

