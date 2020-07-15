Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EC82212E3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgGOQqF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 12:46:05 -0400
Received: from foss.arm.com ([217.140.110.172]:57722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbgGOQqE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 12:46:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04E9931B;
        Wed, 15 Jul 2020 09:46:03 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39EA53F718;
        Wed, 15 Jul 2020 09:46:02 -0700 (PDT)
Date:   Wed, 15 Jul 2020 17:45:59 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: controller: Remove duplicate error message
Message-ID: <20200715164559.GC3432@e121166-lin.cambridge.arm.com>
References: <20200526150954.4729-1-zhengdejin5@gmail.com>
 <1d7703d5c29dc9371ace3645377d0ddd9c89be30.camel@amazon.com>
 <20200527132005.GA7143@nuc8i5>
 <1b54c08f759c101a8db162f4f62c6b6a8a455d3f.camel@amazon.com>
 <CAL_JsqJWKfShzb6r=pXFv03T4L+nmNrCHvt+NkEy5EFuuD1HAA@mail.gmail.com>
 <20200706155847.GA32050@e121166-lin.cambridge.arm.com>
 <20200711074733.GD3112@nuc8i5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711074733.GD3112@nuc8i5>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 11, 2020 at 03:47:33PM +0800, Dejin Zheng wrote:
> On Mon, Jul 06, 2020 at 04:58:47PM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Jun 02, 2020 at 09:01:13AM -0600, Rob Herring wrote:
> > 
> > [...]
> > 
> > > > The other 2 error cases as well don't print the resource name as far as
> > > > I recall (they will at least print the resource start/end).
> > > 
> > > Start/end are what are important for why either of these functions
> > > failed.
> > > 
> > > But sure, we could add 'name' here. That's a separate patch IMO.
> 
> Hi Lorenzo, Bob and Jonathan:                                                                                                     
> 
> Thank you very much for helping me review this patch,

I merge this patch in pci/misc, thanks.

> I sent a new patch for print the resource name when the request memory
> region or remapping of configuration space fails. and it is here:
> https://patchwork.kernel.org/patch/11657801/

We will get to it soon.

Lorenzo
