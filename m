Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF4B515B1E
	for <lists+linux-pci@lfdr.de>; Sat, 30 Apr 2022 09:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiD3Hzr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Apr 2022 03:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiD3Hzq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Apr 2022 03:55:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADA9517E0;
        Sat, 30 Apr 2022 00:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6ACEB81A53;
        Sat, 30 Apr 2022 07:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F04C385A7;
        Sat, 30 Apr 2022 07:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651305142;
        bh=7WU6Hv+j5IpVc4WlVEIwGBU4ZFEmt4nHCYEncgGlcn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bftjN0qO/SG4jvtvjb3gkReAtIDReW4NuHomITzamBvbFKa47b+q4or07Bz4gvkPP
         m+LASPvPyfaXDV9V359Bep0eUtfJmK1BBYPx3yTUU2z9UDIGBf4Q7h9pxJLnG/LDDl
         Z2O+IfJ/Fea8Ya7bACgDQdH/i++YLQiyKRyAS5To=
Date:   Sat, 30 Apr 2022 09:52:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tanjore Suresh <tansuresh@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] driver core: Support asynchronous driver shutdown
Message-ID: <YmzqrqfVLQ9/4KXp@kroah.com>
References: <20220412224348.1038613-1-tansuresh@google.com>
 <20220412224348.1038613-2-tansuresh@google.com>
 <CAJZ5v0ivNq3aYCEcxPYMosLJCAyWiAnucwOCmRBzkM=sbyPWgQ@mail.gmail.com>
 <CALVARr6v5hcY0Vcf1izPUX-tXNJyyNXBMANbKX4CW9wfRf-pYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALVARr6v5hcY0Vcf1izPUX-tXNJyyNXBMANbKX4CW9wfRf-pYQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Fri, Apr 29, 2022 at 11:03:07AM -0700, Tanjore Suresh wrote:
> Rafael,
> 
> That is a good observation, however, many of the use cases in data
> centers (deployment of devices in data centers) do not exploit device
> power management. Therefore, I'm not sure that is the right way to
> design this.

Yes it is, enable device power management and use that interface please.
Devices in data centers should of course be doing the same thing as
everyone else, as it actually saves real money in power costs.  To not
do so is very odd.

thanks,

greg k-h
