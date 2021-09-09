Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAACE405B4F
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbhIIQw2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 12:52:28 -0400
Received: from ale.deltatee.com ([204.191.154.188]:53188 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbhIIQwY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Sep 2021 12:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=YtcxtM2RbgTic/9NhzdoONL1C+9xeRtzN770QHck5PY=; b=Gq6aTGAg4XeCQAHjIOeJU6/6Ss
        OUPL9qiZpS2odtm4q2meLIjIpvpj+gS0x7STykqChPo+osVFbChNL2F01ETE5W4MO5CFmJoMjsNOT
        wbymCOHB9bqma2wTIyyQWO9nUtTzNJ0jSXQqHe0Ae+rmNHBmvRzc+d9oUvRgl392F3FO23KM5RQpw
        X2dC6OOz/Qutclae9csQYT01pAb7FU1aHIhrpWGxQF28FzXGsSmkndnk+q+pRg3gOJgHbT//lC/pf
        GDUw6rGYcdrbFqj2A7uOOwRpv06OcWFSG+qGPyrM9DEJnukPpRPcPI8k/e2RTOQda4lU64NhHaWaC
        4am0y9Fw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mONGX-0006AA-Jj; Thu, 09 Sep 2021 10:51:11 -0600
To:     Wang Lu <wanglu@dapustor.com>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210909032528.24517-1-wanglu@dapustor.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8e3b718c-1a74-232c-0e4c-9cc76d3ae1ac@deltatee.com>
Date:   Thu, 9 Sep 2021 10:51:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210909032528.24517-1-wanglu@dapustor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, wanglu@dapustor.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: fix the wrong dma address calculation when
 map sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2021-09-08 9:25 p.m., Wang Lu wrote:
> The bus offset is bus address - physical address,
> so the calculation in __pci_p2pdma_map_sg should be:
> bus address = physical address + bus offset.
> 
> Signed-off-by: Wang Lu <wanglu@dapustor.com>

Thanks, yes I believe my math was wrong here.

It was never tested on any machine that has a non-zero bus-offset.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
