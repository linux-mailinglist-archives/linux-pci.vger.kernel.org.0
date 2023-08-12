Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D970779CA5
	for <lists+linux-pci@lfdr.de>; Sat, 12 Aug 2023 04:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjHLCg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 22:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbjHLCg4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 22:36:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258FD2683;
        Fri, 11 Aug 2023 19:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=4z/qOob4uBWAd1rheJ69DtL9lYWGYCF4g3CdPVYsPpw=; b=KJfyeW5epkiQBEI9VSl3qTrAfK
        +p4LvERsL1v9Y8e+e6uByLu3L3ZRIU24U6ZIL9oc87ACxha1YpP3QQJo7VKZdYaCW00dRWUxwBGTk
        zQMzM5aQU8Ra3XiO0d7jpUS8pRSHjAG39sqPlMye/gEkV0IOGXf1neNIMbtyVagKW1O+skUgdCMOG
        pucfobtHqoIvMiQe4075cileYS92NzfndBDOnM7pQP2n3Q0kJSnG8w99CmNz27UYseglF2vnV0Ups
        mV3xknhbYRcELeB+gcjHWzjRPu6aMpqO98lTNJkvXeb5ex27fFI4xJa9B8F93b4928U5X7RCv1bMV
        ghyWwFlg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUeUj-00CUud-1p;
        Sat, 12 Aug 2023 02:36:49 +0000
Message-ID: <acded232-0c6b-a745-a2ba-22159d43b130@infradead.org>
Date:   Fri, 11 Aug 2023 19:36:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5] PCI/DOE: Expose the DOE protocols via sysfs
Content-Language: en-US
To:     Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        Alistair Francis <alistair.francis@wdc.com>
References: <20230812004453.1241736-1-alistair.francis@wdc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230812004453.1241736-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi--

On 8/11/23 17:44, Alistair Francis wrote:
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ecf47559f495..1002a276dac9 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -500,3 +500,14 @@ Description:
>  		console drivers from the device.  Raw users of pci-sysfs
>  		resourceN attributes must be terminated prior to resizing.
>  		Success of the resizing operation is not guaranteed.
> +
> +What:		/sys/bus/pci/devices/.../doe_protocols
> +Date:		August 2023
> +Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
> +Description:
> +		This directory contains a list of the supported
> +		Data Object Exchange (DOE) features. The feature values are in the
> +		file name. The contents of each file is the same as the name.

Either
		               contents              are
or
		               content               is

> +		The value comes from the device and specifies the vendor and
> +		data object type supported. The lower byte is the data object
> +		type and the next two bytes are the vendor ID.

-- 
~Randy
