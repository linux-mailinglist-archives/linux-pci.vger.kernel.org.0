Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793F26F20A1
	for <lists+linux-pci@lfdr.de>; Sat, 29 Apr 2023 00:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjD1WA6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Apr 2023 18:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjD1WA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2023 18:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9181340CB
        for <linux-pci@vger.kernel.org>; Fri, 28 Apr 2023 15:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31B3F6454D
        for <linux-pci@vger.kernel.org>; Fri, 28 Apr 2023 22:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFB3C433EF;
        Fri, 28 Apr 2023 22:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682719256;
        bh=vI+1JB4ApKraEw8+XsPFnXCbU8kgnq8FeUwTtUjYHiw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uuoaOcmJYoqHdTkZWqF9TiqQFORoPXGxuuShRrnqMDTGnhAG/PlTVTsR1zPuh4LQt
         7/wKP5A7SJEhlJ86vzcR4xcDop2StOXK/KFIaXxO3ElCs3umzcQz7KDEJaOXqszXpW
         4AK/43W2rTJkoQ/BnyaVRq6q4ESCrLSxPMANS2n2CtKHxua/oK+SoyyaVx6GPiE7mD
         XLV8UBNYQN79XNcAsnVKesrUsmMMIoKlGOZkM7ll62I7R0fP4nZCI73aqoTIp+IPk0
         ONRIQ81Qzywd1BEzM2ZTncobxydWDdnergKbcxjVgfqoNeiNQEizji48+IU6zYhn28
         VVT0SkH4Xpm7A==
Date:   Fri, 28 Apr 2023 17:00:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Grant Grundler <grundler@chromium.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN730
 WD SSD
Message-ID: <20230428220054.GA369990@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB64739F4EE26DB3E95BA8D1788B679@DM6PR04MB6473.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 24, 2023 at 11:27:43AM +0000, Alexey Bogoslavsky wrote:
> Hello Bjorn,
> 
> Sorry for not addressing your questions earlier. As you may have
> heard, WD experienced a hacking attack which left us with no access
> to the company e-mail for weeks.

So sorry to hear that, that is incredibly disruptive.

> As for the patch, no FW change was an option as the product causing
> the issue was basically at the end of life. So, I prepared a
> workaround that took into account all the comments from the
> community.

Makes sense and is a very common situation.  In general we try to
avoid "fixing" issues by requiring a firmware update because even if
such an update is available, most users will not have it.

I think the hope was that a kernel quirk could tweak something on the
device to make it stop reporting these errors.

> Yet, at this point it seems like the company has lost interest in
> promoting this patch altogether.  So we could just drop it. Please
> let me know if there's anything I need to do to request that
> officially.

No worries, you don't need to do anything.  If you can point me to any
users or bug reports, maybe I can tidy this up and merge it.  Those
users are still being annoyed by the error spam, and that seems
pointless.

Bjorn
