Return-Path: <linux-pci+bounces-19974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495EA13D10
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 16:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FC03A05A4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1821222A7F2;
	Thu, 16 Jan 2025 15:00:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6080E5336E;
	Thu, 16 Jan 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039639; cv=none; b=AyWDrQe/b/8sgkGPsaUl5833/mVPQTvrzroqYIAdLu6YUYOND/UNJF50aB22cIP8VQDkbUgAD2Llk12JS8R8JRu1p1KX+H1RCXU4JbsSC86mfXqyIxh/JuQJtUd+X/LfMD+e9hZja6GEiJD+1cbXXzkTcXMHNF8vAX6VNiLsn2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039639; c=relaxed/simple;
	bh=NVOlZzzhzUOAW7q5O1+OgND6AqqhB5g5w9dMLcJPzh8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bG9mrbL4VfsUzS3piLvOZEZ4ND1ZoTQzOyyxFTPnQpbR1chJfB2DJQHPpC69OMEv5NxYIE2qHzFOc5bqjtx6V+VadC60Lz6PxPChHQfGkfzGvNRFMoC3eg7jq24XQz7RGuulADLZM79LOA3JxrngAWUA13pNUWagNqhVz6c9Ty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 795EC92009C; Thu, 16 Jan 2025 16:00:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7318792009B;
	Thu, 16 Jan 2025 15:00:28 +0000 (GMT)
Date: Thu, 16 Jan 2025 15:00:28 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Jiwei Sun <sjiwei@163.com>, bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, helgaas@kernel.org, 
    Lukas Wunner <lukas@wunner.de>, ahuang12@lenovo.com, sunjw10@lenovo.com, 
    jiwei.sun.bj@qq.com, sunjw10@outlook.com
Subject: Re: [PATCH v2 2/2] PCI: reread the Link Control 2 Register before
 using
In-Reply-To: <4df1849e-c56e-b889-8807-437aab637112@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2501161426010.50458@angie.orcam.me.uk>
References: <20250115134154.9220-1-sjiwei@163.com> <20250115134154.9220-3-sjiwei@163.com> <4df1849e-c56e-b889-8807-437aab637112@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 16 Jan 2025, Ilpo Järvinen wrote:

> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 76f4df75b08a..02d2e16672a8 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -123,6 +123,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
> >  			return ret;
> >  		}
> >  
> > +		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
> >  		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> >  	}
> 
> I started to wonder if there would be a better way to fix this. If I've 
> understood Maciej's intent correctly, there are two cases when the 2nd 
> step (the one lifting the 2.5GT/s restriction) should be used:
> 
> 1) TLS is 2.5GT/s at the entry to the quirk and it's an ASMedia switch.

 Correct.

> 2) If the quirk lowered TLS to 2.5GT/s and the link became up fine 
> because of that. This also currently checks for ASMedia but in the v1 you 
> also proposed to change that. We know it works in some cases with ASMedia 
> but are unsure what happens with other switches.

 Correct.

> In the case 2, we don't need to check TLS since the function itself asked 
> TLS to be lowered which did not return an error, so we know the speed was 
> lowered so why spend time on rereading the register? A simple local 
> variable could convey the same information.

 Agreed.

> In case 1, I don't think ASMedia check should be removed. It was about a 
> case where FW has a workaround to lower the speed (IIRC). If Link Speed is 
> 2.5GT/s at entry but it's not ASMedia switch, there's no 2.5GT/s 
> restriction to lift.

 Your recollection is correct.  Perhaps we ought to lift the restriction 
instead based on the ID of the downstream device though.

 NB referring our earlier discussion the system in question is now at:

# uptime
 15:31:25 up 160 days,  2:58,  1 user,  load average: 0.00, 0.00, 0.00
# 

and the questionable link has recorded no LBMS events except for one on 
the day it was booted or maybe a day after (which I cleared back then):

# setpci -s 02:03.0 CAP_EXP+0x12.W
3012
# 

There has been some network data traffic across the link, not excessively 
high, but not insignificant either:

        RX packets 181328169  bytes 2178598128 (2.0 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 267194647  bytes 1149978069 (1.0 GiB)
        TX errors 0  dropped 2 overruns 0  carrier 0  collisions 0

So I think we can safely conclude signalling is free from disruption at 
the electrical level and all the mess with link training at speeds beyond 
2.5GT/s is owing to some kind of a protocol interpretation issue at the 
data link layer with either or both devices, and the downstream device 
being the higher suspect based on other issues with Pericom/Diodes gear.  

 Would you agree with my conclusion?

 NB I continue being busy with other stuff, but please feel free to ping 
me directly if you need any input from me.

  Maciej

