Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00F37BE7F9
	for <lists+linux-pci@lfdr.de>; Mon,  9 Oct 2023 19:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377911AbjJIRaT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377407AbjJIRaR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 13:30:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C31A9D;
        Mon,  9 Oct 2023 10:30:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A51C433C7;
        Mon,  9 Oct 2023 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696872615;
        bh=EACK2tmq5+41Js6GZfBr/J8+BuSNLbbDDNpHvCryNec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INX4ASZNRg/lD8oCQEsXmK56PSVK/sEm9Mkl83Lf+wu6Pq6XbuVOt8fQHRF/LILAS
         fvBuviO4505VLsdbEbjKHnZpR9i3YN6+G42buKLgOzK30gks9PtUCHIIpMAGmvnre5
         RidVSyLf/g5j7I1uMYVsSeIjpRqPCTh62O5WpvbM=
Date:   Mon, 9 Oct 2023 19:30:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH 7/7] block, drivers: make lots of attribute_group globals
 const
Message-ID: <2023100944-sandpit-bronco-3db4@gregkh>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-7-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009165741.746184-7-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 09, 2023 at 06:57:40PM +0200, Max Kellermann wrote:
> This moves those variables to the ".rodata" section which reduces the
> kernel size a bit and protects the variables by putting them on
> read-only pages at runtime.

The kernel size should still be the same overall, you are just moving
pointers from one section to another, right?

If not, what are the numbers, show them please.

But step back, are you SURE you can make these attribute group pointers
const?  They are modified by some subsystems by adding or removing items
from the lists, so why does the core need to change for that?

thanks,

greg k-h
