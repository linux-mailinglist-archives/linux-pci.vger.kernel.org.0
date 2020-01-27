Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F4414A345
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2020 12:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgA0Lsz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 27 Jan 2020 06:48:55 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbgA0Lsz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jan 2020 06:48:55 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7C8AF3E244E542EAB93F;
        Mon, 27 Jan 2020 11:48:53 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 27 Jan 2020 11:48:53 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jan
 2020 11:48:53 +0000
Date:   Mon, 27 Jan 2020 11:48:50 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Martin =?utf-8?Q?Mare=C5=A1?= <mj@ucw.cz>
CC:     <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <jcm@redhat.com>, <nariman.poushin@linaro.org>,
        <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 0/2] lspci: support for CCIX DVSEC
Message-ID: <20200127114850.00002978@Huawei.com>
In-Reply-To: <mj+md-20200122.092951.48097.albireo@ucw.cz>
References: <20190627144355.27913-1-Jonathan.Cameron@huawei.com>
        <mj+md-20200122.092951.48097.albireo@ucw.cz>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 22 Jan 2020 10:42:21 +0100
Martin Mareš <mj@ucw.cz> wrote:

> Hello!
> 
> > This series adds support for near complete interpretation of CCIX DVSEC.
> > Most of the CCIX base 1.0 specification is covered, but a few minor
> > elements are not currently printed (some of the timeouts and credit
> > types). That can be rectified in a future version or follow up patch
> > and isn't necessary for this discussion.
> > 
> > CCIX (www.ccixconsortium.org) is a coherent interconnect specification.
> > It is flexible in allowed interconnect topologies, but is overlayed
> > on top of a traditional PCIe tree.  Note that CCIX physical devices
> > may turn up in a number of different locations in the PCIe tree.
> > 
> > The topology configuration and physical layer controls and description
> > are presented using PCIe DVSEC structures defined in the CCIX 1.0
> > base specification.  These use the unique ID granted by the PCISIG.
> > Note that, whilst it looks like a Vendor ID for this usecase it is
> > not one and can only be used to identify DVSEC and related CCIX protocol
> > messages.
> > 
> > So why an RFC?
> > * Are the lspci maintainers happy to have the tool include support for
> >   PCI configuration structures that are defined in other standards?
> > * Is the general approach and code structure appropriate?
> > * It's a lot of description so chances are some of it isn't in a format
> >   consistent with the rest of lspci!  
> 
> I am very happy to include parsers of vendor-specific capabilities.

Great.

> 
> The general approach is fine, but please bring the source code closer
> to the coding style of the rest of pciutils.

Will do - though may take me a while to get back to this one.

> 
> > The following grants the 'pciutils' project trademark usage of
> > CCIX tradmark where relevant.
> > 
> > This patch is being distributed by the CCIX Consortium, Inc. (CCIX) to
> > you and other parties that are paticipating (the "participants") in the
> > pciutils with the understanding that the participants will use CCIX's
> > name and trademark only when this patch is used in association with the
> > pciutils project.  
> 
> I suspect that this is not compatible with the GPL. Everybody is allowed
> to use portions of pciutils in other GPLed projects. So the trademark usage
> right should be granted to use in the contributed code, regardless of whether
> it is currently in the pciutils project, or any other project.

I'll keep clear of the interesting legal argument around that one.
Good news is that the CCIX consortium has agreed to more standard statement
on trademark ownership only.  No right limitations in the new version, just
statements of fact.

As I understand it, using the CCIX to mean CCIX is never a trademark violation
anyway, it's only when composites are created from it that we might run into
issues.  That's true whatever the text here says and is equally true of PCI for
example if they should ever decide to enforce their trademarks.

> 
> > CCIX is also distributing this patch to these participants with the
> > understanding that if any portion of the CCIX specification will be
> > used or referenced in the pciutils project, the participants will not modify
> > the cited portion of the CCIX specification and will give CCIX propery
> > copyright attribution by including the following copyright notice with
> > the cited part of the CCIX specification:
> > "© 2019 CCIX CONSORTIUM, INC. ALL RIGHTS RESERVED."  
> 
> Are there any citations affected by this in your patch? You only refer to data
> structures defined by the specification, but this is factual information which
> cannot be copyrighted (but IANAL).

I never got a clear answer on this from our legal (was exploring other
alternatives if we couldn't get the CCIX consortium requirements relaxed).
My understanding was the same as yours, but it became unnecessary with
confirmation that the CCIX consortium legal had relaxed their requirements
anyway.

> 
> I am strongly opposed to adding more copyright notices to the pciutils
> besides the GPL.
> 
> 				Have a nice fortnight

I'll fix the legal stuff in the next version. We got that changed after
push back from various other bits of the open source community.  Just took
a while due to some other complexities that I won't go into but you might
be able to guess given who I work for ;)

Was very helpful indeed to get feedback of the form you've given as it
forced the issue nicely.  I should have posted a note to this thread to
say that was changing, sorry for wasting your time.

Thanks!

Jonathan



