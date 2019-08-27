Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDAD59F700
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 01:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfH0XmM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 19:42:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44075 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfH0XmL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 19:42:11 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so2041147iog.11;
        Tue, 27 Aug 2019 16:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fAkCsG+LfrTL4UGMAIquUE2ULf5h5EBAaE7x0EeLZEg=;
        b=m4kexfQTWGYpHGXqP0LYp8yz54l7T3jjdgj8Y3To44Wtd4BVWYDmm4qpVyR0RZtBOI
         aSbjYbij4Z9KC8b9TzR9jK/q4wMG9QJgRuZ/687YOfaqc2+2VKdlzdFnz8JZMYbl50fo
         2M/8acHcXYECd46jtqXNT6vcy3IuDNSsNRbdbfFCO7iw3AZfNehbSpX6gdHHUKtOWDNo
         CoiVlzPK26Ncvl+lxJE3F++6mlxWExnEnzy4rKaFzvwOX457OvfSwLii6yvtUCI/DtHv
         xVrfwFPQo1laViaptvFhUgDeVbW0rDtPpfORmlwRaUWgnIxKSor00hKXpH+/AIIH8Zhu
         TqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fAkCsG+LfrTL4UGMAIquUE2ULf5h5EBAaE7x0EeLZEg=;
        b=NpxBw/361+YePQpOm2UfaMcO1/YUX/bIr7P3PzRx3vq9sUmNcK64o1asNNOvY/+KV4
         F80pGogVDNCu0u+QtVJ72J8YY23lgHFGjK6HX7Khj0ASLEoTLHrGAILL5vci7XKQvslN
         W4o+4vPCcvKI38Ae1pcLg3TdKwOIPwrruPnMaTaOPtVwycyio/6H8XPB8lYWdp+IiNLG
         rHgSiQ0++Ym0uHhndjyb2mZs4iKafqVHC/j51x33TbeEDzaC4m7pTUB0dTQgD/OMPBYY
         piwwXCuiFFouV2m7np6ZpbWLwFhyg3tHgAky7Clb8MAuySV3sNfk5IaGfTBgWhGn0pxo
         s0jg==
X-Gm-Message-State: APjAAAU/EC9WC8TZYZHIlEzBNyCTYN5N6qdiqiCRPSszmaESQnRprOhM
        0MmxBNgUIhaBICpU1Z7d/G4/F/oVs9qErKHfPbI=
X-Google-Smtp-Source: APXvYqw9FPGLKMvuxuRalZIHFU6gtUuvALXjMlCBRAxvOKkRjRS+pqxedw6XSof+czWezQc+QRTQR6uYC//V6JVXUSU=
X-Received: by 2002:a6b:6e0e:: with SMTP id d14mr1075179ioh.18.1566949330504;
 Tue, 27 Aug 2019 16:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190819160643.27998-1-efremov@linux.com> <20190819160643.27998-2-efremov@linux.com>
In-Reply-To: <20190819160643.27998-2-efremov@linux.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 28 Aug 2019 09:41:59 +1000
Message-ID: <CAOSf1CEMwePWiGPEfqsqjXQ2bbBiRRSHHk7BpWcwqUdgSmpzCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] PCI: pciehp: Add pciehp_set_indicators() to
 jointly set LED indicators
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 2:07 AM Denis Efremov <efremov@linux.com> wrote:
>
> Add pciehp_set_indicators() to set power and attention indicators with a
> single register write. Thus, avoiding waiting twice for Command Complete.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/pci/hotplug/pciehp.h     |  1 +
>  drivers/pci/hotplug/pciehp_hpc.c | 29 +++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h    |  2 ++
>  3 files changed, 32 insertions(+)
>
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 8c51a04b8083..0e272bf3deb4 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -167,6 +167,7 @@ int pciehp_power_on_slot(struct controller *ctrl);
>  void pciehp_power_off_slot(struct controller *ctrl);
>  void pciehp_get_power_status(struct controller *ctrl, u8 *status);
>
> +void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
>  void pciehp_set_attention_status(struct controller *ctrl, u8 status);
>  void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
>  int pciehp_query_power_fault(struct controller *ctrl);
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index bd990e3371e3..5474b9854a7f 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -443,6 +443,35 @@ void pciehp_set_attention_status(struct controller *ctrl, u8 value)
>                  pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
>  }
>
> +void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
> +{
> +       u16 cmd = 0, mask = 0;
> +
> +       if (PWR_LED(ctrl))
> +               switch (pwr) {
> +               case PCI_EXP_SLTCTL_PWR_IND_ON:
> +               case PCI_EXP_SLTCTL_PWR_IND_BLINK:
> +               case PCI_EXP_SLTCTL_PWR_IND_OFF:

Do you need an explicit /* fallthrough */ comment? I thought the
fallthrough warning was enabled by default now.

> +                       cmd |= pwr;
> +                       mask |= PCI_EXP_SLTCTL_PIC;
> +               }
> +
> +       if (ATTN_LED(ctrl))
> +               switch (attn) {
> +               case PCI_EXP_SLTCTL_ATTN_IND_ON:
> +               case PCI_EXP_SLTCTL_ATTN_IND_BLINK:
> +               case PCI_EXP_SLTCTL_ATTN_IND_OFF:
> +                       cmd |= attn;
> +                       mask |= PCI_EXP_SLTCTL_AIC;
> +               }
> +
> +       if (cmd) {
> +               pcie_write_cmd_nowait(ctrl, cmd, mask);
> +               ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> +                        pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
> +       }
> +}
> +
>  void pciehp_green_led_on(struct controller *ctrl)
>  {
>         if (!PWR_LED(ctrl))
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f28e562d7ca8..291788b58f3a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -591,10 +591,12 @@
>  #define  PCI_EXP_SLTCTL_CCIE   0x0010  /* Command Completed Interrupt Enable */
>  #define  PCI_EXP_SLTCTL_HPIE   0x0020  /* Hot-Plug Interrupt Enable */
>  #define  PCI_EXP_SLTCTL_AIC    0x00c0  /* Attention Indicator Control */

> +#define  PCI_EXP_SLTCTL_ATTN_IND_NONE  0x0    /* Attention Indicator noop */
>  #define  PCI_EXP_SLTCTL_ATTN_IND_ON    0x0040 /* Attention Indicator on */
>  #define  PCI_EXP_SLTCTL_ATTN_IND_BLINK 0x0080 /* Attention Indicator blinking */
>  #define  PCI_EXP_SLTCTL_ATTN_IND_OFF   0x00c0 /* Attention Indicator off */
>  #define  PCI_EXP_SLTCTL_PIC    0x0300  /* Power Indicator Control */
> +#define  PCI_EXP_SLTCTL_PWR_IND_NONE   0x0    /* Power Indicator noop */

I don't think pci_regs.h is the right place for this. The contents of
pci_regs.h is essentially a transcription of bit definitions from the
various PCI standards documents. The PCIe Base spec says the the 0b00
combination for the two-bit Power and Attn indicator fields is
reserved and there's nothing suggesting that writing a zero to those
fields should preserve the current value. Basicly, we now have a
implementation quirk of pcie_set_indicators() masquerading as part of
the standard.

>  #define  PCI_EXP_SLTCTL_PWR_IND_ON     0x0100 /* Power Indicator on */
>  #define  PCI_EXP_SLTCTL_PWR_IND_BLINK  0x0200 /* Power Indicator blinking */
>  #define  PCI_EXP_SLTCTL_PWR_IND_OFF    0x0300 /* Power Indicator off */
> --
> 2.21.0
>
