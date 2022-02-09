Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734074AFF65
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 22:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiBIVrW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 16:47:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiBIVrV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 16:47:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89024C0F8692;
        Wed,  9 Feb 2022 13:47:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1212DB8125B;
        Wed,  9 Feb 2022 21:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2822C340E7;
        Wed,  9 Feb 2022 21:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644443241;
        bh=YQ93vvu/mLRTii8DBVQc/ZPhQKp/nljv1Z77ABdvnmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSpJb1ewaZ2Z9xJBWbGcdJCZsTktGsEZJ3dFz6EY2R9NYPmruhmCnhi8U66OqjICR
         WjyUSGe0Jx2Cm9eFGOM8qWCF9Rd7+M6yjL2lbrHmr7xJAOLroLF80ooK+DNgpYm0sp
         S/QvsauD6hI3oXF4YBbxJ6ja6FzZJeStGjMBQ2ELkMNKtu+8jbg2Fj5jJ9lALJDBDD
         THn7Wgs4wIpBln20X8iGIKVf14HkgwatyM4X67v10X14DRgRJ8+HGpSZBXEvl+JJio
         Z44gj4P571G6865pXJwAS8x/kz/6U2O351PKSqu2LhVIsTISb7tPW7yd9GgAAilvdu
         yofN8SyfCKtSw==
Date:   Wed, 9 Feb 2022 13:47:18 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     nitirawa@codeaurora.org
Cc:     Vidya Sagar <vidyas@nvidia.com>, rafael.j.wysocki@intel.com,
        keith.busch@intel.com, hch@lst.de, bhelgaas@google.com,
        mmaddireddy@nvidia.com, kthota@nvidia.com, sagar.tv@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Query related to shutting down NVMe during system suspend
Message-ID: <20220209214718.GC1616420@dhcp-10-100-145-180.wdc.com>
References: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
 <20220209202639.GB1616420@dhcp-10-100-145-180.wdc.com>
 <bc80ec7d1ca2c56feded1a6848c285ef@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc80ec7d1ca2c56feded1a6848c285ef@codeaurora.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 10, 2022 at 02:47:47AM +0530, nitirawa@codeaurora.org wrote:
> IMO, the NVME driver is not associated with any device tree, Instead PCI
> driver is associated with device tree.

That may be good, though: the idle behavior isn't unqiue to nvme. It may
be fine if PCI is the common layer to own this, as long as drivers can
query it.

> So unlike ACPI based platform where we have platform specific DMI matching,
> we don't have equivalent check for DT based platform.

Is there any existing kernel API a driver can call to uniquely identify
such a platform?

> Do we see any concern if we introduce a module param with default not set to
> quick suspend.

As of now, the idea was proposed and was not accepted.
