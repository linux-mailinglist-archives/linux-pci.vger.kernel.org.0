Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3DC508DF4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242512AbiDTRIH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 13:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242237AbiDTRIB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 13:08:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE9D63BA;
        Wed, 20 Apr 2022 10:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5E84B8210B;
        Wed, 20 Apr 2022 17:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0593BC385A1;
        Wed, 20 Apr 2022 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650474312;
        bh=c+AKJvGX71aqNABEFZtpCfQ+5Lzs898ms9TaehXDrj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sl1YUjxSlaFoDPg4zEIxvaZPwalOUrSiutAphkHKiW2tXo+rbDfEMgT5gHUaJp1y9
         S+YGADSjgG6I7T5XNGi7j36BjOkAyPmqCj0f6cMGVtCJmqZq2wzFdQ4UVQ0A8nHUZb
         bOsQqqQNMAZzyZEro6NG5Woz4KrALoeqYB9F+TjE=
Date:   Wed, 20 Apr 2022 19:05:09 +0200
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
Message-ID: <YmA9RZIIypzWOWV8@kroah.com>
References: <20220412224348.1038613-1-tansuresh@google.com>
 <CALVARr6GNk=LCLaeaW87=UKPz+LtJFnuXbARkH44R+vs3E3S-Q@mail.gmail.com>
 <Yl+kzdPG2EvAGCFG@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl+kzdPG2EvAGCFG@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 20, 2022 at 08:14:37AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 19, 2022 at 03:35:47PM -0700, Tanjore Suresh wrote:
> > Hey,
> > 
> > I did not hear any comments on this v2 version. Please help me with your
> > comments and approval so that this can be prepared for checkin.
> 
> Wait, there was comments, that you seem to have ignored.  Why?
> 

Because of that, this patch series is dropped on my end.  Please fix up
and resubmit a new version if you still want this.

thanks,

greg k-h
