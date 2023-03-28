Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897546CC95C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjC1Rg0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 13:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjC1RgZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 13:36:25 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F391D510;
        Tue, 28 Mar 2023 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=UPxRSwVrPyIK71gfH3NckS35CBxZJ2s/oLf4mXb2RAA=; b=ie8m3VB0GH0i7rRKeh5SoWWHoY
        gXr145ASpB5e3vjTGrcJKofeJAJsZIOHhuKKzLG+v3uIHpzDNumVFtEd/0DtcZVUICPyeoh90MbMB
        7E5bN/zB8c31XQelLwYTUgClEQj1+BvbUdpl+DmlLElYnNv5ngzacUW5z7M4nirVpTB58yWM5P6ij
        mVuXFCeuJFjoyXFq0xlHPhpcWH+c4ddC8j4sUs5DUWZ5mux6Y70WuttuVMYzjkZqV2K84DTS4+1uS
        pUIWDmY3lAeRlxcAf/LR/A257QEkHsQownrYWZ11xqxj+8C7OMZVDnH/F81vE/ep9ZgnmYAMQHxSs
        ztKpvClw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1phDF1-00BzJv-Px; Tue, 28 Mar 2023 11:36:16 -0600
Message-ID: <5017f565-1047-6f0c-e578-e8ed9d31802f@deltatee.com>
Date:   Tue, 28 Mar 2023 11:36:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230328173448.GA2952425@bhelgaas>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230328173448.GA2952425@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: helgaas@kernel.org, cai.huoqing@linux.dev, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2] PCI/P2PDMA: Fix the comments on pci_p2pmem_find_many()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-03-28 11:34, Bjorn Helgaas wrote:
> On Tue, Mar 28, 2023 at 07:06:10PM +0800, Cai Huoqing wrote:
>> Remove pci_p2pmem_dma() reference,
>> because pci_p2pmem_dma() method is already removed.
> 
> AFAICT, pci_p2pmem_dma() *never* existed.  I suppose it was a typo,
> and pci_p2pdma_distance_many() was intended?
> 
> I'm happy to either merge this patch (with an updated commit log) to
> remove the comment text or merge a patch correct the comment text.
> 
> I just don't want to merge this with a commit log that says we removed
> the pci_p2pmem_dma() method when it never actually existed.

Ah, yes that's fair. I thought pci_p2pmem_dma() was an odd function
name. Good to confirm it never existed.

Thanks,

Logan
