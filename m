Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0DF353494
	for <lists+linux-pci@lfdr.de>; Sat,  3 Apr 2021 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhDCPsX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Apr 2021 11:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhDCPsW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Apr 2021 11:48:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3ACC0613E6
        for <linux-pci@vger.kernel.org>; Sat,  3 Apr 2021 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=WsLManB+MfoSegKGNLw1LGetGT5rOJNYbXyb7raZb6w=; b=eXSPaLc9lRgcWNXM+zaTIQ1OM+
        2wG/F0uBf6bLjrAAN/FGphBGvmWgZwVSdZ7jBPmVzFdoBfX+P1E1jcrcrUN3npgYE/f+HvBjZywCK
        8RStMF7NKc3/t/6H11UO5Slx55ADMX+Md6DXSbYVIplcROXBksJ40UXaiRn9AdcwMWN2uVR0yAuER
        RYHabFSXwgHE8OTZpFuQ+VeEpocJGlW68htLFT+1z8aC2VMaYNSm0hlu3PTpAOdjAgnr9xlIpVjaZ
        nyF0XF+99vOCYN9RDfYjkaR9qyZ3Iy0ATbb3455uPXfgMtaV9InuI114QttxtWED6M6ls1CBWAX5v
        j994zhiA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lSiVM-0093ey-E8; Sat, 03 Apr 2021 15:48:09 +0000
Date:   Sat, 3 Apr 2021 16:48:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org
Subject: Re: lspci: Slot Power Limit values above EFh
Message-ID: <20210403154808.GR351017@casper.infradead.org>
References: <20210403114857.n3h2wr3e3bpdsgnl@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210403114857.n3h2wr3e3bpdsgnl@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 03, 2021 at 01:48:57PM +0200, Pali Rohár wrote:
> Hello!
> 
> PCI Express Base Specification rev. 3.0 has the following definition for
> the Slot Power Limit Value:

FWIW, it's the same in rev 5.  I had thought they might add even more
power encodings, but no.

> But the function power_limit() in ls-caps.c does not handle value above
> EFh according to this definition.
> 
> Here is a simple patch which fixes it for values F0h..F2h. But I'm not
> sure how (reserved) values above F2h should be handled.
> 
> diff --git a/ls-caps.c b/ls-caps.c
> index db56556971cb..bc1eaa15017d 100644
> --- a/ls-caps.c
> +++ b/ls-caps.c
> @@ -659,6 +659,9 @@ static int exp_downstream_port(int type)
>  static float power_limit(int value, int scale)
>  {
>    static const float scales[4] = { 1.0, 0.1, 0.01, 0.001 };
> +  static const int scale0_values[3] = { 250, 275, 300 }; /* F3h to FFh = Reserved for Slot Power Limit values above 300 W */
> +  if (scale == 0 && value >= 0xF0)
> +    value = scale0_values[(value > 0xF2 ? 0xF2 : value) & 0xF];
>    return value * scales[scale];
>  }

How about ...

  if (scale == 0)
    {
      if (value > 0xf2)
        return 0.0f/0;
      if (value >= 0xf0)
        return scale0_values[value - 0xf0];
    }

(btw, a float is the same size as an int -- 32 bits, so there's no
benefit to storing the values as an int and doing the conversion at runtime.
may as well have the compiler put the right set of bits in the binary)

in the caller:

  if ((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_UPSTREAM) ||
      (type == PCI_EXP_TYPE_PCI_BRIDGE))
    {
      float power = power_limit((t & PCI_EXP_DEVCAP_PWR_VAL) >> 18,
				(t & PCI_EXP_DEVCAP_PWR_SCL) >> 26));
      if (isnan(power))
        printf(" SlotPowerLimit >300W");
      else
	printf(" SlotPowerLimit %.3fW", power);
    }

