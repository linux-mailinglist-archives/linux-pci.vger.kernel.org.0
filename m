Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC5C52D66D
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 16:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbiESOtb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 10:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiESOta (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 10:49:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6318CA308B;
        Thu, 19 May 2022 07:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C91F1B8238B;
        Thu, 19 May 2022 14:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B60C385AA;
        Thu, 19 May 2022 14:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652971766;
        bh=ayoCX7gR4WIf3jJ8o7PQG1ielh2fRN6IkzHzz1JrmuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hhWfwUr2aFYlg4+FHLVk92NQX1YKaTK0c9wKa/fi38OIZ3x9yRnj97DC1v0idmrYE
         tt4ZhWnmQogAo4ZlBZ5arw34BXjxvlUj41ezbSxwsk88xrsH0bBVI+iTrDsW/txdSS
         5SQqzHqXTwfsbA4B8wSzeX1GdxxJMusl+I88s53sjhxdXZPlWPYTH2ILqdbDgyWoQV
         U6zm+zOyUdja/7wm82O5JhdzpVc7euMQl6DG/h6kaZOrUvLIueKMJA5I1iIc1CkWuw
         b3amEcIUz1vafZwoRN3XT1J0+MlxOfy+Pf3L+O1XY31NaN91VzjhI21akJqsoeswZP
         5AS3C8UTRZyEw==
Date:   Thu, 19 May 2022 09:49:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/1] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
Message-ID: <20220519144923.GA22233@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49dfdf1-c1e8-a9d2-0f31-f190d7b6631f@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 19, 2022 at 04:29:43PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 5/19/22 16:14, Bjorn Helgaas wrote:
> > On Thu, May 19, 2022 at 04:01:48PM +0200, Hans de Goede wrote:
> > 
> >> Ok, I'll go and prepare a v9 and I will submit that later today.
> > 
> > Would it be practical to split into three patches?
> > 
> >   1) Add command-line args
> >   2) Add DMI quirks
> >   3) Add date check
> > 
> > It seems easier to assimilate and document in smaller pieces, if
> > that's possible.
> 
> Ack, will do. Note this will cause quite a bit of copy/paste
> in the commit msg to explain why these changes are necessary.

OK, if the repetition gets excessive I can squash them back
together.  Hopefully the main explanation can go in the first patch,
the second can just mention the fact that these machines need the
exception, and the third can focus on the plan for the future.
