Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA6C258C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfI3Q5D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 12:57:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35931 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfI3Q5D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 12:57:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id 67so8965537oto.3
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2019 09:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZJu5nMPyA3CcXPtrWusDX9FpZgNc7KiBqwKc0pCnNk=;
        b=lDMXPyHH0b4q5PAmhy6A3YLJAkPCddp6btlDUZ0fPsYCu5yMeJTt74gZ5ZUXWWwe/w
         QnXSoca9X+Ns+PkoKCftGvH+eaa8NqLQr1kdj58zJ2hiotXy2CBBNxVuUeD0NYk76Beu
         YBIyyDFD6dc6upQ597O4TV60qpD4y3gXNE7Jery+lSUTFIndraj1O/EcZ1NBkAY+sVH2
         v9Ff9yFBknkTGA7ZEnjAI/tM6OntsNWbkiRuV6dtG3p13i1YVPGbTfhVgwtVRieZkRmM
         IFBRMzd0DiKPR74GE5cGaMLRvXbhOal7CevhadIXbfMyF4jjMUB76fGc/0EZmpPBcItS
         cFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZJu5nMPyA3CcXPtrWusDX9FpZgNc7KiBqwKc0pCnNk=;
        b=W+UWjcxmHyZPT5c032Lq/rUk3Ymk31lsHJ9pvj6W4bI0hZ8/mKdMe2SzClj7fwPjPo
         CiuqxcJMBwHfJE3OhO9jJcQTJxSzPSwMj37bgj2tM54eszVPDKxwvMrOKoybO0GDsvO7
         sgAwnDxT1RjGMN+5VjG/5w9tHlrhizUvD6bgjLmCb7aMCu8exZsrXUr63/WwOlM7YroK
         S7N/VJ6761uN8z2uZHcZVFhUrtr0bg/AolrPc+Cs1ePHZYSQltfAdRdwiel4xizbjrob
         H2BLsqxzzPRc4xNzcNgv3JRixUY12edjpkM9fTUcNWGnzmsagCXP/18h4frwMc9dBb2N
         1hTA==
X-Gm-Message-State: APjAAAXcREiynsq+WEppHDUkkpr0PeAqlKGJTYT95kNN9LgudxXjlBu9
        sOo9tD7cfDCppcPQmmN+7ddinaG7yNQ+HOUkdhMiWQ==
X-Google-Smtp-Source: APXvYqzB8H/7R2/+lg1XepUdOoHj928L8GWJV0m55A4x/X1lbYqO0HreOXXiM5k44rOocAfzJA5NKe2lpHDKrO0K8gI=
X-Received: by 2002:a9d:562:: with SMTP id 89mr1391432otw.232.1569862622367;
 Mon, 30 Sep 2019 09:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190924214630.12817-1-robh@kernel.org> <20190924214630.12817-6-robh@kernel.org>
 <20190925103752.GS9720@e119886-lin.cambridge.arm.com> <CAL_JsqJW2t3F6HdKqcHguYLLiYQ6XWOsQbY-TFsDXhrDjjszew@mail.gmail.com>
In-Reply-To: <CAL_JsqJW2t3F6HdKqcHguYLLiYQ6XWOsQbY-TFsDXhrDjjszew@mail.gmail.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 30 Sep 2019 17:56:51 +0100
Message-ID: <CAFEAcA_Lu73n9z-fyWNLvnxXyk-JcUbONHE5x06Uh9Upk4MVbw@mail.gmail.com>
Subject: Re: [PATCH 05/11] PCI: versatile: Use pci_parse_request_of_pci_ranges()
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 26 Sep 2019 at 22:45, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 25, 2019 at 5:37 AM Andrew Murray <andrew.murray@arm.com> wrote:
> >
> > On Tue, Sep 24, 2019 at 04:46:24PM -0500, Rob Herring wrote:
> > > Convert ARM Versatile host bridge to use the common
> > > pci_parse_request_of_pci_ranges().
> > >
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---

> > >  static int versatile_pci_probe(struct platform_device *pdev)
> > >  {
> > >       struct device *dev = &pdev->dev;
> > >       struct resource *res;
> > > -     int ret, i, myslot = -1;
> > > +     struct resource_entry *entry;
> > > +     int ret, i, myslot = -1, mem = 0;
> >
> > I think 'mem' should be initialised to 1, at least that's what the original
> > code did. However I'm not sure why it should start from 1.
>
> The original code I moved from arch/arm had 32MB @ 0x0c000000 called
> "PCI unused" which was requested with request_resource(), but never
> provided to the PCI core. Otherwise, I kept the setup the same. No one
> has complained in 4 years, though I'm not sure anyone would have
> noticed if I just deleted PCI support...

Yes, QEMU users will notice if you drop or break PCI support :-)
I don't think anybody is using real hardware PCI though.

Anyway, the 'mem' indexes here matter because you're passing
them to PCI_IMAP() and PCI_SMAP(), which are writing to
hardware registers. If you write to PCI_IMAP0 when we
were previously writing to PCI_IMAP1 then suddenly you're
not configuring the behaviour for accesses to the PCI
window that's at CPU physaddr 0x50000000, you're configuring
the window that's at CPU physaddr 0x44000000, which is
entirely different (and notably is smaller, being only
0x0c000000 in size rather than 0x10000000).

If this is supposed to be a no-behaviour-change refactor
then it would probably be a good test to check that we're
writing exactly the same values to the hardware registers
on the device as we were before the change.

thanks
-- PMM
