Return-Path: <linux-pci+bounces-7546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0368C7163
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 07:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90698B21214
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 05:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA3F19479;
	Thu, 16 May 2024 05:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M0fIfb+v"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FAC10A23;
	Thu, 16 May 2024 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715837883; cv=none; b=uN4C3xOgr1SCWL73Y/f30EpZhOgBy3WkSyxZhp88NTY0Vdf5GcuVoQj/MfGkLxy1/C3NJWCSUrJuODiJTTbOsofOXLDtDPzJWIVSA9e+aT7Gl1mKj26nxaAI7dSoc05WjU+/xxer03fZLsSIVXULRCWlxINUHmJejF/cxjYRZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715837883; c=relaxed/simple;
	bh=+x9P2g10w13sFtsPvEkQvrH5zn5tUCuZy9wdbJMlwyw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1r28qMCDKM36qDQO0P3EUaSvAoj88oJFtKJ8X4nZmS+zp6zF1MECVblEojGNcFFd3mFQGCtsDHlYkldMluuCoXC0FRWrFihDfTqSB3cB18wu2D35BkEdSDSbSZsUE7fpHeJgZPNKAhI2AhzhtqEWWHkPGLCkiUL58Yh1fzf8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M0fIfb+v; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44G5bTiY107053;
	Thu, 16 May 2024 00:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715837849;
	bh=Y+0+gVcTYlTJ4NuM6emf0ej+bmnF17XCG4Y5MCExeEM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=M0fIfb+vug0ndmHZykTjjoy+wJnfkyjq5jD7Zk9UPyIXNuJooZJbfUKs1yR41eR4h
	 1Zc3eAm8Dj8wh5bETHru5KCxzrUZ39tKExNVgtPnB9NJH6ee1tzqSLpz18GZyu85wO
	 uDJJ9Hcx7qRwOzSH/77e6PQ8RBlzHaZjOcMH+4iw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44G5bTS3063310
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 May 2024 00:37:29 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 May 2024 00:37:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 May 2024 00:37:28 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44G5bSjM068377;
	Thu, 16 May 2024 00:37:28 -0500
Date: Thu, 16 May 2024 11:07:27 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <fancer.lancer@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <cassel@kernel.org>,
        <dlemoal@kernel.org>, <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v7 2/2] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <ee5f54a8-c19f-4a56-9a9b-f8aeebf475d0@ti.com>
References: <20240514211452.GA2082543@bhelgaas>
 <20240515192614.GA2133406@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240515192614.GA2133406@bhelgaas>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, May 15, 2024 at 02:26:14PM -0500, Bjorn Helgaas wrote:
> On Tue, May 14, 2024 at 04:14:54PM -0500, Bjorn Helgaas wrote:
> > On Tue, May 14, 2024 at 05:41:48PM +0530, Siddharth Vadapalli wrote:
> > > On Mon, May 13, 2024 at 04:53:50PM -0500, Bjorn Helgaas wrote:
> > ...
> 
> > > > I'm not quite clear on the mechanism, but it would be helpful to at
> > > > least know what's wrong and on what platform.  E.g., currently v4.90
> > > > suffers Completion Timeouts and 45 second boot delays?  And this patch
> > > > fixes that?
> > > 
> > > Yes, the Completion Timeouts cause the 45 second boot delays and this
> > > patch fixes that.
> > 
> > And this problem happens on AM654x/v4.90a, right?  I really want the
> > commit log to say what platform is affected!
> > 
> > Maybe something like this?
> > 
> >   PCI: keystone: Enable BAR 0 only for v3.65a
> > 
> >   The BAR 0 initialization done by ks_pcie_v3_65_add_bus() should
> >   happen for v3.65a devices only.  On other devices, BAR 0 should be
> >   left disabled, as it is by dw_pcie_setup_rc().
> > 
> >   After 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus()
> >   callback to use add_bus"), ks_pcie_v3_65_add_bus() enabled BAR 0 for
> >   both v3.65a and v4.90a devices.  On the AM654x SoC, which uses
> >   v4.90a, enabling BAR 0 causes Completion Timeouts when setting up
> >   MSI-X.  These timeouts delay boot of the AM654x by about 45 seconds.
> > 
> >   Move the BAR 0 initialization to ks_pcie_msi_host_init(), which is
> >   only used for v3.65a devices, and remove ks_pcie_v3_65_add_bus().
> 
> I haven't heard anything so I amended it to the above.  But please
> correct me if it's wrong.

I would suggest specifying the failing combination since I do not know
if there is another device that is using v4.90a but doesn't see this
issue. What is certain is that this issue is seen with the v4.90a
controller on AM654x platform. Despite the PCIe Controller version
remaining the same across different platforms, it might be possible
that not all features supported by the PCIe Controller are enabled on
all platforms. For that reason, it appears to me that the subject could
be:

  PCI: keystone: Don't enable BAR 0 for AM654x

which implicitly indicates the combination as well (v4.90a on AM654x).

The commit message's contents could be reduced to:

  After 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus()
  callback to use add_bus"), ks_pcie_v3_65_add_bus() enabled BAR 0 for
  both v3.65a and v4.90a devices.  On the AM654x SoC, which uses
  v4.90a, enabling BAR 0 causes Completion Timeouts when setting up
  MSI-X.  These timeouts delay boot of the AM654x by about 45 seconds.

  Move the BAR 0 initialization to ks_pcie_msi_host_init(), which is
  only used for v3.65a devices, and remove ks_pcie_v3_65_add_bus().

by dropping:

  The BAR 0 initialization done by ks_pcie_v3_65_add_bus() should
  happen for v3.65a devices only.  On other devices, BAR 0 should be
  left disabled, as it is by dw_pcie_setup_rc().

The reason behind dropping the above paragraph is that BAR 0 could
probably be enabled on other controller versions as well, but not on the
v4.90a controller on the AM654x SoC.

Thank you Bjorn, for enhancing the commit message.

Regards,
Siddharth.

