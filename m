Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38140441D20
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 16:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhKAPIa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 11:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhKAPIa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 11:08:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11734C061714
        for <linux-pci@vger.kernel.org>; Mon,  1 Nov 2021 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=DR9Q7vfgVUPNCB3kRxKMs1vyoQKx6cYaJLshEkCqR00=; b=sIsepe2edw/DRLtgLtO4drDuRS
        V+QHcuJYRi/gCtuoFjIywXvfIBRxK/AYetmKJL3sDfPIZtkFyWn8o1jSyzPbrOORXz+OxTMUqt2L/
        Bb3Haik9IurblyOZll5zGzid+LTfg64Ts6JYj6YhE6KqLhtN1L153iJ4SWrh/5nHLvmay8qeCCU1j
        RNJDhOTIGFwVYO/I/MYoZu9RTncW7kRAwYiGNfYNBHkqwulYKyPdwuce6wM3MuAhQ4y6F8xkE8P4q
        OjnoMiRsDOrcAiI67Uz3YthTS9U5kwiH4JZ8J0xgkzGzpNyKarXP5Il9Y+klckC1OkP3rIjpMx6c1
        ITSIun2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhYqR-003q3y-H6; Mon, 01 Nov 2021 15:04:15 +0000
Date:   Mon, 1 Nov 2021 15:03:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] lspci: Show Slot Power Limit values above EFh
Message-ID: <YYABw84admN1+8Ly@casper.infradead.org>
References: <20211101144740.14256-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211101144740.14256-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 01, 2021 at 03:47:40PM +0100, Pali Rohár wrote:
> PCI Express Base Specification rev. 3.0 has the following definition for
> the Slot Power Limit Value:
> 
> =======================================================================
> When the Slot Power Limit Scale field equals 00b (1.0x) and Slot Power
> Limit Value exceeds EFh, the following alternative encodings are used:
>   F0h = 250 W Slot Power Limit
>   F1h = 275 W Slot Power Limit
>   F2h = 300 W Slot Power Limit
>   F3h to FFh = Reserved for Slot Power Limit values above 300 W
> =======================================================================
> 
> Replace function power_limit() by show_power_limit() which also prints
> power limit value. Show reserved value as string ">300W" and omit usage of
> floating point variables as it is not needed.

I don't understand why you want to avoid the use of floating point here?

> +++ b/ls-caps.c
> @@ -656,10 +656,27 @@ static int exp_downstream_port(int type)
>  	 type == PCI_EXP_TYPE_PCIE_BRIDGE;	/* PCI/PCI-X to PCIe Bridge */
>  }
>  
> -static float power_limit(int value, int scale)
> +static void show_power_limit(int value, int scale)
>  {
> -  static const float scales[4] = { 1.0, 0.1, 0.01, 0.001 };
> -  return value * scales[scale];
> +  static const int scales[4] = { 1000, 100, 10, 1 };
> +  static const int scale0_values[3] = { 250, 275, 300 };
> +  if (scale == 0 && value >= 0xF0) {
> +    /* F3h to FFh = Reserved for Slot Power Limit values above 300 W */
> +    if (value >= 0xF3) {
> +      printf(">300W");
> +      return;
> +    }
> +    value = scale0_values[value - 0xF0];
> +  }
> +  value *= scales[scale];
> +  printf("%d", value / 1000);
> +  if (value % 10)
> +    printf(".%03d", value % 1000);
> +  else if (value % 100)
> +    printf(".%02d", (value / 10) % 100);
> +  else if (value % 1000)
> +    printf(".%d", (value / 100) % 10);
> +  printf("W");

Wouldn't this be clearer if written as:

static void show_power_limit(int value, int scale)
{
  static const float scales[4] = { 1.0, 0.1, 0.01, 0.001 };
  static const int scale0_values[3] = { 250, 275, 300 };

  if (scale == 0 && value >= 0xF0) {
    /* F3h to FFh = Reserved for Slot Power Limit values above 300 W */
    if (value >= 0xF3) {
      printf(">300W");
      return;
    }
    value = scale0_values[value - 0xF0];
  }
  printf("%.3fW", value * scales[scale]);
}

