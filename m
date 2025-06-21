Return-Path: <linux-pci+bounces-30288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22607AE2874
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 11:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8BF17B3A5
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE49F1F237A;
	Sat, 21 Jun 2025 09:59:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B55C2E0;
	Sat, 21 Jun 2025 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750499969; cv=none; b=bL3r71TwqKagENuX44INC9j06PV6l+keUot6PkDaofOjCLcTpFQebX2oMIAwcFYa/F2fGKPIKvyEwbNWbl8QQQvU1SP6zY4Y2aHzv+zk6P269w34iWjgSezGV+8VN38L3XQc5wGdOBt9rImf8bf/tZWhyFYytTqZWqf19lWX/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750499969; c=relaxed/simple;
	bh=JhJhCe6muwM4NOd1MNCRosfJQfOvjKx3LG/4KbOWN1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrtZHsAtD2L+xkxYHjkQ25H2hj3foM6whRuZ4RhzcUSfR+7awsd/vPSvtHms7vtVdHFmQA4RYJzAIXnCt1eq8srZod96gKggMnsNzVJgmQ8LclHzVoZ/pQL+oX9FHxhJgptOy3gcJ04PvbqJ0OEiVcel+7CqCTNpjiBJ4f2xFrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 06C922C06849;
	Sat, 21 Jun 2025 11:59:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E55963A0E4E; Sat, 21 Jun 2025 11:59:25 +0200 (CEST)
Date: Sat, 21 Jun 2025 11:59:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krishna Kumar <krishnak@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Timothy Pearson <tpearson@raptorengineering.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"\"linux-pci\"," <linux-pci@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	"\"Bjorn Helgaas\"," <bhelgaas@google.com>
Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention
 indicator
Message-ID: <aFaCfYre9N52ARWH@wunner.de>
References: <20250618190146.GA1213349@bhelgaas>
 <1469323476.1312174.1750293474949.JavaMail.zimbra@raptorengineeringinc.com>
 <19689b53-ac23-4b48-97c7-b26f360a7b75@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19689b53-ac23-4b48-97c7-b26f360a7b75@linux.ibm.com>

On Fri, Jun 20, 2025 at 02:56:51PM +0530, Krishna Kumar wrote:
> 5. If point 3 and 4 does not solve the problem, then only we should
> move to pciehp.c. But AFAIK, PPC/Powernv is DT based while pciehp.c
> may be only supporting acpi (I have to check it on this). We need to
> provide PHB related information via DTB and maintain the related
> topology information via dtb and then it can be doable.

pciehp is not ACPI-specific.  The PCIe port service driver in
drivers/pci/pcie/portdrv.c binds to any PCIe port, examines the
port's capabilities (e.g. hotplug, AER, DPC, ...) and instantiates
sub-devices to which pciehp and the other drivers such as aer bind.

How do you prevent pciehp from driving hotplug on PowerNV anyway?
Do you disable CONFIG_HOTPLUG_PCI_PCIE?

Thanks,

Lukas

