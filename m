Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669EB761CD1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 17:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjGYPCK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 11:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjGYPBm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 11:01:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17AF3C14;
        Tue, 25 Jul 2023 08:00:38 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R9Kr53m31z67fjR;
        Tue, 25 Jul 2023 22:57:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 16:00:35 +0100
Date:   Tue, 25 Jul 2023 16:00:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alistair Francis <alistair23@gmail.com>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <20230725160034.00005774@Huawei.com>
In-Reply-To: <20230725035755.2621507-1-alistair.francis@wdc.com>
References: <20230725035755.2621507-1-alistair.francis@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Jul 2023 13:57:55 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> The PCIe 6 specification added support for the Data Object Exchange (DOE).
> When DOE is supported the Discovery Data Object Protocol must be
> implemented. The protocol allows a requester to obtain information about
> the other DOE protocols supported by the device.
> 
> The kernel is already querying the DOE protocols supported and cacheing
> the values. This patch exposes the values via sysfs. This will allow
> userspace to determine which DOE protocols are supported by the PCIe
> device.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Hi Alistair,

Needs documentation. 
Documentation/ABI/testing/sys-bus-pci probably the right place.

Also, I wonder if we want to associate each DOE with the protocols
it supports rather than clumping them together in one file...
Otherwise we'll loose information on sharing + we may well see
repeated entries as it's fine to have more than one instance of
given protocol.

A few more comments inline about what happens when we do run out
of space in the buffer.

Thanks,

Jonathan

> ---
>  drivers/pci/doe.c       | 28 ++++++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c | 27 +++++++++++++++++++++++++++
>  include/linux/pci-doe.h |  2 ++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 1b97a5ab71a9..cc1c23c78ac1 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -563,6 +563,34 @@ static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
>  	return false;
>  }
>  
> +/**
> + * pci_doe_sysfs_proto_supports() - Write the supported DOE protocols
> + *			     to a sysfs buffer
> + * @doe_mb: DOE mailbox capability to query
> + * @buf: buffer to store the sysfs strings
> + * @offset: offset in buffer to store the sysfs strings
> + *
> + * RETURNS: The number of bytes written, 0 means an error occured
> + */
> +unsigned long pci_doe_sysfs_proto_supports(struct pci_doe_mb *doe_mb,
> +					   char *buf, ssize_t offset)
> +{
> +	unsigned long index;
> +	ssize_t ret = offset, r;

I find that hard to parse.  Maybe

	ssize_t ret = offset;
	ssize_t r;



> +	void *entry;
> +
> +	xa_for_each(&doe_mb->prots, index, entry) {
> +		r = sysfs_emit_at(buf, ret, "0x%08lX\n", xa_to_value(entry));
> +
> +		if (r == 0)
> +			return 0;

return ret here? Otherwise we aren't outputting everything that we have
managed to print before the buffer fills up.
It's also inconsistent because if the last entry happens to partly print
we'll let it through whereas, if it doesn't fit at all we will drop
all the info about this DOE instance.


> +
> +		ret += r;
> +	}
> +
> +	return ret;
> +}
> +
>  /**
>   * pci_doe_submit_task() - Submit a task to be processed by the state machine
>   *
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index ab32a91f287b..df93051e65bf 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <linux/stat.h>
>  #include <linux/export.h>
>  #include <linux/topology.h>
> @@ -290,6 +291,29 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(modalias);
>  
> +#ifdef CONFIG_PCI_DOE
> +static ssize_t doe_proto_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	unsigned long index;
> +	ssize_t ret = 0, r;

As above.

> +	struct pci_doe_mb *doe_mb;
> +
> +	xa_for_each(&pci_dev->doe_mbs, index, doe_mb) {
> +		r = pci_doe_sysfs_proto_supports(doe_mb, buf, ret);
> +
> +		if (r == 0)
> +			return 0;

As above, return ret here I think makes more sense than 0.


> +
> +		ret += r;
> +	}
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(doe_proto);
> +#endif
> +
>  static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
>  			     const char *buf, size_t count)
>  {
> @@ -603,6 +627,9 @@ static struct attribute *pci_dev_attrs[] = {
>  	&dev_attr_local_cpus.attr,
>  	&dev_attr_local_cpulist.attr,
>  	&dev_attr_modalias.attr,
> +#ifdef CONFIG_PCI_DOE
> +	&dev_attr_doe_proto.attr,
> +#endif
>  #ifdef CONFIG_NUMA
>  	&dev_attr_numa_node.attr,
>  #endif
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index 1f14aed4354b..066494a4dba3 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -21,5 +21,7 @@ struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
>  int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
>  	    const void *request, size_t request_sz,
>  	    void *response, size_t response_sz);
> +unsigned long pci_doe_sysfs_proto_supports(struct pci_doe_mb *doe_mb,
> +					   char *buf, ssize_t offset);
>  
>  #endif

