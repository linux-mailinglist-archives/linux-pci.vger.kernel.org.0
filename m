Return-Path: <linux-pci+bounces-40133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7A7C2D7C1
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 18:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A214834A419
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 17:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2341631281F;
	Mon,  3 Nov 2025 17:34:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10854302776;
	Mon,  3 Nov 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191252; cv=none; b=SsVyGOilAUNsUsx9T6A6uSA3Y0MZuLTeCdqXrUDJNPceIdlW/gSPtYACgTXLSZXPYRLIdXg/+QWwz1TW6MRagV0QIi+1VY+1BCzNT3Lm80CY4gA/TToKAWC3SDRu1Etx04+euSGGy8i3Tk6v18BwjRX5AnNSPzmbpGoNxUZRgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191252; c=relaxed/simple;
	bh=EeNYtgR1toDC3fdjLxxuBK0lqNQOk8UkqKfeoB/1HXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDOdqNretieYq2dE48NMaPb3b6uy+DDOve8IhsoxVJ8LVVSaj5QeslfN3JtAxaiMOCXJUGdO1YWgw116/vzn9NaCjdWAd3iFH5xBLdX9dKeoZxOJ1QIs17IkLdBobQj+LoglAmEt6c9QKBO1MgOobOmcKCvyirkjsNcvoDuNAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id E01D82C02B9C;
	Mon,  3 Nov 2025 18:24:08 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id ABEC2AEC9; Mon,  3 Nov 2025 18:24:08 +0100 (CET)
Date: Mon, 3 Nov 2025 18:24:08 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] PCI: pciehp: Add macros for hotplug operation
 delays
Message-ID: <aQjlOHJoj-Fkkk4b@wunner.de>
References: <20251101160538.10055-4-18255117159@163.com>
 <20251103153734.GA1806239@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103153734.GA1806239@bhelgaas>

On Mon, Nov 03, 2025 at 09:37:34AM -0600, Bjorn Helgaas wrote:
> On Sun, Nov 02, 2025 at 12:05:37AM +0800, Hans Zhang wrote:
> > Add WAIT_PDS_TIMEOUT_MS and POLL_CMD_TIMEOUT_MS macros for hotplug
> > operation delays to improve code readability.
[...]
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -28,6 +28,9 @@
> >  #include "../pci.h"
> >  #include "pciehp.h"
> >  
> > +#define WAIT_PDS_TIMEOUT_MS	10
> > +#define POLL_CMD_TIMEOUT_MS	10
> > +
> >  static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
> >  	/*
> >  	 * Match all Dell systems, as some Dell systems have inband
> > @@ -103,7 +106,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
> >  			smp_mb();
> >  			return 1;
> >  		}
> > -		msleep(10);
> > +		msleep(POLL_CMD_TIMEOUT_MS);
> 
> Lukas might have different opinions and I would defer to him here.
> 
> But IMO (a) these aren't timeouts, they are poll intervals, (b) the
> values are arbitrary with no connection to a spec, so less reason for
> a #define, and (c) the #defines don't improve readability because now
> I have to look at two places to understand the poll loops.

I agree on all counts.

Thanks,

Lukas

