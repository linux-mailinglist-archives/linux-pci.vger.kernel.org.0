Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35DA717CEF
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 12:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjEaKN0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 06:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbjEaKNY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 06:13:24 -0400
X-Greylist: delayed 939 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 03:13:20 PDT
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C004C188
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2023 03:13:20 -0700 (PDT)
Received: from [167.98.27.226] (helo=[10.35.5.28])
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1q4IaI-0087hR-P2; Wed, 31 May 2023 10:57:39 +0100
Message-ID: <9d4f0f57-0458-987f-d9e7-0ece2a2476b9@codethink.co.uk>
Date:   Wed, 31 May 2023 10:57:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pci: add PCI_EXT_CAP_ID_PL_32GT define
Content-Language: en-GB
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Jude Onyenegecha <jude.onyenegecha@codethink.co.uk>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
References: <20230531095545.293063-1-ben.dooks@codethink.co.uk>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20230531095545.293063-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31/05/2023 10:55, Ben Dooks wrote:
> From: Ben Dooks <ben.dooks@sifive.com>
> 
> Add the define for PCI_EXT_CAP_ID_PL_32GT for drivers that
> will want this whilst doing Gen5/Gen6 accesses.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   include/uapi/linux/pci_regs.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index dc2000e0fe3a..e5f558d96493 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -738,6 +738,7 @@
>   #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>   #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>   #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> +#define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>   #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
>   #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE

Just noticed this isn't tab indented, so fixed and sent a v2.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

