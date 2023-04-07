Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A1B6DB766
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 01:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjDGX6e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 19:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDGX6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 19:58:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38405BB96;
        Fri,  7 Apr 2023 16:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8A3364C8F;
        Fri,  7 Apr 2023 23:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC3AC433EF;
        Fri,  7 Apr 2023 23:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680911911;
        bh=rYZ2xlKwjcs//lx+4b1WY8Qxb6BZXFCn8T7hyocxDIM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ORh6EGV9lgAIW8DnUhNuNEw3ch/WwPL3QlLV8/XlSsfDp/FfqsLwqsAfxxVaq4+Ga
         SxQjoTYw3g7Q9AcrgScjO+Ir/kjZj/zvNoKFWuNHn3BTLx7PK3VNPLRrQSVWhEhICY
         ffiATOMWjroNLfO+UOvQn4zLPdnTHG7HP/OfqyERfwf6AEOmRgTvYHo8HbkLT8f7Lv
         Sz4oENR7rfEbEW307DffbTHSIRH6DvmH4tioAYewtLnWbRSWVmgF9aeCVDDVXJVnlq
         n9dZt1mDqQA08RmPuzrgG7Teq+kZ88GzNUwNWIPlMvJ4GxwDzwDbOaNE738Sl8utJ7
         EYDHMFvkAEcXw==
Date:   Fri, 7 Apr 2023 18:58:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "You-Sheng Yang (vicamo)" <vicamo.yang@canonical.com>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Korneliusz Osmenda <korneliuszo@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH] PCI: vmd: guard device addition and removal
Message-ID: <20230407235829.GA3834716@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313173733.1815277-1-vicamo.yang@canonical.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Korneliusz, Alexander]

On Tue, Mar 14, 2023 at 01:37:33AM +0800, You-Sheng Yang (vicamo) wrote:
> VMD may fail to create sysfs entries while `pci_rescan_bus()` called in
> some other drivers like t7xx wwan driver:
> 
>   sysfs: cannot create duplicate filename '/devices/.../resource0'
>   Call Trace:
>    <TASK>
>    sysfs_warn_dup.cold+0x17/0x34
>    sysfs_add_bin_file_mode_ns+0xc0/0xf0
>    sysfs_create_bin_file+0x6d/0xb0
>    pci_create_attr+0x117/0x260
>    pci_create_resource_files+0x6b/0x150
>    pci_create_sysfs_dev_files+0x18/0x30
>    pci_bus_add_device+0x30/0x80
>    pci_bus_add_devices+0x31/0x80
>    pci_bus_add_devices+0x5b/0x80
>    vmd_enable_domain.constprop.0+0x6b7/0x880 [vmd]
>    vmd_probe+0x16d/0x193 [vmd]

This is a long-standing issue, and I would *love* to nail it, but this
doesn't feel like the right solution to me.  What's unique about vmd
here?

I guess maybe it's similar to the situation Korneliusz and Alexander
ran into at [1]?

And why is t7xx called out specifically here?  This is a pretty
generic sysfs attribute issue and it doesn't *seem* like t7xx should
be special in that respect.  Oooh, maybe it's the fact that there's a
t7xx patch [2] coming that adds pci_rescan_bus() there?

Krzysztof has converted a lot of the sysfs files to static attributes,
e.g.,

  506140f9c06b ("PCI/sysfs: Convert "index", "acpi_index", "label" to static attributes")
  d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
  f42c35ea3b13 ("PCI/sysfs: Convert "reset" to static attribute")
  527139d738d7 ("PCI/sysfs: Convert "rom" to static attribute")
  e1d3f3268b0e ("PCI/sysfs: Convert "config" to static attribute")

I think that's the *best* approach since the sysfs infrastructure
already prevents races here.  But these last few files are more
difficult to convert, so we've been kind of stalled on them.

Bjorn

[1] https://lore.kernel.org/r/20230316091540.494366-1-alexander.stein@ew.tq-group.com
[2] https://lore.kernel.org/linux-pci/20230124204543.550d88e3@kernel.org/

> Fixes: 185a383ada2e ("x86/PCI: Add driver for Intel Volume Management Device (VMD)")
> Signed-off-by: You-Sheng Yang (vicamo) <vicamo.yang@canonical.com>
> ---
>  drivers/pci/controller/vmd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..f050991bd1e9 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -838,9 +838,13 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
>  	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
>  
> +	pci_lock_rescan_remove();
> +
>  	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
>  				       &vmd_ops, sd, &resources);
>  	if (!vmd->bus) {
> +		pci_unlock_rescan_remove();
> +
>  		pci_free_resource_list(&resources);
>  		vmd_remove_irq_domain(vmd);
>  		return -ENODEV;
> @@ -893,6 +897,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	vmd_acpi_end();
>  
> +	pci_unlock_rescan_remove();
> +
>  	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>  			       "domain"), "Can't create symlink to domain\n");
>  	return 0;
> -- 
> 2.39.2
> 
