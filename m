Return-Path: <linux-pci+bounces-8852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 129AE909301
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 21:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA9C1F23571
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7049D15B562;
	Fri, 14 Jun 2024 19:37:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943731F946;
	Fri, 14 Jun 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718393828; cv=none; b=G9Qh6Tuoerb2j5BNzksFyjKEUtlyXPzkqh487lzIcy706VGkDgCmGii65pUvD8wEqs0jStPCyZxxPEVUSWIWp+oG4uU4dyCBW+Snl7jPNzogZ5DO6b1uJdjS3dx25tsYtnnWgdj/IXC+KLi5oE6syk82MQxCEY3MnIG8a8t0qsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718393828; c=relaxed/simple;
	bh=Gc/dYo30ou/yoPeuq9iJSaYcgjGlV7uJIRDgzrfZsxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9n9n/Vdq4EZhFC0HJBtyEmLn0mftraOKQ90/A7ktUwMz9RvdBs585v3V8JRgsyVjLBq1/bzZ59z+CRaRMPcXxM0C8XpeAb8eOHE5kDBIPCUJTdNeCkGws1OSS1XoMwVo2ISH9zeHkiaSaAA6s3bfnb1BIC/JZvnfeniz/+fRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id BD82C3000E431;
	Fri, 14 Jun 2024 21:36:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9D64219DDD1; Fri, 14 Jun 2024 21:36:57 +0200 (CEST)
Date: Fri, 14 Jun 2024 21:36:57 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bitao Hu <yaoma@linux.alibaba.com>, bhelgaas@google.com,
	weirongguang@kylinos.cn, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kanie@linux.alibaba.com,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCHv2] PCI: pciehp: Use appropriate conditions to check the
 hotplug controller status
Message-ID: <Zmyb2WMhhNc7zQ2i@wunner.de>
References: <20240528064200.87762-1-yaoma@linux.alibaba.com>
 <20240614184120.GA1121063@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614184120.GA1121063@bhelgaas>

On Fri, Jun 14, 2024 at 01:41:20PM -0500, Bjorn Helgaas wrote:
> On Tue, May 28, 2024 at 02:42:00PM +0800, Bitao Hu wrote:
> > "present" and "link_active" can be 1 if the status is ready, and 0 if
> > it is not. Both of them can be -ENODEV if reading the config space
> > of the hotplug port failed. That's typically the case if the hotplug
> > port itself was hot-removed. Therefore, this situation can occur:
> > pciehp_card_present() may return 1 and pciehp_check_link_active()
> > may return -ENODEV because the hotplug port was hot-removed in-between
> > the two function calls. In that case we'll emit both "Card present"
> > *and* "Link Up" since both 1 and -ENODEV are considered "true". This
> > is not the expected behavior. Those messages should be emited when
> > "present" and "link_active" are positive.
[...]
> > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > @@ -276,10 +276,10 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
> >  	case OFF_STATE:
> >  		ctrl->state = POWERON_STATE;
> >  		mutex_unlock(&ctrl->state_lock);
> > -		if (present)
> > +		if (present > 0)
> 
> I completely agree that this is a problem and this patch addresses it.
> But ...
> 
> It seems a little bit weird to me that we even get to this switch
> statement if we got -ENODEV from either pciehp_card_present() or
> pciehp_check_link_active().  If that happens, a config read failed,
> but we're going to go ahead and call pciehp_enable_slot(), which is
> going to do a bunch more config accesses, potentially try to power up
> the slot, etc.
> 
> If a config read failed, it seems like we might want to avoid doing
> some of this stuff.

Hm, good point.  I guess we should change the logical expression instead:

-	if (present <= 0 && link_active <= 0) {
+	if (present < 0 || link_active < 0 || (!present && !link_active)) {


> > -		if (link_active)
> > +		if (link_active > 0)
> >  			ctrl_info(ctrl, "Slot(%s): Link Up\n",
> >  				  slot_name(ctrl));
> 
> These are cases where we misinterpreted -ENODEV as "device is present"
> or "link is active".
> 
> pciehp_ignore_dpc_link_change() and pciehp_slot_reset() also call
> pciehp_check_link_active(), and I think they also interpret -ENODEV as
> "link is active".
> 
> Do we need similar changes there?

Another good observation, both need to check for <= 0 instead of == 0.
Do you want to fix that yourself or would you prefer me (or someone else)
to submit a patch?

Thanks,

Lukas

