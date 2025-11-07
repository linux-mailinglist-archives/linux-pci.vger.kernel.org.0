Return-Path: <linux-pci+bounces-40565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 196F8C3EA04
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 07:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFA018874A4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 06:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0FF242D84;
	Fri,  7 Nov 2025 06:33:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF522877D2;
	Fri,  7 Nov 2025 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497217; cv=none; b=H/tFAZhz814Z8B0ah0RVlcvhAZvCrkM8wI2zYsrBSFaxEkQdhPQntiXiwzQ/OlPp4GSawmY08w+Bwy6nIa/s8isAUUae0iZ0kHCqr/XyJvyg/wgYHXlQrGdWy+LiT45d+yks2LwF7nCvtrytOjhZ/ivfnldNYHR02Q7R0qmlrCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497217; c=relaxed/simple;
	bh=gjhNdhbX09NImVbFe6Szl845BIzLIYmjAsrq60zVgOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBXQESVPj6kIAxt1b4nPWkvIZZPSL2IvbaQcScFkmPqyIZTzxG5Y+MGpE3dkkD/51rkpFDxe2pWEileF9cxsjwOsrfGEtACeK4sI5IEhRQ1igp+iHSOtbEtnd4hBhWD/B5l3aWjaY3M0p6yPey5pzUBMI0HxahoT0qw7rF9MzUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 15FDC2C06414;
	Fri,  7 Nov 2025 07:33:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0B73549A; Fri,  7 Nov 2025 07:33:31 +0100 (CET)
Date: Fri, 7 Nov 2025 07:33:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI/ASPM: Allow quirks to avoid L0s and L1
Message-ID: <aQ2Su6wp5DWlkEgb@wunner.de>
References: <20251106183643.1963801-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106183643.1963801-1-helgaas@kernel.org>

On Thu, Nov 06, 2025 at 12:36:37PM -0600, Bjorn Helgaas wrote:
> L1 PM Substates and Clock PM in particular are a problem because they
> depend on CLKREQ# and sometimes device-specific configuration, and none of
> this is discoverable in a generic way.

According to PCIe r7.0 sec 7.5.3.7, the "Enable Clock Power Management"
bit is "applicable only for Upstream Ports and with form factors that
support a Clock Request (CLKREQ#) mechanism".

Thus, if BIOS has set the "Enable Clock Power Management" bit
on a Downstream Port, we can infer that CLKREQ# is supported.

Thanks,

Lukas

