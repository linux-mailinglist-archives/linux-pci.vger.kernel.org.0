Return-Path: <linux-pci+bounces-23146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D287A5723E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 20:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D697ABE09
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F6D253330;
	Fri,  7 Mar 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4EAmMZQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414ED24DFEF
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376492; cv=none; b=a/HUjp6jU7SqvgPvN0wnPN4bWmlA3h6a57Xs3vMC+A0EPeMrVBXvNhiDdh8VK9aPnK+V/0ELi6OFkBTb1IRRmC0vLtNOdurDmgkkusCL/bAA4aDYbSfDSwRNrfUn3K6vgFRRip8ETkm3zrn4UwmC8tHN1sgCmLSj9Vc5ExgPsxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376492; c=relaxed/simple;
	bh=xOC4u6t1ZU43ufUN9LyYGDC5Sn8ns7W/DvgAZTjLIyo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MUm5hVAQYy2TBpAOrCC34cBv/Hn3W5EherplRBj+Ol/qCQf8UdU+pt9L+aLfmHHFi92mQg2hFLftbKY/VQCmPieu7qdukyA6sN3l1mY1le0qOgBypomt9R+9k7HNhQWOZ7GffNKYjoTpiRz/HRrIRFli9fR+pCji/C005qHXSrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4EAmMZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DA2C4CED1;
	Fri,  7 Mar 2025 19:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741376491;
	bh=xOC4u6t1ZU43ufUN9LyYGDC5Sn8ns7W/DvgAZTjLIyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=R4EAmMZQoEHl6zqAlx5RDewrBHPSHZhG3eu3t3Qbsn8B8xmKCdtBBQnMpwM/tAlh0
	 +WMH9Zsci8eB522/qxmTs7ns7pxW1MABsteQGjWs8CBnSqbYstko6IpmkHj7PufMKd
	 ZrtmImyGSGi9cbWr3JjQRt1EIFSblqjN/iz0LQksEzNEJfT37Dyn1qXfpW9Kuqnb4R
	 /gyrkcQjtaXiGDKPQOW+sH8SUKPr7vA6D9loAoTUy0dWgqB+OavH0cjk/tGkMmSsFf
	 9VrL8YcHN8s46ToxtP62eTwhMfuCxq5CgW9z4eCizUJKUMkvVj/I6M0Oe/aG6SOWAg
	 rtNLyvtwag0pw==
Date: Fri, 7 Mar 2025 13:41:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 7/8] PCI/AER: Add AER sysfs attributes for log
 ratelimits
Message-ID: <20250307194130.GA420442@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <037da68f-791a-4f04-a39c-0fde3dac5704@oracle.com>

On Fri, Mar 07, 2025 at 01:10:33PM +0100, Karolina Stolarek wrote:
> On 04/03/2025 01:58, Jon Pan-Doh wrote:
> > On Mon, Mar 3, 2025 at 12:31 AM Karolina Stolarek
> > <karolina.stolarek@oracle.com> wrote:
> > > In my opinion, we want them to be separate. We may want to see no logs
> > > of errors but still have them recorded in rasdaemon, for example.
> > 
> > Understood. So the sysfs toggles could be something like:
> > 
> > aer/ratelimit_log_enable
> > aer/ratelimit_irq_enable (with default = off)
> > 
> > This assumes that IRQ ratelimiting part is able to be merged.
> 
> Sounds good to me
> 
> > FYI, the current implementation ratelimits for both logs and trace
> > events, but increments AER counters. If there's a scenario where you'd
> > want no logs but have trace events sent, then we may need another
> > ratelimit and/or roll that into IRQ ratelimiting (to avoid trace
> > buffer/userspace agent getting inundated with events). Granted, there
> > is probably a higher tolerance for spam there than in console logs.
> 
> Right, I see what you mean. I think we would like to still trace them, at
> least that's what I got from the conversation I had with Jonathan[1]. It
> would be good to agree on the final solution here.

I agree; I don't think we have a need to rate limit trace events.

If we get inundated by trace events, I suspect the solution will be to
turn off the interrupt and poll periodically.

> --------------------------------------------------------------------
> [1] - https://lore.kernel.org/linux-pci/20241216104424.00000fab@huawei.com/

