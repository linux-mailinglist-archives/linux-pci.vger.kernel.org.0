Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E9B62192B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 17:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiKHQMt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 11:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbiKHQMs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 11:12:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3084FF87
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 08:12:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C06D8615F0
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 16:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D66C433D6;
        Tue,  8 Nov 2022 16:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667923967;
        bh=nvy6oRQX03hPUL9Rh+Si6o6pX8guUolTc4YGF6bT3Lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C1SLdWqYUeOx1bCz90z4wPUh7ioagitYPOXE3BURGIDMunQdmDxfAamlU/gYTaJtc
         Dl7aury599CENr+D5cZFKKv1gE7iuRPP0/BhyRV42krnUei5irU8ndMYeKjQi1Qvvv
         3T58onG/hecEgUSQQyL67Vyqz1m4oqdCclLTgQtlvN4UQL/yidpymODw0hxk/ZFHaf
         /FPAjxFHcv42XlvDyLXwNdPQrkcfOujn6K7kuuV1sv/Jx+eMOqi5c/LFSsS/Rh9ekz
         xElSWnYZZO4VslqovNv/svg/cE/KkqlIHRs5Hz1t/Mf5dn9aKB4fVdvFmG7nBA4RrJ
         g5g2ZtIomzY5w==
Date:   Tue, 8 Nov 2022 09:12:44 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pci@vger.kernel.org
Subject: Re: [External] : Re: sysfs interface to force power off
Message-ID: <Y2p//Eqa9HGRmwWW@kbusch-mbp>
References: <20221107204129.GA417338@bhelgaas>
 <0081d0f6-871f-3d07-1af7-0e8e41f5d983@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0081d0f6-871f-3d07-1af7-0e8e41f5d983@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 07, 2022 at 04:14:54PM -0500, James Puthukattukaran wrote:
> 
> There is a path to disable the controller and that code ran but did
> not help. I checked wit the nvme folks and Keith mentioned that there
> might be an issue with the nvme queue management. Unfortunately, we
> can't try newer kernels in the field. So, looking for a way to just
> "shut off the device" when we have scenarios like this where we can't
> untangle the mess. 

Well, I didn't request you try new kernels in the field. I asked if you
could experiment with a newer one on a development machine to confirm if
the bug was fixed by some of the significant changes in this path so
that we could confirm a reason to port to stable. You're going to have
to change your kernel to fix this observation, so it would be worth the
effort to know if the changes being considered actually address the
problem.

If you're just looking for a work-around for this specific scenario,
sorry, I don't think we'll find one. You should just avoid this scenario
if you can't change your kernel.
