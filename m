Return-Path: <linux-pci+bounces-32963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68668B1299E
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 09:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EF13B226E
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 07:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD62219311;
	Sat, 26 Jul 2025 07:52:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F7C322E;
	Sat, 26 Jul 2025 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753516331; cv=none; b=iI3d0Io8ciNkDlS0b49C1TcoxnetNcPqp1LXhp9CDlAm+EV1Ts/QmZdT7MC4j+dVIjw5VRfBPBABZFhm9GUk3tvHDTrk/476cGIvLUsrhm2SdcDh249riNHGwx+zrXtTe9pTL+hIALjGwXNm3e7lygF03B44OqrP9oSD73fUEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753516331; c=relaxed/simple;
	bh=kzxF4i8cuPpT5a8MZcrFAX+gW/2sJgQUQnWd7w2NFj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xfj6GWLyowZpiquZ3o8ICqDa/Mf6TAn6IKjMxNBqdtTZ2rTVAzIXt2Plsj+ZYkhXRLADsj/1EnJrggA9iPC8i+SgQfOaTX8k8Dk23AbRQ9YSN9Hl1RCpkHuIdUTIIO9F2tlON2e+jYimMs13hWlt0fEkcracnJC0CQXiwg1d6W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 062F72012A14;
	Sat, 26 Jul 2025 09:51:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DCBCF2EBF0F; Sat, 26 Jul 2025 09:51:58 +0200 (CEST)
Date: Sat, 26 Jul 2025 09:51:58 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, rostedt@goodmis.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
	Jonathan.Cameron@huawei.com, bhelgaas@google.com,
	tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
	davem@davemloft.net, anil.s.keshavamurthy@intel.com,
	mark.rutland@arm.com, peterz@infradead.org,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
Message-ID: <aISJHjFrHkxVNFzJ@wunner.de>
References: <20250723033108.61587-3-xueshuai@linux.alibaba.com>
 <20250725210921.GA3131414@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725210921.GA3131414@bhelgaas>

On Fri, Jul 25, 2025 at 04:09:21PM -0500, Bjorn Helgaas wrote:
> > @@ -319,8 +319,7 @@ int pciehp_check_link_status(struct controller *ctrl)
> >  		return -1;
> >  	}
> >  
> > -	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &linksta2);
> > -	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status, linksta2);
> > +	pcie_update_link_speed(ctrl->pcie->port->subordinate, PCIE_HOTPLUG);
> 
> It kind of bugs me that the hot-add flow reads LNKSTA three times and
> generates both pci_hp_event LINK_UP and link_event tracepoints:
> 
>   pciehp_handle_presence_or_link_change
>     link_active = pciehp_check_link_active()
>       pcie_capability_read_word(PCI_EXP_LNKSTA)
>     if (link_active)
>       ctrl_info(ctrl, "Slot(%s): Link Up\n")

This LNKSTA read decides whether to bring up the slot.
It can't be eliminated.

>       trace_pci_hp_event(PCI_HOTPLUG_LINK_UP)
>       pciehp_enable_slot
>         __pciehp_enable_slot
>           board_added
>             pciehp_check_link_status
>               pcie_capability_read_word(PCI_EXP_LNKSTA)

This is sort of a final check whether the link is (still) active
before commencing device enumeration.  Doesn't look like it can
safely be eliminated either.

>               pcie_update_link_speed
>                 pcie_capability_read_word(PCI_EXP_LNKSTA)
>                 pcie_capability_read_word(PCI_EXP_LNKSTA2)
>                 trace_pcie_link_event(<REASON>)

This third register read is introduced by the present patch and is
indeed somewhat a step back, given that pciehp_check_link_status()
currently deliberately calls __pcie_update_link_speed() to pass
the already read LNKSTA value.

I'm wondering if the tracepoint can be moved down to
__pcie_update_link_speed()?

> And maybe we need both a bare LINK_UP event and a link_event with all
> the details, but again it seems a little weird to me that there are
> two tracepoints when there's really only one event and we know all the
> link_event information from the very first LNKSTA read.

One of the reasons is that a "Link Down" event would have to
contain dummy values for link speed etc, so it seemed cleaner
to separate the hotplug event from the link speed event.

Thanks,

Lukas

