Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D85613B1AA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 19:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgANSHY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 13:07:24 -0500
Received: from ale.deltatee.com ([207.54.116.67]:34644 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgANSHY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 13:07:24 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1irQaw-0000jP-3C; Tue, 14 Jan 2020 11:07:14 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kit Chow <kchow@gigaio.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20200113200756.GA97441@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f15334a9-6cac-803d-7e64-28c74c4d12af@deltatee.com>
Date:   Tue, 14 Jan 2020 11:07:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200113200756.GA97441@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mika.westerberg@linux.intel.com, nicholas.johnson-opensource@outlook.com.au, benh@kernel.crashing.org, kchow@gigaio.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v5] PCI: Fix disabling of bridge BARs when assigning bus
 resources
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-01-13 1:07 p.m., Bjorn Helgaas wrote:
> Applied to pci/resource for v5.6, thanks!
> 
> I added a check of pci_is_bridge() as another hint that this is really
> a bridge-specific issue.  Let me know if that breaks anything.
> 
> commit 9db8dc6d0785 ("PCI: Don't disable bridge BARs when assigning bus resources")
> Author: Logan Gunthorpe <logang@deltatee.com>
> Date:   Wed Jan 8 14:32:08 2020 -0700

Thanks! I was going to test the pci/resource branch, but I haven't seen
the patch in your repo yet... Current head is

86f98025a075 ("PCI: Allow extend_bridge_window() to shrink resource if
necessary")

Logan
