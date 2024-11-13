Return-Path: <linux-pci+bounces-16619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC8B9C6840
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 05:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B091F235A9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 04:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AF61632D6;
	Wed, 13 Nov 2024 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sb/sTOv1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842317C;
	Wed, 13 Nov 2024 04:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731473641; cv=none; b=fwG+xM0T3f5rnoGErgAH9XHlEMj7zRRHXQsr2a/hR7O/E45rozb1Bomxnow6A/YvIWhcVKrI3WIGKGwe4afYWIPG+Epn/XQaVyW/JV9ov1/BQkiP2usmpKYpvNebdQ19Iww2jdGrNM1UWHxgrLhQqt9MK0zk8350fvIUDO1PAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731473641; c=relaxed/simple;
	bh=50M8QyqvOiLw79dnp44grtDclTZpf9Y9sZZSQA62YSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5bN6iJC4qPjoHjrQf7ySncaNm5cL7N9HPbHXhZkeNHvKE7pS8PcKUIvgF101R93lPSnBs/fjw8Z+bYPNtp1n3cnsNC9oJdyfpm4FQQcE6kU2CG6ANFGRVTPKnJRCW5Z/NbFmARzoyJ9p1K5MJwvGR4Qg3zENpOTEVVwTS2HpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sb/sTOv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A17C4CECD;
	Wed, 13 Nov 2024 04:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731473640;
	bh=50M8QyqvOiLw79dnp44grtDclTZpf9Y9sZZSQA62YSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sb/sTOv11bIdc2j5hYDgQB8ShAm2DtsH5/vco8Se/htf0iF233FBceinpvAMpYN53
	 W9L1r0jD7wst354HKtWKoPVZJa8UAi1WQm+puU3fUc6OfykRdY1uXPD3oPSM/axQBX
	 FlQDt4GTc1uZOV1ME8XTJBHJQLwq3SlWfoihaWic=
Date: Wed, 13 Nov 2024 05:53:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] usb: cdns3: Synchronise PCI IDs via common data
 base
Message-ID: <2024111345-recall-party-e801@gregkh>
References: <20241112160125.2340972-1-andriy.shevchenko@linux.intel.com>
 <20241112212447.GA1861184@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112212447.GA1861184@bhelgaas>

On Tue, Nov 12, 2024 at 03:24:47PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 12, 2024 at 06:01:25PM +0200, Andy Shevchenko wrote:
> > There are a few places in the kernel where PCI IDs for different Cadence
> > USB controllers are being used. Besides different naming, they duplicate
> > each other. Make this all in order by providing common definitions via
> > PCI IDs database and use in all users. While doing that, rename
> > definitions as Roger suggested.
> > 
> > Suggested-by: Roger Quadros <rogerq@kernel.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Looks like maybe something for the USB tree?

Sure, I'll take it, thanks!

greg k-h

