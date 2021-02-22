Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9143B321DE1
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 18:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBVRPv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 12:15:51 -0500
Received: from ale.deltatee.com ([204.191.154.188]:56402 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhBVRPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Feb 2021 12:15:45 -0500
X-Greylist: delayed 2250 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Feb 2021 12:15:44 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=ZaBl187RW3wcHNzU6VMvuh9HIKf1g3manotNX1gzFcU=; b=BQpFzIwoWYk242YWVW+9NYLDiV
        gU1xicLWtxKvW0XUzybbcSX7S9Lzks7q/Pnc5Ro0jeAUnojqc0AjKh/k5ALI2dadC5MQqPl3c3di5
        h0FFZkXNIcSZSK65xbkArGBRmDIDcmVUoyJzZKZH5+hCi6V03LJV5ZlyhAv8kgt+VVwy3Uxm4py5/
        CAqpI7qu7HlrqdvVEoQwXgXBPgMaOZBAwXysPodjKD7BG1jZvoZ043XLx0mJ6+BOOQKoLilJwT7x/
        9wKTibcn6C7thPcUtzStNHWL6zVdhkNHOSRobB4+nWmkn0HID8hDnvt177mKFNgVx/UsmTwy9yX0J
        VghJHvfA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lEED5-0008DA-U6; Mon, 22 Feb 2021 09:37:24 -0700
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        linux-pci@vger.kernel.org
References: <20210220062837.1683159-1-kw@linux.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a00e216c-18d4-1e23-a5bc-1c0a73364429@deltatee.com>
Date:   Mon, 22 Feb 2021 09:37:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210220062837.1683159-1-kw@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, gustavo@embeddedor.com, helgaas@kernel.org, kurt.schwemmer@microsemi.com, kw@linux.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_URI_HASH,NICE_REPLY_A autolearn=no autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] PCI/switchtec: Fix Spectre v1 vulnerability
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-02-19 11:28 p.m., Krzysztof Wilczyński wrote:
> The "partition" member of the struct switchtec_ioctl_pff_port can be
> indirectly controlled from user-space through an IOCTL that the device
> driver provides enabling conversion between a PCI Function Framework
> (PFF) number and Switchtec logical port ID and partition number, thus
> allowing for command-line tooling [1] interact with the device from
> user-space.
> 
> This can lead to potential exploitation of the Spectre variant 1 [2]
> vulnerability since the value of the partition is then used directly
> as an index to mmio_part_cfg_all of the struct switchtec_dev to retrieve
> configuration from Switchtec for a specific partition number.
> 
> Fix this by sanitizing the value coming from user-space through the
> available IOCTL before it's then used as an index to mmio_part_cfg_all.
> 
> This issue was detected with the help of Smatch:
> 
>   drivers/pci/switch/switchtec.c:1118 ioctl_port_to_pff() warn:
>   potential spectre issue 'stdev->mmio_part_cfg_all' [r] (local cap)
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [3].
> 
> Related commit 46feb6b495f7 ("switchtec: Fix Spectre v1 vulnerability").
> 
> 1. https://github.com/Microsemi/switchtec-user/blob/master/lib/platform/linux.c
> 2. https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/spectre.html
> 3. https://lore.kernel.org/lkml/CAPcyv4gLKYiCtXsKFX2FY+rW93aRtQt9zB8hU1hMsj770m8gxQ@mail.gmail.com/
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan
