Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B093E14F5
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 14:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhHEMoE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 08:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233016AbhHEMoD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 08:44:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42E4161131;
        Thu,  5 Aug 2021 12:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628167428;
        bh=Lpsj90z+H7LHyrSlpa+uC5g21Y53OJdEV2uKhYpNbiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ReyCKngtjhYK4YbQq3Xy+wDQv3jAVUVdRnW7vfibaOOIDn563QVVAsi+Hb4MFt8Zo
         d72ap9ywRpu1s5dumaTgyny/IpvoE4t1HwzVoXkhKGUySaCqy9lhbo2vNXA5scdhY6
         WgwcHGLg28EFLpRk+UoGMGs18oL4MeCqpN6bA2zs=
Date:   Thu, 5 Aug 2021 14:43:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Allow deferred execution of iomem_get_mapping()
Message-ID: <YQvdAkSLcMlFFoPO@kroah.com>
References: <YQOI0qdVK0dudSbx@kroah.com>
 <20210730195013.GA1090988@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210730195013.GA1090988@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 30, 2021 at 02:50:13PM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 30, 2021 at 07:06:26AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jul 29, 2021 at 11:32:33PM +0000, Krzysztof Wilczyński wrote:
> > > Hello,
> > > 
> > > At the moment, the dependency on iomem_get_mapping() that is currently
> > > used in the pci_create_resource_files() and pci_create_legacy_files()
> > > stops us from completely retiring the late_initcall() that is used to
> > > invoke pci_sysfs_init() when creating sysfs object for PCI devices.
> > > 
> > > This dependency on iomem_get_mapping() stops us from retiring the
> > > late_initcall at the moment as when we convert dynamically added sysfs
> > > objects, that are primarily added in the pci_create_resource_files() and
> > > pci_create_legacy_files(), as these attributes are added before the VFS
> > > completes its initialisation, and since most of the PCI devices are
> > > typically enumerated in subsys_initcall this leads to a failure and an
> > > Oops related to iomem_get_mapping() access.
> > > 
> > > See relevant conversations:
> > >   https://lore.kernel.org/linux-pci/20210204165831.2703772-1-daniel.vetter@ffwll.ch/
> > >   https://lore.kernel.org/linux-pci/20210313215747.GA2394467@bjorn-Precision-5520/
> > > 
> > > After some deliberation about the problem at hand, Dan Williams
> > > suggested a solution to the problem, as per:
> > >   https://lore.kernel.org/linux-pci/CAPcyv4i0y_4cMGEpNVShLUyUk3nyWH203Ry3S87BqnDJE0Rmxg@mail.gmail.com/
> > > 
> > > The idea is to defer execution of the iomem_get_mapping() to only when
> > > the sysfs open callback is run, and thus removing the reliance of
> > > fs_initcalls to complete before any other sub-system that uses the
> > > iomem_get_mapping().
> > > 
> > > Currently, the PCI sub-system will benefit the most from this change
> > > allowing for it to complete the transition from dynamically created to
> > > static sysfs objects.
> > > 
> > > This series aims to take Dan Williams' idea through the finish line.
> > > 
> > > Related to:
> > >   https://lore.kernel.org/linux-pci/20210527205845.GA1421476@bjorn-Precision-5520/
> > >   https://lore.kernel.org/linux-pci/20210507102706.7658-1-danijel.slivka@amd.com/
> > >   https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pali/
> > > 
> > > 	Krzysztof
> > > 
> > 
> > No objection from me on these, Bjorn, mind if I take them through my
> > driver core tree?
> 
> That'd be great!
> 
> Is your tree immutable?  I'm hoping we can take advantage of this to
> get rid of pci_sysfs_init(), which will fix a race that people seem to
> be hitting frequently now [1].  I think Krzysztof is getting pretty
> close.
> 
> [1] https://lore.kernel.org/r/m3eebg9puj.fsf@t19.piap.pl

Yes, my tree is immutable.  Let me create a branch just for this that
you can pull from after it passes 0-day...

thanks,

greg k-h
