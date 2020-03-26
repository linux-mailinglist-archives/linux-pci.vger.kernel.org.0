Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91AB7194361
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 16:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgCZPkh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 11:40:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43884 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgCZPkh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2020 11:40:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id bd14so7304661edb.10
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2020 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VQc7P8VY+5XsYW/q9fSaKw3tAVjuhPWecyw2BKtLuE=;
        b=J3jrCa0tFr4pwLXuXWbuCGiOBBZpWlVmlwn1FsYpqmHmJE3e83vXUWsqu4NQ4nX0MT
         t2NPbVEay6HMFtgrvQXYGz5cgSR+ZS6BfeiJA8mQO1TMiCrfU8rFfwq03L5XeH8a8a/V
         Xzc4GCiOCh7S6cmmyTQ97kHpFqVlo5FgHwHn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VQc7P8VY+5XsYW/q9fSaKw3tAVjuhPWecyw2BKtLuE=;
        b=WyvHSMrPOIDEib+wO2+2tN7bRoCZEo8jg2PY/opUjHs0Fnj/SUSJ3mS4ItIHNaANSC
         FFXrRJW7XS8DWztYDdIOB7I484rwpvfUGOPXCLwHcZRJgmzb/c7lo/fdywkyhcMwwQTr
         DDbTCvcMqr5f4lJ+3C8kNOGn75UGnoflTf5G3hcdOWZCc2RiLJiU7XLxRvlBJDpS++P4
         QUPbjU4bGvZ/rCh7Vf/dBq5tvNPHayIfkrAkBzkVbThLX8KhMfIHen4hAm36Idbklq0Q
         7bVrb7pRTZSQnR/eA4/1ZmJLr0Nfm8Hed8D6ys5pyaJz9qKDksq6Ylbs4HsitxnbKemN
         /nRA==
X-Gm-Message-State: ANhLgQ07v7FEa1fbzrL9wbBfvBr6UfZnwPhyVtXubVHdpJ9A4bZFZ2NN
        /05ka7S39YmwDXUcYUPBSSV6Caz23WvmhLsWkI4zVQ==
X-Google-Smtp-Source: ADFU+vsJp1fQnpYw9Capue287rBN86xbyCVnw5heNA1CFBWynQnZYV9F3U+M+h6o+gbtj6xxJpvFgkswkFldUAadwGo=
X-Received: by 2002:a17:906:d18e:: with SMTP id c14mr8569496ejz.120.1585237235110;
 Thu, 26 Mar 2020 08:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <1585206447-1363-3-git-send-email-srinath.mannam@broadcom.com> <20200326153318.GA11697@google.com>
In-Reply-To: <20200326153318.GA11697@google.com>
From:   Roman Bacik <roman.bacik@broadcom.com>
Date:   Thu, 26 Mar 2020 08:38:30 -0700
Message-ID: <CAGQAs7xFY2Xp5fWBMFtzLDpP4zMFUNsddYXQk7QC0OS3oozXtw@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: iproc: fix invalidating PAXB address mapping
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <andrew.murray@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 26, 2020 at 8:33 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Mar 26, 2020 at 12:37:26PM +0530, Srinath Mannam wrote:
> > From: Roman Bacik <roman.bacik@broadcom.com>
> >
> > Second stage bootloader prior to Linux boot may use all inbound windows
> > including IARR1/IMAP1. We need to ensure all previous configuration of
> > inbound windows are invalidated during the initialization stage of the
> > Linux iProc PCIe driver. Add fix to invalidate IARR1/IMAP1 because it was
> > missed in previous patch.
> >
> > Fixes: 9415743e4c8a ("PCI: iproc: Invalidate PAXB address mapping")
> > Signed-off-by: Roman Bacik <roman.bacik@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index 6972ca4..e7f0d58 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -351,6 +351,8 @@ static const u16 iproc_pcie_reg_paxb_v2[IPROC_PCIE_MAX_NUM_REG] = {
> >       [IPROC_PCIE_OMAP3]              = 0xdf8,
> >       [IPROC_PCIE_IARR0]              = 0xd00,
> >       [IPROC_PCIE_IMAP0]              = 0xc00,
> > +     [IPROC_PCIE_IARR1]              = 0xd08,
> > +     [IPROC_PCIE_IMAP1]              = 0xd70,
>
> And paxb_v2_ib_map[] has a comment saying "IARR1/IMAP1 (currently
> unused)".  Is that comment now wrong?
>

The comment is still correct, IARR1/IMAP1 is unused in Linux. But it
may need to be invalidated in case it was modified by bootloaders.

> >       [IPROC_PCIE_IARR2]              = 0xd10,
> >       [IPROC_PCIE_IMAP2]              = 0xcc0,
> >       [IPROC_PCIE_IARR3]              = 0xe00,
> > --
> > 2.7.4
> >
