Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63949544006
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 01:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiFHXmI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 19:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiFHXl5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 19:41:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995891AA17D;
        Wed,  8 Jun 2022 16:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA6F4B829F9;
        Wed,  8 Jun 2022 23:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D42C3411E;
        Wed,  8 Jun 2022 23:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654731662;
        bh=8TesstUwyX400Czc4f/SvrGdHmpleWBYHpobEaZCwkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=InGtDqacJmo8CM6l4lGtNFSqYRF/mp1WqAFeknGWsuvfBS9Gio9rSz/TDbEI9VoYW
         lq/1cpE72U11sAE/A76bYuzsaoWytZqKhexukpWwxlW/OJX1HCFHmRxAEUzfrYCcox
         K8gn4Qfl4aJIGB+qzccPQOekypKr4mCHM6bKwIG+vDFfwlbiuKx1TQ6dmkkaV1G5b3
         SveEMin/ZOuGfatVXUe3wyYVmktytRcA0NepOcbpC5VSSMryzeRYteu2j8LPq9xW5g
         TG78VLvGMspHYQnuk4iYHa3/aPM3NHhE37V9kf29qHbUD2hr0V7COa2zi9MmuwFZfJ
         mtC/+JRlfJ3bQ==
Date:   Wed, 8 Jun 2022 18:40:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, linux-pci@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 29/33] PCI/P2PDMA: Convert to printbuf
Message-ID: <20220608234059.GA434397@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5d0cc2e-79e1-3248-0f55-8f1afd21f926@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 08, 2022 at 07:24:02PM -0400, Kent Overstreet wrote:
> On 6/8/22 17:11, Bjorn Helgaas wrote:
> > On Sat, Jun 04, 2022 at 03:30:38PM -0400, Kent Overstreet wrote:
> > > This converts from seq_buf to printbuf. We're using printbuf in external
> > > buffer mode, so it's a direct conversion, aside from some trivial
> > > refactoring in cpu_show_meltdown() to make the code more consistent.
> > 
> > cpu_show_meltdown() doesn't appear in p2pdma.c.  Leftover from another
> > patch?  Maybe from 27/33 ("powerpc: Convert to printbuf")?

Don't forget this part :)

> > I'm not opposed to this, but it would be nice to say what the benefit
> > is.  How is printbuf better than seq_buf?  It's not obvious from the
> > patch how this is better/safer/shorter/etc.
> > 
> > Even the cover letter [1] is not very clear about the benefit.  Yes, I
> > see it has something to do with improving buffer management, and I
> > know from experience that's a pain.  Concrete examples of typical
> > printbuf usage and bugs that printbufs avoid would be helpful.
> 
> Take a look at the vsprintf.c conversion if you want to see big
> improvements. Also, %pf() is another thing that's going to enable a lot more
> improvements.

Like I said, I'm not opposed to this, I'm just looking for a hint in
this commit log that makes me think "yes, this is a good idea for
PCI."

Right now it just says "converts X to Y."  I'm hoping for "convert X
to Y to avoid <some problem with X>."

Bjorn
