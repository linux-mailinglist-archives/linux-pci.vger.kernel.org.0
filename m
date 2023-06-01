Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930E571F5AD
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 00:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjFAWKq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 18:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjFAWKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 18:10:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7C3132
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 15:10:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 587AA615B4
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 22:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAEEC433EF;
        Thu,  1 Jun 2023 22:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685657443;
        bh=8tQG3r9liR0zHRv1gXLfhnere31qjg1a8jwhIULFC6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kwL+od+MYrO5gLXKlGaGPY7THD8iSJCZ4O5PcPPUSYYp6+4oajPWabUMoXhNPp13V
         ldjiM7KnV5dzrugGSO4HAezBrIc6fVVJUQ3Mn4li5qSKKIV8esINPWtu4VLbuHxQ3v
         83eg3y8hofV52VFi24kfG5WzNZsnTVxpW6ti4qAr8Mou+84p08IYv5Zj4xVzYMQNNY
         QjsAF4MIBRd6P388Tg3dyzXTOZ8z9Oiz1pfm8cYZ755vkwBmZtcHO0MfyR5Vs1YGDE
         yHpOUwqylBXwRNqqgcCTrObZsBoS168KCBHIXQi+f1DmCIodrONHG5g/BPEWV160WQ
         0o2dtTHmxiXng==
Date:   Thu, 1 Jun 2023 17:10:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-pci@vger.kernel.org, Bodong Wang <bodong@mellanox.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Eli Cohen <eli@mellanox.com>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Usage of sriov_drivers_autoprobe
Message-ID: <ZHkXYWu2cvWxhjDw@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd9vsNnX-Pvqu2-1CUiwGSoqsWLbJKJny16smue0s_eAVA@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 30, 2023 at 01:58:00PM -0700, Ben Gardon wrote:
> Hi Bodong, PCI folk generally,
> 
> I've found an issue with sriov_drivers_autoprobe not working as I
> would expect it to and I'd like to check if my expectations are
> incorrect or if it's not working as intended.
> 
> Please consider the sequence below
> 
> /sys/bus/pci/devices/0000:12:34.1# echo 0 > sriov_numvfs
> /sys/bus/pci/devices/0000:12:34.1# echo 0 > sriov_drivers_autoprobe
> /sys/bus/pci/devices/0000:12:34.1# echo 1 > sriov_numvfs
> (Let's say 0000:13:ab.0 is a VF of 0000:12:34.1)
> /sys/bus/pci/devices/0000:12:34.1# echo 0000:13:ab.0 >
> /sys/bus/pci/drivers/vfio-pci/bind
> -bash: echo: write error: No such device
> /sys/bus/pci/devices/0000:12:34.1# echo 1 > sriov_drivers_autoprobe
> /sys/bus/pci/devices/0000:12:34.1# echo 0000:13:ab.0 >
> /sys/bus/pci/drivers/vfio-pci/bind
> /sys/bus/pci/devices/0000:12:34.1# echo 0000:13:ab.0 >
> /sys/bus/pci/drivers/vfio-pci/unbind
> /sys/bus/pci/devices/0000:12:34.1#
> 
> From the above, we can see that having sriov_drivers_autoprobe unset
> prevents even manually binding a driver, after VF initialization. This
> seems unintentional, but it can be worked around by unsetting
> sriov_drivers_autoprobe.
> 
> If this is how it was intended to work please let me know. If it is,
> then the documentation should be updated. It says: "Note that changing
> this file does not affect already-enabled VFs." But that does not
> appear to be true.

I think the intent of the doc was something like this:

  Note that changing this file only affects future attempts to bind
  VFs to a driver, e.g., when VFs are enabled or a new driver is
  loaded.  Setting it to 0 does not unbind VFs from drivers, and
  setting it to 1 does not cause existing VFs to be bound to drivers.

I'm happy to update the doc if that seems right.

This behavior IS a little different from /sys/bus/*/drivers_autoprobe.
In that case, I think manual binding when you write to /sys/*/bind
*does* work even after writing 0 to /sys/bus/*/drivers_autoprobe.

This is because the drivers_autoprobe check happens earlier, in
bus_probe_device() or bus_add_driver(), before we get down to
driver_probe_device():

  pci_device_add(dev)                         # add new device
    device_add
      bus_probe_device
        if (sp->drivers_autoprobe)            # set by /sys/*/drivers_autoprobe
          device_initial_probe
            bus_for_each_drv(__device_attach_driver)
              __device_attach_driver
                driver_probe_device(drv, dev) # bind device to driver
		  pci_device_probe

  pci_register_driver(drv)                    # add new driver
    driver_register
      bus_add_driver
        if (sp->drivers_autoprobe)            # set by /sys/*/drivers_autoprobe
          driver_attach
            bus_for_each_dev(__driver_attach)
              __driver_attach
                driver_probe_device(drv, dev) # bind device to driver
		  pci_device_probe

When we write a device ID to /sys/*/bind path, we look up the device
and bypass the drivers_autoprobe check:

  bind_store(drv, buf)                        # /sys/bus/*/bind
    dev = bus_find_device_by_name(buf)
    if (driver_match_device(drv, dev))
      device_driver_attach(drv, dev)
        driver_probe_device                   # bind device to driver
	  pci_device_probe

It would be nice if sriov_drivers_autoprobe worked the same way.  The
problem is the sriov->drivers_autoprobe check happens inside
pci_device_probe(), so we don't know whether we came from bind_store()
or the other paths.

The current generic drivers_autoprobe is a per-bus thing (set by
bus_register() and the sysfs file), and sriov_drivers_autoprobe is a
per-PF thing.  I could imagine a new struct bus_type callback where we
could do something like this:

  bus_probe_device(dev)
  {
    struct bus_type bus = dev->bus;

    if (sp->drivers_autoprobe) {
      if (!bus->autoprobe || bus->autoprobe(dev))
        device_initial_probe(dev)
    }
  }

That would give us the flexibility to make this work as you expected
by moving the check from pci_device_probe() to the callback.

Bjorn
