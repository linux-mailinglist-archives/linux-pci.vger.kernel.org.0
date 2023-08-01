Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F33076B5CE
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 15:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjHAN2G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjHAN2F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 09:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB31198D;
        Tue,  1 Aug 2023 06:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C17461578;
        Tue,  1 Aug 2023 13:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120F1C433C8;
        Tue,  1 Aug 2023 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690896483;
        bh=POuWFteD3NwA48P4giSN15tn5wUCxk+0SLbPWhwKI1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZy5iGa+0PyePRL83vCsD7AcTmJDu92hgT67FTpRqaYniYSnnkjOzP5T9UutXTD8C
         msGNzPV0r1Cxoy/vgMMHzMoKx/HB7Kegr25jbbehYYb+H6zsFfEGEL+yA5ucmsC1lo
         YuSQCpqa0GEswQjznCPZ4ZmYWOh5kJAb6oDQqes0=
Date:   Tue, 1 Aug 2023 15:28:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <2023080152-disobey-widen-65a4@gregkh>
References: <20230801121824.174556-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801121824.174556-1-alistair.francis@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 01, 2023 at 08:18:24AM -0400, Alistair Francis wrote:
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
> By exposing the information to userspace tools like lspci can relay the
> information to users. By listing all of the supported protocols we can
> allow userspace to parse and support the list, which might include
> vendor specific protocols as well as yet to be supported protocols.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 11 ++++++
>  drivers/pci/doe.c                       | 52 +++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c                 |  8 ++++
>  include/linux/pci-doe.h                 |  2 +
>  4 files changed, 73 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ecf47559f495..ae969bbfa631 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -500,3 +500,14 @@ Description:
>  		console drivers from the device.  Raw users of pci-sysfs
>  		resourceN attributes must be terminated prior to resizing.
>  		Success of the resizing operation is not guaranteed.
> +
> +What:		/sys/bus/pci/devices/.../doe_proto
> +Date:		July 2023
> +Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
> +Description:
> +		This file contains a list of the supported Data Object Exchange (DOE)
> +		protocols. The protocols are seperated by newlines.
> +		The value comes from the device and specifies the vendor and
> +		protocol supported. The lower byte is the protocol and the next
> +		two bytes are the vendor ID.
> +		The file is read only.

Sorry, but sysfs files are "one value per file", you can't have a "list
of protocols with new lines" in a one value-per-file rule.


> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 1b97a5ab71a9..70900b79b239 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -563,6 +563,58 @@ static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
>  	return false;
>  }
>  
> +#ifdef CONFIG_SYSFS
> +/**
> + * pci_doe_sysfs_proto_supports() - Write the supported DOE protocols
> + *			     to a sysfs buffer
> + * @doe_mb: DOE mailbox capability to query
> + * @buf: buffer to store the sysfs strings
> + * @offset: offset in buffer to store the sysfs strings
> + *
> + * RETURNS: The number of bytes written, 0 means an error occured
> + */
> +static unsigned long pci_doe_sysfs_proto_supports(struct pci_doe_mb *doe_mb,
> +						  char *buf, ssize_t offset)
> +{
> +	unsigned long index;
> +	ssize_t ret = offset;
> +	ssize_t r;
> +	void *entry;
> +
> +	xa_for_each(&doe_mb->prots, index, entry) {
> +		r = sysfs_emit_at(buf, ret, "0x%08lX\n", xa_to_value(entry));
> +

No need for a blank line.

> +		if (r == 0)
> +			return ret;



> +
> +		ret += r;
> +	}
> +
> +	return ret;
> +}
> +
> +ssize_t doe_proto_show(struct device *dev, struct device_attribute *attr,
> +		       char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	unsigned long index;
> +	ssize_t ret = 0;
> +	ssize_t r;
> +	struct pci_doe_mb *doe_mb;
> +
> +	xa_for_each(&pci_dev->doe_mbs, index, doe_mb) {
> +		r = pci_doe_sysfs_proto_supports(doe_mb, buf, ret);
> +
> +		if (r == 0)
> +			return ret;
> +
> +		ret += r;
> +	}

So this is going to be a lot of data, what is ensuring that you didn't
truncate it?  Which again, is the reason why this is not a good idea for
sysfs, sorry.

What userspace tool wants this information?

thanks,

greg k-h
