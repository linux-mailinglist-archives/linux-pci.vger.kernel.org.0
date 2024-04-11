Return-Path: <linux-pci+bounces-6142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7468A1C96
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 19:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D2928729C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 17:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74163D3A2;
	Thu, 11 Apr 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="ivDvCXxs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9682497;
	Thu, 11 Apr 2024 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852918; cv=none; b=WbsQ5WHlLHvnL/4YucWj8FPENdaCBP5rWMa+U1JHkoXpJMX6qR7yiKxI0thW2EtZ0077B0Bov+vwDdUyEPsx3iv3or/2wTwh480fX2DtxNzgQaoUG2S73C/f4lIG8C+FZivmZ5ABY8BRrSF+jiB7JOO1D6M1DgLE6ste0+rBznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852918; c=relaxed/simple;
	bh=oofwmCHVRmps+v1Jh/wKzpKey4d39SMonCrnWlldz4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyLbLeY1twtnf7IKL+b37JZSP5/ZjbTdWsGL7i0yjWF49iCFF9xsdQ9rnm2EQUeNhR4N5dOKYCQ+5WUgpjWGLFfs6aEwRk5yfGLcWRJL1KLrka4esueRlPHQsjxKUuQRvqVU3tZ2YndeOrEKg/3r5zhfhp9Xm4MKkU9xHg+8tEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=ivDvCXxs; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712852911; x=1713457711; i=parker@finest.io;
	bh=i36H0ZCXwcembXajIhl0o7h/+/2ntAQNOo7Cn43cE68=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=ivDvCXxsmQbi73M8hz+GmSnI4ZBJ8xUr3E68WyPkoe4U3peQhJCsPT1I1w8OrA9G
	 yhaXw0ZXqThOOVk2kD1i2BZq7PUZ+Zi6IxZmO2pe8nFl5YDsYlz+oULMaepsfVZIJ
	 11gemlWOj1/dAEx8Oozfs4p6uxG11dfBx6umg0Y4Y23lTHGY5pnbA6UwPILQKwWQC
	 /3GrG39nyWOfP3frOm8XX16Emp9fo/FjBl2u0PorWbuIrSopJaK0jlSqdi6EspVqO
	 3rf0Qb5tzCLVyOB4DR3NxbpZY4Msi9iglybgyYYRt8Yp7ewJ8wbSD2xpfIG6NJAY0
	 Os9BsSMcjwffHcfm1Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LeehE-1sYAym3Ugo-00qTS8; Thu, 11 Apr 2024 18:28:30 +0200
Date: Thu, 11 Apr 2024 12:28:29 -0400
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH 2/2] serial: exar: adding CTI PCI/PCIe serial port
 support to 8250_exar
Message-ID: <20240411122829.2125e13e@SWDEV2.connecttech.local>
In-Reply-To: <2024041147-flogging-straining-910c@gregkh>
References: <cover.1712846025.git.pnewman@connecttech.com>
	<9ffdef053f455c87f705dff169346bc10d307787.1712846026.git.pnewman@connecttech.com>
	<2024041147-flogging-straining-910c@gregkh>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XZqeAm/4Y7GhYw5XZZSC4TD4cd4IoaQQ5QfNPPymm8gJ1KNAhWX
 JhCpdtcLhLj0OBTkCpPW4Y4DbmlglER/EFbd004khP4fyAsJlzdnr6plC/yhClxRIi39X4W
 WwAwW+8u1srfytWKMEqJfjl64bmcYSoism2XaJ97SVEAHISBp9Ed746cX7HtIrETH6n4qwB
 +5Kcv9fTUe6vBDvJZYTLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:otLAxziXAP4=;dtfYW5QSXfSoPkQF1mBXck0KEFf
 nZ1TK7n9PmXBd/62uXFrr1b4RyOMwXjsT8FFsHavmQxCNbGaxI/bPrq1M0KBShBq6tqJJ3GNS
 DEznB+Q2jKgs/qukQpVcKPvF4W2cqetZcg/SWCUTf63NIVZNxwxHC2itR+Yaajd9PdnePECY9
 l/nNE00E20hV7v/9nt47JBqhRbhtqzK/Mzy/hhamiHEWnCr9TSQcOEs5JBVE75inzdund4IPZ
 Ax2w8ox6en6saJpRxu4yArxF1BGmqRPR15YamOcBNd7ELXy1BXoJuKRDEm1mJi+hNvcV/T9is
 a0n11anhx75xpDyigd7QP0trsBaUhWGb8tfJH/jDTFaA28EdX1OUYg/2Y7LDRUDOL+2rS28HI
 k7myxkSkJi48a9lZrmsAveH+gVC2BrN8gXZoBeC65NNQZzOSsKlnGyq/8dx9R410DuLEQ+S1w
 Zvjm70C0z3ng3gaVzJe9CQSYutWFB91740uYMkBI3Nefwln9VKUuOqSqu+IpeNYP/Pp0QBU20
 yCHJPufTWElx0+CzWUhv6aUPjM1v1Ex/pOxFZvMCL9vGP7wSkvIaSOWX7+Vr+3FIm1euDAJay
 jc14ChBoRdhgBit2QI/eFm3T3aI63M3WJb0SnU1wzb3Ny3QgRVw8C/IUBNKDF4PaIe0hbxTGv
 UJIvFRJmFXn2WtAP/dBlUeiSx+Sw2RAi6dfdfWCw07SBzSomXu+59d+O+cGwscaVyj+V2vUA4
 BIHQhR9ON0mx8ZMxcUTFrtPTHyZ4YQ70Tjc9IDQzevu0wGuR7ibhwY=

On Thu, 11 Apr 2024 17:55:54 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Apr 11, 2024 at 11:29:27AM -0400, parker@finest.io wrote:
> > From: Parker Newman <pnewman@connecttech.com>
> >
> > This patch adds support for most of Connect Tech's (CTI) PCI/PCIe
> > serial cards to the 8250_exar driver.
> >
> > Major changes:
> >  - Added (optional) board_setup function called once during probe
> >  - Added exar_get_nr_ports function
> >  - Removed old Connect Tech setup functions
> >  - Added new UART family based CTI setup functions
> >  - Added PCI IDs entries for Exar XR17V25x and CTI FPGA based cards
> >  - Added MPIO functions for configuring/setting a single MPIO
> >  - Added support for reading from the Exar EEPROM
>
> When you need to list the different things you did in a single patch,
> that's a huge hint it needs to be broken up into smaller, easier to
> review, pieces.
>
> >
> > Signed-off-by: Parker Newman <pnewman@connecttech.com>
> > ---
> >  drivers/tty/serial/8250/8250_exar.c | 1089 +++++++++++++++++++++++++-=
-
> >  1 file changed, 1019 insertions(+), 70 deletions(-)
>
> Reviewing 1000 lines of changes at once that does different things,
> isn't easy.  Please break this up into smaller,
> one-logical-step-at-a-time patches.
>
> thanks,
>
> greg k-h

I will try to split it up better and submit a v2.

Thank you,
- Parker

