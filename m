Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133EF7CBD97
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 10:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjJQIe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 04:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjJQIeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 04:34:25 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D990FE8
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 01:34:23 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id BF837280248D0;
        Tue, 17 Oct 2023 10:34:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B3DA151FE31; Tue, 17 Oct 2023 10:34:21 +0200 (CEST)
Date:   Tue, 17 Oct 2023 10:34:21 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
        christian.koenig@amd.com, kch@nvidia.com,
        gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v9 2/3] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20231017083421.GA23168@wunner.de>
References: <20231013034158.2745127-1-alistair.francis@wdc.com>
 <20231013034158.2745127-2-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013034158.2745127-2-alistair.francis@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 13, 2023 at 01:41:57PM +1000, Alistair Francis wrote:
> +#ifdef CONFIG_SYSFS
> +static umode_t pci_doe_sysfs_attr_is_visible(struct kobject *kobj,
> +					     struct attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index, j;
> +	void *entry;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		xa_for_each(&doe_mb->feats, j, entry)
> +			return a->mode;
> +	}
> +
> +	return 0;
> +}

Out of curiosity:  Does this method prevent creation of a
"doe_features" directory for devices which don't have any
DOE mailboxes?

(If it does, a code comment explaining that might be helpful.)


> +const struct attribute_group pci_dev_doe_feature_group = {
> +	.name	= "doe_features",
> +	.attrs	= pci_dev_doe_feature_attrs,
> +	.is_visible = pci_doe_sysfs_attr_is_visible,
> +};

Nit:  Wondering why the "=" is aligned for .name and .attrs
but not for .is_visible?


> +static void pci_doe_sysfs_feature_remove(struct pci_dev *pdev,
> +					 struct pci_doe_mb *doe_mb)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_attribute *attrs = doe_mb->sysfs_attrs;
> +	unsigned long i;
> +	void *entry;

Nit:  Inverse Christmas tree?


> +static int pci_doe_sysfs_feature_populate(struct pci_dev *pdev,
> +					  struct pci_doe_mb *doe_mb)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_attribute *attrs;
> +	unsigned long num_features = 0;
> +	unsigned long vid, type;
> +	unsigned long i;
> +	void *entry;
> +	int ret;
> +
> +	xa_for_each(&doe_mb->feats, i, entry)
> +		num_features++;
> +
> +	attrs = kcalloc(num_features, sizeof(*attrs), GFP_KERNEL);
> +	if (!attrs)
> +		return -ENOMEM;
> +
> +	doe_mb->sysfs_attrs = attrs;
> +	xa_for_each(&doe_mb->feats, i, entry) {
> +		sysfs_attr_init(&attrs[i].attr);
> +		vid = xa_to_value(entry) >> 8;
> +		type = xa_to_value(entry) & 0xFF;
> +		attrs[i].attr.name = kasprintf(GFP_KERNEL,
> +					       "0x%04lX:%02lX", vid, type);

Nit:  Capital X conversion specifier will result in upper case hex
characters in filename and contents, whereas existing sysfs attributes
such as "vendor", "device" contain lower case hex characters.

Might want to consider lower case x for consistency.


> +void pci_doe_sysfs_teardown(struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		pci_doe_sysfs_feature_remove(pdev, doe_mb);
> +	}

Nit:  Curly braces not necessary.


> @@ -1153,6 +1154,10 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
>  {
>  	int i;
>  
> +	if (IS_ENABLED(CONFIG_PCI_DOE)) {
> +		pci_doe_sysfs_teardown(pdev);
> +	}

Nit:  Curly braces not necessary.


> @@ -1230,6 +1235,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
>  	int i;
>  	int retval;
>  
> +	if (IS_ENABLED(CONFIG_PCI_DOE)) {
> +		retval = pci_doe_sysfs_init(pdev);
> +		if (retval)
> +			return retval;
> +	}
> +
>  	/* Expose the PCI resources from this device as files */
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {

I think this needs to be added to pci_create_sysfs_dev_files() instead.

pci_create_resource_files() only deals with creation of resource files,
as the name implies, which is unrelated to DOE features.

Worse, pci_create_resource_files() is also called from
pci_dev_resource_resize_attr(), i.e. every time user space
writes to the "resource##n##_resize" attributes.

Similarly, the call to pci_doe_sysfs_teardown() belongs in
pci_remove_sysfs_dev_files().

Thanks,

Lukas
