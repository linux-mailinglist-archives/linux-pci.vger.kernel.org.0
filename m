Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3D94AF317
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 14:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiBINlJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 08:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbiBINlH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 08:41:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB031C05CB8A
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 05:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644414070; x=1675950070;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ytlCuv9AQaNz8CJBqOnHKM5IzorX4K6wkF49+q+wbLs=;
  b=LTDYWF7tIDDKo92JmPca+XmTvMmhcm4n9pxyfIq1Hdc5PRdSyR5v3+bL
   Y3Nf2HbQNyJ3TSyPGTiEm9U084q/+PbMTHx2prhklG5IXvOnp3uWnQvwh
   IZ/YDiEdixvfTDaBsp/17kjw1gx6auFLKhWqbvSQHuPKNYSONA5OiFIZO
   MW8APooyEIGvCjMb8XoxtYlCnIrJtaxTLsrhAtPIIc424uft9CfA5wLgQ
   uUnqcVbrXVWba5lcTkSwgh3b69Z60PQH4dY00IJRGGjwiUrZPP+4G7E+T
   nCYdGDbya3k5ncl/1qm9MyfL6yB+3r3jxEKIZa7r2QQSUelop+7eG/gRb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229851617"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="229851617"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:41:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="485241819"
Received: from bkucman-mobl.ger.corp.intel.com (HELO localhost) ([10.249.140.15])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:41:07 -0800
Date:   Wed, 9 Feb 2022 14:41:02 +0100
From:   Blazej Kucman <blazej.kucman@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        linux-pci@vger.kernel.org, Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Message-ID: <20220209144102.0000143e@linux.intel.com>
In-Reply-To: <20220203155804.GA97933@bhelgaas>
References: <20220203114709.00000fd1@linux.intel.com>
 <20220203155804.GA97933@bhelgaas>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 3 Feb 2022 09:58:04 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Feb 03, 2022 at 11:47:09AM +0100, Blazej Kucman wrote:
> > > > On Wed, Feb 02, 2022 at 04:48:01PM +0100, Blazej Kucman wrote:
> > > >   
> > > >> On Fri, 28 Jan 2022 08:03:28 -0600
> > > >> Bjorn Helgaas <helgaas@kernel.org> wrote:    
> > > >>>> On Fri, Jan 28, 2022 at 9:08 PM Bjorn Helgaas
> > > >>>> <helgaas@kernel.org> wrote:      
> 
> > > >>>>> 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features")
> > > >>>>> looks like a it could be related.  Try reverting that commit
> > > >>>>> and see whether it makes a difference.      
> > > >>>>
> > > >>>> The affected NVMe is indeed behind VMD domain, so I think the
> > > >>>> commit can make a difference.
> > > >>>>
> > > >>>> Does VMD behave differently on laptops and servers?
> > > >>>> Anyway, I agree that the issue really lies in
> > > >>>> "pci=nommconf".      
> > > >>>
> > > >>> Oh, I have a guess:
> > > >>>
> > > >>>   - With "pci=nommconf", prior to v5.17-rc1, pciehp did not
> > > >>> work in general, but *did* work for NVMe behind a VMD.  As of
> > > >>> v5.17-rc1, pciehp no longer works for NVMe behind VMD.
> > > >>>
> > > >>>   - Without "pci=nommconf", pciehp works as expected for all
> > > >>> devices including NVMe behind VMD, both before and after
> > > >>> v5.17-rc1.
> > > >>>
> > > >>> Is that what you're observing?
> > > >>>
> > > >>> If so, I doubt there's anything to fix other than getting rid
> > > >>> of "pci=nommconf".    
> > > >>
> > > >> I haven't tested with VMD disabled earlier. I verified it and
> > > >> my observations are as follows:
> > > >>
> > > >> OS: RHEL 8.4
> > > >> NO - hotplug not working
> > > >> YES - hotplug working
> > > >>
> > > >> pci=nommconf added:
> > > >> +--------------+-------------------+---------------------+--------------+
> > > >> |              | pci-v5.17-changes | revert-04b12ef163d1 |
> > > >> inbox kernel
> > > >> +--------------+-------------------+---------------------+--------------+
> > > >> | VMD enabled  | NO                | YES                 | YES
> > > >> +--------------+-------------------+---------------------+--------------+
> > > >> | VMD disabled | NO                | NO                  | NO
> > > >> +--------------+-------------------+---------------------+--------------+
> > > >>  
> 
> OK, so the only possible problem case is that booting with VMD enabled
> and "pci=nommconf".  In that case, hotplug for devices below VMD
> worked before 04b12ef163d1 and doesn't work after.
> 
> Your table doesn't show it, but hotplug for devices *not* behind VMD
> should not work either before or after 04b12ef163d1 because Linux
> doesn't request PCIe hotplug control when booting with "pci=nommconf".
> 
> Why were you testing with "pci=nommconf"?  Do you think anybody uses
> that with VMD and NVMe?

It was added long time ago when it was useful.

On our side we will drop the parameter, and that resolves issue for us.

Bugzilla report can be closed if you don't consider it as regression.

Thanks,
Blazej

