Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139314EA71B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 07:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiC2F2C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 01:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiC2F2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 01:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915541D78B3;
        Mon, 28 Mar 2022 22:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE0161449;
        Tue, 29 Mar 2022 05:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD36C2BBE4;
        Tue, 29 Mar 2022 05:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648531578;
        bh=F94j0WiJmE2n0U54lTd9JyGb37irQw7Kn+4tBx3Tek8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rfKOAIHc3UKdfQCh+KF0GLb4Ygz1rsSRoqsaN84U/rjKkufMQbBDESgGP71GMbPRB
         llDZ5wx/fJIZ16qJwRp0QHtsq7IJqi1JgBVHVqJDZp6dVfGR+KLr/7rhPq76AqBd9H
         JXsh0GTY+o2gfJf8MwG4LgrU4wShbcwBMR65lAXs=
Date:   Tue, 29 Mar 2022 07:26:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tanjore Suresh <tansuresh@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Asynchronous shutdown interface and example
 implementation
Message-ID: <YkKYd3DIduUyuEso@kroah.com>
References: <20220328230008.3587975-1-tansuresh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328230008.3587975-1-tansuresh@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 28, 2022 at 04:00:05PM -0700, Tanjore Suresh wrote:
> Problem:
> 
> Some of our machines are configured with  many NVMe devices and
> are validated for strict shutdown time requirements. Each NVMe
> device plugged into the system, typicaly takes about 4.5 secs
> to shutdown. A system with 16 such NVMe devices will takes
> approximately 80 secs to shutdown and go through reboot.
> 
> The current shutdown APIs as defined at bus level is defined to be
> synchronous. Therefore, more devices are in the system the greater
> the time it takes to shutdown. This shutdown time significantly
> contributes the machine reboot time.
> 
> Solution:
> 
> This patch set proposes an asynchronous shutdown interface at bus level,
> modifies the core driver, device shutdown routine to exploit the
> new interface while maintaining backward compatibility with synchronous
> implementation already existing (Patch 1 of 3) and exploits new interface
> to enable all PCI-E based devices to use asynchronous interface semantics
> if necessary (Patch 2 of 3). The implementation at PCI-E level also works
> in a backward compatible way, to allow exiting device implementation
> to work with current synchronous semantics. Only show cases an example
> implementation for NVMe device to exploit this asynchronous shutdown
> interface. (Patch 3 of 3).
> 
> Tanjore Suresh (3):
>   driver core: Support asynchronous driver shutdown
>   PCI: Support asynchronous shutdown
>   nvme: Add async shutdown support
> 
>  drivers/base/core.c        | 39 ++++++++++++++++++-
>  drivers/nvme/host/core.c   | 28 +++++++++----
>  drivers/nvme/host/nvme.h   |  8 ++++
>  drivers/nvme/host/pci.c    | 80 ++++++++++++++++++++++++--------------
>  drivers/pci/pci-driver.c   | 17 ++++++--
>  include/linux/device/bus.h | 10 +++++
>  include/linux/pci.h        |  2 +
>  7 files changed, 144 insertions(+), 40 deletions(-)
> 
> -- 
> 2.35.1.1021.g381101b075-goog
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
