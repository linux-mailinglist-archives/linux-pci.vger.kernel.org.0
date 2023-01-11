Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E91666169
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 18:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjAKRJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 12:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbjAKRIi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 12:08:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D92263E;
        Wed, 11 Jan 2023 09:08:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD25661D89;
        Wed, 11 Jan 2023 17:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E9FC433EF;
        Wed, 11 Jan 2023 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673456879;
        bh=hVyTqh0Iph+dvws+E6VhlQQFwt5VavXewGsFtmKwJLc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YeXsUXLEV3TzdSRkNCsLki6vEv4CdLl11cy2z1wkiOeg+5cGN07XgvfIThxHmUoZ4
         blrHkoRHDID72RyzYajCk8PHfKIC3ZdLgj7aZz5Wcp45KgXCiictITSkMh59wTYR0H
         V54PivkHinCyGhLGBvh15WAN6Z5CV+V2hslPhgKiMcDHU+OqCmjAVlB/amhv8om4M6
         Z6e+d2Fg4u8yuyYWl3ziOszy2Ze6ZKu1WcWpSLBqCQgWVSBUiDc6Aq6bz5mTn3m6+P
         bFO39URBImLjo8J0QmIM7lSQubL57pZWkipULCR84Ed5gcjmQ/xN8waqXH+7r4jToZ
         5HTxfJ0HXcxDA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Moshe Shemesh <moshe@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V3 13/33] x86/apic/vector: Provide MSI parent domain
References: <20221124230505.073418677@linutronix.de>
        <20221124232326.034672592@linutronix.de> <Y7VyXNbWMdWWAC6d@nvidia.com>
        <87eds2k2nr.ffs@tglx> <Y719OcFueTg09OUV@nvidia.com>
        <87o7r5dpq2.fsf@kernel.org> <Y77lNZzsUVUKPaON@nvidia.com>
Date:   Wed, 11 Jan 2023 19:07:52 +0200
In-Reply-To: <Y77lNZzsUVUKPaON@nvidia.com> (Jason Gunthorpe's message of "Wed,
        11 Jan 2023 12:35:01 -0400")
Message-ID: <877cxtyp7b.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Wed, Jan 11, 2023 at 06:02:13PM +0200, Kalle Valo wrote:
>> Jason Gunthorpe <jgg@nvidia.com> writes:
>> 
>> > On Tue, Jan 10, 2023 at 01:14:00PM +0100, Thomas Gleixner wrote:
>> >
>> >> Care to send a proper patch with changelog?
>> >
>> > Yes, I'll post it in a few days once the test team confirms it
>> 
>> I think I'm seeing the same leak and it's spamming logs on my test box a
>> lot. Let me know if you need any help with testing, I can do that pretty
>> quickly.
>
> https://github.com/jgunthorpe/linux/commits/msi_fwnode_leak

Nice, this fixes the issue for me. I don't see memleaks anymore while
running my ath11k regression tests. Thanks!

Tested-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
