Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA8F77EAEE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 22:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346221AbjHPUm2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 16:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346290AbjHPUmU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 16:42:20 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E55E2716;
        Wed, 16 Aug 2023 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=sw8EX7W/LW/Jwme06SDZwl0frTKXlowZ9/wflHHWXPQ=; b=Aqu7s3SdwVz/lN2At96Rmazjj1
        8cWtZYYC1CTExE9ndC23BXoWFlx7H+PTgI7FHH7n6mxNqBAuSP5gjdehoXJQGpylYhWao/NPMdm21
        YhDMGKTMlJsCZxdpvdB9ClM2D62zF4GkBPIek643q7j/SI5+H+oRlmgIhtX69GAURgtvGQg7XHu3H
        jyPs7ZJZpfw6FqM/4EM9hEaGS+GbPs3ZuRnhvKUxa+P89mDtz9/p3uIpQlcaVo1ss+VSweWUDI081
        a/+5sGu9eLe6lpOGHgslbYPvrSYXrabwF26KeVSLL8AKawtkaBvee4kwjzFTcW7u4sSifW3HRUk+f
        MPJw7dig==;
Received: from d75-158-34-12.abhsia.telus.net ([75.158.34.12] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1qWNKz-00DCsd-UK; Wed, 16 Aug 2023 14:41:54 -0600
Message-ID: <36368b25-0c13-107b-d1ba-77df7fac036d@deltatee.com>
Date:   Wed, 16 Aug 2023 14:41:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>, kurt.schwemmer@microsemi.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc:     linux-pci@vger.kernel.org, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230816083305.1426718-1-yajun.deng@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230816083305.1426718-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 75.158.34.12
X-SA-Exim-Rcpt-To: yajun.deng@linux.dev, kurt.schwemmer@microsemi.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] ntb_hw_switchtec: Fix shift-out-of-bounds in
 switchtec_ntb_mw_set_trans
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-08-16 02:33, Yajun Deng wrote:
> There is a kernel API ntb_mw_clear_trans() would pass 0 to both addr and
> size. This would make xlate_pos negative.
> 
> [   23.734156] switchtec switchtec0: MW 0: part 0 addr 0x0000000000000000 size 0x0000000000000000
> [   23.734158] ================================================================================
> [   23.734172] UBSAN: shift-out-of-bounds in drivers/ntb/hw/mscc/ntb_hw_switchtec.c:293:7
> [   23.734418] shift exponent -1 is negative
> 
> Ensuring xlate_pos is a positive or zero before BIT.
> 
> Fixes: 1e2fd202f859 ("ntb_hw_switchtec: Check for alignment of the buffer in mw_set_trans()")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

That makes sense. Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
