Return-Path: <linux-pci+bounces-7837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D2C8CFC31
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 10:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A271F22C5E
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911260DCF;
	Mon, 27 May 2024 08:51:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D64200A9;
	Mon, 27 May 2024 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799860; cv=none; b=sJ1Bd0FLg72Hjf3ERwvMUaFWL6crWeMiLX1WzFYTWLybZJBJ01S4AbZ93szxAtShX+kj3mTGbNJI8XLL+FeNZ2huVCXRjtYXntxZRFffXhceK6Q8S2Ky3QR2VOmp/TrtG8Zl5PmGx8RSyt+V9V5cbiKr05yFZ/EP0QWPUknqbBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799860; c=relaxed/simple;
	bh=qXqUDFPMgEqJdlRNZ8WO6HftsW7XpxjeTbHSU5QdQeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAURNfnaFvWXEfsPYDg7/pHX3Jd7lSwWqS+CEOq9uPcserc2w0fDqyPPTqPK9DtfR6xewJyqcnDtt2x0vhaFN1H62+PFmTQEwnuPrjeOygtgu6BK/T9Cs9bRifVf1uKP3liqUunp9FLXNvjUGSuP8JTEQJclFp/CScA7dIIQisE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4B04E100DE9DE;
	Mon, 27 May 2024 10:50:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 196C65194CF; Mon, 27 May 2024 10:50:48 +0200 (CEST)
Date: Mon, 27 May 2024 10:50:48 +0200
From: Lukas Wunner <lukas@wunner.de>
To: yaoma <yaoma@linux.alibaba.com>
Cc: bhelgaas@google.com, weirongguang@kylinos.cn, kanie@linux.alibaba.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Use appropriate conditions to check the
 hotplug controller status
Message-ID: <ZlRJaEEGEMsyxXqm@wunner.de>
References: <20240524063023.77148-1-yaoma@linux.alibaba.com>
 <ZlBHjbmjjSEnXCMp@wunner.de>
 <7855600C-4BB6-417B-8F91-24F4F7E0820E@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7855600C-4BB6-417B-8F91-24F4F7E0820E@linux.alibaba.com>

On Sun, May 26, 2024 at 10:45:36PM +0800, yaoma wrote:
> > 2024 5 24 15:53 Lukas Wunner <lukas@wunner.de>
> > On Fri, May 24, 2024 at 02:30:23PM +0800, Bitao Hu wrote:
> > > The values of 'present' and 'link_active' have similar meanings:
> > > the value is %1 if the status is ready, and %0 if it is not. If the
> > > hotplug controller itself is not available, the value should be
> > > %-ENODEV. However, both %1 and %-ENODEV are considered true, which
> > > obviously does not meet expectations. 'Slot(xx): Card present' and
> > > 'Slot(xx): Link Up' should only be output when the value is %1.
> > [...]
> > > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > > @@ -276,10 +276,10 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
> > > 	case OFF_STATE:
> > > 		ctrl->state = POWERON_STATE;
> > > 		mutex_unlock(&ctrl->state_lock);
> > > -		if (present)
> > > +		if (present > 0)
> > > 			ctrl_info(ctrl, "Slot(%s): Card present\n",
> > > 				  slot_name(ctrl));
> > > -		if (link_active)
> > > +		if (link_active > 0)
> > > 			ctrl_info(ctrl, "Slot(%s): Link Up\n",
> > > 				  slot_name(ctrl));
> > > 		ctrl->request_result = pciehp_enable_slot(ctrl);
> > 
> > We already handle the "<= 0" case immediately above this code excerpt:
> > 
> > 	if (present <= 0 && link_active <= 0) {
> > 	...
> > 	}
> 
> I'm not sure if the following scenarios would occur in actual production
> environment, but from the code level, there is the possibility of
> "present <= 0 && link_active > 0" or "present > 0 && link_active <= 0".
> In these cases, the "<= 0" conditions will not be properly handled,
> and "ctrl_info" will output incorrect prompt messages.

I see, that makes sense.

"present" and "link_active" can be -ENODEV if reading the config space
of the hotplug port failed.  That's typically the case if the hotplug
port itself was hot-removed, which happens all the time with
Thunderbolt/USB4.

E.g. pciehp_card_present() may return 1 and pciehp_check_link_active()
may return -ENODEV because the hotplug port was hot-removed in-between
the two function calls.  In that case we'll emit both "Card present"
*and* "Link Up".  The latter is uncalled for and is supressed by your
patch.

So your code change is
Reviewed-by: Lukas Wunner <lukas@wunner.de>

...but it would be good if you could respin the patch and explain the
rationale of the code change in the commit message more clearly.
Basically summarize what you and I have explained above.

Also, the percent sign % in front of 0, 1, -ENODEV is unnecessary in
commit messages. It only has special meaning in kernel-doc.

Thanks,

Lukas

