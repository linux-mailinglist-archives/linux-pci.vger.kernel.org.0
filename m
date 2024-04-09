Return-Path: <linux-pci+bounces-5971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E5589E416
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 22:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC4C1C20F42
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 20:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976591581E6;
	Tue,  9 Apr 2024 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIuyFRFe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E5157E97;
	Tue,  9 Apr 2024 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692997; cv=none; b=XUGDn4huTeDDLeIEzpZFb2IMwBH4NODFGBgYohddeQF5EkP/8IpyzDIVuZ9Y9m3B/1bkjdDs/F48jc2KjR7ob2D64/smTumuy76O1ogeE8BhE/Ev9BSyEo2yI2N8NO3ZwCfMQwoMMXRnsPE5SAC3w3en648+G0L+Pu3WMQdv/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692997; c=relaxed/simple;
	bh=W0Dg/LFVG/zk6w1OJr/E+L0AAUiXJ9nwCf1h17aljN0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sEGvYlcbhqDEsS7NXV/N/qly7zcZeuI8EcKPv4/B3CEJDua/pnaMPjFqx+k+mJieJdmLZuigtdla7VtDjQIRjv/JoHYAqHH/cCVlVPhHENvL59lHqJ4ul+0awBxzwoPSjH/ReLTlMcJDrbWV89hMDs8q98nZH4TBOJCVdcdGEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIuyFRFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EFDC433F1;
	Tue,  9 Apr 2024 20:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712692996;
	bh=W0Dg/LFVG/zk6w1OJr/E+L0AAUiXJ9nwCf1h17aljN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qIuyFRFe8Io8vngdx3pCHOgr9fPX5ND0sl//x5REFfEOjyjYNU76rWwfsRqAw6vDv
	 3Vib8zwLf743gCAZaVORYHFdeQSWBjOKZ5k0yJxTbO8HsUfJZDiZYbd+hGnpXRUc8T
	 ZX109BdQn0wlxURG5F2KlWvXYdgcHPHFf6tjCnChvmRiY33b/a4pYTzJv4R6bTTcJV
	 UJroth14Lrg1CsSiP/NUrmp8jlcJIsPDDTTsOWZfa7qKaHWkbebDvYgcu2xGVpWZr/
	 GzkTGJMCToZ8xhCzRsQn1IAetrwX0w0O9cWHbWXO6ZVomimvxzE2jhBqO8B+I131GQ
	 I2c2hOSkzQ4Xg==
Date: Tue, 9 Apr 2024 15:03:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Len Brown <lenb@kernel.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v4 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Message-ID: <20240409200314.GA2086199@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5849572DFC67B1F8A68E123DE7002@BL1PR12MB5849.namprd12.prod.outlook.com>

[+to Rafael]

On Mon, Apr 08, 2024 at 06:42:31AM +0000, Chen, Jiqian wrote:
> Hi Bjorn,
> It has been almost two months since we received your reply last time.
> This series are blocking on this patch, since there are patches on Xen and Qemu side depending on it.
> Do you still have any confusion about this patch? Or do you have other suggestions?
> If no, may I get your Reviewed-by?

  - This is ACPI-specific, but exposes /sys/.../gsi for all systems,
    including non-ACPI systems.  I don't think we want that.

  - Do you care about similar Xen configurations on non-ACPI systems?
    If so, maybe the commit log could mention how you learn about PCI
    INTx routing on them in case there's some way to unify this in the
    future.

  - Missing an update to Documentation/ABI/.

  - A nit: I asked about s/dumU/DomU/ in the commit log earlier,
    haven't seen any response.

  - Commit log mentions "and for other potential scenarios."  It's
    another nit, but unless you have another concrete use for this,
    that phrase is meaningless hand waving and should be dropped.

  - A _PRT entry may refer directly to a GSI or to an interrupt link
    device (PNP0C0F) that can be routed to one of several GSIs:

      ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
 
    I don't think the kernel reconfigures interrupt links after
    enumeration, but if they are reconfigured at run-time (via _SRS),
    the cached GSI will be wrong.  I think setpnp could do this, but
    that tool is dead.  So maybe this isn't a concern anymore, but I
    *would* like to get Rafael's take on this.  If we don't care
    enough, I think we should mention it in the commit log just in
    case.

Bjorn

