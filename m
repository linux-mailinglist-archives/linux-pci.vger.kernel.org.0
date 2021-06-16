Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384113A9324
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 08:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhFPGxP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 02:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231774AbhFPGxP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 02:53:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8F62613B9;
        Wed, 16 Jun 2021 06:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623826269;
        bh=vFYUc/FPXe7v29rZc6G7piYAomJ6yWfSv9/yeEoUkxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TS6XOoGL4KFZ2jcCPUwlMc0J6sXPc0KOW84TacDfvAAZzhzoYsfTc0o8UaAgCmrk0
         L6OsejPKQEPNzyNv1UJXCQJ9Zxt5fZ9r0nva+0JrnYk1nXFrgHLWTJsOc8mWUd7dCW
         U7JPDYD1ZoHLVk3hvO4hMrAn3j+IHfpWPgPidSOIG8QKGGstIQpHeRx1WixmbzYdIo
         9hiPJWevjQLpKtVpMiet/U+H7teRA+CJVUn1IlSDOWt9Atdv27qH1Z5rVbQPg27PfZ
         /kogiKhOC9XguMKoiBLCUQK3XwN+0wocHAEEVM/JOJIwOkiIQCWb49qy6U8BIYexYe
         MghCqGcPgKO0A==
Date:   Wed, 16 Jun 2021 08:51:04 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 12/16] docs: PCI: acpi-info.rst: replace some
 characters
Message-ID: <20210616085104.0477bd7b@coco.lan>
In-Reply-To: <20210519214731.GA262176@bjorn-Precision-5520>
References: <320bafda201827dd63208af55b528ae63bcf8217.1621159997.git.mchehab+huawei@kernel.org>
        <20210519214731.GA262176@bjorn-Precision-5520>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 19 May 2021 16:47:31 -0500
Bjorn Helgaas <helgaas@kernel.org> escreveu:

> On Sun, May 16, 2021 at 12:18:29PM +0200, Mauro Carvalho Chehab wrote:
> > The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
> > conversion and some cut-and-pasted text contain some characters that
> > aren't easily reachable on standard keyboards and/or could cause
> > troubles when parsed by the documentation build system.
> >=20
> > Replace the occurences of the following characters:
> >=20
> > 	- U+00a0 ('=C2=A0'): NO-BREAK SPACE
> > 	  as it can cause lines being truncated on PDF output
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org> =20
>=20
> Apparently you missed
> https://lore.kernel.org/r/20210512212938.GA2516413@bjorn-Precision-5520
> where I pointed out a couple issues (3 spaces after period in first
> hunk, extra whitespace at end of "know about it." hunk) and added my
> ack.
>=20
> The subject line would be more useful as:
>=20
>   docs: PCI: Replace non-breaking spaces to avoid PDF issues
>=20
> It's fine to defer those issues if you want,=20

Yeah, I opted to separate the changes into parts. This one is focused
on problematic chars that could lead into output issues.=20

Once those get merged, I'll submit a separate one with things like curly
commas and dashes, as a couple of maintainers seem to have different
opinions about that.

> but this is still:
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

Regards,
Mauro
