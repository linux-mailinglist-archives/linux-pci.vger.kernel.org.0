Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21FA6CF017
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjC2RFV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 13:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC2RFU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 13:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132221FC6;
        Wed, 29 Mar 2023 10:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A291961D14;
        Wed, 29 Mar 2023 17:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0E3C433D2;
        Wed, 29 Mar 2023 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680109517;
        bh=ItVnaZ8FUAX4pSnv5WsIqGPOgOFkxmneK6Rfun+mOtY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=c1+JvlWVoHxfTWRdSlzBTwUTIw3f3QETPbe52cty0rY36OZA8abs67W9qizwgOuWF
         5IoLpxrEH5RzrH0UDNkXIvYL0rJJ4nqbwLZvs9c1FE3l7qMRwtdK86SA1QFzXFtSTG
         TiLe9iNTx8he8OyIWwpiVH0BPml1o7ksCnTZEFwhbqAqexfmj4URDBKcfd1rt50Epl
         J90k/f6t1FaOqo+dKSXZOo07HREotWF3WjX2NQwkQ9I56eUMT0OPt0An7JdL938eB5
         qXP8UeRrkkx7lE2KOWw5Rd332/3xQoJHwsUJhSWQNUPRNPSFwBV1WjL0gd5gRgkDKh
         LWmaY0kiJgrsA==
Date:   Wed, 29 Mar 2023 12:05:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     sdonthineni@nvidia.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wllenyj@linux.alibaba.com, wutu.xq2@linux.alibaba.com,
        gerry@linux.alibaba.com
Subject: Re: [RFC PATCH] PCI: avoid SBR for NVIDIA T4
Message-ID: <20230329170515.GA3067097@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <388bc353a5f88edb502ec04c0dc53ab62a526020.1680090885.git.wuzongyong@linux.alibaba.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 29, 2023 at 07:58:45PM +0800, Wu Zongyong wrote:
> Secondary bus reset will fail if NVIDIA T4 card is direct attached to a
> root port.

Blank line between paragraphs.  Rewrap to fill 75 columns if it's a
single paragraph.

Is this only a problem when direct attached to a Root Port?  Why would
that be?  If it's *not* related to being directly under a Root Port,
don't mention that at all.

> So avoid to do bus reset,  pci_parent_bus_reset() works nomarlly.
> 
> Maybe NVIDIA guys can do some detailed explanation abount the SBR
> behaviour of GPUs.

This is a follow-on to 4c207e7121fa ("PCI: Mark some NVIDIA GPUs to
avoid bus reset"), so probably should have a Fixes: tag so it goes
whereever that commit goes.

Also copy the subject line from 4c207e7121fa, e.g.,

  PCI: Mark NVIDIA T4 GPUs to avoid bus reset

Are there any problem reports or bugzilla issues you can include a URL
to?

> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44cab813bf95..be86b93b9e38 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3618,7 +3618,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
>   */
>  static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
>  {
> -	if ((dev->device & 0xffc0) == 0x2340)
> +	if ((dev->device & 0xffc0) == 0x2340 || dev->device == 0x1eb8)
>  		quirk_no_bus_reset(dev);
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> -- 
> 2.34.3
> 
