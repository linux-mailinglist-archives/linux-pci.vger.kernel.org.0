Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7688A7B48FA
	for <lists+linux-pci@lfdr.de>; Sun,  1 Oct 2023 19:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjJARxh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Oct 2023 13:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjJARxh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Oct 2023 13:53:37 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7772D9;
        Sun,  1 Oct 2023 10:53:33 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id C0877300000BE;
        Sun,  1 Oct 2023 19:53:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B40DE17C3E; Sun,  1 Oct 2023 19:53:31 +0200 (CEST)
Date:   Sun, 1 Oct 2023 19:53:31 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
        christian.koenig@amd.com, kch@nvidia.com,
        gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v8 2/3] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20231001175331.GA13453@wunner.de>
References: <20230921055531.2028834-1-alistair.francis@wdc.com>
 <20230921055531.2028834-2-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921055531.2028834-2-alistair.francis@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 21, 2023 at 03:55:30PM +1000, Alistair Francis wrote:
> The PCIe 6 specification added support for the Data Object Exchange (DOE).
> When DOE is supported the Discovery Data Object Protocol must be

"... the DOE Discovery *Feature* must be implemented per PCIe r6.1
sec 6.30.1.1"


> implemented. The protocol allows a requester to obtain information about
> the other DOE features supported by the device.
> 
> The kernel is already querying the DOE features supported and cacheing
> the values. This patch exposes the values via sysfs. This will allow

Instead of "This patch ...", prefer imperative mood, i.e.:
"Expose the values in sysfs to allow user space to ..."


> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -500,3 +500,26 @@ Description:
>  		console drivers from the device.  Raw users of pci-sysfs
>  		resourceN attributes must be terminated prior to resizing.
>  		Success of the resizing operation is not guaranteed.
> +
> +What:		/sys/bus/pci/devices/.../doe_features
> +Date:		August 2023

Date says August but patch submission is from September.


> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -47,6 +47,7 @@
>   * @wq: Wait queue for work item
>   * @work_queue: Queue of pci_doe_work items
>   * @flags: Bit array of PCI_DOE_FLAG_* flags
> + * @sysfs_attrs: Array of sysfs device attributes

What's the purpose of this pointer?  It's set in
pci_doe_sysfs_feature_supports() but never used for anything.

I'm guessing that you meant to use it to tear down the added attributes
on device removal, but that's missing in the patch.

The attributes are added with sysfs_add_file_to_group(), but it seems
to me they're not automatically removed by sysfs_remove_groups() on
device teardown.  Am I missing something?


> +static int pci_doe_sysfs_feature_supports(struct pci_dev *pdev,
> +					  struct pci_doe_mb *doe_mb)

I don't quite understand the meaning of the function name:
It sounds as if its purpose is to determine whether a feature
is supported.  Maybe something like pci_doe_sysfs_add_features()
instead?


> +	doe_mb->sysfs_attrs = attrs;

Set this after the xa_for_each() loop to avoid having to reset it
to NULL on error.


> +		attrs[i].show = pci_doe_sysfs_feature_show;
> +
> +		ret = sysfs_add_file_to_group(&dev->kobj, &attrs[i].attr,
> +					      pci_dev_doe_feature_group.name);
> +		if (ret) {
> +			attrs[i].show = NULL;
> +			goto fail;
> +		}

The purpose of resetting attrs[i].show to NULL in the error path
seems to be that you want to skip over features which haven't
been created as attributes yet.

It seems more straightforward to just iterate over the elements
in attrs[] until you reach one whose mode is 0.

Alternatively, use xa_for_each_range(&doe_mb->feats, i, entry, 0, i - 1).


> +int doe_sysfs_init(struct pci_dev *pdev)

Rename to pci_doe_sysfs_init() for consistency.


> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -186,6 +186,9 @@ extern const struct attribute_group *pci_dev_groups[];
>  extern const struct attribute_group *pcibus_groups[];
>  extern const struct device_type pci_dev_type;
>  extern const struct attribute_group *pci_bus_groups[];
> +#ifdef CONFIG_SYSFS
> +extern const struct attribute_group pci_dev_doe_feature_group;
> +#endif

No #ifdef necessary.

Thanks,

Lukas
