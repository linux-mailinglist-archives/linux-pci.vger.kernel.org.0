Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C245B37EEF6
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 01:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhELWjX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 18:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1391721AbhELVat (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 May 2021 17:30:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E08C613B5;
        Wed, 12 May 2021 21:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620854979;
        bh=NJiYq8O1tWN0uhyFbIsznz9WLdKwSXYXjkFgfE2Ir90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LcrriKRxoXHzRiwpmWbqT571U+xRdEIZ3UBG/Bwh1L+eu5nhWolHL9mqx3Te6aIL8
         S6HhQTLNFNFzYVLVrOx1D5xT4e/yTg9rHQQnSIL35SgqC09BxQwv1rEk9aJ6MOeyeF
         jLW/NTMheTE8/ZzGqcfHJaeSUHqLtOWCXKtxZfPwpi+vSr7iylc7HFhvGhy1YOlZoR
         P9UOmEbOp3seMe5P0DNJQt96Olui5WAfzEBMZMUHDqI5p1YtwmU8tJmEWUMcq1TwQW
         Qt/W1Vy6V7y0vpv2lGSivb1dGs6Y0JfhmuyfUz0h/dupYuayVWc3diQKXi6cMhExlf
         7arpZt6fKIuEw==
Date:   Wed, 12 May 2021 16:29:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v2 31/40] docs: PCI: acpi-info.rst: Use ASCII subset
 instead of UTF-8 alternate symbols
Message-ID: <20210512212938.GA2516413@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fd9d4360a3d0f761b169b95d9997f4f5d06319c.1620823573.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

1) The subject line convention in Documentation/PCI has been
"Documentation: PCI: ...", but that is a little wordy, and if you want
to start a wider convention of "docs: PCI: ..." I'm OK with that.

2) IMO, including the filename ("acpi-info.rst") in the subject is not
really all that interesting.  In fact, I'd be fine with doing this
sort of mechanical conversion with a patch per directory or even a
single patch for *all* of Documentation/.

On Wed, May 12, 2021 at 02:50:35PM +0200, Mauro Carvalho Chehab wrote:
> The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
> and some automatic rules which exists on certain text editors like
> LibreOffice turned ASCII characters into some UTF-8 alternatives that
> are better displayed on html and PDF.
> 
> While it is OK to use UTF-8 characters in Linux, it is better to
> use the ASCII subset instead of using an UTF-8 equivalent character
> as it makes life easier for tools like grep, and are easier to edit
> with the some commonly used text/source code editors.
> 
> Also, Sphinx already do such conversion automatically outside literal blocks:
>    https://docutils.sourceforge.io/docs/user/smartquotes.html
> 
> So, replace the occurences of the following UTF-8 characters:
> 
> 	- U+00a0 (' '): NO-BREAK SPACE
> 	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK
> 
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Yes, this is annoying.  Thanks for doing this.

I noticed a few other anomalies.  If you want to keep this series as
just a mechanical thing and leave the things below for later, I'm OK
with that, too.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  Documentation/PCI/acpi-info.rst | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/PCI/acpi-info.rst b/Documentation/PCI/acpi-info.rst
> index 060217081c79..30d0fc85dd8e 100644
> --- a/Documentation/PCI/acpi-info.rst
> +++ b/Documentation/PCI/acpi-info.rst
> @@ -22,9 +22,9 @@ or if the device has INTx interrupts connected by platform interrupt
>  controllers and a _PRT is needed to describe those connections.
>  
>  ACPI resource description is done via _CRS objects of devices in the ACPI
> -namespace [2].   The _CRS is like a generalized PCI BAR: the OS can read
> +namespace [2].   The _CRS is like a generalized PCI BAR: the OS can read

s/   The _CRS/  The _CRS/

Remove one of the spaces at the end of this sentence.  One space is
OK, two is the convention in this file, and three is way too many :)

> @@ -66,7 +66,7 @@ the PNP0A03/PNP0A08 device itself.  The workaround was to describe the
>  bridge registers (including ECAM space) in PNP0C02 catch-all devices [6].
>  With the exception of ECAM, the bridge register space is device-specific
>  anyway, so the generic PNP0A03/PNP0A08 driver (pci_root.c) has no need to
> -know about it.  
> +know about it.  

Remove all the whitespace at the end of this line.

Bjorn
