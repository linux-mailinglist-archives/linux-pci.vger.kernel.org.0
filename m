Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9564B1AEA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 02:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbiBKBFJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 20:05:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiBKBFJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 20:05:09 -0500
X-Greylist: delayed 3276 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 17:05:04 PST
Received: from office.oderland.com (office.oderland.com [91.201.60.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B4B5F92
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 17:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=oderland.se
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:
        From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=f5LwesLno9aK7qaWhl94ikSb/XMOItWC7LJzHBJ85RI=; b=kMrycBObjs8zLOaSOz4WPSqREL
        nD+2kVkDr3gtM5k6vthe9TCjv16X7XN4BH/yUbAUhJwkOLYvHXJBPmbsNWocxP0dLUcJvAxCHj92g
        rTBAaXyzDIBZ6cviZH0T1r07G9E2zZZ29aDYxg9FpCBsDqPG0HvtbFH/CHe6mMeXGbTU+eXi5Pf1g
        Rfe6efgYsW2Z+vdKkw5ZeLQP8s8Shp/mVXA27x5u23nodMSxOKXB2Ypca0wj8UukuLMrn4T8BMRhV
        xfV4H7TY4FytruN2GNNrXvBn6o0aua/fheNKXm53dQVMLKp6AIyHS5veXfR+TLucxEcg/x0fJKA5n
        ptnPo9eg==;
Received: from 160.193-180-18.r.oderland.com ([193.180.18.160]:39782 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1nIJW3-0033hn-2Z; Fri, 11 Feb 2022 01:10:23 +0100
Message-ID: <69d705f3-8e0d-31b7-9a80-4413b8dbe7a3@oderland.se>
Date:   Fri, 11 Feb 2022 01:10:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:97.0) Gecko/20100101
 Thunderbird/97.0
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220210235532.GA663996@bhelgaas>
From:   Josef Johansson <josef@oderland.se>
Subject: Re: [PATCH] PCI/MSI: msix_setup_msi_descs: Restore logic for
 msi_attrib.can_mask
In-Reply-To: <20220210235532.GA663996@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - office.oderland.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oderland.se
X-Get-Message-Sender-Via: office.oderland.com: authenticated_id: josjoh@oderland.se
X-Authenticated-Sender: office.oderland.com: josjoh@oderland.se
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/11/22 00:55, Bjorn Helgaas wrote:
> [+cc Jason, since you reviewed the original commit]
>
> On Sat, Jan 22, 2022 at 02:10:01AM +0100, Josef Johansson wrote:
>> From: Josef Johansson <josef@oderland.se>
>>
>> PCI/MSI: msix_setup_msi_descs: Restore logic for msi_attrib.can_mask
> Please match the form and style of previous subject lines (in
> particular, omit "msix_setup_msi_descs:").
Would this subject suffice?
PCI/MSI: Correct use of can_mask in msi_add_msi_desc()
>> Commit 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()") modifies
>> the logic of checking msi_attrib.can_mask, without any reason.
>>     
>> This commits restores that logic.
> I agree, this looks like a typo in 71020a3c0dff4, but I might be
> missing something, so Thomas should take a look, and I added Jason
> since he reviewed it.
>
> Since it was merged by Thomas, I'll let him take care of this, too.
> If it *is* a typo, the fix looks like v5.17 material.
>
> Before: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/msi/msi.c?id=71020a3c0dff4%5E#n522
> After:  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/msi/msi.c?id=71020a3c0dff4#n520
It should be noted that I successfully ran the kernel with this patch.
>> Fixes: 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()")
>> Signed-off-by: Josef Johansson <josef@oderland.se>
>>
>> ---
>> Trying to fix a NULL BUG in the NVMe MSIX implementation I stumbled upon this code,
>> which ironically was what my last MSI patch resulted into.
>>
>> I don't see any reason why this logic was change, nor do I have the possibility
>> to see if anything works with my patch or without, since the kernel crashes
>> in other places.
>>
>> As such this is still untested, but as far as I can tell it should restore
>> functionality.
>>
>> Re-sending since it was rejected by linux-pci@vger.kernel.org due to HTML contents.
>> Sorry about that.
>>
>> CC xen-devel since it very much relates to Xen kernel (via pci_msi_ignore_mask).
>> ---
>>
>> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
>> index c19c7ca58186..146e7b9a01cc 100644
>> --- a/drivers/pci/msi/msi.c
>> +++ b/drivers/pci/msi/msi.c
>> @@ -526,7 +526,7 @@ static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
>>  		desc.pci.msi_attrib.can_mask = !pci_msi_ignore_mask &&
>>  					       !desc.pci.msi_attrib.is_virtual;
>>  
>> -		if (!desc.pci.msi_attrib.can_mask) {
>> +		if (desc.pci.msi_attrib.can_mask) {
>>  			addr = pci_msix_desc_addr(&desc);
>>  			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>>  		}
>>
>> --
>> 2.31.1
>>

