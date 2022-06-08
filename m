Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BF1543FE8
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 01:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiFHXe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 19:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiFHXez (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 19:34:55 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D54716A276;
        Wed,  8 Jun 2022 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=x9c5o5XgezQf9D1LfsqIL78gxzpEYVR1h8VzU25lTjc=; b=XrTFkKpYpoUSWv4ATu6NRiKEF3
        3Bj3KlHb8ku0JYiT6RD3F0zFFwkpKQx2j+zk1XpFudXT/Dpf6DgaePz0baHs2Z2Rde86Bl2+HbRKT
        dOBGAyioIKVQUSBpAArpVE+eFPYvNOeq92mWe/oWxLBq8zXwOQZsihWMFiSmhyvDOUX60Okq17mUe
        2V1GypBMwftFVJCopyu2bhHOoD/nQ5YopiwsR+bYm0WFvYRDnomyZf6y6zQzjq27f3ocNomZNEs4h
        /G/Q1i1oBcOB//dnUUG76jygsg/g5e4ghL72gmeKDiTrq8zDCXJN0nyDb9Dca1VnG2gpw2ChM9Cyr
        5uNKw7QA==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nz5C7-002E5A-RG; Wed, 08 Jun 2022 17:34:36 -0600
Message-ID: <31d462be-c5c9-c895-0760-6b4a5cedfd14@deltatee.com>
Date:   Wed, 8 Jun 2022 17:34:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, linux-pci@vger.kernel.org
References: <20220608211146.GA422296@bhelgaas>
 <d5d0cc2e-79e1-3248-0f55-8f1afd21f926@gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <d5d0cc2e-79e1-3248-0f55-8f1afd21f926@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: kent.overstreet@gmail.com, helgaas@kernel.org, linux-kernel@vger.kernel.org, pmladek@suse.com, rostedt@goodmis.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v3 29/33] PCI/P2PDMA: Convert to printbuf
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-06-08 17:24, Kent Overstreet wrote:
> On 6/8/22 17:11, Bjorn Helgaas wrote:
>> [+cc Logan, maintainer of p2pdma.c]
>>
>> On Sat, Jun 04, 2022 at 03:30:38PM -0400, Kent Overstreet wrote:
>>> This converts from seq_buf to printbuf. We're using printbuf in external
>>> buffer mode, so it's a direct conversion, aside from some trivial
>>> refactoring in cpu_show_meltdown() to make the code more consistent.
>>
>> cpu_show_meltdown() doesn't appear in p2pdma.c.  Leftover from another
>> patch?  Maybe from 27/33 ("powerpc: Convert to printbuf")?
>>
>> I'm not opposed to this, but it would be nice to say what the benefit
>> is.  How is printbuf better than seq_buf?  It's not obvious from the
>> patch how this is better/safer/shorter/etc.
>>
>> Even the cover letter [1] is not very clear about the benefit.  Yes, I
>> see it has something to do with improving buffer management, and I
>> know from experience that's a pain.  Concrete examples of typical
>> printbuf usage and bugs that printbufs avoid would be helpful.
> 
> Take a look at the vsprintf.c conversion if you want to see big
> improvements. Also, %pf() is another thing that's going to enable a lot
> more improvements.

IMHO I'm not sure how these benefits are a result of what looks largely
like a rewrite and rename of seq_buf... Seems to me like it should be
possible to stick with seq_buf and add features to it instead of doing a
replace and remove. As I understand the kernel community, that is always
the preferred practice and would certainly reduce a lot of churn in this
series. But I haven't looked at the entire series and it's not really
something I'm responsible for, so take my opinion with a grain of salt.

>> I guess "external buffer mode" means we use an existing buffer (on the
>> stack in this case) instead of allocating a buffer from the heap [2]?
>> And we do that for performance (i.e., we know the max size) and to
>> avoid sleeping to alloc?
> 
> I did it that way because I didn't want to touch unrelated code more
> than was necessary - just doing a direct conversion. Heap allocation
> would probably make sense here, but it's not my code.

It was changed to a heap allocation recently because my pending patch
set will add a path where this code is called in an atomic context and
cannot sleep. Simplest solution was stack allocation instead of tracking
GFP context for the atomic path.

Logan

