Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753154895F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 18:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfFQQz0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 12:55:26 -0400
Received: from ale.deltatee.com ([207.54.116.67]:45390 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfFQQz0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 12:55:26 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hcuud-00075A-Px; Mon, 17 Jun 2019 10:55:20 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <PS2P216MB0642AD5BCA377FDC5DCD8A7B80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
 <20190615195604.GW13533@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1557cd7b-ccbf-6202-83ea-20923700d260@deltatee.com>
Date:   Mon, 17 Jun 2019 10:55:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190615195604.GW13533@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: benh@kernel.crashing.org, corbet@lwn.net, mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, nicholas.johnson-opensource@outlook.com.au, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v6 0/4] PCI: Patch series to support Thunderbolt without
 any BIOS support
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-15 1:56 p.m., Bjorn Helgaas wrote:
> [+cc Ben, Logan]
> 
> Ben, Logan, since you're looking at the resource code, maybe you'd be
> interested in this as well?
>
> On Wed, May 22, 2019 at 02:30:30PM +0000, Nicholas Johnson wrote:
>> Rebase patches to apply cleanly to 5.2-rc1 source. Remove patch for 
>> comment style cleanup as this has already been applied.
> 
> Thanks for rebasing these.
> 
> They do apply cleanly, but they seem to be base64-encoded MIME
> attachments, and I don't know how to make mutt extract them easily.  I
> had to save each patch attachment individually, apply it, insert the
> commit log manually, etc.
> 
> Is there any chance you could send the next series as plain-text
> patches?  That would be a lot easier for me.

I'd happily look at the patches but I can't find them. Sounds like they
were sent as attachments and it doesn't seem like the mailing list
archives keep those.

Logan


