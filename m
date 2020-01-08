Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4179E134EEB
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 22:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgAHVdk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 16:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgAHVdk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 16:33:40 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34063206DA;
        Wed,  8 Jan 2020 21:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578519219;
        bh=Ebgnz0xt6ViRBHyLUIfMT2DAdw3EQ6/qLeN7bxMH+rI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZzrWYV06AEpqVgipROVFGbWVF7YaQsxGsNst9/hRWgrFLEsJbXMb8iHFYY8sk4kPk
         3/GTM93KmUfLw3VOVAlZRFRLgTwCbBELU4S5g7YhW1XpZHhYERLwS6Rn8ymiYeEA/E
         a1Ai/iI5uKQehToCu0HUzZTVNV4P3Kl/cFzXSWM0=
Date:   Wed, 8 Jan 2020 15:33:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>
Subject: Re: [PATCH 03/12] PCI/switchtec: Add support for new events
Message-ID: <20200108213337.GA210184@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106190337.2428-4-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 06, 2020 at 12:03:28PM -0700, Logan Gunthorpe wrote:
> The intercomm notify  event was added for PAX variants of switchtec
> hardware and the UEC Port was added for the MR1 release of GEN3 firmware.

Do they actually spell it "intercomm" in the datasheet?  Seems like
the most common English spelling is "intercom".

Is there some meaningful expansion of "UEC"?

> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/switch/switchtec.c       | 3 +++
>  include/linux/switchtec.h            | 7 +++++--
>  include/uapi/linux/switchtec_ioctl.h | 4 +++-
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 9c3ad09d3022..218e67428cf9 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -751,10 +751,13 @@ static const struct event_reg {
>  	EV_PAR(SWITCHTEC_IOCTL_EVENT_MRPC_COMP, mrpc_comp_hdr),
>  	EV_PAR(SWITCHTEC_IOCTL_EVENT_MRPC_COMP_ASYNC, mrpc_comp_async_hdr),
>  	EV_PAR(SWITCHTEC_IOCTL_EVENT_DYN_PART_BIND_COMP, dyn_binding_hdr),
> +	EV_PAR(SWITCHTEC_IOCTL_EVENT_INTERCOMM_REQ_NOTIFY,
> +	       intercomm_notify_hdr),
