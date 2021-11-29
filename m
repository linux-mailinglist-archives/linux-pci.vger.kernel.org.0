Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD576461D9F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378152AbhK2S1N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 13:27:13 -0500
Received: from ale.deltatee.com ([204.191.154.188]:44806 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349752AbhK2SZM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 13:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=WV/TNnYNnFcZxzUqPd3ZA5cAcLIoTgfWNZK1F+bgrdE=; b=i+hqBeVjGcPhRQj4lEj6ktxCov
        xKEF9uG+mDz4HqGRMeO1nFng5r97jDgdDGG1iqzovojY+adfOjUTtvG8uqnd15ZiaUUp693volE2B
        KXhlE9aQ8xsPkhjnw7xII1M9i5KGePGLSmBETHhUtfpToXeBhXkuZHD5OmdpzNDPqUiflVkb77FpC
        FW2ajJwdYW5jzNtTPgxbGDl9d3+DcfT81G5QAc7Vk6FluGUu4xjgynE1j/uiY9T9SQ0e6SJTZ3XO+
        BAmRg2cHOZ+nH6spZy/PpJToErS9Pz3NxOZFgp1OA5J1gaFVsyhN3zOWGqk7CGNHNrX/X9laeQK7J
        JayDubbA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1mrlHS-00ANgo-Vh; Mon, 29 Nov 2021 11:21:36 -0700
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
Date:   Mon, 29 Nov 2021 11:21:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211126232735.547996838@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: borntraeger@de.ibm.com, hca@linux.ibm.com, linux-s390@vger.kernel.org, linux-ntb@googlegroups.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, ashok.raj@intel.com, megha.dey@intel.com, jgg@nvidia.com, kevin.tian@intel.com, alex.williamson@redhat.com, maz@kernel.org, helgaas@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-11-26 6:23 p.m., Thomas Gleixner wrote:
> Replace the about to vanish iterators, make use of the filtering and take
> the descriptor lock around the iteration.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: linux-ntb@googlegroups.com

This patch looks good to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
