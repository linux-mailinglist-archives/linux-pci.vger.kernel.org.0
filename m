Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FDF10A88
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 18:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfEAQEB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 12:04:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:34774 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfEAQEA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 May 2019 12:04:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 09:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,418,1549958400"; 
   d="scan'208";a="147298333"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 01 May 2019 09:03:59 -0700
Date:   Wed, 1 May 2019 09:58:13 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Eric Pilmore <epilmore@gigaio.com>,
        linux-ntb <linux-ntb@googlegroups.com>,
        linux-pci@vger.kernel.org, Armen Baloyan <abaloyan@gigaio.com>,
        D Meyer <dmeyer@gigaio.com>, S Taylor <staylor@gigaio.com>
Subject: Re: NVMe peer2peer TLPs over NTB getting split
Message-ID: <20190501155813.GB26910@localhost.localdomain>
References: <CAOQPn8vMn4h=oGWWKa3Uge7WYMkmRAmTyhR6RPjGVtrR1hfhOQ@mail.gmail.com>
 <4389bccb-6993-4a86-b4e4-202e971e2080@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4389bccb-6993-4a86-b4e4-202e971e2080@deltatee.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 30, 2019 at 03:27:53PM -0600, Logan Gunthorpe wrote:
> On 2019-04-24 4:46 p.m., Eric Pilmore wrote:
> > Hi Folks,
> > 
> > Does anybody know why a Host Bridge might break up a full-sized (max
> > payload) TLP into single byte TLPs when those TLPs are traveling from
> > peer-to-peer?
> 
> Host bridges can't be relied on to do the right thing with respect to
> P2P. This is why the p2pdma code explicitly rejects them. Bad
> performance is often the symptom and splitting may be the cause (I've
> never bothered to stick an analyzer on it. There are patches floating
> around to add a whitelist to p2pdma which would be what you'd want to do
> and avoid anything that doesn't go through a switch.

Note that Max Payload Size may not be the same across root ports,
so splitting transactions may be the correct thing to do under some
circumstances. Kernel parameter "pci=pcie_bus_peer2peer" should make
all MPS settings the same, though I doubt that will help for the
hardware desribed here.
