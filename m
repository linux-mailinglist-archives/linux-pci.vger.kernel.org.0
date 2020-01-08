Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B749513450B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 15:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgAHOdP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 09:33:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36730 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgAHOdP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2020 09:33:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so2782548oic.3;
        Wed, 08 Jan 2020 06:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gt5l5oW7BvC/mIpqIR4dhr5zJ89efNCOAMpU+ZM12Dc=;
        b=NAVlmmalYDq3O6wg7vc55R5x+f+KdJqkdndSqGJVogQAQgBWWVblmRq+8uXoFFY8Zb
         11/kQglqK1JcGXlBNk9PFRWvZZkyHtYX3Ouac90MyEoRwISpgkM2UosFqmnMpb109A/z
         KhFEIq6Z37JTpi5Zvx6MSeBbYGtIlxXIwEbA0rBoXNvya59Z+6gWIwCuIQ2DDh6hHZDU
         OhzLDVKDicSrvAHgXw22TuY2YcUAFAT5bWs0Cz6IOf95S9CuFzQl3gypf5riQ7z5a43z
         wOXa9ADqpFdfj27TtIoljAQU43+4BLrwbeSNYgDtw+rWD3iDKw8r8ENM6M2E4wUUU9eR
         EJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gt5l5oW7BvC/mIpqIR4dhr5zJ89efNCOAMpU+ZM12Dc=;
        b=cTJKFBR1QtCQi6jeh7Rnoupy2ACmteRVlhSAL5mJrAvGwmNAERSK9vN0YrgLv2aVoz
         WHjiXrcXxKMARSGqnzylh0Ktx7omqv8afuP7A0tVcoQnTc9Uc6DAr8yRsQcuzt2mf9RZ
         R5n+xAHw1G2ZmhznhWjp3Iul5VRcxZEI8navpg98O+GJgKahmylHS1mt0pmO7WS/j17I
         kIIteQpQAGshW4Fw/4FXIjNvJb06ddBJehaOksFGNZCAtWkuKl2bFsPIJWbOBoNIiJ3S
         hSaUWF9SdAgDc/pS7pq05Mn7UlDe4DhSRsRAFp5MypWsaqMaAPFdcj7iOajR/ry3mrhX
         AwFw==
X-Gm-Message-State: APjAAAVqKtCCJL2IPcPKpb28AC96lmaMfaUPq5AK5GMaP6szoy+hmWsc
        BMskrvZ6RUDgsLHaJNIvcHvkRvj0qXzY89LLHb0eE8/H
X-Google-Smtp-Source: APXvYqxH3FaBBajpQgXoLkcvI7TaBy7ZABU95YvvOEi8apxiNSjJUz+IR50c2jPfK53Chf3/5jI4LvBz1jn2kdZdlyE=
X-Received: by 2002:a54:4396:: with SMTP id u22mr3315338oiv.128.1578493994294;
 Wed, 08 Jan 2020 06:33:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+ijBTp55gZYAejWthnvdmR_qyQJpVV4r1gyQ-Kud6t9qg@mail.gmail.com>
In-Reply-To: <CAHhAz+ijBTp55gZYAejWthnvdmR_qyQJpVV4r1gyQ-Kud6t9qg@mail.gmail.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Wed, 8 Jan 2020 20:03:02 +0530
Message-ID: <CAHhAz+jYdJnh26GU+8xcE4vcpCo-4Sudj7OEZ=y+hCOdz9FQ1g@mail.gmail.com>
Subject: Re: pcie: xilinx: kernel hang - ISR readl()
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 7, 2020 at 9:45 PM Muni Sekhar <munisekharrms@gmail.com> wrote:
>
> Hi,
>
> I have module with Xilinx FPGA. It implements UART(s), SPI(s),
> parallel I/O and interfaces them to the Host CPU via PCI Express bus.
> I see that my system freezes without capturing the crash dump for
> certain tests. I debugged this issue and it was tracked down to the
> below mentioned interrupt handler code.
>
>
> In ISR, first reads the Interrupt Status register using =E2=80=98readl()=
=E2=80=99 as
> given below.
>     status =3D readl(ctrl->reg + INT_STATUS);
>
>
> And then clears the pending interrupts using =E2=80=98writel()=E2=80=99 a=
s given blow.
>         writel(status, ctrl->reg + INT_STATUS);
>
>
> I've noticed a kernel hang if INT_STATUS register read again after
> clearing the pending interrupts.
>
> Can someone clarify me why the kernel hangs without crash dump incase
> if I read the INT_STATUS register using readl() after clearing the
> pending bits?
>
> Can readl() block?
>
>
> Snippet of the ISR code is given blow:
>
> https://pastebin.com/WdnZJZF5
The correct snippet of the ISR code is here: https://pastebin.com/as2tSPwE
>
>
>
> static irqreturn_t pcie_isr(int irq, void *dev_id)
>
> {
>
>         struct test_device *ctrl =3D data;
>
>         u32 status;
>
> =E2=80=A6
>
>
>
>         status =3D readl(ctrl->reg + INT_STATUS);
>
>         /*
>
>          * Check to see if it was our interrupt
>
>          */
>
>         if (!(status & 0x000C))
>
>                 return IRQ_NONE;
>
>
>
>         /* Clear the interrupt */
>
>         writel(status, ctrl->reg + INT_STATUS);
>
>
>
>         if (status & 0x0004) {
>
>                 /*
>
>                  * Tx interrupt pending.
>
>                  */
>
>                  ....
>
>        }
>
>
>
>         if (status & 0x0008) {
>
>                 /* Rx interrupt Pending */
>
>                 /* The system freezes if I read again the INT_STATUS
> register as given below */
>
>                 status =3D readl(ctrl->reg + INT_STATUS);
>
>                 ....
>
>         }
>
> ..
>
>         return IRQ_HANDLED;
> }
>
>
>
> --
> Thanks,
> Sekhar



--=20
Thanks,
Sekhar
