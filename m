Return-Path: <linux-pci+bounces-18053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BED9EBBB1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00EF162EDD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 21:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088BA22CBF9;
	Tue, 10 Dec 2024 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4HkPpMK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057E23ED4A;
	Tue, 10 Dec 2024 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733865463; cv=none; b=CHtfTFR5zZ6JOePTH+k/C9s/Di9W3l8J6G6kMnT2eUL76/YHOE/mDIXI1gR4rbFFYxxM6iKq5GDVLL+zih/5dYk+c/Me8FINaxfxjylAyCFm+Q/x4BnMLs3HYjRSZBpSygfqpgVBOY53pFKbGaRNelbkWQi55CzivSeulKptHAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733865463; c=relaxed/simple;
	bh=UyzaenxJMZxUyiuu2tQwx1Mm4Pxn8j1HQU8DNGDLMP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M65XLYC6OzD6bK/3bXqbYZcRHh2pSmvFyYnnYQUbMXTASxElmCOVUWigBHPVylniWrM1jY5vc0wBXvSCj0ibN/TIEG+c3rmpJQ7BYTr2X87rFsBzDUZLy9Mu/FaLsKJ4+Tn8Zv4NEzg/eR61QeF1a5f5u1II96NbAkfPGrnpvIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4HkPpMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D86C4CED6;
	Tue, 10 Dec 2024 21:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733865463;
	bh=UyzaenxJMZxUyiuu2tQwx1Mm4Pxn8j1HQU8DNGDLMP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F4HkPpMKBxLyj/NgKupTc4pUVt+fm2OjGPZQkO1uN/W36xBGl9RMESHr7Cfe54S4F
	 bwPy1fqXGEUp92cPx51vD57EWdhOKol0CRRpWZCe7iOjVdrOLvhNTNmhYYnZbGdJO6
	 1TCVfyk6YVG5MbGnGMA4Wg30U8bap5dihPbRcfGOmuN0sqjDvKSIxhNMXezt/pk3VA
	 gLPSdxgm5GpsmPqhlS7WSDVyJf5QEwwxmhgmR0qTtCfCQzyUU0zhcUsfTJj0vCuOUw
	 k7YMFiGG4NTP+vprh6J+wqHJtfrHSxuxTr8CV3KsZQKZj3Wl9jFyOi+Fz43klZizQZ
	 5tvS850P34Knw==
Date: Tue, 10 Dec 2024 15:17:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhou Shengqing <zhoushengqing@ttyinfo.com>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHv2] PCI/ACPI: _DSM PRESERVE_BOOT_CONFIG function rev id
 doesn't match with spec.
Message-ID: <20241210211740.GA3257918@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g66WmqeouN6AWADE+J3e-f30wMGyLX-Upk+w7Y+i2OxA@mail.gmail.com>

On Tue, Dec 10, 2024 at 08:56:14PM +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 10, 2024 at 8:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Nov 14, 2024 at 03:04:24AM +0000, Zhou Shengqing wrote:
> > > Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
> > > for PCI. Preserve PCI Boot Configuration Initial Revision ID is 2. But
> > > the code is 1.
> >
> > This _DSM function 5 was added in PCI Firmware r3.1, released Dec 13,
> > 2010.  It's listed in sec 4.6 with Revision 2 (as *all* the defined
> > functions are, even functions 1-4, which were included in r3.0 with
> > Revision 1).
> >
> > But the actual definition that was added in r3.1 is in sec 4.6.5,
> > which specifies Revision ID 1.
> >
> > PCI Firmware r3.2, released Jan 26, 2015, was the newest available at
> > the time Ben implemented a78cf9657ba5 ("PCI/ACPI: Evaluate PCI Boot
> > Configuration _DSM"), and sec 4.6.5 still specified Revision ID 1.
> >
> > So I think Ben's addition used the correct Revision ID (1).
> >
> > PCI Firmware r3.3, released Jan 20, 2021, changed sec 4.6.5 to say
> > "lowest valid Revision ID value: 2"
> >
> > I think it's a mistake to make the kernel change below because
> > platforms in the field implemented function 5 with revision 1 (per the
> > r3.1 and r3.2 specs), and we have no idea whether they implement
> > function 5 revision 2.
> >
> > It's quite likely that newer platforms following r3.3 will implement
> > function 5 revision 2, but NOT revision 1, and the existing code won't
> > work for them.
> >
> > I think the fix is to try revision 1 and, if that isn't implemented,
> > we should try revision 2.  The semantics stayed the same, so they
> > should both work the same.
> 
> Or call Function 0 with the new revision and check the result?

IIUC we should always be using acpi_check_dsm() to call function 0 and
check for the desired function and revision, so we should do that for
both revision 1 and revision 2.  It looks like we're missing that
check here, which is a separate problem.

Of the current pci_acpi_dsm_guid uses, these functions lack that check:

  pci_acpi_preserve_config
    acpi_evaluate_dsm_typed(DSM_PCI_PRESERVE_BOOT_CONFIG)

  acpi_pci_add_bus
    acpi_evaluate_dsm_typed(DSM_PCI_POWER_ON_RESET_DELAY)

  pci_acpi_optimize_delay
    acpi_evaluate_dsm_typed(DSM_PCI_DEVICE_READINESS_DURATIONS)

The only other PCI _DSM functions we use do include the check:

  EDR_PORT_DPC_ENABLE_DSM  acpi_enable_dpc()
  EDR_PORT_LOCATE_DSM      acpi_dpc_port_get()
  TPH_ST_DSM_FUNC_INDEX    tph_invoke_dsm()
  DSM_PCI_DEVICE_NAME      dsm_get_label() (check in device_has_acpi_name())

> > > Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()")
> > > Origin fixes: a78cf9657ba5 ("PCI/ACPI: Evaluate PCI Boot Configuration _DSM")
> > >
> > > Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
> > > ---
> > >  drivers/pci/pci-acpi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > index af370628e583..7a4cad0c1f00 100644
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -132,7 +132,7 @@ bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
> > >                */
> > >               obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
> > >                                             &pci_acpi_dsm_guid,
> > > -                                           1, DSM_PCI_PRESERVE_BOOT_CONFIG,
> > > +                                           2, DSM_PCI_PRESERVE_BOOT_CONFIG,
> > >                                             NULL, ACPI_TYPE_INTEGER);
> > >               if (obj && obj->integer.value == 0)
> > >                       return true;
> > > --
> > > 2.39.2
> > >

