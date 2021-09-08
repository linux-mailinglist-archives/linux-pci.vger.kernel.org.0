Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A6E404033
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 22:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243764AbhIHUhL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 16:37:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhIHUhK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Sep 2021 16:37:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40AEB61041;
        Wed,  8 Sep 2021 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631133362;
        bh=bP3G6bAvac+s/34JTfHdHoXIMUenYwO/ZfeHNQIqd2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crEfVpzf2TgqQIBZnI19w3mvuasxNDyd2XG+OWwems3sMPNVbYtUMSe0E4J6NdAlU
         CalIK/LnF8NwDkEwReWaVqcH/UPQ+lFnwKCqenEcZM1yKA1GQrFA1G6srWkqpjzoAm
         4roHBemYLq/z4oiOplu0I9cMPCtI+Lo8CWKyyIjvuTzftLu7Vi8xQ9kiF+9UT1P8Uv
         g0+G+UgQd3Fm2WOVaCuqKd7h2k5xRksquz+i5SKamfsZwN/J5A4s5Anh29tkCYqbTh
         rHqmj96vpEg+4TktmDpCLOaJJNasdvOJM9Qf+nJ1FTVO2yzsF9QS9DAZXsBg75Ts9m
         kAMSfBwXOn06w==
Received: by pali.im (Postfix)
        id C55D1708; Wed,  8 Sep 2021 22:35:59 +0200 (CEST)
Date:   Wed, 8 Sep 2021 22:35:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ingmar Klein <ingmar_klein@web.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: QCA6174 pcie wifi: Add pci quirks
Message-ID: <20210908203559.6k5clg3fzf5kctbw@pali>
References: <20210415195338.icpo5644bo76rzuc@pali>
 <20210525221215.GA1235899@bjorn-Precision-5520>
 <20210721085453.aqd73h22j6clzcfs@pali>
 <20210820232217.vkx6x6dpxf73jjhs@pali>
 <408e5b45-3eaa-fa13-318d-48f7d1ecdacf@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <408e5b45-3eaa-fa13-318d-48f7d1ecdacf@web.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 08 September 2021 21:18:00 Ingmar Klein wrote:
> Am 21.08.2021 um 01:22 schrieb Pali Rohár:
> > On Wednesday 21 July 2021 10:54:53 Pali Rohár wrote:
> > > On Tuesday 25 May 2021 17:12:15 Bjorn Helgaas wrote:
> > > > On Thu, Apr 15, 2021 at 09:53:38PM +0200, Pali Rohár wrote:
> > > > > Hello!
> > > > > 
> > > > > On Thursday 15 April 2021 13:01:19 Alex Williamson wrote:
> > > > > > [cc +Pali]
> > > > > > 
> > > > > > On Thu, 15 Apr 2021 20:02:23 +0200
> > > > > > Ingmar Klein <ingmar_klein@web.de> wrote:
> > > > > > 
> > > > > > > First thanks to you both, Alex and Bjorn!
> > > > > > > I am in no way an expert on this topic, so I have to fully rely on your
> > > > > > > feedback, concerning this issue.
> > > > > > > 
> > > > > > > If you should have any other solution approach, in form of patch-set, I
> > > > > > > would be glad to test it out. Just let me know, what you think might
> > > > > > > make sense.
> > > > > > > I will wait for your further feedback on the issue. In the meantime I
> > > > > > > have my current workaround via quirk entry.
> > > > > > > 
> > > > > > > By the way, my layman's question:
> > > > > > > Do you think, that the following topic might also apply for the QCA6174?
> > > > > > > https://www.spinics.net/lists/linux-pci/msg106395.html
> > > > > I have been testing more ath cards and I'm going to send a new version
> > > > > of this patch with including more PCI ids.
> > > > Dropping this patch in favor of Pali's new version.
> > > Hello Bjorn! Seems that it would take much more time to finish my
> > > version of patch. So could you take Ingmar's patch with cc:stable tag
> > > for now, which just adds PCI device id into list of problematic devices?
> > Ping, gentle reminder...
> 
> Hi Pali and Bjorn,
> 
> here is the original trivial patch again.
> For the moment, this could do.
> 
> Thank you!
> Best regards,
> Ingmar
> 
> Signed-off-by: Ingmar Klein <ingmar_klein@web.de>

Reviewed-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 706f27a86a8e..ecfe80ec5b9c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3584,6 +3584,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
>  
>  /*
>   * Root port on some Cavium CN8xxx chips do not successfully complete a bus

