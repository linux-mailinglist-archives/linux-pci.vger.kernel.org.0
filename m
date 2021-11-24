Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBA845C1B2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 14:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347818AbhKXNVC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 08:21:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349285AbhKXNS7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 08:18:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B144861AF0;
        Wed, 24 Nov 2021 12:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637757973;
        bh=bRl9hDJ5fv7GM9VcwWXnou2FrLe+Pdi0eP8dUHnU0CU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpSXyt0J3ea65y4x5TXEqZd2yLcfIWbCSISDOpL0qhPP024MJQhcxKv3qq29Le3YH
         Oi9ObFlsmuqGORWySP6P8qc2kmAdwUEoFKwJsPYHMmE/CrW1IYtnwNxnnvGU8kLle0
         ad1n5kZ5e4CB1JA7aWYQFTZGfekB3FK4gsU0wvWZD6KFHxAFNz216XkB676GABs33w
         N0lUvp+zwYveggPAI3WqKT8TfXWQhWWn/Bxn4iAbgO56EWBrYPD3rHl/itLwrKQsTE
         vB7/zJy50OoiYCDI6rej58nZQswjmhR6Uhgr0uDY6qG/24R2C3Y1IHxjhKqcipEBFn
         sXGRIZokSXDhw==
Received: by pali.im (Postfix)
        id 7555A56D; Wed, 24 Nov 2021 13:46:11 +0100 (CET)
Date:   Wed, 24 Nov 2021 13:46:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] lspci: Show Slot Power Limit values above EFh
Message-ID: <20211124124611.wi6u77pnparg2563@pali>
References: <20211101144740.14256-1-pali@kernel.org>
 <YYABw84admN1+8Ly@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYABw84admN1+8Ly@casper.infradead.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 01 November 2021 15:03:31 Matthew Wilcox wrote:
> On Mon, Nov 01, 2021 at 03:47:40PM +0100, Pali Rohár wrote:
> > PCI Express Base Specification rev. 3.0 has the following definition for
> > the Slot Power Limit Value:
> > 
> > =======================================================================
> > When the Slot Power Limit Scale field equals 00b (1.0x) and Slot Power
> > Limit Value exceeds EFh, the following alternative encodings are used:
> >   F0h = 250 W Slot Power Limit
> >   F1h = 275 W Slot Power Limit
> >   F2h = 300 W Slot Power Limit
> >   F3h to FFh = Reserved for Slot Power Limit values above 300 W
> > =======================================================================
> > 
> > Replace function power_limit() by show_power_limit() which also prints
> > power limit value. Show reserved value as string ">300W" and omit usage of
> > floating point variables as it is not needed.
> 
> I don't understand why you want to avoid the use of floating point here?

Because library does not use floating point. So I thought that it is a
good idea to not use it neither for printing power limit.

I can change it, just I wanted to hear project / library preference.

> > +++ b/ls-caps.c
> > @@ -656,10 +656,27 @@ static int exp_downstream_port(int type)
> >  	 type == PCI_EXP_TYPE_PCIE_BRIDGE;	/* PCI/PCI-X to PCIe Bridge */
> >  }
> >  
> > -static float power_limit(int value, int scale)
> > +static void show_power_limit(int value, int scale)
> >  {
> > -  static const float scales[4] = { 1.0, 0.1, 0.01, 0.001 };
> > -  return value * scales[scale];
> > +  static const int scales[4] = { 1000, 100, 10, 1 };
> > +  static const int scale0_values[3] = { 250, 275, 300 };
> > +  if (scale == 0 && value >= 0xF0) {
> > +    /* F3h to FFh = Reserved for Slot Power Limit values above 300 W */
> > +    if (value >= 0xF3) {
> > +      printf(">300W");
> > +      return;
> > +    }
> > +    value = scale0_values[value - 0xF0];
> > +  }
> > +  value *= scales[scale];
> > +  printf("%d", value / 1000);
> > +  if (value % 10)
> > +    printf(".%03d", value % 1000);
> > +  else if (value % 100)
> > +    printf(".%02d", (value / 10) % 100);
> > +  else if (value % 1000)
> > +    printf(".%d", (value / 100) % 10);
> > +  printf("W");
> 
> Wouldn't this be clearer if written as:
> 
> static void show_power_limit(int value, int scale)
> {
>   static const float scales[4] = { 1.0, 0.1, 0.01, 0.001 };
>   static const int scale0_values[3] = { 250, 275, 300 };
> 
>   if (scale == 0 && value >= 0xF0) {
>     /* F3h to FFh = Reserved for Slot Power Limit values above 300 W */
>     if (value >= 0xF3) {
>       printf(">300W");
>       return;
>     }
>     value = scale0_values[value - 0xF0];
>   }
>   printf("%.3fW", value * scales[scale]);
> }
> 
