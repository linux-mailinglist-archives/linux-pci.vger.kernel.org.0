Return-Path: <linux-pci+bounces-6144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AA38A1D91
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 20:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7F11F24F9C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABC81E6F59;
	Thu, 11 Apr 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X3PZmVnt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE041E6F55;
	Thu, 11 Apr 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855602; cv=none; b=RM5cW9wc/Dczpj8wDDwDKe37R8Aj4jwE4SNFsw4+2fgl7Fm85Hpy4M/yCrDr0of5ZdP3C+OJW951IM02/VjSTRdDJM6w0W/txZIzXDbEcDGdKBV35tTfwN9usIvXYNP8Fug+CVZp9e/9wS7cynmTisN6qj8cRpuac4xdtzzqp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855602; c=relaxed/simple;
	bh=DZtpAvlGXWc3UPqcPGt/VFrqNxfRdP36OOZBC2N7nfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOGU2dsqqsmVrRcXm6FIfNttajkv57BtzM908q0kk04Oe/dyEYsyMKT9fo5DthRlxuK4vR1PhDEsqVt8xv2HVLBb8pIR9WFPkAgpmvAWAX4oyiXXJHi+9jW04tYZpR1vor5EYsvofYgP9Xj0/pTkhUiCn+TaIn0qHoqLfodF6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X3PZmVnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC37CC072AA;
	Thu, 11 Apr 2024 17:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712855602;
	bh=DZtpAvlGXWc3UPqcPGt/VFrqNxfRdP36OOZBC2N7nfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3PZmVntVNMAGr14zrnb3A3tYsuHkz5/tkL+uyw4sSIuZTo95cuo2FdtG0Gx2Dvlx
	 yKKWgVGnMO5NwEAX8wcKm5s74XEdMhEW6X7hdgHpREnE8pFR829iY0hppAI4veG+Dn
	 dfz22DK8z93LV4/40btwxU3hPW09/un6RJ5VX36Y=
Date: Thu, 11 Apr 2024 19:13:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH 1/2] serial: exar: add missing CTI/Exar PCI IDs to
 include/linux/pci_ids.h
Message-ID: <2024041153-railing-recast-c4f2@gregkh>
References: <cover.1712846025.git.pnewman@connecttech.com>
 <936439b200c810f83076a710eab81acd1e79ec83.1712846025.git.pnewman@connecttech.com>
 <2024041124-blah-obligate-5f6d@gregkh>
 <20240411122248.5070c840@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411122248.5070c840@SWDEV2.connecttech.local>

On Thu, Apr 11, 2024 at 12:22:48PM -0400, Parker Newman wrote:
> On Thu, 11 Apr 2024 17:54:45 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Apr 11, 2024 at 11:29:26AM -0400, parker@finest.io wrote:
> > > From: Parker Newman <pnewman@connecttech.com>
> > >
> > > - Added missing CTI serial car PCI IDs
> > > - Added missing Exar XR17V25X PCI IDs
> > > - Moved XR17V4358 and XR17V8358 PCI ID defines to pci_ids.h
> >
> > Did you read the top of the pci_ids.h file?  Don't add new ids there
> > unless it is going to be needed in multiple files please.
> >
> > thanks,
> >
> > greg k-h
> No sorry I missed that... I was just trying to consolidate them all
> in one place.
> 
> Would it be better to move all the Connect Tech sub-IDs from
> pci_ids.h into 8250_exar.c? Or should I just add the missing ones
> to 8250_exar.c instead of pci_ids.h?

Just add the missing ones if you don't want to touch the pci_ids.h file,
that way it's a simpler change.

thanks,

greg k-h

