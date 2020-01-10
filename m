Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD1D9136427
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 01:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgAJAIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 19:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730022AbgAJAIE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 19:08:04 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A1820661;
        Fri, 10 Jan 2020 00:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578614883;
        bh=/440QzkufVUrCBncPzX7J4MbMPzyIDqOr54RTigChmk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PBH4vdSW1IL7P0igxznw9qjUFcheYMiE/R8iw2IIt0dEZ7WPxSFhPsmz40sPGbG+7
         mJ0b1EugXFloyG/mAvIJMG9puO5S22xr7FhGrmnnctHEvlSwggrF2ktyHXqB6mCSTZ
         HrBF72ykLD0PMJZXKPjxH95Je+V0urPblGbMddWM=
Date:   Thu, 9 Jan 2020 18:08:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        fangjian 00545541 <f.fangjian@huawei.com>
Subject: Re: PCI: bus resource allocation error
Message-ID: <20200110000801.GA49084@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB0438B0DAE881F9B7F7581D3080390@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 09, 2020 at 11:55:18PM +0000, Nicholas Johnson wrote:
> On Thu, Jan 09, 2020 at 03:55:17PM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 09, 2020 at 06:31:57PM +0800, Yicong Yang wrote:
> > > On 2020/1/9 12:27, Bjorn Helgaas wrote:
> > > > [+cc Nicholas, who is working in this area]
> > > >
> > > > On Thu, Jan 09, 2020 at 11:35:09AM +0800, Yicong Yang wrote:
> > > >> Hi,
> > > >>
> > > >> recently I met a problem with pci bus resource allocation. The allocation strategy
> > > >> makes me confused and leads to a wrong allocation results.
> > > >>
> > > >> There is a hisilicon network device with four functions under one root port. The
> > > >> original bios resources allocation looks like:
> > > > What kernel is this?  Can you collect the complete dmesg log?
> > > 
> > > The kernel version is 5.4.0.  
> > 
> > Good; at least we know this isn't related to Nicholas' new resource
> > code that's in -next right now.
> 
> It is not in next - it is in the release candidates, right?

There are a few things already in v5.5-rc5:

  c13704f5685d ("PCI: Avoid double hpmemsize MMIO window assignment")
  d7b8a217521c ("PCI: Add "pci=hpmmiosize" and "pci=hpmmioprefsize" parameters")

The following are currently in -next and should appear in v5.6-rc1:

  ddbbbb6cb825 ("PCI: Allow extend_bridge_window() to shrink resource if necessary")
  2b2108891303 ("PCI: Set resource size directly in extend_bridge_window()")
  7bd85f16152b ("PCI: Rename extend_bridge_window() parameter")
  5b55d9cf7d43 ("PCI: Consider alignment of hot-added bridges when distributing available resources")

I wanted to make sure Yicong was not testing -next.

Bjorn
