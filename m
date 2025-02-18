Return-Path: <linux-pci+bounces-21694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76022A39483
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 09:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CC73AB2AA
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800941E25F7;
	Tue, 18 Feb 2025 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ijrCWebK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BdwkNdQH"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA422ACDC;
	Tue, 18 Feb 2025 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866179; cv=none; b=edMaTQTiw1M5MpoXOEidCbI/FDGNJgEHTc+swUiAaG5K8zTpomYWuLP2LhZqL22G2sy7LsVpqLmT5yD8ewcj6sZD0nFUO2c8EnxSbVTqwOz+RSCmuB+tLynhOx4FVSB1ZqrdcVoL8VFiqo6407VUjY6gPFDJxQOm1eGcDVZ/4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866179; c=relaxed/simple;
	bh=Y1DLFISRR+2zT2UX5Rkv7qMI2w14d+bviD60HoH17ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWs5H3Pn52B8MqceY+OZTrs7Ys1aX82dD0fkQn1R3kGmqZ7pnmsDb9+o955JOopuSwC3W5q/3Jg0bTd72nKINGGVeCEsdacF6275ABfw58sbIJ/0C5c3FKCtQ5QKMXyFlP8V6aB22FObfMOUuUxc7tw7cB6hdJ8ap2RSr6JxqhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ijrCWebK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BdwkNdQH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:09:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739866176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7KpeWoZTmbui/bco+qfzF3IAHwT11GegvugnBF1JjSk=;
	b=ijrCWebK8yHvpGjnKWuKwDZjWHNKklsim9njTuUZoaTk08rDyCEOepWx0WAZyqXY1Pq7Jr
	bdjnQTtIWT0kQ/atT2hB4Y0k9u154Xs4v/PnuvmyXoS/YqiZTYBas3Dg+jvQgDgHoBAUqy
	GebBX/+0vfimpveBiFTUCKzthDPfjRFk+SxraIYKBve7HQakFbtrdaISf7UqJN9MhgICj1
	v2vu4Xb0dmmv5+scD5bssDQfM60axkmtz3zDBzyYqxBU/ojHE0/6+1oS0+NSGVxTstwMzO
	NKzpBKY108H0705q/te8s55AGT+4ZieGHDqTBRfj8kOaR+zOZ4nDaVDWgRBkcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739866176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7KpeWoZTmbui/bco+qfzF3IAHwT11GegvugnBF1JjSk=;
	b=BdwkNdQHIN25bdwHySJB13EqRJr0kRLeX9QTMQVNFEUqJVTlFh1DbZUkTe99XbHGYI/jVc
	mjfw19ujlhSvdIAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Ryo Takakura <ryotkkr98@gmail.com>, bhelgaas@google.com,
	jonathan.derrick@linux.dev, kw@linux.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, nirmal.patel@linux.intel.com,
	robh@kernel.org, rostedt@goodmis.org, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3] PCI: vmd: Fix spinlock usage on config access for RT
 kernel
Message-ID: <20250218080934.IRRZ6B6h@linutronix.de>
References: <20241219014549.24427-1-ryotkkr98@gmail.com>
 <Z7No3XzmE3t54qNi@uudg.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7No3XzmE3t54qNi@uudg.org>

On 2025-02-17 13:50:37 [-0300], Luis Claudio R. Goncalves wrote:
> On Thu, Dec 19, 2024 at 10:45:49AM +0900, Ryo Takakura wrote:
> > PCI config access is locked with pci_lock which is raw_spinlock.
> > Convert cfg_lock to raw_spinlock so that the lock usage is consistent
> > for RT kernel.
> 
> Any movement here?

Reposted as https://lore.kernel.org/all/20250218080830.ufw3IgyX@linutronix.de

> Best,
> Luis

Sebastian

