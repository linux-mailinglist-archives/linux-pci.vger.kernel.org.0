Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552EA1362EA
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 22:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAIVzU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 16:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbgAIVzU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 16:55:20 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4622080D;
        Thu,  9 Jan 2020 21:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578606919;
        bh=Pm6lyGQhMLRYl7S7KE+vl1AlwfWcZu5NH3Dqa4h0Bi8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ew7xB49dLLe7eLoiNDKc+0jg1FaaWloY4DF5YIzFum3Z7QthAZybp5U/VWY39GmS0
         6qlHSLgctzDU07BGIF2NpV8FsG7FISyamWbijbU83nQLLBMUlaP19jcRGUmFFe2Xcu
         IQV2kuVosgi35bxwforGxmPARSV9GNiCqqSE3afA=
Date:   Thu, 9 Jan 2020 15:55:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org,
        fangjian 00545541 <f.fangjian@huawei.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: Re: PCI: bus resource allocation error
Message-ID: <20200109215517.GA255522@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25173a78-8927-5b2f-c248-731629bbc8ec@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 09, 2020 at 06:31:57PM +0800, Yicong Yang wrote:
> On 2020/1/9 12:27, Bjorn Helgaas wrote:
> > [+cc Nicholas, who is working in this area]
> >
> > On Thu, Jan 09, 2020 at 11:35:09AM +0800, Yicong Yang wrote:
> >> Hi,
> >>
> >> recently I met a problem with pci bus resource allocation. The allocation strategy
> >> makes me confused and leads to a wrong allocation results.
> >>
> >> There is a hisilicon network device with four functions under one root port. The
> >> original bios resources allocation looks like:
> > What kernel is this?  Can you collect the complete dmesg log?
> 
> The kernel version is 5.4.0.  

Good; at least we know this isn't related to Nicholas' new resource
code that's in -next right now.

> the dmesg log is like:

The below is not the complete dmesg log.  I don't know what your
system is, but the complete log might be in /var/log/dmesg, or maybe
you could capture it with the "ignore_loglevel" kernel parameter and a
serial console?

> [  496.598130] hns3 0000:7d:00.3 eth11: net stop
> ...
