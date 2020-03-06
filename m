Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8F517B68C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 07:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgCFGG7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 01:06:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:37424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgCFGG7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 01:06:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BF005B066;
        Fri,  6 Mar 2020 06:06:56 +0000 (UTC)
Date:   Fri, 06 Mar 2020 07:06:55 +0100
Message-ID: <s5hv9nidnk0.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        David Miller <davem@davemloft.net>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 10/10] sound: bt87x: use pci_status_get_and_clear_errors
In-Reply-To: <6362e866-9ce3-31f5-3357-9f086eedf11e@gmail.com>
References: <adeb9e6e-9be6-317f-3fc0-a4e6e6af5f81@gmail.com>
        <6362e866-9ce3-31f5-3357-9f086eedf11e@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 29 Feb 2020 23:29:07 +0100,
Heiner Kallweit wrote:
> 
> Use new helper pci_status_get_and_clear_errors() to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

> ---
>  sound/pci/bt87x.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
> index 8c48864c8..656750466 100644
> --- a/sound/pci/bt87x.c
> +++ b/sound/pci/bt87x.c
> @@ -271,13 +271,8 @@ static void snd_bt87x_free_risc(struct snd_bt87x *chip)
>  
>  static void snd_bt87x_pci_error(struct snd_bt87x *chip, unsigned int status)
>  {
> -	u16 pci_status;
> +	int pci_status = pci_status_get_and_clear_errors(chip->pci);
>  
> -	pci_read_config_word(chip->pci, PCI_STATUS, &pci_status);
> -	pci_status &= PCI_STATUS_PARITY | PCI_STATUS_SIG_TARGET_ABORT |
> -		PCI_STATUS_REC_TARGET_ABORT | PCI_STATUS_REC_MASTER_ABORT |
> -		PCI_STATUS_SIG_SYSTEM_ERROR | PCI_STATUS_DETECTED_PARITY;
> -	pci_write_config_word(chip->pci, PCI_STATUS, pci_status);
>  	if (pci_status != PCI_STATUS_DETECTED_PARITY)
>  		dev_err(chip->card->dev,
>  			"Aieee - PCI error! status %#08x, PCI status %#04x\n",
> -- 
> 2.25.1
> 
> 
