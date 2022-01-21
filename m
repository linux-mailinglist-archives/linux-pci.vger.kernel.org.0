Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C694965D4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 20:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiAUTml (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 14:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiAUTmk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 14:42:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DF2C06173B;
        Fri, 21 Jan 2022 11:42:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31381B820D9;
        Fri, 21 Jan 2022 19:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A24C340E1;
        Fri, 21 Jan 2022 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642794156;
        bh=y3jRqlHbQrLoqnRKvkQrFt1UTEygR3vigrCRGd78NTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=koGUGM9dMqab8ZM1HidFSVpf+SYOfdqbOH4VAo9fefsKghGZHqpBobNxS4MtvOYsy
         F7QHrdkwI99ckCvaVCFo3iVozCAuE8xwFMXgUzoq/0+8kt2DpNkcA+sjlPHIoWa4cI
         X5cDNzSVsWjj6bXdEDVkMdumjWlJZriZBw4ejQlo9eucFAjRu4rkNqGHPlN65dmafM
         Tad3WgLEys8LheMcMI4yDpUVw8x7IcTvRV6qIFSJ+hJzg5JLw873gG4eUZ+XqoC9nJ
         Zr4Q4hvXE/Lu0phy5XrJwmvqQjmqvBdQogkeGmgizxb+F84c52lOcksCY0FcPtGw6q
         EGnKBQhiReHYQ==
Date:   Fri, 21 Jan 2022 13:42:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vikash Bansal <bvikas@vmware.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Srinidhi Rao <srinidhir@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH] PCI: Speed up device init by parsing capabilities all at
 once
Message-ID: <20220121194235.GA1146009@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7E2C2648-76CE-4987-AB4F-7B4576F10D7B@vmware.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 21, 2022 at 05:26:35PM +0000, Vikash Bansal wrote:
>     On 20/01/22, 11:56 AM, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> 
>     Run pahole for pci_dev structure, it is not adding any padding bytes.
>     Please refer to my previous email for replies to Greg's other comments. 

Please don't indent your entire response.  The original posting
apparently didn't go to linux-pci@vger.kernel.org or was rejected,
maybe because it wasn't plain text (see
http://vger.kernel.org/majordomo-info.html)?

It doesn't appear in the thread at
https://lore.kernel.org/all/7E2C2648-76CE-4987-AB4F-7B4576F10D7B@vmware.com/ 

>     >On Tue, Jan 18, 2022 at 09:16:01AM -0800, Vikash Bansal wrote:
>     >> In the current implementation, the PCI capability list is parsed from
>     >> the beginning to find each capability, which results in a large number
>     >> of redundant PCI reads.
>     >>
>     >> Instead, we can parse the complete list just once, store it in the
>     >> pci_dev structure, and get the offset of each capability directly from
>     >> the pci_dev structure.

> ...
