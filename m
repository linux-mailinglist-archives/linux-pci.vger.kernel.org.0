Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24588357342
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 19:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354890AbhDGRfb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 13:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232356AbhDGRfa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 13:35:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EB7861359;
        Wed,  7 Apr 2021 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617816919;
        bh=DJKF3mtl+EHxdpObT36wNiXsVe+AFPcJJOhQgKgWBRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXyM+1WfBORK3yhGZkxvb6do5kfLE5WyjwfwjPtMqhcMyOMYq83GuHMK2WuTMEGly
         JuorDZ1mEqFscvAzyD2rG9/8FL4tsGaaEMfmdQtxJ1eKh4cPhHYbnY7st+bab28dYE
         8qiRpQQItTEU1+iX+/WmuyvtL0ph7gzms4puoy1k=
Date:   Wed, 7 Apr 2021 19:35:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 1/2] Documentation: misc-devices: Fix indentation,
 formatting, and update outdated info
Message-ID: <YG3tVEnjUEg5g7mz@kroah.com>
References: <cover.1617743702.git.gustavo.pimentel@synopsys.com>
 <95bef5f98380bc91b4d321c2638d08da61ef6d6e.1617743702.git.gustavo.pimentel@synopsys.com>
 <YG1OaKU7slMHfweX@kroah.com>
 <DM5PR12MB183598B5F93D4DBC515F61B1DA759@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB183598B5F93D4DBC515F61B1DA759@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 07, 2021 at 03:57:31PM +0000, Gustavo Pimentel wrote:
> On Wed, Apr 7, 2021 at 7:17:12, Greg Kroah-Hartman 
> <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Apr 06, 2021 at 11:17:48PM +0200, Gustavo Pimentel wrote:
> > > Fixes indentation issues reported by doing *make htmldocs* as well some
> > > text formatting.
> > > 
> > > Besides these fixes, there was some outdated information related to stop
> > > file interface in sysfs.
> > 
> > You are not doing this for all "misc-devices", you are doing this only
> > for one specific driver file.
> > 
> > Please look at the example I provided for how to name this and fix up.
> 
> Sorry Greg, I didn't see an example provided. Perhaps you forgot it?

Nope: https://lore.kernel.org/r/YGyl7OWHJm1NuaV2@kroah.com

> 
> > 
> > > 
> > > Fixes: e1181b5bbc3c ("Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver")
> > > Link: https://urldefense.com/v3/__https://lore.kernel.org/linux-next/20210406214615.40cf3493@canb.auug.org.au/__;!!A4F2R9G_pg!MeIXpmOYi4yJTBq19JEADll7-g6cYBmmwG92EWipqsBiPzeubfMGVllrpMt8FpwvW5ZemHY$ 
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > ---
> > >  Documentation/misc-devices/dw-xdata-pcie.rst | 62 +++++++++++++++++++---------
> > >  1 file changed, 43 insertions(+), 19 deletions(-)
> > 
> > What changed from v1?  Always put that below the --- line.
> 
> I've considered the V1 the 2 patches sent wrongly separately, based on 
> your feedback I've generated a v2 to include the cover letter and the 
> reported-by, link, and fixes tags.
> Was this wrong?

No, but you need to say that here, otherwise how do we know this?

> I also placed the change list on the cover letter. Or do you prefer on 
> each patch?

Ah, if you put it in the cover letter, that's fine, but I almost never
read them :)

thanks,

greg k-h
