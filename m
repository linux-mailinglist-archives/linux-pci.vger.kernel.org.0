Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E8362CACB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 21:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiKPU3H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 15:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKPU3G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 15:29:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2D2A199
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 12:29:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC5C361896
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 20:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFC3C433C1;
        Wed, 16 Nov 2022 20:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668630544;
        bh=024zwAx+q16p5nIt1HjvNG6k3GAZG3GeU6xTV2rQ8Ts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J7wn8RM4e615N8gAPOmdnFP7mLAMQ3201pgdR6fC+/OeYHeealyYZm1EewQ0gsseO
         q+3URFUmonnfsifEkx1mAsIjPjkbrGmo1ucMmd8sAKOdMaj9Y/zsTDxHArf7xm8sTa
         EsmBlABtkUtgreEFIbsiEoq0eI8JLShbg+hHin9G1EmWqWXnLDgStxzLLVURwBLItm
         HKAlR8YNlXVBOqUqAQyohvj2Mdowjgoo4qH3A2SH/zYfqdMRJssqcgIvw9ylKxwSwA
         ItuXYwkhtoXluZBD/PA7WpoO9RN2DNZgRLWi08LH9SJx2IKeIdBRKngDSlLn4R3Nxz
         7tQ/s81e5WSxQ==
Date:   Wed, 16 Nov 2022 14:29:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Li Ming <ming4.li@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/1] PCI/DOE: Fix maximum data object length
 miscalculation
Message-ID: <20221116202902.GA1134656@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116185610.GA4563@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 07:56:10PM +0100, Lukas Wunner wrote:
> On Wed, Nov 16, 2022 at 12:02:50PM -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 16, 2022 at 09:56:37AM +0800, Li Ming wrote:
> > > The value of data object length 0x0 indicates 2^18 dwords being
> > > transferred. This patch adjusts the value of data object length for the
> > > above case on both sending side and receiving side.
> > > 
> > > Besides, it is unnecessary to check whether length is greater than
> > > SZ_1M while receiving a response data object, because length from LENGTH
> > > field of data object header, max value is 2^18.
> > > 
> > > Signed-off-by: Li Ming <ming4.li@intel.com>
> > 
> > Applied with Reviewed-by from Jonathan and Lukas, thank you very much
> > to all of you!
> > 
> > I touched up the commit log; let me know if I made anything worse:
> 
> Jonathan mentioned that a Fixes tag might make sense.  If you agree:
> 
> Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
> Cc: stable@vger.kernel.org # v6.0+

Sure, sorry I missed that.  Although I don't see it on the list, so
maybe it was a side-band comment.  Added in any case.

Bjorn
