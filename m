Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F2ADF4EE
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 20:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfJUSRP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 14:17:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34829 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbfJUSRP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 14:17:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id z6so11867588otb.2;
        Mon, 21 Oct 2019 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VQ0yxSypAHnmTVia1KKk9xBQO5JaYYYTVlAYdXCJrEM=;
        b=pWaPLFx6yPit4mrXRY3TFDplkYzgvXWXEki4yByePJfywUvLSZFuIkPRIccvbJizOb
         FgW36DKkExX2ksq50jPvVZOo8yaDQXhHOuZjVd0+pvSVkZaw+ywnV45Vt5qD1NkXbN+q
         Vzf7J8h3oXT6D4WGQ2hf4slVTGQMjIZPA9RpIrOf76ka2vnLIdDpmlZ5sPcCYQ0BKE1w
         LddCk/0OH1YUKkU3pwkGyK8JAtKFGsAfljs0WdHs6i10G9zmKfvLyRbVMJodvnUBeMyC
         tvcDgKtWK867EDeIoZ9I6AUH6oF/kOqinyAt7j1qKxm0AmrkQD/gl0MjmJuRpmmAuDjS
         Orkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VQ0yxSypAHnmTVia1KKk9xBQO5JaYYYTVlAYdXCJrEM=;
        b=fwYgIiBp7FfFiJNxVBqN7CoLDugN560Y+gnKVMj4Ti8WZzlmCNCDC9COaWFHGIIxWD
         2L1CGaAEhEXSgVR4pKLlIouGRGXxcj5dZ+ehkuevDe0g0F/4C5Flaf/Uy8fCLpMj7TdJ
         cOqVu+v2oA2CAmJR0h+87jgde933dmKKQaTWWhqufsnNN8pR7CZlXAkr0NX3XTlqJXT+
         Uf6t1uii5izkmL4D6x0wm17FzWbNy2stSC4l4+zoBc4WPIVubBDIzWkRCa3Uk/EFo1Z+
         Qu3qxxnDNqlbri8IA/HAOdWETuj7z55SSjjSBdF+KJuQEInmNSRpGYugRMpj1SqOq0XC
         pOcQ==
X-Gm-Message-State: APjAAAV9HKEotiJgIg8EA1HLHfSZtmVgQyXIwUqmdp63bEnnck/UNdd2
        fzuKW63WxSvP5csKx30EtYLeBLku4PB1foG5j5s=
X-Google-Smtp-Source: APXvYqzJ34iojFtoSpQNiuTeFTXsG2wKdA+8wnirYpSXyu3F52aftC3ugFL6CeMwdKyjWDBamD6WbkWp1fx98Fi8t2A=
X-Received: by 2002:a05:6830:1693:: with SMTP id k19mr1836698otr.233.1571681833779;
 Mon, 21 Oct 2019 11:17:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:648:0:0:0:0:0 with HTTP; Mon, 21 Oct 2019 11:17:12 -0700 (PDT)
In-Reply-To: <20191021160952.GA229204@google.com>
References: <20191020090800.GA2778@light.dominikbrodowski.net> <20191021160952.GA229204@google.com>
From:   "Michael ." <keltoiboy@gmail.com>
Date:   Tue, 22 Oct 2019 05:17:12 +1100
Message-ID: <CAFjuqNg2BjbxsOeOpoo8FQRwatQHeHKhj01hbwNrSHjz9p3vYw@mail.gmail.com>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not working
 on Panasonic Toughbook CF-29]
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you Dominik for looking at this for us and passing it on.

Good morning Bjorn, thank you also for looking into this for us and
thank you for CCing us into this as non of us are on the mailing list.
One question how do we apply this patch or is this for Dominik to try?

Cheers.
Michael

On 22/10/2019, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sun, Oct 20, 2019 at 11:08:00AM +0200, Dominik Brodowski wrote:
>> On the basis of the additional information (thanks), there might be a
>> more specific path to investigate: It is that the PCI code does not
>> enumerate the second cardbus bridge PCI function in the more recent 4.19
>> kernel compared to the anvient (and working) 2.6 kernel.
>>
>> Namely, only one CardBus bridge is recognized
>>
>> ...
>> 06:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8b)
>> 06:01.1 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host
>> Adapter (rev 11)
>> 06:02.0 Network controller: Intel Corporation PRO/Wireless 2915ABG
>> [Calexico2] Network Connection (rev 05)
>> ...
>>
>> instead of the two which really should be present:
>>
>> ...
>> 06:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8b)
>> 06:01.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8b)
>> 06:01.2 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host
>> Adapter (rev 11)
>> 06:02.0 Network controller: Intel Corporation PRO/Wireless 2915ABG
>> [Calexico2] Network Connection (rev 05)
>> ...
>>
>> To the PCI folks: any idea on what may cause the second cardbus bridge
>> PCI
>> device function to be missed? Are there any command line options the
>> users
>> who reported this issue[*] may try?
>
> Thanks for the report.  Could you try disabling
> ricoh_mmc_fixup_rl5c476(), e.g., with the patch below (this is based
> on v5.4-rc1, but you can use v4.9 if that's easier for you)?  This
> isn't a fix; it's just something that looks like it might be related.
>
>> [*] For more information, see this thread:
>> 	https://lore.kernel.org/lkml/CAFjuqNi+knSb9WVQOahCVFyxsiqoGgwoM7Z1aqDBebNzp_-jYw@mail.gmail.com/
>
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 320255e5e8f8..7a1e1a242506 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3036,38 +3036,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020,
> quirk_hotplug_bridge);
>   * #1, and this will confuse the PCI core.
>   */
>  #ifdef CONFIG_MMC_RICOH_MMC
> -static void ricoh_mmc_fixup_rl5c476(struct pci_dev *dev)
> -{
> -	u8 write_enable;
> -	u8 write_target;
> -	u8 disable;
> -
> -	/*
> -	 * Disable via CardBus interface
> -	 *
> -	 * This must be done via function #0
> -	 */
> -	if (PCI_FUNC(dev->devfn))
> -		return;
> -
> -	pci_read_config_byte(dev, 0xB7, &disable);
> -	if (disable & 0x02)
> -		return;
> -
> -	pci_read_config_byte(dev, 0x8E, &write_enable);
> -	pci_write_config_byte(dev, 0x8E, 0xAA);
> -	pci_read_config_byte(dev, 0x8D, &write_target);
> -	pci_write_config_byte(dev, 0x8D, 0xB7);
> -	pci_write_config_byte(dev, 0xB7, disable | 0x02);
> -	pci_write_config_byte(dev, 0x8E, write_enable);
> -	pci_write_config_byte(dev, 0x8D, write_target);
> -
> -	pci_notice(dev, "proprietary Ricoh MMC controller disabled (via CardBus
> function)\n");
> -	pci_notice(dev, "MMC cards are now supported by standard SDHCI
> controller\n");
> -}
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_RL5C476,
> ricoh_mmc_fixup_rl5c476);
> -DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH,
> PCI_DEVICE_ID_RICOH_RL5C476, ricoh_mmc_fixup_rl5c476);
> -
>  static void ricoh_mmc_fixup_r5c832(struct pci_dev *dev)
>  {
>  	u8 write_enable;
>
