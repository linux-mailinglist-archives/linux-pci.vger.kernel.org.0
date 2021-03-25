Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABEC348B92
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 09:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhCYIaL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhCYI3s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 04:29:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BFAC06174A;
        Thu, 25 Mar 2021 01:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Czz7/IpVf0VeB+L20c4WPq2pqD9eepIa8RvFIJif1+I=; b=VZFr3BNQMFZ96q0aeI2kqbD/Ka
        NexX6E2QBOCmIg0G3cClcC2i2d3d70CqCn8DB9aVUs6mPoxCpdCB3VDuBX77o5KgYsOLjnql/rm6o
        rHzPFoe29Uts26VtIbz0bqyJXDP4fKx8hwuPjOzHMvBdu/rPe9LqiGyJOTOL0sDcgYOuS8c4VHykG
        UnFKBImTS04MvgkKeeE70i860+IxK34Wp6vMMIAtdwCZwLTgC6wNJ3WYBOHz4OuMjNofEuKq2r12k
        wWykLZgShIzBH+8s75PyTIOS3sK4jNnuk6P+Onzz5AjQcbdIibLbaT7iLwglKzDB2JH03qrALH/AZ
        ELFZc0rA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lPLMW-00CXmi-3l; Thu, 25 Mar 2021 08:29:13 +0000
Date:   Thu, 25 Mar 2021 08:29:04 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Allow drivers to claim exclusive access to config
 regions
Message-ID: <20210325082904.GA2988566@infradead.org>
References: <161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YFwzw3VK0okr+taA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFwzw3VK0okr+taA@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 25, 2021 at 07:54:59AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 24, 2021 at 06:23:54PM -0700, Dan Williams wrote:
> > The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
> > configuration cycles. It assumes one initiator at a time is
> > reading/writing the data registers.
> 
> That sounds like a horrible protocol for a multi-processor system.
> Where is it described and who can we go complain to for creating such a
> mess?

Indeed.  Dan, is there a way to stilk kill this protocol off before it
leaks into the wild?
