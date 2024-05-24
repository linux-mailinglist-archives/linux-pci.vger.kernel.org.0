Return-Path: <linux-pci+bounces-7808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A1E8CE1E8
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 10:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EF61C215FB
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976BD7F496;
	Fri, 24 May 2024 08:01:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3811617578;
	Fri, 24 May 2024 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716537660; cv=none; b=rjcNAfFW+Jn3bRy92IOpUE2JygG+Fil91RAsU4tzMH8Vytm2x1aIRYiXA2IYvJaezQ3zD2LXj4qa2ZXkJdgBauPtLKdt71NdfMS78qLZ0RnUhvERK2Zb1zzTZXvbQO3ZypMzoi2u5qaaT+nph0hSb+EEChYJ3SD3siCduInEjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716537660; c=relaxed/simple;
	bh=DNGZeOxYDqy7RtdurPwzY4rLHbt20lsCtA68JHLwjSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY8g2QaYI5oOyrnHFOaar4LNCtUBHP40z3fPrfuhTKYOpLaTRCHHfyQe59s245Gb8OuceWi1VnJsAzu2kMBrI0atlSt0XaB65irkaHlQkJe4Oa6/oFyCrltMN8Im4bNEw57f985eZnEmKQ2pjOgNFTDk/GC0zQAPvfp2cghQ1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 87F7E100FC2B8;
	Fri, 24 May 2024 09:53:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 37AB2541E49; Fri, 24 May 2024 09:53:49 +0200 (CEST)
Date: Fri, 24 May 2024 09:53:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: bhelgaas@google.com, weirongguang@kylinos.cn, kanie@linux.alibaba.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Use appropriate conditions to check the
 hotplug controller status
Message-ID: <ZlBHjbmjjSEnXCMp@wunner.de>
References: <20240524063023.77148-1-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524063023.77148-1-yaoma@linux.alibaba.com>

On Fri, May 24, 2024 at 02:30:23PM +0800, Bitao Hu wrote:
> The values of 'present' and 'link_active' have similar meanings:
> the value is %1 if the status is ready, and %0 if it is not. If the
> hotplug controller itself is not available, the value should be
> %-ENODEV. However, both %1 and %-ENODEV are considered true, which
> obviously does not meet expectations. 'Slot(xx): Card present' and
> 'Slot(xx): Link Up' should only be output when the value is %1.
[...]
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -276,10 +276,10 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	case OFF_STATE:
>  		ctrl->state = POWERON_STATE;
>  		mutex_unlock(&ctrl->state_lock);
> -		if (present)
> +		if (present > 0)
>  			ctrl_info(ctrl, "Slot(%s): Card present\n",
>  				  slot_name(ctrl));
> -		if (link_active)
> +		if (link_active > 0)
>  			ctrl_info(ctrl, "Slot(%s): Link Up\n",
>  				  slot_name(ctrl));
>  		ctrl->request_result = pciehp_enable_slot(ctrl);

We already handle the "<= 0" case immediately above this code excerpt:

	if (present <= 0 && link_active <= 0) {
	...
	}

So neither "present" nor "link_active" can be < 0 at this point.

Hence I don't quite understand what motivates the proposed code change?

Thanks,

Lukas

