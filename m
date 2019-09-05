Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B56AA8DB
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfIEQYV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 12:24:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfIEQYV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 12:24:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4075210F23F6;
        Thu,  5 Sep 2019 16:24:21 +0000 (UTC)
Received: from [10.3.116.78] (ovpn-116-78.phx2.redhat.com [10.3.116.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D05C660BE1;
        Thu,  5 Sep 2019 16:24:19 +0000 (UTC)
Subject: Re: [PATCH] PCI/IOV: Make SR-IOV attributes with mode 0664 use 0644
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bodong@mellanox.com, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, berrange@redhat.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
References: <20190905063226.43269-1-skunberg.kelsey@gmail.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <37736cd8-fc9f-5896-030a-d7957cc68113@redhat.com>
Date:   Thu, 5 Sep 2019 12:24:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190905063226.43269-1-skunberg.kelsey@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 05 Sep 2019 16:24:21 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/05/2019 02:32 AM, Kelsey Skunberg wrote:
> sriov_numvfs and sriov_drivers_autoprobe have "unusual" permissions (0664)
> with no reported or found reason for allowing group write permissions.
> libvirt runs as root when dealing with PCI, and chowns files for qemu
> needs. There is not a need for the "0664" permissions.
> 
> sriov_numvfs was introduced in:
> 	commit 1789382a72a5 ("PCI: SRIOV control and status via sysfs")
> 
> sriov_drivers_autoprobe was introduced in:
> 	commit 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to
> 			      control VF driver binding")
> 
> Change sriov_numvfs and sriov_drivers_autoprobe from "0664" permissions to
> "0644" permissions.
> 
> Exchange DEVICE_ATTR() with DEVICE_ATTR_RW() which sets the mode to "0644".
> DEVICE_ATTR() should only be used for "unusual" permissions.
> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---
>   drivers/pci/iov.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index b335db21c85e..b3f972e8cfed 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -375,12 +375,11 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
>   }
>   
>   static DEVICE_ATTR_RO(sriov_totalvfs);
> -static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
> +static DEVICE_ATTR_RW(sriov_numvfs);
>   static DEVICE_ATTR_RO(sriov_offset);
>   static DEVICE_ATTR_RO(sriov_stride);
>   static DEVICE_ATTR_RO(sriov_vf_device);
> -static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
> -		   sriov_drivers_autoprobe_store);
> +static DEVICE_ATTR_RW(sriov_drivers_autoprobe);
>   
>   static struct attribute *sriov_dev_attrs[] = {
>   	&dev_attr_sriov_totalvfs.attr,
> 
Thanks again for the cleanup.

Acked-by: Donald Dutile <ddutile@redhat.com>

