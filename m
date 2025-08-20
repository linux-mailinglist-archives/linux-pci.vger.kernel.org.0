Return-Path: <linux-pci+bounces-34403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAB8B2E4A7
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 20:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7318F7B821F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C47272E7F;
	Wed, 20 Aug 2025 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYprbOiY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D8126F2A6;
	Wed, 20 Aug 2025 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713212; cv=none; b=fR6GKfaLw2sVfH9x2p0Jh0Xd5ARr4Jm79rLEbZ1b9NsriuRqytPQhGbxvErVfKPpzHyr4wMioSSFFxJ7yon/6n/+tzubP5K/1OM6tAZhAcn/5yajL0cmMk7AnCKp4Q+f5s49Rj34jHIJMMs0WvjxSudDPHhqo35dNpupu+U5Taw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713212; c=relaxed/simple;
	bh=DSe6Do3yRD5RjsX5+7VQ3gV/BN04GCRfQAFf2h8J8lM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i2ZZw9SGRZOQg+Js4NqBYm10/hXZquiiBMAobhPjpiKlxU2xVSytv3zriVxVFbcnBSpTiAmY+7TIKAeJT50g6cZeU/V8XB/hb8nYDbc+3IHLYyeZVuXqD2kJEr8sliXr9nw8kaT7A6o9VMSTyvvKTiVB1JCNNCwJGDnzux5vxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYprbOiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79ECBC4CEE7;
	Wed, 20 Aug 2025 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755713212;
	bh=DSe6Do3yRD5RjsX5+7VQ3gV/BN04GCRfQAFf2h8J8lM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kYprbOiYxXRPhuOn9FvPbn3VITR0+P+3GYxnU75axZq7LKRbswQRREnItxuPa8m4C
	 r+wkRvEnfktyYP7wfH3AVZufPWOEWSPCMVUoXnsuNlzk9vEbxrZRkc6aIRpRgJM87w
	 4YUOOZPFM9Uw8RxNCeeZ2oYdW8suIbAMRyzsoHAJhNlrDdsnXsaKUhLwu55y87j5hL
	 Q/xM6QvQ2qJAOsapa7EfXIGrx3CgwCOVUkJx2hXlugC8dLQvaYZG5djlTRiKNZyU0H
	 l9ome5U2oaXeVfkYr78OcpaR1zwQW4ZNG784zv8qkn7aK6tarQJDy4pygJEenSzwoW
	 9CeC0NC8JlPOw==
Date: Wed, 20 Aug 2025 13:06:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Replace msleep(2) with usleep_range() for precise
 delay
Message-ID: <20250820180651.GA631082@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820160944.489061-1-18255117159@163.com>

On Thu, Aug 21, 2025 at 12:09:44AM +0800, Hans Zhang wrote:
> The msleep(2) may sleep up to 20ms due to timer granularity, which can
> cause unnecessary delays. According to PCI spec v3.0 7.6.4.2, the minimum
> Trst is 1ms and we doubled that to 2ms to meet the requirement. Using
> usleep_range(2000, 2001) provides a more precise delay of exactly 2ms.
> ...

Please cite a recent spec version, i.e., r7.0.  I see this probably
came from the comment at the change; I wouldn't object to updating
the comment, too.

> WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
> #4630: FILE: drivers/pci/pci.c:4630:
> +		msleep(1);
> ...
> WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
> #3970: FILE: drivers/pci/quirks.c:3970:
> +		msleep(10);

> +++ b/drivers/pci/pci.c
> @@ -4967,7 +4967,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>  	 * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
>  	 * this to 2ms to ensure that we meet the minimum requirement.
>  	 */
> -	msleep(2);
> +	usleep_range(2000, 2001);

IMO the most valuable thing here would be to replace the hard-coded
"2" with some kind of #define explicitly tied to the spec.  Similarly
for the other cases.

There is some concern [1] about places that say "msleep(1)" but
actually rely on the current behavior of a longer sleep.

Apart from that concern, I think fsleep() would be my first choice.
usleep_range(x, x+1) defeats the purpose of the range, which is to
reduce interrupts; see 5e7f5a178bba ("timer: Added usleep_range
timer").

Bjorn

[1] https://lore.kernel.org/all/20070809001640.ec2f3bfb.akpm@linux-foundation.org/

