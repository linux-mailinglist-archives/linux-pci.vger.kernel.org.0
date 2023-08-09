Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109A5776CD9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 01:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjHIXoA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 19:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIXn7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 19:43:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716C3F7;
        Wed,  9 Aug 2023 16:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=qZMluxVFdARgESBS1ke/4bB3q9Q5vdFc0ypjEN05320=; b=OE7LIdGTMlMeQvvoYiS2Z+F/X+
        23jtGaM3Pm1P8RMk7HkXaMtMWSA0fPshWlAhmhJhTwrxNnk0dV4BOQvpZ4CzxzbRler4Qxh9lCWm4
        0nWEKKtan2eLvdntDTmvrqTZ35TpwmFOcSkdjNxwlkgR1ZoArqeyWSihumSr++SgnyjZ/bzcf5Lq4
        TJEb9nFdnDFd0K2H3cczKZBHF/HRahI8dSJnaQijqP5MdmE8iC/q2zlOSYbIN8fBMaiv+mXnSjIXA
        WjElslnvrrUJNChxmVCxt0Dk6lVpGevKidBb2g0yWVv27hFGG7N4wD5U21XDK3z86uBBpTNfXXmP2
        6R7zW3uA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTsqH-0064mE-0P;
        Wed, 09 Aug 2023 23:43:53 +0000
Message-ID: <fa02c06c-11f7-0900-1cee-21c491f929fd@infradead.org>
Date:   Wed, 9 Aug 2023 16:43:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] PCI/DOE: Expose the DOE protocols via sysfs
Content-Language: en-US
To:     Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
References: <20230809232851.1004023-1-alistair.francis@wdc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230809232851.1004023-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi--

On 8/9/23 16:28, Alistair Francis wrote:
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
> v3:
>  - Expose each DOE feature as a separate file
> 
>  Documentation/ABI/testing/sysfs-bus-pci |  10 +++
>  drivers/pci/doe.c                       | 107 ++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c                 |   7 ++
>  include/linux/pci-doe.h                 |   1 +
>  4 files changed, 125 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ecf47559f495..e754b8efdb69 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -500,3 +500,13 @@ Description:
>  		console drivers from the device.  Raw users of pci-sysfs
>  		resourceN attributes must be terminated prior to resizing.
>  		Success of the resizing operation is not guaranteed.
> +
> +What:		/sys/bus/pci/devices/.../doe_proto

Should this be                                   doe_protos
? like this:
+	.name	= "doe_protos",


> +Date:		July 2023
> +Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
> +Description:
> +		This diectory contains a list of the supported Data Object Exchange (DOE)

		     directory

> +		features. Each feature is a single file.

		The feature values are in the file name; the files have no contents.
?

> +		The value comes from the device and specifies the vendor and
> +		data object type supported. The lower byte is the data object type and the next
> +		two bytes are the vendor ID.

-- 
~Randy
