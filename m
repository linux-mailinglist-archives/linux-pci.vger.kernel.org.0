Return-Path: <linux-pci+bounces-35699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4304B49C5A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 23:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973854E39B4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1802E11DC;
	Mon,  8 Sep 2025 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1U2iAqi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D02E0B64;
	Mon,  8 Sep 2025 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368233; cv=none; b=MWZxebUlpO0/RrfNr01lKsT1aNVc7Y0nLYXIey1UeZU6ObVpsCuqkMQEspnx4dht3UORW1JyPwS/FO6/vM+t5BoJz1TQWA8eKPInGLY4pHuVLdi2HBWyLWludqSM0avM1b9rYNLdY18W7XbsZf72Y5yHTEexzfM4yhPROmNjNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368233; c=relaxed/simple;
	bh=KefSjzm73w2HbGHRtz1VsVIvbTeN+FJ2LIqeCoIeTSc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QloGRUIjGqkRpV/pQmu9a2um7bU16JYUcB0Umi/vTm91sc34qPLeE97Ug+ppSj95kni+/kXgq1fFyvxDZK8Ek8DVhJbRvMNYBtlhETBaP/kFxS7r/keqpCU26823hd6aEnY7q636h2d0HPi+fqpLYjE8Lb7v200K8UdgrSYpVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1U2iAqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F129C4CEF1;
	Mon,  8 Sep 2025 21:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757368232;
	bh=KefSjzm73w2HbGHRtz1VsVIvbTeN+FJ2LIqeCoIeTSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c1U2iAqiQ03ZBi7PkxMTtfTBrrIm9wa75r9F5SolN9ABm7e2yC6NE5h6dBxrON9i6
	 B1O70eYbU45+B+WhRb1m+aIG16ZZ7mRPvqrMDfn4f3gZDnUALUgUQ5Q0g51V6YACoQ
	 YSZOijLUVgEWBRH6ZijmctH07Zz03fuK8kh8lyrtZar8wBD7Tre6Jm7phkd88VMlsH
	 PAUbo3ahvKTlQPBi7k9VONHmMvvQCK2K4E1eMalH79ioMxkARTAUuKNkQO2ndEK4mk
	 gUg+lgFGH4xNDy5Jx6VQM2c+UsoxFK5NycrlIix2NP7vu+OwaPtxOIH/29ffj0Bj7I
	 eVx5lNo/LKArQ==
Date: Mon, 8 Sep 2025 16:50:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Merthan =?utf-8?Q?Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	Denis Benato <benato.denis96@gmail.com>
Subject: Re: [PATCH v6 09/11] PCI: Put PCIe bridges with downstream devices
 into D3 at hibernate
Message-ID: <20250908215031.GA1467002@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818020101.3619237-10-superm1@kernel.org>

On Sun, Aug 17, 2025 at 09:00:59PM -0500, Mario Limonciello (AMD) wrote:
> For the suspend flow PCIe bridges that have downstream devices are put into
> the appropriate low power state (D3hot or D3cold depending upon specific
> devices). For the hibernate flow, PCIe bridges with downstream devices
> stay in D0 however. This can lead to PCIe bridges that are remained
> powered on needlessly during hibernate.

s/are remained/remain/ I guess?

> Adjust the pci_pm_poweroff_noirq() to follow the same flow as
> pci_pm_suspend_noirq() by using pci_pm_suspend_noirq_common().
> 
> This introduces a functional change that the hibernate flow will now
> call pci_save_state() and unless bus PM is skipped will also set
> the PCIe device into an unknown state.

