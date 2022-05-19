Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AF852D5B5
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 16:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiESOPA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 10:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiESOPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 10:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBA068F87;
        Thu, 19 May 2022 07:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B27A6187A;
        Thu, 19 May 2022 14:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0158C385AA;
        Thu, 19 May 2022 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652969698;
        bh=GImfUl4SfmHkUDh1diWounltULWP05AJztWDPxtaZIU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dPO5MQ4rN6PVPmuYzB4eiP47udUzfL5CsEKf7OZUN9QEZIhD90wJjz5+vrHTnDJNc
         bmXjN9ZDzT8smYxN3N3n+HCoCB7tErqgXHIYbYL2hLEvWbKTJmLgYfU5x9gt+mIzH7
         gMSd4vTA27d2MsjGjtVdgoX0iXawyrDR4o3zXnWp3FpesfwACm5PduH4+zJhiAti0p
         v63EOrbAfwxN/UDp6LwVPA9YV/QsLjUz7WA/cDcCFFT1SpHO6w8oAJBZlAK4DBNGcD
         tIoOT6cydpaWzB2b/b15JOUILZLDVjaWjKgBwhq5CI1wJo7OOyRigBI47CT9gwPSZ1
         VwYV9YJxuSaaQ==
Date:   Thu, 19 May 2022 09:14:50 -0500
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
Message-ID: <20220519141450.GA19225@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba9fd954-64e1-189d-9a0e-7c7e329ff81b@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 19, 2022 at 04:01:48PM +0200, Hans de Goede wrote:

> Ok, I'll go and prepare a v9 and I will submit that later today.

Would it be practical to split into three patches?

  1) Add command-line args
  2) Add DMI quirks
  3) Add date check

It seems easier to assimilate and document in smaller pieces, if
that's possible.

> I believe that this summary is correct, except that the broken by
> 4dc2287c1805 list needs the TUXEDO / Clevo:
> 
>     https://bugzilla.kernel.org/show_bug.cgi?id=214259 02/01/2021 TUXEDO (Clevo)

Right, thanks!

Bjorn
