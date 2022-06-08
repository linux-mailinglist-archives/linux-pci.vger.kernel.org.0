Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EDE543CE0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 21:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiFHT3T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 15:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiFHT2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 15:28:30 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78315C8BF;
        Wed,  8 Jun 2022 12:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=jzw+GWOG9Mfo0ITA4LZ9XZSuZUbnK+zW/G3KRzWMyhM=; b=L2Su555++vPsLsMQ/LOPbzg0VM
        OIDSzfYDrYarzgNd/CHqdmT+bxgaYJ0yXhc4lHn6HFxF5Y5NWDhTfnlKfqxYto6f5wBOvZfHHFv3I
        X0CgPBUgoGYIkpx+o1TXyKL8rn7QPse+MQeqxlNy+O0gtA0WvfAduEiDIkL54UKNPTn3L3QOsZTob
        KKtuhBBhh0uZ1yuc3IpJ1j8lGkCPDNGEcNeWvxwpXJzc7d3vZTVF2+j9pQtvD5z8rVvdrItu5M+rL
        e64zOFtM43aBXQx9mFccZO64X91LRqYj/zAwTKo/pq6G+0/NPJTFHOmCs6MjLU0Lvu3aZrBrDCy/W
        L9D2NtIg==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nz1Lj-002A3y-39; Wed, 08 Jun 2022 13:28:15 -0600
Message-ID: <bb078344-2394-e9a6-712c-8dfa8afff6d3@deltatee.com>
Date:   Wed, 8 Jun 2022 13:28:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, Ke Liu <liuke94@huawei.com>
Cc:     bhelgaas@google.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608184259.GA410049@bhelgaas>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220608184259.GA410049@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: helgaas@kernel.org, liuke94@huawei.com, bhelgaas@google.com, nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev, lpieralisi@kernel.org, robh@kernel.org, kw@linux.com, kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v2] drivers: pci: Directly use ida_alloc()/free()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-06-08 12:42, Bjorn Helgaas wrote:
> On Thu, Jun 02, 2022 at 07:11:15AM +0000, Ke Liu wrote:
>> Use ida_alloc()/ida_free() instead of deprecated
>> ida_simple_get()/ida_simple_remove().
>>
>> Signed-off-by: Ke Liu <liuke94@huawei.com>
> 
> I'd like acks from a vmd maintainer (Nirmal) and a switchtec
> maintainer (Kirt, Logan) before applying this.
> 
> You don't need to post this again with those acks, but if you do post
> it again for some reason, take note of the subject line history; see
> "git log --oneline drivers/pci/controller/ drivers/pci/switch/"
>> ---
>> v2	fix sign-off name suggest by Bjorn Helgaas
>> ---
>>  drivers/pci/controller/vmd.c   | 6 +++---
>>  drivers/pci/switch/switchtec.c | 7 +++----
>>  2 files changed, 6 insertions(+), 7 deletions(-)


Oh, yup, looks good to me. Thanks!

Acked-by: Logan Gunthorpe <logang@deltatee.com>

Logan
