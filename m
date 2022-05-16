Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EB35293A8
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 00:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346817AbiEPWfe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 18:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiEPWfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 18:35:32 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F9636B43;
        Mon, 16 May 2022 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=NpPlI000Df83tLILxBmUWAGtNMcZvLgAm6/3k71RE7c=; b=nbbvOq1l/AOdW8AAdrmqYaX3SU
        +BKP4b1ioPIDOKq5mxiC8mxgQx+PJa8pqsNHrgF9heI1XStQtL1VX0tf8YSfIeC5w751r6d+sGV4m
        YCJFqNXQKwgefLzj15o31jE+GfMK9z76fYxadtGnYb6i1FY8ViSnTzZpTyFZpPgGCEuUhOxKi5nQK
        WJT6Mvc2WszLg5OliMAGH7cR5pd8ttOWl3E9TEyQMAcmT2ojXYYVSMGZ9dYV0NQR93BLhEDhzYmBC
        M1DHMP1xM4/0qw7GLD84zbXyXZ3nZo4nwnI3t7/sGUsGgETlEkwd5jum/jgKn5WGfRo2VcUk4VTcz
        z7jevUug==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nqjJC-0009d5-0n; Mon, 16 May 2022 16:35:22 -0600
Message-ID: <06e36931-33bf-7c3a-9b7f-afdd9686ccc5@deltatee.com>
Date:   Mon, 16 May 2022 16:35:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-CA
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20220407154717.7695-1-logang@deltatee.com>
 <32d5901d-f7d3-0701-0b72-1493897b025e@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <32d5901d-f7d3-0701-0b72-1493897b025e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: chaitanyak@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v6 00/21] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-05-16 16:31, Chaitanya Kulkarni wrote:
> Do you have any plans to re-spin this ?

I didn't get any feedback this cycle, so there haven't been any changes.
I'll probably do a rebase and resend after the merge window.

Logan
