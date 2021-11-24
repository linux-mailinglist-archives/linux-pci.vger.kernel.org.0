Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3545C45B328
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 05:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhKXEbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 23:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhKXEbV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 23:31:21 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F360C061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 20:28:12 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 683283000B087;
        Wed, 24 Nov 2021 05:28:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5AC002BC2C6; Wed, 24 Nov 2021 05:28:10 +0100 (CET)
Date:   Wed, 24 Nov 2021 05:28:10 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Update BAR # and window messages
Message-ID: <20211124042810.GB1887@wunner.de>
References: <20211106115831.GA7452@wunner.de>
 <20211119214304.GA1963177@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119214304.GA1963177@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 03:43:04PM -0600, Bjorn Helgaas wrote:
> On Sat, Nov 06, 2021 at 12:58:31PM +0100, Lukas Wunner wrote:
> > Use a static const array of char * instead of a switch/case ladder
> > to reduce LoC count and improve performance.
> 
> I tried converting this and came up with the below.  Is that the sort
> of thing you're thinking?  Gcc *does* generate slightly smaller code
> for it, but Puranjay's original source code is smaller and IMO a
> little easier to read.

Yes, that's what I had in mind.  Aside from binary or source code size,
retrieving the name from an array is just a quick direct access, whereas
a switch/case ladder becomes a lot of conditional branches in binary code,
which is slower.

Another option is to use case ranges.  See max3191x_set_config() in
drivers/gpio/gpio-max3191x.c for an example.  gcc is smart enough to
generate an optimized set of conditional greater-than / less-than branches.
That could be used to shorten your cardbus_name[] array.

Thanks,

Lukas
