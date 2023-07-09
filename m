Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA474C3DC
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jul 2023 13:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjGILva (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jul 2023 07:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjGILva (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jul 2023 07:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6681DB
        for <linux-pci@vger.kernel.org>; Sun,  9 Jul 2023 04:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688903441;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBb9/8vjIFR5k1dWVuaEzBrYQy43VK7ohIeSAHPTPP8=;
        b=APQ1RRT5FPrLFCX7PcwPQSJ5WrO2jS2GT+pY8x0ZB5YNKKpAMeeqLaCkN+xr082tTrZiwr
        jb2I4rCe96Ad6ENLX1WABTmcPMrWDgfyWIORS9B9amx6NXd61nLtGDg/uOYPER7Bmh+gvP
        kORcKZFlh6Kz1PURE1uCQZJMMzW+4a8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-YMFuyYa1MUGYxghfFD8XZA-1; Sun, 09 Jul 2023 07:50:40 -0400
X-MC-Unique: YMFuyYa1MUGYxghfFD8XZA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-786ca3e9160so64558739f.1
        for <linux-pci@vger.kernel.org>; Sun, 09 Jul 2023 04:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688903439; x=1691495439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBb9/8vjIFR5k1dWVuaEzBrYQy43VK7ohIeSAHPTPP8=;
        b=j7O1nFVhwB2/HvvNju8ctyNqAEUbJ8PEwhY8I61DtieoxLcJK1x9x2BusWfBNmN1cK
         Y5A7Fp9ZV47WUzqf5OGcoItAiVACltS4yym1NTnVDEcSouTXBrQD6lVOZZ6PAoDvtamF
         MzQEK2uO9zkxMJFRO8UmjYipAKK7xWb4bM76PazaiX3lfVHiR0QY5EvAaHRX5fF2bQ6b
         tabCmhJC1oI8ooEFNwvWPHwf4lPAkdgab+QSukPEAglM4WI72EHB5VahNcXCw0w9Hpfl
         jccX/gVYW3JDxs2FJ5QmHhg2ixRRiV3XDNVdEEwEraJeRxLh+KrwPm3j7jy9uHCAy2rB
         ON0Q==
X-Gm-Message-State: ABy/qLazVZ7s/MaJKDuf0gJKGm7CTf6mvQ5pmyYMU5Y+duCmIsFqZS+b
        7VmDFTRhFtsgoOK+Pb994FiFmcaEE/ryy1+FkjnZgRXliC+jU/0Dhm+VYRjBC43T+By6nBzRgQw
        /fnFHSSfj/r75w/noedEO
X-Received: by 2002:a05:6e02:1c85:b0:346:15f5:2667 with SMTP id w5-20020a056e021c8500b0034615f52667mr11732413ill.4.1688903439511;
        Sun, 09 Jul 2023 04:50:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlExfGJk/s9ZSCE7I6PVBdLQhGJsHoBt8lj24XrnqjS05FS/zv5freA8kB7TlVVqSaa/QJboYA==
X-Received: by 2002:a05:6e02:1c85:b0:346:15f5:2667 with SMTP id w5-20020a056e021c8500b0034615f52667mr11732408ill.4.1688903439281;
        Sun, 09 Jul 2023 04:50:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id g6-20020a02b706000000b0041f4da30787sm2569772jam.167.2023.07.09.04.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 04:50:38 -0700 (PDT)
Message-ID: <08e455b0-31a6-b379-ba8b-b9a2c0962e22@redhat.com>
Date:   Sun, 9 Jul 2023 13:50:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] PCI/VPD: Add runtime power management to sysfs interface
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230707151044.1311544-1-alex.williamson@redhat.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230707151044.1311544-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

On 7/7/23 17:10, Alex Williamson wrote:
> Unlike default access to config space through sysfs, the vpd read and
> write function don't actively manage the runtime power management state
> of the device during access.  Since commit 7ab5e10eda02 ("vfio/pci: Move
> the unused device into low power state with runtime PM"), the vfio-pci
> driver will use runtime power management and release unused devices to
> make use of low power states.  Attempting to access VPD information in
> this low power state can result in incorrect information or kernel
> crashes depending on the system behavior.
>
> Wrap the vpd read/write bin attribute handlers in runtime PM and take
> into account the potential quirk to select the correct device to wake.

This much improved the situation as it is more difficult to hit the
issue. Unfortunately after tens of attempts I was still able to hit a
kernel crash. The console output does not mention the VPD anymore but
PCI power management events (PME).



[  168.616700] CPU: 0 PID: 1409 Comm: kworker/0:5 Not tainted
6.4.0-vpd-upstream+ #56
[  168.624257] Hardware name: GIGABYTE R181-T90-00/MT91-FS1-00, BIOS F34
08/13/2020
[  168.631639] Workqueue: events_freezable pci_pme_list_scan
[  168.637032] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[  168.643982] pc : pci_generic_config_read+0x64/0xd8
[  168.648763] lr : pci_generic_config_read+0x28/0xd8
[  168.653542] sp : ffff80008caebcb0
[  168.656844] x29: ffff80008caebcb0 x28: 0000000000000000 x27:
0000000000000000
[  168.663969] x26: 0000000000000000 x25: 0000000000000000 x24:
ffff80008caebd76
[  168.671094] x23: ffff0008063fd800 x22: 0000000000000044 x21:
ffff80008232d4c8
[  168.678218] x20: ffff80008caebd24 x19: 0000000000000002 x18:
00000000000040fc
[  168.685342] x17: 00000000000040f8 x16: 0000000000000000 x15:
0000000000000001
[  168.692466] x14: ffffffffffffffff x13: 0000000000000000 x12:
0101010101010101
[  168.699590] x11: 7f7f7f7f7f7f7f7f x10: fefefefefefefeff x9 :
ffff8000807b3938
[  168.706714] x8 : fefefefefefefeff x7 : 0000000000000018 x6 :
000000000000007f
[  168.713838] x5 : 0000000000000000 x4 : ffff800090000000 x3 :
0000000000000000
[  168.720962] x2 : 0000000000000044 x1 : 0000000000c00044 x0 :
ffff800090c00044
[  168.728086] Call trace:
[  168.730520]  pci_generic_config_read+0x64/0xd8
[  168.734953]  pci_bus_read_config_word+0x84/0xe8
[  168.739471]  pci_read_config_word+0x30/0x50
[  168.743642]  pci_check_pme_status+0x70/0xa8
[  168.747813]  pci_pme_list_scan+0x84/0x158
[  168.751811]  process_one_work+0x1ec/0x488
[  168.755810]  worker_thread+0x48/0x400
[  168.759461]  kthread+0x10c/0x120
[  168.762678]  ret_from_fork+0x10/0x20
[  168.766245] Code: 52800000 a94153f3 a8c27bfd d65f03c0 (79400000)
[  168.772326] ---[ end trace 0000000000000000 ]---
[  168.776931] Kernel panic - not syncing: synchronous external abort:
Fatal exception
[  168.784574] SMP: stopping secondary CPUs
[  169.831001] SMP: failed to stop secondary CPUs 0,199
[  169.835955] Kernel Offset: 0x190000 from 0xffff800080000000


Thanks

Eric
>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/vpd.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index a4fc4d0690fe..81217dd4789f 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -275,8 +275,23 @@ static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
>  			size_t count)
>  {
>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
> +	struct pci_dev *vpd_dev = dev;
> +	ssize_t ret;
> +
> +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> +		vpd_dev = pci_get_func0_dev(dev);
> +		if (!vpd_dev)
> +			return -ENODEV;
> +	}
> +
> +	pci_config_pm_runtime_get(vpd_dev);
> +	ret = pci_read_vpd(vpd_dev, off, count, buf);
> +	pci_config_pm_runtime_put(vpd_dev);
> +
> +	if (dev != vpd_dev)
> +		pci_dev_put(vpd_dev);
>  
> -	return pci_read_vpd(dev, off, count, buf);
> +	return ret;
>  }
>  
>  static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
> @@ -284,8 +299,23 @@ static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
>  			 size_t count)
>  {
>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
> +	struct pci_dev *vpd_dev = dev;
> +	ssize_t ret;
> +
> +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> +		vpd_dev = pci_get_func0_dev(dev);
> +		if (!vpd_dev)
> +			return -ENODEV;
> +	}
> +
> +	pci_config_pm_runtime_get(vpd_dev);
> +	ret = pci_write_vpd(vpd_dev, off, count, buf);
> +	pci_config_pm_runtime_put(vpd_dev);
> +
> +	if (dev != vpd_dev)
> +		pci_dev_put(vpd_dev);
>  
> -	return pci_write_vpd(dev, off, count, buf);
> +	return ret;
>  }
>  static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
>  

