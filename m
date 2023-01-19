Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB00674C20
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 06:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjATFYH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 00:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjATFXo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 00:23:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2EE7AF3A;
        Thu, 19 Jan 2023 21:14:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E80FB82101;
        Thu, 19 Jan 2023 13:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95431C433F0;
        Thu, 19 Jan 2023 13:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674134915;
        bh=8xre6Ca6rQGRdzO7Ba6CAgNe5xPH3qbrIwEPFKRtmU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRtx9aUef3TLh6lE1gayUWVlKq+1pky9Go+T7etMBShXa6I1lLGyxZYz6jDPi+G5O
         zz9VIkm1bfU/JhbAzMEhxzU8A8YRPBx/x6YxfOmFA4Fm2xbE+BpFntb36fJzQzPfpb
         TmsECDYiD8VqpQCuR+Nbc9jO6+P+RCISaowRde5g=
Date:   Thu, 19 Jan 2023 14:28:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, lukas@wunner.de, kabel@kernel.org,
        mani@kernel.org, pali@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        russell.h.weight@intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        lee@kernel.org, matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v1 10/12] PCI: hotplug: implement the hotplug_slot_ops
 callback for fpgahp
Message-ID: <Y8lFgKZGKYrM02Wm@kroah.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
 <20230119013602.607466-11-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119013602.607466-11-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 18, 2023 at 08:36:00PM -0500, Tianfei Zhang wrote:
> Implement the image_load and available_images callback functions
> for fpgahp driver. This patch leverages some APIs from pciehp
> driver to implement the device reconfiguration below the PCI hotplug
> bridge.
> 
> Here are the steps for a process of image load.
> 1. remove all PFs and VFs except the PF0.
> 2. remove all non-reserved devices of PF0.
> 3. trigger a image load via BMC.
> 4. disable the link of the hotplug bridge.
> 5. remove all reserved devices under PF0 and PCI devices
>    below the hotplug bridge.
> 6. wait for image load done via BMC, e.g. 10s.
> 7. re-enable the link of the hotplug bridge.
> 8. re-enumerate PCI devices below the hotplug bridge.
> 
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-fpgahp |  21 ++
>  MAINTAINERS                                   |   1 +
>  drivers/pci/hotplug/fpgahp.c                  | 179 ++++++++++++++++++
>  3 files changed, 201 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-fpgahp
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-fpgahp b/Documentation/ABI/testing/sysfs-driver-fpgahp
> new file mode 100644
> index 000000000000..8d4b1bfc4012
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-fpgahp
> @@ -0,0 +1,21 @@
> +What:		/sys/bus/pci/slots/X-X/available_images
> +Date:		May 2023
> +KernelVersion:	6.3
> +Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
> +Description:	Read-only. This file returns a space separated list of
> +		key words that may be written into the image_load file
> +		described below. These keywords decribe an FPGA, BMC,
> +		or firmware image in FLASH or EEPROM storage that may
> +		be loaded.

No, sysfs is "one value per file", why is this a list?

And what exactly defines the values in this list?

> +
> +What:		/sys/bus/pci/slots/X-X/image_load
> +Date:		May 2023
> +KernelVersion:	6.3
> +Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
> +Description:	Write-only. A key word may be written to this file to
> +		trigger a new image loading of an FPGA, BMC, or firmware
> +		image from FLASH or EEPROM. Refer to the available_images
> +		file for a list of supported key words for the underlying
> +		device.
> +		Writing an unsupported string to this file will result in
> +		EINVAL being returned.

Why is this a separate file from the "read the list" file?

That feels wrong.

thanks,

greg k-h
