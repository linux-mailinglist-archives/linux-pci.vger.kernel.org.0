Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4F64EBAC8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 08:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbiC3G1G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 02:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiC3G1F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 02:27:05 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36581517F2;
        Tue, 29 Mar 2022 23:25:18 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id E0CD930002AA1;
        Wed, 30 Mar 2022 08:25:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D300917F1F; Wed, 30 Mar 2022 08:25:16 +0200 (CEST)
Date:   Wed, 30 Mar 2022 08:25:16 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Tanjore Suresh <tansuresh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Asynchronous shutdown interface and example
 implementation
Message-ID: <20220330062516.GA24340@wunner.de>
References: <20220328230008.3587975-1-tansuresh@google.com>
 <YkO7d7Eel4BVQOy4@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkO7d7Eel4BVQOy4@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 29, 2022 at 08:07:51PM -0600, Keith Busch wrote:
> Thanks, I agree we should improve shutdown times. I tried a while ago, but
> lost track to follow up at the time. Here's the reference, fwiw, though it
> may be out of date :):
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2014-May/000826.html
> 
> The above solution is similiar to how probe waits on an async domain.
> Maybe pci can schedule the async shutdown instead of relying on low-level
> drivers so that everyone implicitly benefits instead of just nvme? I'll
> double-check if that's reasonable, but I'll look through this series too.

Using the async API seems much more reasonable than adding new callbacks.

However I'd argue that it shouldn't be necessary to amend any drivers,
this should all be doable in the driver core:  Basically a device needs
to wait for its children and device links consumers to shutdown, apart
from that everything should be able to run asynchronously.

Thanks,

Lukas
