Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E632812E3BE
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2020 09:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgABIUC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jan 2020 03:20:02 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36201 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgABIUB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jan 2020 03:20:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id 19so43556513otz.3;
        Thu, 02 Jan 2020 00:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHriWhJI0dqaNpyRfzm/gY6/ALoua79QPBLVzGEfWhQ=;
        b=LYHBU3hyZ4qeez/x8Dc6xNL+CoxkMucMrviIHsG4U7S2oBXfo3sm0E1OqVhgkPIAB9
         WjbMWW1IYC1v/BXWqU2M3IcQKuR3fBjdq7oLC7Xg0Sk7WGpK3vqlqg1nF1zX8YzZSzI3
         QkcRw7QedQurR4i+1nwDlF4PZrMY3a4U8gQZphEunf7CZ6evf6TosC1u1Ga6lvRwp8RO
         66lR56KQoVjtDPXsILWbDNPTWU6YNMew4QFIH6sE8uqEMPq3I5xZEsdeAOoqlxJggxNA
         /v/d830qKdKIsp4TcJQSN9+Xb98L5kBox5S/CVj8KVXlyP3FG+vhgRLKJ9zm7bwuUEuh
         JYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHriWhJI0dqaNpyRfzm/gY6/ALoua79QPBLVzGEfWhQ=;
        b=N9U+5TXT/3COIUkcyj2pFRGGebRIFr6jxDLPG8n5YBoUjU49Sla4/jLJazIcmm60q1
         3DHmJNv4sVUDC4B71PJ/gzmkg63/1ZyRBWWUswSdCURxAWCQokEPuWjkxUJNHzJoKwGf
         spLa3rkir/p1XQM/UL/amn5jqXkIOzcsL+J2B9UcPICol9i9Yr1j9mYo3Qvek+q8kQiZ
         RsSINLCO3xHXDDUUjfBTIAmIvVoAHFfHls8415pip65I+rTOn+LSQvQ0CJL5b3KTHGGd
         OvrAjuYt7HbA0xDWxV44a5tBRomIo2ON3aipGKK/n+//0AeBnlHewScc4ISLKzld29sv
         FN0g==
X-Gm-Message-State: APjAAAXGdo7bafLAmKJtohIzJlLHbIndUqsXBvUKBVGXOGAINM5CdnlA
        n/7KtCiyRlgSDLcyAKPGVGovJTA6bIYVZrXZrck=
X-Google-Smtp-Source: APXvYqyWFs4P4fJpHL4dAErb4LD+E4qkFoJIMSL10eM8o/+GIMuANvXQbWlQHIE4bI13/uvpEL312cHqld0uEKCiSXg=
X-Received: by 2002:a05:6830:1615:: with SMTP id g21mr94672907otr.49.1577953200818;
 Thu, 02 Jan 2020 00:20:00 -0800 (PST)
MIME-Version: 1.0
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
In-Reply-To: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Thu, 2 Jan 2020 10:19:49 +0200
Message-ID: <CAGi-RUJuS540oNTtJc1zfv6tbfTtSt-S0m1tdpQ-=5JPeo92xg@mail.gmail.com>
Subject: Re: MSI irqchip configured as IRQCHIP_ONESHOT_SAFE causes spurious IRQs
To:     hkallweit1@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        marc.zyngier@arm.com, tglx@linutronix.de, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping

On Mon, Dec 9, 2019 at 12:27 PM Ramon Fried <rfried.dev@gmail.com> wrote:
>
> Hi,
> While debugging the root cause of spurious IRQ's on my PCIe MSI line it appears
> that because of the line:
>     info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> in pci_msi_create_irq_domain()
> The IRQF_ONESHOT is ignored, especially when requesting IRQ through
> pci_request_threaded_irq() where handler is NULL.
>
> The problem is that the MSI masking now only surrounds the HW handler,
> and all additional MSI that occur before the threaded handler is
> complete are considered by the note_interrupt() as spurious.
>
> Besides the side effect of that, I don't really understand the logic
> of not masking the MSI until the threaded handler is complete,
> especially when there's no HW handler and only threaded handler.
>
> Your thoughts?
>
> Thank,
> Ramon.
