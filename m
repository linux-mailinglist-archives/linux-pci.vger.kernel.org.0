Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB534E2DB9
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 17:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiCUQUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 12:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351003AbiCUQT7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 12:19:59 -0400
X-Greylist: delayed 1945 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Mar 2022 09:18:32 PDT
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE363F898
        for <linux-pci@vger.kernel.org>; Mon, 21 Mar 2022 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=0uN8O5/IyHHZMoLNzIJxeGa6UW5nG/jE1qpz2EKQBMo=; b=TJsD0mSm7pqbbOGonKHQ25ghIt
        L4AOP+BjjmPPvRfcUXvWkahX8KDVKVCu90x9/mPhWN1xpiGAhP6UQl614j4o0zwnj36lUV5rKD/ZY
        FhUIriS3KZ04u+U1pj7Ktba04xBEVTKhKJm1lffBe3cfCiw67XXkvFLuHjBgzyq2pc77gJy8HXI//
        rXANn3gwlTuRIPfb/NfmYps3umMc5ndUBLntEcC6bCVp4s3Ed7aIeuWeO6fyl4mxfhNLk/6tPFHht
        wE3PHrYDhNKrdQ3t9T/i/9gnCcbWeFEgsDJFoO6+zT2Ue+jgko9WhqUXoWlzrtY3kjoCW6IdAY7Ue
        gLJaXKLA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nWKEP-005XdR-FC; Mon, 21 Mar 2022 09:46:05 -0600
Message-ID: <981016a7-f994-f0dd-422e-66ac909371c7@deltatee.com>
Date:   Mon, 21 Mar 2022 09:46:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-CA
To:     Shlomo Pongratz <shlomopongratz@gmail.com>,
        linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        bhelgaas@google.com, Shlomo Pongratz <shlomop@pliops.com>
References: <20220321143120.12191-1-shlomop@pliops.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220321143120.12191-1-shlomop@pliops.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: shlomopongratz@gmail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, andrew.maier@eideticom.com, bhelgaas@google.com, shlomop@pliops.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v1] Intel Sky Lake-E host root ports check.
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-03-21 08:31, Shlomo Pongratz wrote:
> On commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to the whitelist")
> Andrew Maier added the Sky Lake-E additional devices
> 2031, 2032 and 2033 root ports to the already existing 2030 device.
> Note that the Intel devices 2030, 2031, 2032 and 2033 are ports A, B, C and D.
> Consider on a bus X only port C is connected downstream so in the PCI scan only
> device 8086:2032 on 0000:X:02.0 will be found as bridges that have no children are ignored.
> As a result the routine pci_host_bridge_dev will return NULL for devices under slot C.
> In the proposed patch port field is added to the whitelist which is 0 for 2030, 1 for 2031,
> 2 for 2032 3 for 2033 and 0 for all other devices.

The patch looks largely ok, but I'm not sure I follow this description.

It sounds like in practice the host bridges B, C and D are not addressed
at function 0 as was assumed. But what does it mean that only C is
connected downstream? How can a bridge not be connected downstream?


> Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
> ---
>  drivers/pci/p2pdma.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 1015274bd2fe..86f6594a0b8a 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -305,22 +305,23 @@ static bool cpu_supports_p2pdma(void)
>  static const struct pci_p2pdma_whitelist_entry {
>  	unsigned short vendor;
>  	unsigned short device;
> +	unsigned short port;
>  	enum {
>  		REQ_SAME_HOST_BRIDGE	= 1 << 0,
>  	} flags;

If port is placed after flags then we only need to add the port for the
three devices that care about it. Designated initializers will set it to
0 if it is omitted.

>  } pci_p2pdma_whitelist[] = {
>  	/* Intel Xeon E5/Core i7 */
> -	{PCI_VENDOR_ID_INTEL,	0x3c00, REQ_SAME_HOST_BRIDGE},
> -	{PCI_VENDOR_ID_INTEL,	0x3c01, REQ_SAME_HOST_BRIDGE},
> +	{PCI_VENDOR_ID_INTEL,	0x3c00, 0, REQ_SAME_HOST_BRIDGE},
> +	{PCI_VENDOR_ID_INTEL,	0x3c01, 0, REQ_SAME_HOST_BRIDGE},
>  	/* Intel Xeon E7 v3/Xeon E5 v3/Core i7 */
> -	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
> -	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
> +	{PCI_VENDOR_ID_INTEL,	0x2f00, 0, REQ_SAME_HOST_BRIDGE},
> +	{PCI_VENDOR_ID_INTEL,	0x2f01, 0, REQ_SAME_HOST_BRIDGE},
>  	/* Intel SkyLake-E */
> -	{PCI_VENDOR_ID_INTEL,	0x2030, 0},
> -	{PCI_VENDOR_ID_INTEL,	0x2031, 0},
> -	{PCI_VENDOR_ID_INTEL,	0x2032, 0},
> -	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
> -	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2030, 0, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2031, 1, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2032, 2, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2033, 3, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2020, 0, 0},
>  	{}
>  };
>  
>

Logan
