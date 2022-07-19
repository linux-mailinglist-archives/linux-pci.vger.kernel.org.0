Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE857A442
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiGSQjP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 19 Jul 2022 12:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGSQjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 12:39:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387903AB3B;
        Tue, 19 Jul 2022 09:39:09 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnPYl67rsz6842y;
        Wed, 20 Jul 2022 00:34:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 19 Jul 2022 18:39:06 +0200
Received: from localhost (10.81.209.49) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 17:39:06 +0100
Date:   Tue, 19 Jul 2022 17:39:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V14 5/7] driver-core: Introduce BIN_ATTR_ADMIN_{RO,RW}
Message-ID: <20220719173904.00005c9a@Huawei.com>
In-Reply-To: <20220715030424.462963-6-ira.weiny@intel.com>
References: <20220715030424.462963-1-ira.weiny@intel.com>
        <20220715030424.462963-6-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.81.209.49]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Jul 2022 20:04:22 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Many binary attributes need to limit access to CAP_SYS_ADMIN only; ie
> many binary attributes specify is_visible with 0400 or 0600.
> 
> Make setting the permissions of such attributes more explicit by
> defining BIN_ATTR_ADMIN_{RO,RW}.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Krzysztof Wilczyński <kw@linux.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Seems sensible.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes from V12:
> 	Pick up review tag
> 	Bjorn:
> 		NOTE: this has a lot of similarities to
> 		https://lore.kernel.org/all/20210416205856.3234481-7-kw@linux.com/
> 		I'm not sure why that patch was not picked up.  But I've
> 		added Krzysztof as a suggested by if that is ok?
> 
> Changes from V11:
> 	New Patch
> ---
>  include/linux/sysfs.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index e3f1e8ac1f85..fd3fe5c8c17f 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -235,6 +235,22 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
>  #define BIN_ATTR_RW(_name, _size)					\
>  struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
>  
> +
> +#define __BIN_ATTR_ADMIN_RO(_name, _size) {					\
> +	.attr	= { .name = __stringify(_name), .mode = 0400 },		\
> +	.read	= _name##_read,						\
> +	.size	= _size,						\
> +}
> +
> +#define __BIN_ATTR_ADMIN_RW(_name, _size)					\
> +	__BIN_ATTR(_name, 0600, _name##_read, _name##_write, _size)
> +
> +#define BIN_ATTR_ADMIN_RO(_name, _size)					\
> +struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RO(_name, _size)
> +
> +#define BIN_ATTR_ADMIN_RW(_name, _size)					\
> +struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RW(_name, _size)
> +
>  struct sysfs_ops {
>  	ssize_t	(*show)(struct kobject *, struct attribute *, char *);
>  	ssize_t	(*store)(struct kobject *, struct attribute *, const char *, size_t);

