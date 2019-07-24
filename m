Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E169C7300C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfGXNiQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 09:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfGXNiQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jul 2019 09:38:16 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A5012190F;
        Wed, 24 Jul 2019 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563975495;
        bh=1YIiARjBCZhAYRSdWpXHpVJxvWd/TEuDaQWmESH5Fg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sMud2GYZAqqp7c/0dZ33BRTYXSHhSIMuO3NxzLXpt9GeTndrtnt6qszPKZHsfgNAb
         MR14gjNG2NUII5pV8pVS9MGbX6ixLJP/6uANJR06qsCs26VCLUHGqgR6hyy2X1hDom
         pRisnQEmuuAiGf4TlZy9VkiI2oFPvaj9VFcJO+hY=
Date:   Wed, 24 Jul 2019 08:38:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Possible PCI Regression Linux 5.3-rc1
Message-ID: <20190724133814.GA194025@google.com>
References: <SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 24, 2019 at 12:54:00PM +0000, Nicholas Johnson wrote:
> Hi all,
> 
> I was just rebasing my patches for linux 5.3-rc1 and noticed a possible 
> regression that shows on both of my machines. It is also reproducible 
> with the unmodified Ubuntu mainline kernel, downloadable at [1].
> 
> Running the lspci command takes 1-3 seconds with 5.3-rc1 (rather than an 
> imperceivable amount of time). Booting with pci.dyndbg does not reveal 
> why.
> 
> $ uname -r
> 5.3.0-050300rc1-generic
> $ time lspci -vt 1>/dev/null
> 
> real	0m2.321s
> user	0m0.026s
> sys	0m0.000s
> 
> If none of you are aware of this or what is causing it, I will submit a 
> bug report to Bugzilla.

I wasn't aware of this; thanks for reporting it!  I wasn't able to
reproduce this in qemu.  Can you play with "strace -r lspci -vt" and
the like?  Maybe try "lspci -n" to see if it's related to looking up
the names?
