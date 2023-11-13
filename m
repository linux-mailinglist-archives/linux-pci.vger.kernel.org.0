Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59B07EA23F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 18:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjKMRnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 12:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjKMRnQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 12:43:16 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6711C171A;
        Mon, 13 Nov 2023 09:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=qakUNyCfhZ+dCkJi5eky2DzuNS8lnx39d2dRA/FKlqY=; b=FCC1WEgxXyl6HYa6/ZkNsTP6o1
        TMBnKFggBpvkjwXsQ14v/5i/zuaVuCeYdkqYUg+ELDAEBmFv05xbj9zJQFbLw28+kcD1EmnoXdZh3
        /gs9QoWS3fMIYhsMc9SRzNpcaBYeGp71BXxx13Xldv3QLYzlpPeHH9TsQA3x2jMnV8r3Aumjf7Udo
        0KX3TI6d0zNY9x5l9HpUB/1wENZnkMNiFk8HbR8V/N4JINtt2QqAEuoA4iOc3s964GjFz+yajteOB
        B2EQpG8pEdVtIng/GIQ+jDyKWamSDrWO2Ro7Qh2nTYKovCbyl4gCaBfyaBkhCxvX0ruW0xSD8ye17
        1ZJDnx3A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1r2axn-004mSL-Ha; Mon, 13 Nov 2023 10:43:08 -0700
Message-ID: <6eb84bc5-dd58-4745-8e99-ccc97c10fb63@deltatee.com>
Date:   Mon, 13 Nov 2023 10:43:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-CA
To:     Tadeusz Struk <tstruk@gigaio.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, stable@kernel.org,
        Tadeusz Struk <tstruk@gmail.com>
References: <20231111092239.308767-1-tstruk@gmail.com>
 <8899b3e9-50bd-4356-9c94-d2d8a5256b0b@deltatee.com>
 <777d9449-0207-401b-a239-40110fab2977@gigaio.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <777d9449-0207-401b-a239-40110fab2977@gigaio.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: tstruk@gigaio.com, bhelgaas@google.com, corbet@lwn.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, stable@kernel.org, tstruk@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH] Documentation: PCI/P2PDMA: Remove reference to
 pci_p2pdma_map_sg()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-11-13 10:23, Tadeusz Struk wrote:
> On 11/13/23 17:44, Logan Gunthorpe wrote:
>> Might make sense to rework this next paragraph as well seeing it
>> references the P2P mapping functions that no longer exist.
>>
>> Thanks for cleaning up the documentation I forgot about!
> 
> Ok, I will need to check exactly what was removed when.
> Currently I'm working with v6.1, and all the other functions are
> still there in this version.

The function still exists, but it's talking about using it to decide
when to use the map functions that are gone. Could probably just drop
the paragraph.

> The pci_p2pdma_[un]map_sg() functions are gone since v6.0.
> If you want to take this one, I will follow up with updates that
> apply to more recent versions.

Unfortunately I don't have the time at the moment to look at it.

Logan
