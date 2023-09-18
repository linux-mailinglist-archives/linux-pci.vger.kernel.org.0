Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15147A52CB
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 21:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjIRTQM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 15:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjIRTQL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 15:16:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA45AF7;
        Mon, 18 Sep 2023 12:16:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B828C433C8;
        Mon, 18 Sep 2023 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695064565;
        bh=wYEVj15bDxnaXMivmxiWqgy0vU8qjUuOqF7AfiUWUqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Cz0HGQWw4H6kVQnl5O9XbRDJ5UsVvOGoPOLjXlhUeHZ1QsxK+qQf5VZ4qE+AWMXko
         gFK18ORhXkPvQ2Fd7TbFBQf1+BuTb2R3q8+zaIIYflmlyyZ0s/FEmMgtx+vg6oFV2h
         EiaW5eN4NcJgZ/aDEduWxoF2jczWm844x0p575TRwPg2O33AIwk+ou4Jn8iIR8Iw3r
         N8ET7j5T7zvqIBfLWUaRE82zNRXep2zWiZAiBtSHHYhkHbqTMf6TnHArntPJlvzpD5
         TawoVLeAYVgpix8vZJwNh+0yi+3JnN6lEfDbODQGtzIoQ5FoXpAgrxY+b5jo2FdzNf
         vjZxkIKc8J0RQ==
Date:   Mon, 18 Sep 2023 14:16:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        glaubitz@physik.fu-berlin.de
Subject: Re: [RFC PATCH v2 06/30] drivers/pci: SH7751 PCI Host bridge header.
Message-ID: <20230918191602.GA201859@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b738791694e216841f0db37c10b8e37e3e51526b.1694596125.git.ysato@users.sourceforge.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 06:23:31PM +0900, Yoshinori Sato wrote:
> This file move from SH specific directory "arch/sh/drivers/pci/pci-sh7751.h"
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  drivers/pci/controller/pci-sh7751.h | 270 ++++++++++++++++++++++++++++
>  1 file changed, 270 insertions(+)
>  create mode 100644 drivers/pci/controller/pci-sh7751.h

If this is a move from arch/sh/drivers/pci/, shouldn't this diff show
both the removal and the addition?  Or even better, if you use "git
mv", won't it show the move directly, without a diff at all?

This file is only used in one place, so please just incorporate it
directly into pci-sh7751.c.  I think the git history would be a little
cleaner if you did this as a separate patch before moving it to
drivers/pci/.

If you're moving things into drivers/pci/, follow the subject line
conventions (see "git log --oneline drivers/pci/controller/"):

  - No period at end of subject line

  - Subject line begins with "PCI: <driver-tag>: <Verb> ...", e.g.,
    PCI: sh7751: Add SH7751 driver

> diff --git a/drivers/pci/controller/pci-sh7751.h b/drivers/pci/controller/pci-sh7751.h
> new file mode 100644
> index 000000000000..9b7de8243e92
> --- /dev/null
> +++ b/drivers/pci/controller/pci-sh7751.h
> @@ -0,0 +1,270 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *	Low-Level PCI Support for SH7751 targets
> + *
> + *  Dustin McIntire (dustin@sensoria.com) (c) 2001
> + *  Paul Mundt (lethal@linux-sh.org) (c) 2003
> + *
> + *  May be copied or modified under the terms of the GNU General Public
> + *  License.  See linux/COPYING for more information.

Unnecessary text, given the SPDX header above.

> + *

Spurious blank line.

> +/* Platform Specific Values */
> +#define SH7751_VENDOR_ID             0x1054
> +#define SH7751_DEVICE_ID             0x3505
> +#define SH7751R_DEVICE_ID            0x350e

Most of this file uses upper-case hex, so use it consistently.

Bjorn
