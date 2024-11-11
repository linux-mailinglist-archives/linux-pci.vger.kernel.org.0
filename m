Return-Path: <linux-pci+bounces-16443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FAE9C3EB9
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 13:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F71C282763
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0B11850AF;
	Mon, 11 Nov 2024 12:50:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC4315687C;
	Mon, 11 Nov 2024 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329440; cv=none; b=YzLtYXG+PYkCyMuQXM6K3qr03+K2dtA2GNPJq3XU/v1316DmK8nIpOSIPHZEODJd9ISg3yGRAaa2JgBmbl4Xhd9HBCv6sax6mpFljkw7ApH296zpE5hKNCsj98LxNKPjwuhlqFxT++q+fLpqP2iJv4wM8awaPQ7afHgceQ+JPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329440; c=relaxed/simple;
	bh=xuyTolcM5oeWzulx8gokCjIjisBFJI73ZxzAkg9MKi4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q4bXWKdikPJvSHFot5SAw4jMSYZdhu5Mtjk7X2HD8Yq5kxA94tUD3Dvt6lYHQlCeoI9nzqX5HF3GmkOo+9++eCROzs2b3Ds+Y2KEPcpv80jOqAL1XQuDBBRcTMrToFUDT8PHzkCEJ6H6FQbkf5Dtexv5TMrlxZQET2ywzwic7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9454292009C; Mon, 11 Nov 2024 13:50:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8E13592009B;
	Mon, 11 Nov 2024 12:50:34 +0000 (GMT)
Date: Mon, 11 Nov 2024 12:50:34 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, 
    Jinhui Guo <guojinhui.liam@bytedance.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC] PCI: Fix the issue of link speed downgrade after link
 retraining
In-Reply-To: <Zy3x_QK0vZHOFZvF@wunner.de>
Message-ID: <alpine.DEB.2.21.2411110503410.9262@angie.orcam.me.uk>
References: <20241107143758.12643-1-guojinhui.liam@bytedance.com> <20241107153438.GA1614749@bhelgaas> <Zy3x_QK0vZHOFZvF@wunner.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 8 Nov 2024, Lukas Wunner wrote:

> > > Some printing information can be obtained when the issue emerges.
> > > "Card present" is reported twice via external interrupts due to
> > > a slight tremor when the Samsung NVMe device is plugged in.

 What do you mean by "a slight tremor"?  Do the devices involved fail to 
negotiate link in the time prescribed by the PCIe specification?  Why is 
the interrupt sent twice?

> > > To avoid wrongly setting the link speed to 2.5GT/s, only allow
> > > specific pcie devices to perform link retrain.
> 
> With which kernel version are you seeing this?
> 
> A set of fixes for the 2.5GT/s retraining feature appeared in v6.12-rc1,
> specifically f68dea13405c ("PCI: Revert to the original speed after PCIe
> failed link retraining").
> 
> Have you tested whether the latest v6.12 rc is still affected?

 Thanks for chiming in.  I do hope the fixes will have addressed issues 
like one concerned here.

 NB I have been fully booked recently due to an upcoming patch submission 
deadline and will continue to be throughout this week, so I may be slow to 
response.

  Maciej

