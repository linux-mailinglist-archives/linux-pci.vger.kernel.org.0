Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9B04A8828
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 16:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345467AbiBCP6O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 10:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352061AbiBCP6I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 10:58:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3DFC06173B
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 07:58:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A62F960FF0
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 15:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DDCC340E8;
        Thu,  3 Feb 2022 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643903887;
        bh=dGoAMWEaVRbHIn4zw7B09vLApbo9/a/S6o7nbAX1PIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O7+QGWS4tu7gjIWz3Lx2GjH6NsDxVaghZ3E/kdzV146dMMDFA9SZi2uZdsko4qgVR
         xTxzAXsjQqtiZfWm4QWNWePbQcaoBMI5VgtUDRFgznSoheYIhaD8Ygwf6li5OR8kgH
         c4itX7u8Yjv+FXY063rMN8C07kdhvpgwaFpTuxPko4ej3SjMuQTq69O+g3XCjBZn3W
         BfEETftWZdskl9Og26pTZFjWv8RjcXaljcih6FOMaIFqsVtG58kGtRQupJAZ9sejGP
         BMXI4DE0wtLatiSl1WGTfcnT97QgfoGoJfS8Cuh3iHMeYAs10tbfPRmQEhBy8JV61O
         f6Ldmj7hauKFA==
Date:   Thu, 3 Feb 2022 09:58:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Blazej Kucman <blazej.kucman@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        linux-pci@vger.kernel.org, Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Message-ID: <20220203155804.GA97933@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203114709.00000fd1@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 03, 2022 at 11:47:09AM +0100, Blazej Kucman wrote:
> > > On Wed, Feb 02, 2022 at 04:48:01PM +0100, Blazej Kucman wrote:  
> > >> On Fri, 28 Jan 2022 08:03:28 -0600
> > >> Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > >>>> On Fri, Jan 28, 2022 at 9:08 PM Bjorn Helgaas
> > >>>> <helgaas@kernel.org> wrote:    

> > >>>>> 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features")
> > >>>>> looks like a it could be related.  Try reverting that commit
> > >>>>> and see whether it makes a difference.    
> > >>>>
> > >>>> The affected NVMe is indeed behind VMD domain, so I think the
> > >>>> commit can make a difference.
> > >>>>
> > >>>> Does VMD behave differently on laptops and servers?
> > >>>> Anyway, I agree that the issue really lies in "pci=nommconf".    
> > >>>
> > >>> Oh, I have a guess:
> > >>>
> > >>>   - With "pci=nommconf", prior to v5.17-rc1, pciehp did not work
> > >>> in general, but *did* work for NVMe behind a VMD.  As of
> > >>> v5.17-rc1, pciehp no longer works for NVMe behind VMD.
> > >>>
> > >>>   - Without "pci=nommconf", pciehp works as expected for all
> > >>> devices including NVMe behind VMD, both before and after
> > >>> v5.17-rc1.
> > >>>
> > >>> Is that what you're observing?
> > >>>
> > >>> If so, I doubt there's anything to fix other than getting rid of
> > >>> "pci=nommconf".  
> > >>
> > >> I haven't tested with VMD disabled earlier. I verified it and my
> > >> observations are as follows:
> > >>
> > >> OS: RHEL 8.4
> > >> NO - hotplug not working
> > >> YES - hotplug working
> > >>
> > >> pci=nommconf added:
> > >> +--------------+-------------------+---------------------+--------------+
> > >> |              | pci-v5.17-changes | revert-04b12ef163d1 | inbox
> > >> kernel
> > >> +--------------+-------------------+---------------------+--------------+
> > >> | VMD enabled  | NO                | YES                 | YES
> > >> +--------------+-------------------+---------------------+--------------+
> > >> | VMD disabled | NO                | NO                  | NO
> > >> +--------------+-------------------+---------------------+--------------+

OK, so the only possible problem case is that booting with VMD enabled
and "pci=nommconf".  In that case, hotplug for devices below VMD
worked before 04b12ef163d1 and doesn't work after.

Your table doesn't show it, but hotplug for devices *not* behind VMD
should not work either before or after 04b12ef163d1 because Linux
doesn't request PCIe hotplug control when booting with "pci=nommconf".

Why were you testing with "pci=nommconf"?  Do you think anybody uses
that with VMD and NVMe?

Bjorn
