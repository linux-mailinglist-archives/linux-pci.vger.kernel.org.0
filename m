Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0213F35A8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 18:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfKGRZT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 12:25:19 -0500
Received: from ale.deltatee.com ([207.54.116.67]:51428 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbfKGRZS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 12:25:18 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iSlWw-0000Nu-2Y; Thu, 07 Nov 2019 10:25:11 -0700
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
References: <PS2P216MB075530CB1B7B099AAF9F42D580780@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c7de4e19-377c-7b82-3afd-f0fe40dcc20f@deltatee.com>
Date:   Thu, 7 Nov 2019 10:25:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <PS2P216MB075530CB1B7B099AAF9F42D580780@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: benh@kernel.crashing.org, corbet@lwn.net, mika.westerberg@linux.intel.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, nicholas.johnson-opensource@outlook.com.au
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 0/1] Fix bug resulting in double hpmemsize being assigned
 to MMIO window
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-11-07 6:50 a.m., Nicholas Johnson wrote:
> I have split this patch off my main series, as I realised that it does 
> not need to be part of that series.
> 
> I have made some recent improvements to add assurance against it 
> breaking existing behaviour. Instead of returning the first resource of 
> the desired type regardless of it being assigned, now it goes through 
> all of the resources and returns only those of type that are not 
> assigned. Only then does it go through and return the first resource of 
> desired type that is assigned. If none are found then it returns NULL as 
> usual.
> 
> I have made extensive changes to the patch notes, also.
> 
> Logan Gunthorpe <logang@deltatee.com> has an alternative method of 
> fixing this same bug. Please also consider his patch and accept 
> whichever is best for Linux. All I care is that the bug be fixed.

Oh, yes, I haven't had time to follow up on this. My patch is here[1].
It has a bit more info in the commit message and is a bit less
intrusive. However, Nicholas's approach is more of a cleanup and may be
a bit cleaner going forward.

I also had another bug fix in that series I really need to find time to
update and resend. I'll try to do it in the next cycle.

Logan

[1]
https://lore.kernel.org/linux-pci/20190531171216.20532-2-logang@deltatee.com/
