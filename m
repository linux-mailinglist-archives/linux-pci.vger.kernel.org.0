Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AB3148EB0
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390394AbgAXT1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jan 2020 14:27:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389270AbgAXT1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jan 2020 14:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7WJvYw6BG8AN+9sejDTzeDJEZaELXZLd1pKBfuTKYrs=; b=C2pA3ZwoU3tK2mDyg4OmcM4V+
        RW3N0fTO9ecXiUibg92EP+DbmgXruYCrrSj0l0tUQhde5zOHFlFSM/E6+dWu2iOfLMCSFQ7aFFLeR
        5E6Lk9e4HtdLBK753+WT9MpW2y74pbbv/Apca0vhvhryvS2VNWZN+bvsRUrlqysdPJj+YQyZ02k4o
        f8rbcnUgAO83X9VTCacsbMPwYnGXoj4oxDhpWslAld5nI9CCpz6QWKxayzGQZD1Vn9xAJ5YRFkziw
        NDG2IFlBUvR5IAUyf3nMOJ4AJUY0lfZNUDtWB0XYasMxG3Yeb2jDwZ49hDzuYqdSQsZ/QUqo+WXGR
        sfGWLaYiQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iv4cJ-00071l-8c; Fri, 24 Jan 2020 19:27:43 +0000
Date:   Fri, 24 Jan 2020 11:27:43 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-pci@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC] PCI: Add "pci=blacklist_dev=" parameter to
 blacklist specific devices
Message-ID: <20200124192743.GL4675@bombadil.infradead.org>
References: <20200124144248.11719-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124144248.11719-1-yu.c.chen@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 24, 2020 at 10:42:48PM +0800, Chen Yu wrote:
> It was found that on some platforms the bogus pci device might bring
> troubles to the system. For example, on a MacBookPro the system could
> not be power off or suspended due to internal pci resource confliction
> between bogus pci device and [io 0x1804]. Another case is that, once
> resumed from hibernation on a VM, the pci config space of a pci device
> is corrupt.
> 
> To narrow down and benefit future debugging for such kind of issues,
> introduce the command line blacklist_dev=<vendor:device_id>> to blacklist
> such pci devices thus they will not be scanned thus not visible after
> bootup. For example,
> 
>  pci.blacklist_dev=8086:293e
> 
> forbid the audio device to be exposed to the OS.

This feels really unsafe to me.  Just because Linux ignores the device
doesn't mean the device will ignore I/O requests.  I think we should
call this pci.disable_dev and clear the device's I/O Space Enable,
Memory Space Enable and Bus Master Enable bits (in the Command register,
config space offset 4).
