Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5E26764FC
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jan 2023 08:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjAUHfY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Jan 2023 02:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUHfX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Jan 2023 02:35:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B497135D;
        Fri, 20 Jan 2023 23:35:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60D33B82A2B;
        Sat, 21 Jan 2023 07:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2DAC433EF;
        Sat, 21 Jan 2023 07:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674286520;
        bh=WjefWdiCL/8Sz2EGJFW9nb3fkDOMUyc6/UNjuyE0PTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQgeRDVc+OYVn7BZ+U1l4syouVdAqIOBf7OnNvPENNlJshtIlQecaetgk5H3u8KS1
         Q2vfMuva0LU8CW7u4UEg4Xtj7sJZy/dBcgiWK9q+ObA1n6QCjxr/lsGVimlOyt9L7w
         wUJxBNtsN/lAiUP6FvwZW0rVI9HfUn6ejatG+zxU=
Date:   Sat, 21 Jan 2023 08:35:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org,
        lukas@wunner.de, kabel@kernel.org, mani@kernel.org,
        pali@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, lee@kernel.org,
        matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v1 10/12] PCI: hotplug: implement the hotplug_slot_ops
 callback for fpgahp
Message-ID: <Y8uVtSw1qXhfHrNk@kroah.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
 <20230119013602.607466-11-tianfei.zhang@intel.com>
 <Y8lFgKZGKYrM02Wm@kroah.com>
 <ea85cb02-a13d-f232-8ebd-c13893fc00c4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea85cb02-a13d-f232-8ebd-c13893fc00c4@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 20, 2023 at 02:38:43PM -0800, Russ Weight wrote:
> 
> 
> On 1/19/23 05:28, Greg KH wrote:
> > On Wed, Jan 18, 2023 at 08:36:00PM -0500, Tianfei Zhang wrote:
> >> Implement the image_load and available_images callback functions
> >> for fpgahp driver. This patch leverages some APIs from pciehp
> >> driver to implement the device reconfiguration below the PCI hotplug
> >> bridge.
> >>
> >> Here are the steps for a process of image load.
> >> 1. remove all PFs and VFs except the PF0.
> >> 2. remove all non-reserved devices of PF0.
> >> 3. trigger a image load via BMC.
> >> 4. disable the link of the hotplug bridge.
> >> 5. remove all reserved devices under PF0 and PCI devices
> >>    below the hotplug bridge.
> >> 6. wait for image load done via BMC, e.g. 10s.
> >> 7. re-enable the link of the hotplug bridge.
> >> 8. re-enumerate PCI devices below the hotplug bridge.
> >>
> >> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> >> ---
> >>  Documentation/ABI/testing/sysfs-driver-fpgahp |  21 ++
> >>  MAINTAINERS                                   |   1 +
> >>  drivers/pci/hotplug/fpgahp.c                  | 179 ++++++++++++++++++
> >>  3 files changed, 201 insertions(+)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-driver-fpgahp
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-driver-fpgahp b/Documentation/ABI/testing/sysfs-driver-fpgahp
> >> new file mode 100644
> >> index 000000000000..8d4b1bfc4012
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-driver-fpgahp
> >> @@ -0,0 +1,21 @@
> >> +What:		/sys/bus/pci/slots/X-X/available_images
> >> +Date:		May 2023
> >> +KernelVersion:	6.3
> >> +Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
> >> +Description:	Read-only. This file returns a space separated list of
> >> +		key words that may be written into the image_load file
> >> +		described below. These keywords decribe an FPGA, BMC,
> >> +		or firmware image in FLASH or EEPROM storage that may
> >> +		be loaded.
> > No, sysfs is "one value per file", why is this a list?
> >
> > And what exactly defines the values in this list?
> >
> >> +
> >> +What:		/sys/bus/pci/slots/X-X/image_load
> >> +Date:		May 2023
> >> +KernelVersion:	6.3
> >> +Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
> >> +Description:	Write-only. A key word may be written to this file to
> >> +		trigger a new image loading of an FPGA, BMC, or firmware
> >> +		image from FLASH or EEPROM. Refer to the available_images
> >> +		file for a list of supported key words for the underlying
> >> +		device.
> >> +		Writing an unsupported string to this file will result in
> >> +		EINVAL being returned.
> > Why is this a separate file from the "read the list" file?
> 
> The intended usage is like this:
> 
> $ cat available_images
> bmc_factory bmc_user fpga_factory fpga_user1 fpga_user2
> $ echo bmc_user > image_load
> 
> This specifies which image stored in flash that you want to have activated
> on the device.
> 
> An existing example of something like this is in the tracing code:
> available_tracers and current_tracer
> 
> Would it be preferable to just create a file for each possible image,
> and echo 1 to trigger the event? (echo 1 > bmc_user)

That would make things much more simpler overall and not force people to
have to parse a sysfs file, which is the main reason we created sysfs in
the first place.

thanks,

greg k-h
