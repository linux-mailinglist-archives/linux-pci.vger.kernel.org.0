Return-Path: <linux-pci+bounces-11240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FAF946C91
	for <lists+linux-pci@lfdr.de>; Sun,  4 Aug 2024 07:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDAF281937
	for <lists+linux-pci@lfdr.de>; Sun,  4 Aug 2024 05:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CBC320F;
	Sun,  4 Aug 2024 05:55:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4DFC0E;
	Sun,  4 Aug 2024 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722750943; cv=none; b=MT66XF/VFg7yyWXaQX34OCbxPTHUtpcyhBOu2UoTTEtKqLrS7aJvxMNHLrAIS0GkW+eXjoUlfWAODbmLvYlr++N+K1uI9A5jA8/sHE3n6pt0bY33qgg9XP6y3jItJATZzDYLBDerM3lm33ofTxCKYyZu6GnC2AvtvgqOYBbe2qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722750943; c=relaxed/simple;
	bh=be4NnnWnjMAF0BLjyQVYsszoMErpyxXnIAw9IJ0GH4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvdpHm+gDggwAup00T9OVGyxCNOF3ktZEjUrrxMgfC2oCac8HBifceTVx8D4zEpedaNe88X2qOkyOWTdhY7ROXTGxJ0tPGvXXP4vdyITTsynaP851ZomouE3aH7lLT81vTQvoS2agxEDKG/Vml5DvMIZV9dfnq9Np55v0nAzyqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6F402280137BE;
	Sun,  4 Aug 2024 07:55:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5978C390434; Sun,  4 Aug 2024 07:55:30 +0200 (CEST)
Date: Sun, 4 Aug 2024 07:55:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alistair Francis <alistair23@gmail.com>, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com,
	gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
	rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v9 2/3] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <Zq8X0t0lMLQ12oIQ@wunner.de>
References: <20231013034158.2745127-2-alistair.francis@wdc.com>
 <20231019165829.GA1381099@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019165829.GA1381099@bhelgaas>

On Thu, Oct 19, 2023 at 11:58:29AM -0500, Bjorn Helgaas wrote:
> Is it feasible to build an attribute group in pci_doe_init() and add
> it to dev->groups so device_add() will automatically add them?

Note that pcibios_device_add() in arch/s390/pci/pci.c does this:

	pdev->dev.groups = zpci_attr_groups;

... which prevents usage of pdev->dev.groups for anything else.

This needs to be cleaned up first before the PCI core can allocate
and fill generic attribute groups on enumeration.

Thanks,

Lukas

