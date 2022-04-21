Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965A8509774
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 08:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384769AbiDUG04 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 02:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351485AbiDUG0z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 02:26:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B22B13EB5;
        Wed, 20 Apr 2022 23:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA5086179D;
        Thu, 21 Apr 2022 06:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99E7C385A1;
        Thu, 21 Apr 2022 06:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650522246;
        bh=DOFw4L9az3DU5b90Fdo72Tbgr20jrBqwWs0Fec98yRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rnRA+LDLgPpHIwm4YaAbf7zZbEoPQsaX81SvBNp6y/gdZPIWGc1hqmTAoAITziTtG
         av0kIpP2o8vyyxp4b16jWD6HKgL/8/g8MJ5zQLJ7vEmWghfBs10ie9KUtfTfmebOGg
         xhTqjHAAk8uWkU+z/psvWBap8DdYfK5nQqJrN4aM=
Date:   Thu, 21 Apr 2022 08:24:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tanjore Suresh <tansuresh@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Asynchronous shutdown interface and example
 implementation
Message-ID: <YmD4gkbq+Ar1albY@kroah.com>
References: <20220412224348.1038613-1-tansuresh@google.com>
 <CALVARr6GNk=LCLaeaW87=UKPz+LtJFnuXbARkH44R+vs3E3S-Q@mail.gmail.com>
 <Yl+kzdPG2EvAGCFG@kroah.com>
 <YmA9RZIIypzWOWV8@kroah.com>
 <CALVARr7Ms7+jL3EyTNNRaOB6co0ycWQtCWCDU+0zVjOnKEuK7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALVARr7Ms7+jL3EyTNNRaOB6co0ycWQtCWCDU+0zVjOnKEuK7g@mail.gmail.com>
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

On Wed, Apr 20, 2022 at 04:12:38PM -0700, Tanjore Suresh wrote:
> Greg,

<snip>

You sent this in html form, which is rejected by our mailing lists.
Please fix up your email client and resend and I will be glad to point
you at this thread on lore.kernel.org with responses from other
developers.  Or you can just look it up yourself :)

thanks,

greg k-h
