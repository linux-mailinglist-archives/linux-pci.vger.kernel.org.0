Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C13139B48
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 22:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgAMVRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 16:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgAMVRb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 16:17:31 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D062F2072B;
        Mon, 13 Jan 2020 21:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578950250;
        bh=a3M9peGLxqJfcgONYpYrnY2hm9/E2kn/qjsgS5bQ528=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nJfd27bjMYKkFoxQGTtykqdD5cumqlRhVFp5DZZxAZlrD9hZE5LW5CNjYi3wyLOwI
         4LvHAZgSqafE4+zMNaUOo5z8KUJk6v0FF9tQMVDEaI9HmMbawRTw+5QcB4c87e2538
         3Gp9zPtJfSGbhHo/ESt2SB49GkUk7l/WfLDyEibw=
Date:   Mon, 13 Jan 2020 15:17:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, f.fangjian@huawei.com
Subject: Re: [Patch] PCI:add 32 GT/s decoding in some macros
Message-ID: <20200113211728.GA113776@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578883220-28222-1-git-send-email-yangyicong@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 13, 2020 at 10:40:20AM +0800, Yicong Yang wrote:
> Link speed 32.0 GT/s is supported in PCIe r5.0. Add in macro
> PCIE_SPEED2STR and PCIE_SPEED2MBS_ENC to correctly decode.
> This patch is a complementary to
> commit de76cda215d5 ("PCI: Decode PCIe 32 GT/s link speed")

Thanks for the patch!  Can you please rework current_link_speed_show()
(which was updated by de76cda215d5 ("PCI: Decode PCIe 32 GT/s link
speed")) so we don't duplicate the strings there and in
PCIE_SPEED2STR()?

Maybe something like:

  switch (linkstat & PCI_EXP_LNKSTA_CLS) {
  case PCI_EXP_LNKSTA_CLS_32_0GB:
    speed = PCIE_SPEED2STR(PCIE_SPEED_32_0GT);
    break;
  ...

My goal is to both remove the string duplication and make it more
likely that when we add the *next* new speed, we'll catch everything
the first time around.

Bjorn

> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/pci/pci.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3f6947e..2cd64bd 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -288,7 +288,8 @@ void pci_bus_put(struct pci_bus *bus);
> 
>  /* PCIe link information */
>  #define PCIE_SPEED2STR(speed) \
> -	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
> +	((speed) == PCIE_SPEED_32_0GT ? "32 GT/s" : \
> +	 (speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
>  	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
>  	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
>  	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
> @@ -296,7 +297,8 @@ void pci_bus_put(struct pci_bus *bus);
> 
>  /* PCIe speed to Mb/s reduced by encoding overhead */
>  #define PCIE_SPEED2MBS_ENC(speed) \
> -	((speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
> +	((speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
> +	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
>  	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
>  	 (speed) == PCIE_SPEED_5_0GT  ?  5000*8/10 : \
>  	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
> --
> 2.8.1
> 
