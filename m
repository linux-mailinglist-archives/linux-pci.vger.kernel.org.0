Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20402132ADD
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2020 17:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgAGQP1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jan 2020 11:15:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40085 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgAGQP0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jan 2020 11:15:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id c77so17664371oib.7;
        Tue, 07 Jan 2020 08:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=OZxJnB1DYtw8zolbAPJSc4mNYJnP83L9HUFtNXkxNXo=;
        b=JprkbSdq56PZOBTa8U2MleFu4Z9Jzse32ho48Zw7RFla008pIdVz+s9Kmf33qwUB18
         jJUue/mCXkQyybXHcvFTkTMI4hTCWbhBufEFx/I/rILkldFoBhF0Vrk5UKngjzirdmHs
         QosYj3toTLrtwWcc5gcM9KSM89LPYg8gzDYe4IHrkdbzft7lsyba3wZ5NSkGmkT6N8oD
         tfni23vfcLtpEt6avvTasYWdQVrTBlIsJ0rOhDlUfDuk5sLjMt0yPjzripZSRb6U+zEu
         M9XFF2rheXrZ7rCc4ac0kdu4pfBqQyaMwHZVjVp6KFR5/X4gYR+SdLv+TKuhCAGI3qy8
         6vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=OZxJnB1DYtw8zolbAPJSc4mNYJnP83L9HUFtNXkxNXo=;
        b=mAwIDlyeNnWUx4q5Gl8WHvNvigPnSJi20E4oLf/wsjO3hduiEBDHuEEgrZE0BHCXEo
         emkbl0fRIfmcDmvFptqKyIK8p8eLTrnoFIbtYYWnshNQ9BBEzeefgat8eMZ1XtzZ9QAE
         xJf7/GCOX+Lkb13ebndRMexMki9Yf1mvVmtvyX9v4zEltpwo46qiIfn5wBNFtSH38DGc
         eBbAJJvAxK6LW7BIvJ507AazZPvM7RUE7wLyetIOpQAQsnVLw74NlxYJdFJIW7EaxroB
         d/H1Le097DRlRRcWQtP2bQ3fWj/93CVulZsgDKEH3YWmtsWKOtmjZ+/Bq+aDkhqe1Z9l
         jlAg==
X-Gm-Message-State: APjAAAUrFcRACwF1Id2rpg135Jw6fQVLWz0sXhAdkl7Z8k+OfLDI5PBj
        AAusnLFr6t28da3s9cBENBdywBptH8340i13gyOVxM3W
X-Google-Smtp-Source: APXvYqyHdohV/pTOS7O+0bK6K+fijJasQ+i3SqqIgYR48fzKG8iRyQJnTDmtHZ2RngcMIazYBHhKuO73LMfnRUWpc8Y=
X-Received: by 2002:a54:4501:: with SMTP id l1mr251542oil.101.1578413724985;
 Tue, 07 Jan 2020 08:15:24 -0800 (PST)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 7 Jan 2020 21:45:13 +0530
Message-ID: <CAHhAz+ijBTp55gZYAejWthnvdmR_qyQJpVV4r1gyQ-Kud6t9qg@mail.gmail.com>
Subject: pcie: xilinx: kernel hang - ISR readl()
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I have module with Xilinx FPGA. It implements UART(s), SPI(s),
parallel I/O and interfaces them to the Host CPU via PCI Express bus.
I see that my system freezes without capturing the crash dump for
certain tests. I debugged this issue and it was tracked down to the
below mentioned interrupt handler code.


In ISR, first reads the Interrupt Status register using =E2=80=98readl()=E2=
=80=99 as
given below.
    status =3D readl(ctrl->reg + INT_STATUS);


And then clears the pending interrupts using =E2=80=98writel()=E2=80=99 as =
given blow.
        writel(status, ctrl->reg + INT_STATUS);


I've noticed a kernel hang if INT_STATUS register read again after
clearing the pending interrupts.

Can someone clarify me why the kernel hangs without crash dump incase
if I read the INT_STATUS register using readl() after clearing the
pending bits?

Can readl() block?


Snippet of the ISR code is given blow:

https://pastebin.com/WdnZJZF5



static irqreturn_t pcie_isr(int irq, void *dev_id)

{

        struct test_device *ctrl =3D data;

        u32 status;

=E2=80=A6



        status =3D readl(ctrl->reg + INT_STATUS);

        /*

         * Check to see if it was our interrupt

         */

        if (!(status & 0x000C))

                return IRQ_NONE;



        /* Clear the interrupt */

        writel(status, ctrl->reg + INT_STATUS);



        if (status & 0x0004) {

                /*

                 * Tx interrupt pending.

                 */

                 ....

       }



        if (status & 0x0008) {

                /* Rx interrupt Pending */

                /* The system freezes if I read again the INT_STATUS
register as given below */

                status =3D readl(ctrl->reg + INT_STATUS);

                ....

        }

..

        return IRQ_HANDLED;
}



--=20
Thanks,
Sekhar
