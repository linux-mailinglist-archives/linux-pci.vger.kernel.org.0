Return-Path: <linux-pci+bounces-20692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36521A26E2E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 10:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAB4166050
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC28206F37;
	Tue,  4 Feb 2025 09:23:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21DB205E26;
	Tue,  4 Feb 2025 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661030; cv=none; b=XfScB9Gjsq7Atb1PrXjSlmkdRnLWf+GboEDkIMOhwK4VRTHm1DHXRuSMdYq9r1/L1KnkYYZCRGFx5pCaV1BRZtf0ayCyNqSQio46dCoMVBzRo0LJU8s30o/RTTMxb2LQ9EDlhVW2ME4Dnf+eLPhHQBiGXXKQaM/tF5+mdaa5hN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661030; c=relaxed/simple;
	bh=Sk4f8a3ZYm6LNS90zNDrp65XN39AnRMW+m/z8KUDM4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHR8MYcasGb+E0gy3zua6CaqZTC811HbxzzZCwb3HfDJpVnUMrWYaewqx6MYLPfH1LhRmu0AQmteQ/e9mrSCd8fEA7eqEuOd778Rn3U0hsYR7gDl9vLK8//And4aO6XpRvVYdd7Pu3gFcL7/lbjLEC3TIGSPRUOrqC/fGtE5PCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9AF27100BA63C;
	Tue,  4 Feb 2025 10:23:45 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 54DCA4E0704; Tue,  4 Feb 2025 10:23:45 +0100 (CET)
Date: Tue, 4 Feb 2025 10:23:45 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Disable PCIE hotplug interrupts early when msi
 is disabled
Message-ID: <Z6HcoUB3i51bzQDs@wunner.de>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <20250204053758.6025-2-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204053758.6025-2-feng.tang@linux.alibaba.com>

On Tue, Feb 04, 2025 at 01:37:58PM +0800, Feng Tang wrote:
> There was a irq storm bug when testing "pci=nomsi" case, and the root
> cause is: 'nomsi' will disable MSI and let devices and root ports use
> legacy INTX inerrupt, and likely make several devices/ports share one
> interrupt. In the failure case, BIOS doesn't disable the PCIE hotplug
> interrupts, and  actually asserts the command-complete interrupt.
> As MSI is disabled, ACPI initialization code will not enumerate root
> port's PCIE hotplug capability, and pciehp service driver wont' be
> enabled for the root port to handle that interrupt, later on when it is
> shared and enabled by other device driver like NVME or NIC, the "nobody
> care irq storm" happens.

Is there a section in the PCI Firmware Spec which says ACPI doesn't
enumerate the hotplug capability if MSI is disabled?

If so, it should be referenced in the commit message.

If not, I'm wondering if it's safe to fiddle with the Slot Control
register given the platform hasn't granted OSPM control of it.

Of course if this is spec-defined behavior in the nomsi case,
we could make the write to the Slot Control register conditional
on that.  But if this turns out to be platform-specific behavior,
we can't deal with it in generic PCI code but only in a quirk.

Thanks,

Lukas

