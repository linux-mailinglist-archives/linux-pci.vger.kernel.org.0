Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD844D388E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 19:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiCISQV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 13:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiCISQU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 13:16:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DE4128DD7;
        Wed,  9 Mar 2022 10:15:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F124861607;
        Wed,  9 Mar 2022 18:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148A6C340E8;
        Wed,  9 Mar 2022 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646849720;
        bh=klcC1qku76fYEhGINiDMx4XkazS43HCSZUi7qfC3JBY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CepSo++WWIGwTuVJKKTM7HLAiWkZg5mzQV4zyG9GeFtbyyeFy1UVtOkuIp4lUmG03
         KK8NirWLnZm0gn43tASPP4JB8KPKiuKU9jRSZSUy2fYqV81BrsL5Js9BlBnlHM1G8c
         IQIDeJhaitcFZBkRatn8tAViKBVF/ISjA3p0msAX2+arHZ/fCQjpKMd+qCe4JtWByu
         1iC7C3xYplktvT+K2Wj8+X6wJ1h4+EkBbMEJGwOaOWWHlCASJEOoUa5C91q3nCxPX6
         byvkcdtth4XtnQHvX8PvFmOAAkqsm5BQ4Gmo4D/kZfZzP04aagW+hcl7g0e9y6ZAeC
         erBQmBbiBEC2w==
Date:   Wed, 9 Mar 2022 12:15:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, wse@tuxedocomputers.com
Subject: Re: [PATCH 3/3] x86/PCI: Preserve host bridge windows completely
 covered by E820
Message-ID: <20220309181518.GA63422@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfdb214d-b6e7-f0e7-60de-f30204b0aa90@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 05, 2022 at 11:37:23AM +0100, Hans de Goede wrote:
> On 3/4/22 16:46, Hans de Goede wrote:
> > On 3/4/22 16:32, Bjorn Helgaas wrote:
> >> On Fri, Mar 04, 2022 at 03:16:42PM +0100, Hans de Goede wrote:
> >>> On 3/4/22 04:51, Bjorn Helgaas wrote:
> >>>> From: Bjorn Helgaas <bhelgaas@google.com>
> >>>>
> >>>> Many folks have reported PCI devices not working.  It could affect any
> >>>> device, but most reports are for Thunderbolt controllers on Lenovo Yoga and
> >>>> Clevo Barebone laptops and the touchpad on Lenovo IdeaPads.
> >>>> ...

> >>>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> >>>> index 7378ea146976..405f0af53e3d 100644
> >>>> --- a/arch/x86/kernel/resource.c
> >>>> +++ b/arch/x86/kernel/resource.c
> >>>> @@ -39,6 +39,17 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
> >>>>  		e820_start = entry->addr;
> >>>>  		e820_end = entry->addr + entry->size - 1;
> >>>>  
> >>>> +		/*
> >>>> +		 * If an E820 entry covers just part of the resource, we
> >>>> +		 * assume E820 is telling us about something like host
> >>>> +		 * bridge register space that is unavailable for PCI
> >>>> +		 * devices.  But if it covers the *entire* resource, it's
> >>>> +		 * more likely just telling us that this is MMIO space, and
> >>>> +		 * that doesn't need to be removed.
> >>>> +		 */
> >>>> +		if (e820_start <= avail->start && avail->end <= e820_end)
> >>>> +			continue;
> >>>> +
> >>>
> >>> IMHO it would be good to add some logging here, since hitting this is
> >>> somewhat of a special case. For the Fedora test kernels I did I changed
> >>> this to:
> >>>
> >>> 		if (e820_start <= avail->start && avail->end <= e820_end) {
> >>> 			dev_info(dev, "resource %pR fully covered by e820 entry [mem %#010Lx-%#010Lx]\n",
> >>> 				 avail, e820_start, e820_end);
> >>> 			continue;
> >>> 		}
> >>>
> >>> And I expect/hope to see this new info message on the ideapad with the
> >>> touchpad issue.

I added this logging.

> So I just got the first report back from the Fedora test 5.16.12 kernel
> with this series added. Good news on the ideapad this wotks fine to
> fix the touchpad issue (as expected).

Any "Tested-by" I could add?  If we can, I'd really like to give some
credit to the folks who suffered through this and helped resolve it.

Bjorn
