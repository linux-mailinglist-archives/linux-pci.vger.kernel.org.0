Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE3D3421C7
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 17:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCSQYe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 12:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhCSQYJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Mar 2021 12:24:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 564B96197D;
        Fri, 19 Mar 2021 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616171049;
        bh=/yXF3uPIsmHLvUVU1g7tNdmmY4GPVtBysBVdEqlnvVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R0LZg0L5arQh06MS7ClFuuhhelQKVgjW64soP35KJAKi2mUfINOa3CHT5LJwOVehh
         5p65lmtzmnK1PePJ55fSfsGjxkeOKXH9/njq1+4u5wmDAVvBQgTNLfOEOOT8e3YCEe
         Xq7ZZ+QMN/Zl8yGvqXdRjqnblnaIo5OIk6hIdIZETrru2TVJ/6hF+qPUkrfMBjwr+z
         sakj4olwel5uAWcQluWGwCzfj/tUROqEFkxnyk2TfmCKDzMDM1EVl5MTzjnHaIUgDe
         SkhxcPbxt1hZAdMN+K5kp7aNA8LRSUPpfcboQfDxAwvPZrerHWzZc3r505ZzAKKuys
         rPohqic2hjJOg==
Date:   Fri, 19 Mar 2021 18:24:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Alex Williamson <alex.williamson@redhat.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YFTQJc4AAlVz2+9x@unreal>
References: <YFSgQ2RWqt4YyIV4@unreal>
 <20210319155711.GA234744@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319155711.GA234744@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 19, 2021 at 10:57:11AM -0500, Bjorn Helgaas wrote:
> On Fri, Mar 19, 2021 at 02:59:47PM +0200, Leon Romanovsky wrote:
> > On Thu, Mar 18, 2021 at 07:34:56PM +0100, Enrico Weigelt, metux IT consult wrote:
> > > On 18.03.21 18:22, Leon Romanovsky wrote:
> > > 
> > > > Which email client do you use?  Your responses are grouped as
> > > > one huge block without any chance to respond to you on specific
> > > > point or answer to your question.
> > > 
> > > I'm reading this thread in Tbird, and threading / quoting all
> > > looks nice.
> > 
> > I'm not talking about threading or quoting but about response
> > itself.  See it here
> > https://lore.kernel.org/lkml/20210318103935.2ec32302@omen.home.shazbot.org/
> > Alex's response is one big chunk without any separations to
> > paragraphs.
> 
> Don't make this harder than it needs to be.  I think it's totally
> acceptable to just split Alex's text where you need to respond.  For
> example, Alex wrote this:
> 
>   vfio-pci uses the internal kernel API, ie. the variants of
>   pci_reset_function(), which is the same interface used by the existing
>   sysfs reset mechanism.  This proposed configuration of the reset method
>   would affect any driver using that same core infrastructure and from my
>   perspective that's really the goal.  ...
> 
> If I wanted to respond to the first sentence, I would just do this:
> 
> aw> vfio-pci uses the internal kernel API, ie. the variants of
> aw> pci_reset_function(), which is the same interface used by the existing
> aw> sysfs reset mechanism.  
> 
> I would write my response to the above here.  The rest of the quote
> continues on below.  If the rest of Alex's message isn't relevant to
> my response, I would remove it completely.
> 
> aw> This proposed configuration of the reset method
> aw> would affect any driver using that same core infrastructure and from my
> aw> perspective that's really the goal.  ...
> 
> Bjorn

Thanks Bjorn, you presented me how to respond on such messages, however
I was more afraid if my setup needs some adjustments and it is only me
who sees it as one chunk.

Thanks

