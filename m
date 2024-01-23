Return-Path: <linux-pci+bounces-2488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00A3839415
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 17:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FB1283D10
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105D6612E0;
	Tue, 23 Jan 2024 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6h4Q+yW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931A5FDC6;
	Tue, 23 Jan 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025775; cv=none; b=qsJeM6sUnoqygT2/8r5PVckNwI13G4n5EBlSrZQkj1IDI6ZN1t4I7kse1MTQj0bbGlYHitNIQafZWagERPIuK6mEj705Dj6DoaLroHa7fiILlL4TvsjXR1l4MYUVJfrjGPeZ/UQKS6yKrucN5+t6NfkbG4aVybtMfuXIzyxQc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025775; c=relaxed/simple;
	bh=fBQWnLEBcYKTR5Qq7Ag6Kr3ZXGVUxHSMlcYjRnrDpCw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TIMCpJBWl2QlqQ72NYW4Vlgc7Z8SWBTow8o2qI4b2shCpI6tNMbkRjrGvpNqNJQaYLfk6vX4YYhk1CPSaWS0pYq7NlOgHkDG1LevyRee8IkgSUFiBPQbuWEV7q4FBPucrL1E2U8n1utGn1AGz2VeiqfURYWC0BJ+9/gTLgaLedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6h4Q+yW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE89C433F1;
	Tue, 23 Jan 2024 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706025774;
	bh=fBQWnLEBcYKTR5Qq7Ag6Kr3ZXGVUxHSMlcYjRnrDpCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W6h4Q+yW/ndZBGBIYtAlkUk50X2t2NYM6vTxdjLeHdF0LS7L/E7xxpzJYiLpK3ZVf
	 cxLMQ6NCDTLGEQb3Ee69CTnTiPCnP5O7OAKltCTwxTbk6Tng/0W8zHUfqUrZzaJlOr
	 JEGR09vZVL32iC1gSTucjmxerZB1C+BrO7Nge/bay5nEfiRf7JvahldiZKXN6yeNNl
	 wjxbZxVI8GjvV+ieI3y1Z6Nb1l72e93Ql8ayabmkdTLQgWY07nx5uo+dBgiRV/GV5s
	 RBAt7o76WucKEx7ES6icgfU/zS67hfRDPH3KzAm1KlHvrrY4zNRdXCxGkV33OcfaUX
	 ARNNR+BTs1psA==
Date: Tue, 23 Jan 2024 10:02:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>
Subject: Re: [RFC KERNEL PATCH v4 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Message-ID: <20240123160252.GA316914@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5849D7A9EC2BEB55CAF3A889E7742@BL1PR12MB5849.namprd12.prod.outlook.com>

On Tue, Jan 23, 2024 at 10:13:52AM +0000, Chen, Jiqian wrote:
> On 2024/1/23 07:37, Bjorn Helgaas wrote:
> > On Fri, Jan 05, 2024 at 02:22:17PM +0800, Jiqian Chen wrote:
> >> There is a need for some scenarios to use gsi sysfs.
> >> For example, when xen passthrough a device to dumU, it will
> >> use gsi to map pirq, but currently userspace can't get gsi
> >> number.
> >> So, add gsi sysfs for that and for other potential scenarios.
> ...

> > I don't know enough about Xen to know why it needs the GSI in
> > userspace.  Is this passthrough brand new functionality that can't be
> > done today because we don't expose the GSI yet?
>
> In Xen architecture, there is a privileged domain named Dom0 that
> has ACPI support and is responsible for detecting and controlling
> the hardware, also it performs privileged operations such as the
> creation of normal (unprivileged) domains DomUs. When we give to a
> DomU direct access to a device, we need also to route the physical
> interrupts to the DomU. In order to do so Xen needs to setup and map
> the interrupts appropriately.

What kernel interfaces are used for this setup and mapping?

