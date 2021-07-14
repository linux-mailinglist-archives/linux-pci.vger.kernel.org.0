Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D1D3C89BF
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbhGNR3W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 13:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239772AbhGNR3S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Jul 2021 13:29:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A976F613BE;
        Wed, 14 Jul 2021 17:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626283586;
        bh=qd+SV4jHiK8MESWbTl8dubrtJ+ZETw/93EBcFJ9edx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXYUOZzt3WPDaJjPYCUQ6+4HGydBFuanoW5LpkIOLsfvR4K2Wy/f0o76JBKVzEtzz
         SeAKHNPhFb13EMYBEEY6Sh8YAncjqEsSTjA220L6jSksglA7Ju4Iot6vU7qo34EeLZ
         8ee/BAZC4XdyggvRogV05cSPsd0eQujooQswLo7DMQ9rAEQtg+aTN/RPKCCsCbrTob
         AMtfzjcp2zKcNWaURGHKByQY1V5DbHqkd3YtYIXPm8TwDT7d0Cm2Nlb2SHbCeqISNZ
         a0cElD75KMWS5AtQHScnJHXB09kzaJ2iE4B28UQq0aN7dBtdl9P7GA7jlIMdxn6EVF
         f0wBZFUAajHjg==
Date:   Wed, 14 Jul 2021 10:26:23 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wenchao Hao <haowenchao@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Wu Bo <wubo40@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>, linfeilong@huawei.com,
        lijinlin3@huawei.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [question]: Query regarding the PCI addresses
Message-ID: <20210714172623.GB1159813@dhcp-10-100-145-180.wdc.com>
References: <bb7e27ea-5957-21a0-34b4-5adf517c3546@huawei.com>
 <20210714165427.GA1854138@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714165427.GA1854138@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 14, 2021 at 11:54:27AM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 14, 2021 at 02:33:37PM +0800, Wenchao Hao wrote:
> 
> > If they are not fixed, then is there anyway I can get a fixed ID
> > which can indicate physical connection.
> 
> You can look at the "lspci -P" option.  I'm not really familiar with
> this, but I think Matthew (cc'd) implemented it.

That option shows the parent devices for each listed device, but that
may not produce the same output if BDf doesn't always enumerate the
same.

I think Wenchao was seeking some invariant device identification that
can be used to look up its BDf. There's no PCI level requirement for
uniquely identifying a specific device across changing topologies, so I
don't think this is generically possible.
