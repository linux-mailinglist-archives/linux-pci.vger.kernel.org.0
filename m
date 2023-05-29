Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D96714966
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 14:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjE2MXZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 08:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjE2MXY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 08:23:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CB1B1;
        Mon, 29 May 2023 05:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1674461478;
        Mon, 29 May 2023 12:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4431BC4339B;
        Mon, 29 May 2023 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685363002;
        bh=DIom684KiSxk01dPxTEKYPYlKZpznxqWChGWbgchUas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m4huvw5FG87KkGp5G3c8mVaPbM/gEiXG+/qixHAbgpeFl0VLnEkTvQBqodFGEHH8z
         Kub46+L6NPl7bhqzEl563kbd8CCrHPTsh+waN3A7pHqapeFNaA9nlQETtbkiuGh+Dn
         kmy+h8vfXfQbArn0f63TOuetidEW/dy87CBXcO/P3rFKA6Tw2nurzspDUAjGuO1hEl
         liuE0b3YCe3k56krJ9D7G9TCdrR8fGKQJZhMGJ5MAo9L2mXtklS63FWtdj9xPcwKuX
         yWpXNYr2bYemW3TwKZW3Ru13mT79WvyUHLDX5CZvUqZuobq9YK65hY9RvxI/4Zn0lp
         Zj0iup5lWOMJA==
Date:   Mon, 29 May 2023 07:23:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?utf-8?B?5qWK5a6X57+w?= <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@google.com>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@google.com>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] drivers: pci: quirks: Add suspend fixup for SSD on
 sc7280
Message-ID: <ZHSZOKEMNbARQyiG@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPao8GJNbXnh1R2-9rueMygyYyy-r3kqvQ55xdN61E7m6_dkdw@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 29, 2023 at 02:24:53PM +0800, 楊宗翰 wrote:
> Hi Bjorn,
> 
> Thanks for your kind directions.

Your response was a multi-part message, which doesn't work on the
Linux mailing lists.  See http://vger.kernel.org/majordomo-info.html

>   - Subject line in style of the file (use "git log --oneline
>     drivers/pci/quirks.c").
> Done, and I resend in topic "[PATCH v1] PCI: Add suspend fixup for SSD
>  on sc7280", please review it.

This would actually have been "v2", since you sent v1 previously.

>   - Description of incorrect behavior.  What does the user see?  If
>     there's a bug report, include a link to it.
> 
> This issue seems to be discovered in ChromeOS only. SSD will randomly
> 
> crashed at 100~250+ suspend/resume cycle. Phison and Qualcomm
> 
> found that its due to NVMe entering D3cold instead of L1ss.
> https://partnerissuetracker.corp.google.com/issues/275663637

This kind of information needs to be in the commit log, not just in
the email thread.

It's best if there is a published errata document from Qualcomm that
describes the issue and how software should work around it.  Obviously
a URL to that document would be in the commit log.

>   - Multi-line code comments in style of the file (look at existing
>     comments in the file).
> Done.

Not quite done.  Needs to be like this:

  /*
   * Text ...
   */

Not like this:

  /* Text ...
   */

>   - Details of "the correct ASPM state".  ASPM may be enabled or
>     disabled by the user, so you can't assume any particular ASPM
>     configuration.
> According to Qualcomm. This issue has been found last year and they have
> attempt to submit some patches to fix the pci suspend behavior.
> (ref:https://patchwork.kernel.org/project/linux-arm-msm/list/?
> series=665060&state=%2A&archive=both).
> But somehow these patches were rejected because of its complexity. And
> we've got advise from Google that it will be more efficient that we
> implement
> a quirks to fix this issue.

Some of this history or at least a pointer to it should be in the
commit log.

>   - Details on the Qualcomm sc7280 connection.  This quirk would
>     affect Phison SSDs on *all* platforms, not just sc7280.  I don't
>     want to slow down suspend on all platforms just for a sc7280
>     issue.
> The DECLARE_PCI_FIXUP_SUSPEND function has already specify the PCI device
> ID. And this SSD will only be used at our Chromebook device only.

It's hard to guarantee that this will only be used in Chromebook, so
this is a little weak.  But if it's the best we have, it needs to be
mentioned in the code comment.

Bjorn
