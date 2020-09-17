Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD826D15B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 04:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIQCxB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 22:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgIQCxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 22:53:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEC0C061788
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 19:45:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so360013wrm.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 19:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8P2jctWZN/5eJkEdVuM9znhmWHOtIZTLDjAWDuJb9M=;
        b=Za12trdXVsgVYk/OACJ23Hh32EeUwfxF8RHHC82ArfhSmg/irqmqNC3JhORAVhwsvl
         pV6lpoHfaZ0CIiiaBnlUzWaRNay8gsbg4y7cvH9qeMF7XoY8K8oHkNIg0kBS6w1Vfxvw
         nSUO2fjnEGJKWU1b5nziBpUJ+xbWOCHIc2IVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8P2jctWZN/5eJkEdVuM9znhmWHOtIZTLDjAWDuJb9M=;
        b=XnCGyhIiN9opTUAlP+bzVWncVS7z0OJLptY1u19IIs8uwBRAOXcSE1c2dm9uu8r8Hv
         H0dBOpFv8bDbS0Q7lJpNS2iZgS1moRQJ6WPY93ZOpQX2z7e7tazc/FH+VtyFFS5IpUhp
         NW/QS2InQSxXw3FGRSkn1NElMiIypsNJbgVBhkPI/EWduEoHfDag9XqZMBI7hxSQRUQ+
         dmeR3npWZawIY+BvmUpZTjQT+R+oKMajLDt+jwKJpj87HPWzadlOFsTJkam6YMKy6XYx
         /f/7oknjvqdnt8JnGaaYD2cshGY3PB9BGjG5lfruIrehyzgySegB5R+2vUihp5K5gEv4
         69qQ==
X-Gm-Message-State: AOAM533S8e1P9yt+bVgyXO21zCddTMD00dPccq70Z9rCDkbJR727ttns
        KR08xbzH3+Ldn9dwAgzGbFtfhqyXpcSl1mbAM1+JRA==
X-Google-Smtp-Source: ABdhPJwgnPUqBBfqemPY+Nm+WDNYOKVc09CpbmuIpcXMT+8VwbnX/lKv7lAkMPik8q0vBvkMXlq3/sVclYG4JmI+oZM=
X-Received: by 2002:a5d:5751:: with SMTP id q17mr6705826wrw.409.1600310699882;
 Wed, 16 Sep 2020 19:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200915134541.14711-1-srinath.mannam@broadcom.com> <20200916220821.GA1589643@bjorn-Precision-5520>
In-Reply-To: <20200916220821.GA1589643@bjorn-Precision-5520>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 17 Sep 2020 08:14:48 +0530
Message-ID: <CABe79T7ADCYnQtFbhruo4-Lj9Q1cRZPU_Li4X69gKyLS-me-6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PCI: iproc: Add fixes to pcie iproc
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 17, 2020 at 3:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
Hi Bjorn,
Thanks for review.
> On Tue, Sep 15, 2020 at 07:15:38PM +0530, Srinath Mannam wrote:
> > This patch series contains fixes and improvements to pcie iproc driver.
> >
> > This patch set is based on Linux-5.9.0-rc2.
> >
> > Changes from v1:
> >   - Addressed Bjorn's review comments
> >      - pcie_print_link_status is used to print Link information.
> >      - Added IARR1/IMAP1 window map definition.
> >
> > Bharat Gooty (1):
> >   PCI: iproc: fix out of bound array access
> >
> > Roman Bacik (1):
> >   PCI: iproc: fix invalidating PAXB address mapping
>
> You didn't update thest subject lines so they match.
> https://lore.kernel.org/r/20200326194810.GA11112@google.com
Yes this patchset is the latest version to the patches in the link.
My apologies that I missed to address your review comment about
the commit message of "PCI: iproc: fix out of bound array access"
in this patchset.
Thanks & Regards,
Srinath.
>
> > Srinath Mannam (1):
> >   PCI: iproc: Display PCIe Link information
> >
> >  drivers/pci/controller/pcie-iproc.c | 29 ++++++++++++++++++++++-------
> >  1 file changed, 22 insertions(+), 7 deletions(-)
> >
> > --
> > 2.17.1
> >
