Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B834D496978
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jan 2022 03:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiAVCtZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 21:49:25 -0500
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:34414 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230513AbiAVCtZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 21:49:25 -0500
X-Greylist: delayed 2191 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jan 2022 21:49:25 EST
Received: from c-24-16-8-193.hsd1.wa.comcast.net ([24.16.8.193] helo=srivatsab-a02.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1nB5td-000OOb-JR; Fri, 21 Jan 2022 21:12:53 -0500
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Vikash Bansal <bvikas@vmware.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Srinidhi Rao <srinidhir@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Ajay Kaher <akaher@vmware.com>
References: <20220121194235.GA1146009@bhelgaas>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH] PCI: Speed up device init by parsing capabilities all at
 once
Message-ID: <d1b71a67-80aa-629c-6aff-7265036fffe7@csail.mit.edu>
Date:   Fri, 21 Jan 2022 18:12:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220121194235.GA1146009@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 1/21/22 11:42 AM, Bjorn Helgaas wrote:
> On Fri, Jan 21, 2022 at 05:26:35PM +0000, Vikash Bansal wrote:
>>     On 20/01/22, 11:56 AM, "Greg KH" <gregkh@linuxfoundation.org> wrote:
>>
>>     Run pahole for pci_dev structure, it is not adding any padding bytes.
>>     Please refer to my previous email for replies to Greg's other comments. 
> 
> Please don't indent your entire response.  The original posting
> apparently didn't go to linux-pci@vger.kernel.org or was rejected,
> maybe because it wasn't plain text (see
> http://vger.kernel.org/majordomo-info.html)?
> 
> It doesn't appear in the thread at
> https://lore.kernel.org/all/7E2C2648-76CE-4987-AB4F-7B4576F10D7B@vmware.com/ 
> 

Looking at the source for Vikash's first email in this thread, I see:
"Content-Type: text/plain", so I don't think that was the issue. Also,
the patch was sent using git-send-email: "X-Mailer: git-send-email
2.6.2".

Is there a way to find out exactly why that email might have prompted
the mailing list to drop it?

Thank you!

Regards,
Srivatsa
VMware Photon OS
