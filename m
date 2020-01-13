Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 676D2139420
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 15:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAMO7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 09:59:25 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43766 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbgAMO7Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jan 2020 09:59:24 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so8456754oif.10;
        Mon, 13 Jan 2020 06:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCwfIC03FW7tvdPBad/HEE7Kup/8TTUBtywUXJH0P+E=;
        b=M9kmTwmfD3ZqcD2tbmm2KWW5uiVUdcRfVyU6S0ia639Uj0Jhg8dEKYc+Tn4JSa/uJl
         VaSUivGUEBLl6xNYkF1GtBHRKNZv1dn+tgubbRpfGmvRcvXWnR6M1gxUZL4pHuu+V2uS
         jpYPnQtJIzINUBMD8SRnhh5HCU7dRYXeGX/jMhNur6V+bw/y/FjqKyLoXXeEsyVc+xhA
         A9KOi/DuisoF3drvErDMkHmHdGm2KTNnqlQI0KxbMoaifVgp2BDHklHloqTTIIFtmI95
         DOulXXKq/Hjdk/KERB02pEphfNAVUPg060drb2XU/Fya1UIpLR4quDr26WlvyjFoadk6
         jiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCwfIC03FW7tvdPBad/HEE7Kup/8TTUBtywUXJH0P+E=;
        b=DGOCRXsynNOyiPv+9zlIDDRcUVQXJ9BEVFx04ifwbTuuCS3/aXhfwJomxx/nO2Duu/
         RTCP6aYlFulAxcoenQiI5TbxARmHaXsBHlp+LQB6t/DkE9vILWTYIwwKP0b44ONKhqnF
         fIefyQl2Kbgcy0xS7CdBuydVNyq9KCVy9tIdzT4rSEfMHFYMuFpUlTRwru/KA/dv24v9
         jSovj41/dU3A/Psh3FKs5QMwCBb5wrhHU2ISbCeznTMgMJexlvMCVbsOA4FWv19gqT+G
         TOkkkqOf/Sjx9PGh+vDvyPUWwmRrDaP3GhK9v+V9jQ62sdRHn9hec6blqjlEeJMax6eg
         NQqg==
X-Gm-Message-State: APjAAAWQg4AgSfLhE4CLpG1+I5ehWf3erwaHgOcR+wym11+FjPuYSw1E
        gLi2BZ/b3ELRv1/1pQnFFpsJZpV24zdc0WYKNE0=
X-Google-Smtp-Source: APXvYqyLULHbiI9YKkrGDcoo+kD0Us4o55DpWU7+8pPazA+bbB+0NEDp2zJQCvYcQLiEXr6ZwZaBl+5MnqBjRkz+upw=
X-Received: by 2002:a05:6808:6c5:: with SMTP id m5mr12275955oih.106.1578927563829;
 Mon, 13 Jan 2020 06:59:23 -0800 (PST)
MIME-Version: 1.0
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
In-Reply-To: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Mon, 13 Jan 2020 16:59:12 +0200
Message-ID: <CAGi-RU+GPLJ0b2K5u45KEwT=jZw565K_bxXh2OTaFR2xUmQs3Q@mail.gmail.com>
Subject: Re: MSI irqchip configured as IRQCHIP_ONESHOT_SAFE causes spurious IRQs
To:     hkallweit1@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        tglx@linutronix.de, lorenzo.pieralisi@arm.com, maz@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Resending with correct e-mail address of maz.

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
