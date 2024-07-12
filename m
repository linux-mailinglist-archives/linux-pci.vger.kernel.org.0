Return-Path: <linux-pci+bounces-10203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5485792F9A7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 13:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865361C217E5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4AE1640B;
	Fri, 12 Jul 2024 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtwXpn0e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7614A3D
	for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2024 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720784538; cv=none; b=SHomegNqATd8pNLnDv8CzfTDfrVGdni7o9azHzEIVQR94jPVw5iV5ly5lCpZrhMYw4FfQ6glWobtgA120LICgc45x6sBn6tqXSCDyHivu4xGgHBMIUgQDBIjli9ayY0vZzZ8PU3zgGx16gYcLfKvDfhqg9p19L+DZl9os4pvHUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720784538; c=relaxed/simple;
	bh=Vyjy44iWXBUAtobZim+B+vF7TS8mewHUrZGQBPuJp0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VCdUnll24TjMEq71vlVFuhcaFRpKLV47+k9CYYyLggtCOF5YRHqKcrDBuhxkAuuA5btkebNq2mCuWUONoYDJkea8sR/fFhZHj5wmdPGmFu4tV46gAOk3nwsS2o8DwhwWgH09AQcDNWlkQY1+b02xmUz8frpprrxkzp3Kbbrd33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtwXpn0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C83FC32782;
	Fri, 12 Jul 2024 11:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720784538;
	bh=Vyjy44iWXBUAtobZim+B+vF7TS8mewHUrZGQBPuJp0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AtwXpn0eIi7syH5YQGAu5JEJjQ3SThv7T1OkcaJv64zZp2ZThUsIp9cwbwAbW1mFk
	 OU9fIszhDX0lJGC6FuF1eWtbE1TU+WGW9F95JgYflwntpQtPc6FAVZ+0mrRtmJWc9a
	 WfA1mm1L1E/IaoWRTFgVv6KFrJLQD71aeo0MIZBBxdruQn1QWaSC7rMHyxeijEEqMJ
	 zqIsCXNsR7xwCIOHrWxiPkHP+/wS2SKfQhaFDUTelkBfy//lhw7YzAzVPPOs8jZtD9
	 8u5N3I0DlmkQeQYNEX9d5pXf8ybUFtmhJbhE2APqaq5VR1NtNpmEtYTSS8zuJAK4Mk
	 caUoXekGds7lg==
Date: Fri, 12 Jul 2024 06:42:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: dukovac.stefanie@live.ca
Cc: linux-pci@vger.kernel.org
Subject: Re: [Bug 219031] New: DPC Regression non-Root Port and non-RCEC
 devices
Message-ID: <20240712114216.GA322718@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-219031-41252@https.bugzilla.kernel.org/>

On Fri, Jul 12, 2024 at 12:18:46AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=219031
> 
>             Bug ID: 219031
>            Summary: DPC Regression non-Root Port and non-RCEC devices
>            Product: Drivers
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: dukovac.stefanie@live.ca
>         Regression: No
> 
> Created attachment 306564
>   --> https://bugzilla.kernel.org/attachment.cgi?id=306564&action=edit
> Diff of lspci output of switch between 6.5 and 6.5 with native dpc
> 
> This commit
> https://lore.kernel.org/all/20221210002922.1749403-1-helgaas@kernel.org/
> assumes that "switch[es] supports AER but not MSI" so initializing the AER IQR
> fails. This commit prevents registering AER and consequently DPC services on
> non-Root Port, non-Root Complex Event Collector devices.
> 
> I have a switch that supports MSI (or so I think). I find that DPC is no longer
> enabled by default on the switch with this commit. To re-enable DPC I pass
> `pcie_ports=dpc-native` as a karg. This means pci_aer_available() in on L263 of
> portdrv.c must evaluate to true, which means pci_msi_enabled() must be true,
> hence my switch does not match the assumption of the commit.
> 
> The `pcie_ports=dpc-native` karg forces native DPC control, regardless of
> whether native AER is enabled or not. PCIe r4.0 sec 6.1.10 and PCIe r7.0 sec
> 6.2.11 both recommend the operating system always link DPC control to the
> control of AER. 
> 
> I am working on 6.5.13.

Thanks for the report.

The change you mention was merged as
https://git.kernel.org/linus/d8d2b65a940b ("PCI/portdrv: Allow AER
service only for Root Ports & RCECs"), which appeared in v6.2, so it
looks like this would be a regression between v6.1 and v6.2.

Can you verify that v6.9 is still broken this way?  It sounds like
you've checked that reverting d8d2b65a940b solves the problem?

Can you please attach the complete dmesg log from the newest kernel
you can test?

