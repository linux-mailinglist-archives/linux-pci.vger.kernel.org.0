Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B2731F215
	for <lists+linux-pci@lfdr.de>; Thu, 18 Feb 2021 23:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhBRWIO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Feb 2021 17:08:14 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:45275 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhBRWH7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Feb 2021 17:07:59 -0500
Received: by mail-wr1-f47.google.com with SMTP id f7so3459844wrt.12;
        Thu, 18 Feb 2021 14:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0n+YfZI6F9Ec0xH8pK2WNkYmhD2t2qIeMiAyh4+JUos=;
        b=odWnqpjjEjNdElBsK8jx1a3z0Fo2blLXJNss9EcZZ7/GI/D7PB+syVNCs6LUKuhnZ2
         0pAa2KPwoev+IB/XEgmkKjGMLLEbA1Dw2J15CcBJss7prUQAqchqsvTYPPGEeGYYf/Df
         uS6TcdgqO8aGHiEJIakwiiOPsYdXr1xwlgRBR5HX5IwlxYj7bNAmqX8RAmKLLi9l4xn6
         d+M+uPOB1WpcUjGEKU53mgi8XVe14/BslYXOD3x7IRjwDqVT5f2UoN3qpDfRyJ5plK/2
         SH/IpPpmOvT+RE3kmDRLD2k5ZACTjoIERbuZ4Y4zp7nlTatglxWeyUvZYtkWHuhtCoc3
         W+iw==
X-Gm-Message-State: AOAM532znqKe6V/LfUPAbhfDNRQYuG+xF450MLCEXihuwgTBzcdTVl7A
        DMbWfa6/+92iGxRTEwpkzDY=
X-Google-Smtp-Source: ABdhPJwmnADLdGOpvALWY6RGD5mn/BJw98YjuC7zbBfSacCz/X+q1L92Yl8i46J1TK0tiD2zLB97mg==
X-Received: by 2002:adf:c785:: with SMTP id l5mr6140263wrg.234.1613686037041;
        Thu, 18 Feb 2021 14:07:17 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j3sm407533wrs.43.2021.02.18.14.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 14:07:16 -0800 (PST)
Date:   Thu, 18 Feb 2021 23:07:15 +0100
From:   'Krzysztof =?utf-8?Q?Wilczy=C5=84ski'?= <kw@linux.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/RCEC: Fix failure to inject errors to some RCiEP
 devices
Message-ID: <YC7lE2Ph/MHxNKs+@rocinante>
References: <20210210020516.95292-1-qiuxu.zhuo@intel.com>
 <YCQT90mK1kacZ7ZA@rocinante>
 <a5b1aa8ef91a4c71982ad77234932349@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5b1aa8ef91a4c71982ad77234932349@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Bjorn as we talked about RCiEP briefly on IRC]

Hello Qiuxu,

[...]
> Sorry, just back from Chinese New Year holiday.

Welcome back!  I hope you had a nice rest, and also Happy New Year!

[...]
> > Would this only affect error injection or would this be also a generic problem
> > with the driver itself causing issues regardless of whether it was an error
> > injection or not for this particular device?  I am asking, as there is a lot going on
> > in the commit message.
> 
> This is also a generic problem.

Good to know.  Bjorn was also wondering if this is potentially a sign of
a larger probed with the RCiEP support.

> > I wonder if simplifying this commit message so that it clearly explains what was
> > broken, why, and how this patch is fixing it, would perhaps be an option?  The
> > backstory of how you found the issue while doing some testing and error
> > injection is nice, but not sure if needed.
> > 
> > What do you think?
> 
> Agree to simplify the commit message. How about the following subject and commit message?
> 
> Subject:  
> Use device number to check RCiEPBitmap of RCEC
> 
> Commit message: 
> rcec_assoc_rciep() used the combination of device number and function
> number 'devfn' to check whether the corresponding bit in the
> RCiEPBimap of RCEC was set. According to [1], it only needs to use the
> device number to check the corresponding bit in the RCiEPBitmap was
> set. So fix it by using PCI_SLOT() to convert 'devfn' to device number
> for rcec_assoc_rciep(). [1] PCIe r5.0, sec "7.9.10.2 Association
> Bitmap for RCiEPs"

I took your suggestion and came up with the following:

  Function rcec_assoc_rciep() incorrectly used "rciep->devfn" (a single
  byte encoding the device and function number) as the device number to
  check whether the corresponding bit was set in the RCiEPBitmap of the
  RCEC (Root Complex Event Collector) while enumerating over each bit of
  the RCiEPBitmap.

  As per the PCI Express Base Specification, Revision 5.0, Version 1.0,
  Section 7.9.10.2, "Association Bitmap for RCiEPs", p. 935, only needs to
  use a device number to check whether the corresponding bit was set in
  the RCiEPBitmap.

  Fix rcec_assoc_rciep() using the PCI_SLOT() macro and convert the value
  of "rciep->devfn" to a device number to ensure that the RCiEP devices
  are associated with the RCEC are linked when the RCEC is enumerated.

Using either of the following as the subject:

  PCI/RCEC: Use device number to check RCiEPBitmap of RCEC
  PCI/RCEC: Fix RCiEP capable devices RCEC association

What do you think?  Also, feel free to change whatever you see fit, of
course, as tis is only a suggestion.

Krzysztof
