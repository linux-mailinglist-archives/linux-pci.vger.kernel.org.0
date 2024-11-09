Return-Path: <linux-pci+bounces-16375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A39C2EF9
	for <lists+linux-pci@lfdr.de>; Sat,  9 Nov 2024 18:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB641C20BB1
	for <lists+linux-pci@lfdr.de>; Sat,  9 Nov 2024 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E868619D08A;
	Sat,  9 Nov 2024 17:53:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542C8145A16;
	Sat,  9 Nov 2024 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731174780; cv=none; b=fOCCshMeGhZAPqJmusEWXll5D9Lr9AddpgRlaOXaJeMLzIlJuRBd2H32bdSEwx2zPR/X5B5o6jAJXSbZhsfAcuPuhJWZs1aavqvMOOG6IgHjy4OIcQ1d1cp6fFdlJO20Z2Du8TnNzA4W9U+7sLaWWWLS3r4g/5LfHyvD7ZWIeH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731174780; c=relaxed/simple;
	bh=8XAejHONwBv8Djr5AYLz5T89/opOHAwxD+hHigv5kIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtyLHHigV3Q66dDK8WIkKl1Tmwrkep29Tl3PwK29vqD2klLf0ik3UH+6LoZ9UfLcDr6gRvm21IeV1Qf4uIM+xbjTVRo3HWmREsoYaXzxSQ8zatpMd75G2BnryVYA7T6sbOiNmNWbDwEsKF2ScKTfhCdsu67OtI3J0r5vzeTwRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id A8DF8300000A1;
	Sat,  9 Nov 2024 18:52:47 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8234018F614; Sat,  9 Nov 2024 18:52:47 +0100 (CET)
Date: Sat, 9 Nov 2024 18:52:47 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, bhelgaas@google.com,
	tony.luck@intel.com, bp@alien8.de
Subject: Re: [RFC PATCH] PCI: pciehp: Generate a RAS tracepoint for hotplug
 event
Message-ID: <Zy-hbwLohwf-_hCN@wunner.de>
References: <20241108030939.75354-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108030939.75354-1-xueshuai@linux.alibaba.com>

On Fri, Nov 08, 2024 at 11:09:39AM +0800, Shuai Xue wrote:
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -19,6 +19,7 @@
>  #include <linux/types.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci.h>
> +#include <ras/ras_event.h>
>  #include "pciehp.h"

Hm, why does the TRACE_EVENT() definition have to live in ras_event.h?
Why not, say, in pciehp.h?


> @@ -245,6 +246,8 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  		if (events & PCI_EXP_SLTSTA_PDC)
>  			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>  				  slot_name(ctrl));
> +		trace_pciehp_event(dev_name(&ctrl->pcie->port->dev),
> +				   slot_name(ctrl), ON_STATE, events);
>  		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
>  		break;
>  	default:

I'd suggest using pci_name() instead of dev_name() as it's a little shorter.

Passing ON_STATE here isn't always accurate because there's
"case BLINKINGOFF_STATE" with a fallthrough preceding the
above code block.

Wouldn't it be more readable to just log the event that occured
as a string, e.g. "Surprise Removal" (and "Insertion" or "Hot Add"
for the other trace event you're introducing) instead of the state?

Otherwise you see "ON_STATE" in the log but that's actually the
*old* value so you have to mentally convert this to "previously ON,
so now must be transitioning to OFF".

I'm fine with adding trace points to pciehp, I just want to make sure
we do it in a way that's easy to parse for admins.

Thanks,

Lukas

