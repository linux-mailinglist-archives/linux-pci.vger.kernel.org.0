Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE0319A2C1
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 02:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbgDAAEl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 20:04:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbgDAAEk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 20:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5AHQT3HNoIfrpxFYcnKnT3xJDAyH56vM7k0YaLOkJVw=; b=WXHxeM0n35BJgssvOzHfB7PrVS
        gX96MWzJMJdJqAtFWyuzP/6IVMdYm37f63ftVeAokCU66LbE3016VYkHF9XAAJ1eBev/dxbwgRJs7
        eKChYRuBoPwOWq6s+BJO9+lV7rwoASQ82KFz+QBzDZDe626Y3w30pZVlZVZbEmsR73XYeqEAPYM0E
        Ptwp4VN7hB3MRLPa7SxBgo93TgjhgbJxXuZDVOEpf+3ZvGWRwmkCwNd4hp76Rfps9BuBAs6G+iFKu
        9NattIPbR5E7JQssNMR+E9s/vLQXAnsCxLs5mgiNXRMF+1a3p5H7waztpo1ty+KjCc7+oAY4PptsS
        TI5FDsyw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJQs3-0006SZ-Pr; Wed, 01 Apr 2020 00:04:39 +0000
Date:   Tue, 31 Mar 2020 17:04:39 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: filesystems: Convert sysfs-pci to ReST
Message-ID: <20200401000439.GE21484@bombadil.infradead.org>
References: <cover.1585693146.git.vitor@massaru.org>
 <637c0379a76fcf4eb6cdde0de3cc727203fd942f.1585693146.git.vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <637c0379a76fcf4eb6cdde0de3cc727203fd942f.1585693146.git.vitor@massaru.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 31, 2020 at 07:28:56PM -0300, Vitor Massaru Iha wrote:
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
>  .../{sysfs-pci.txt => sysfs-pci.rst}          | 40 ++++++++++---------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>  rename Documentation/filesystems/{sysfs-pci.txt => sysfs-pci.rst} (82%)
> 
> diff --git a/Documentation/filesystems/sysfs-pci.txt b/Documentation/filesystems/sysfs-pci.rst

In addition to Jon's comments, for the next version, I would suggest
cc'ing the linux-pci@vger.kernel.org mailing list.  

Also, maybe add:

F: Documentation/filesystems/sysfs-pci.rst

to the 'PCI SUBSYSTEM' section of MAINTAINERS.
