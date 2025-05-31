Return-Path: <linux-pci+bounces-28765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36765AC9B4D
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 16:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17F017C56B
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 14:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003D5237162;
	Sat, 31 May 2025 14:09:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA92AEF5;
	Sat, 31 May 2025 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748700561; cv=none; b=TBRV89GIBgmuLTl6rhTeYT3lZxJhYdiQXRk4GogCE4Hai140j+ezs3Aep+DcF2fT8LzebRFXMefETXqmPQMDOpF2wVSZ7+N8jdq8J8CiPyk86fkC21/f2ovOTdPZ/1nUeWaWBqlpYlaQczZG2Xg1RJ4o06+LO+ZlMVitR69y+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748700561; c=relaxed/simple;
	bh=FKxShnEbZSjUaa6Uz60/biiqzLbGuCdxYMgF+Qa81tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d62RTA2Rlxp9MYCgrcNi2cLYYgqncJTkabrQaPEEBOCDTGn6cLrLsLdg6NLvzKOaDZsecS1Atb0XIkW4EpFq5YUrt3hHRXFwLB8nHHCvZFwK9Gxa3RZamT+grJr1nf1oH3G0uxLWND5QXcBMF7FZt0vnd8L7uywydItSmbSA1pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7A1392C000A5;
	Sat, 31 May 2025 16:09:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5DF9A2473D9; Sat, 31 May 2025 16:09:09 +0200 (CEST)
Date: Sat, 31 May 2025 16:09:09 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Graham Whyte <grwhyte@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com,
	code@tyhicks.com, Okaya@kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Reduce delay after FLR of Microsoft MANA devices
Message-ID: <aDsNhVIv5xt3S7KQ@wunner.de>
References: <20250528181047.1748794-1-grwhyte@linux.microsoft.com>
 <aDg4PE4Zbzwps71E@wunner.de>
 <b23fb8f4-0da7-4403-8a2d-665d5675be9c@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b23fb8f4-0da7-4403-8a2d-665d5675be9c@linux.microsoft.com>

On Fri, May 30, 2025 at 09:26:16AM -0700, Graham Whyte wrote:
> On 5/29/2025 3:34 AM, Lukas Wunner wrote:
> > On Wed, May 28, 2025 at 06:10:47PM +0000, grwhyte@linux.microsoft.com wrote:
> > > Add a device-specific reset for Microsoft MANA devices with the FLR
> > > delay reduced from 100ms to 10ms. While this is not compliant with the
> > > pci spec, these devices safely complete the FLR much quicker than 100ms
> > > and this can be reduced to optimize certain scenarios
> > 
> > How often do you reset these devices that 90 msec makes a difference?
> > What are these "certain scenarios"?
> 
> VF removal and rescan is the main scenario for runtime repairs and driver
> updates.
> Doing this on scale with 100ms adds up to significant time across multiple
> VFs.

Please mention this in the commit message to avoid head-scratching
by someone reading it down the road.

Thanks,

Lukas

