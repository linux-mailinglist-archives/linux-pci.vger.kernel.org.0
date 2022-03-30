Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440D04EC80F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 17:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243704AbiC3PWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 11:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbiC3PWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 11:22:21 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2567C190EA0;
        Wed, 30 Mar 2022 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=9wM6FQB7fW1D8tg4Fc2Q9KgBOZZpfHiBHzAL+ITMNbY=; b=o+QKq04kVAnT6POMwoZ/FBmjbv
        pwtdHUbqYteLwliqYlLp87bmyLjoTxqPaKqX0DfvX8VPMxhf4SyXoy3lN1+KY0/a+KTARCHcjqE9f
        9JvwMouO7BVrkBwa/Om5HJ5mV9/I/+JemzvkbnqyWxYkQujweQFUyFJi2Tu38/YUce4FrgslV5aCW
        hOk5lkQTxolNxvjg5Ki3PJ5MttsKd8mt0JDz58udYckZ0pwluJ2cy6SjXGTLOxmF+OL+4V1ywbmLx
        3s2gBG7qUwOZW8+WjdMTb01RsPb9NTjLyv2oefy112bazpDowFhzofy7djnA1amsAeCUMD7Uy4WLD
        KLlP7P0w==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nZa7Z-00D4UW-Ki; Wed, 30 Mar 2022 09:20:30 -0600
Message-ID: <d8e5e5ce-aac3-fe37-d710-88639a1a62f3@deltatee.com>
Date:   Wed, 30 Mar 2022 09:20:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-CA
To:     Shlomo Pongratz <shlomopongratz@gmail.com>,
        linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        bhelgaas@google.com, jgg@nvidia.com, helgaas@kernel.org,
        Shlomo Pongratz <shlomop@pliops.com>
References: <20220330140823.28826-1-shlomop@pliops.com>
 <20220330140823.28826-2-shlomop@pliops.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220330140823.28826-2-shlomop@pliops.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: shlomopongratz@gmail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, andrew.maier@eideticom.com, bhelgaas@google.com, jgg@nvidia.com, helgaas@kernel.org, shlomop@pliops.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH V4 1/1] Intel Sky Lake-E host root ports check.
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2022-03-30 08:08, Shlomo Pongratz wrote:
> In commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to
> the whitelist")
> Andrew Maier added the Sky Lake-E additional devices
> 2031, 2032 and 2033 root ports to the already existing 2030 device.
> 
> The Intel devices 2030, 2031, 2032 and 2033 which are root ports A, B, C and D,
> respectively and if all exist they will occupy slots 0 till 3 in that order.
> 
> The original code handled only the case where the devices in the whiltlist are

s/whiltlist/whitelist/

> host bridges and assumed that they will be found on slot 0.
> 
> This assumption doesn't hold for root ports so an explicit test was added to
> cover this case.
> 
> Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>

This patch looks good to me. Much cleaner and easier to understand than
the previous ones.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
