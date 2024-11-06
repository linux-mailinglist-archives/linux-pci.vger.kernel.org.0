Return-Path: <linux-pci+bounces-16097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4B69BDE7C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 07:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505C9285166
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 06:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EEF190057;
	Wed,  6 Nov 2024 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qPDAHpXr"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85536D;
	Wed,  6 Nov 2024 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873237; cv=none; b=E0vxC5M0LewXD8/KoRkTQSUN6soR1eiR8rROu28oFko9Z54p/LSBVigDtiR5TRoeYX+kWsGjrnO93yYEhmNyy0BcblXytPnIcPJ/A7KZU4iQyJ4vu+nSbn6SI57pWUt7z3sDWveECgkDhA+nCmIRQ2ckMZMJrXBvvB4wk92pvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873237; c=relaxed/simple;
	bh=oGFIBXGmNj4TtM62n5n9meAA22Gd8kybI9OvvT5MMjA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXVFGIaKTD9rgyFqQkdf9b3C0gW4GiXp2L5rjcDbaJGUOT5TCdarVkhlAfrQ9FgWkEibe3h/qySvHfrvZDPQPSJhLAglJGAZYG+3bUKl7aah0SXvNdwEUlI0kWZyfioGz0rQHN7Ei6to6PdZxyneemLgGQRp4dNE4cvB1JFn9sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qPDAHpXr; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A666eoj064806;
	Wed, 6 Nov 2024 00:06:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730873200;
	bh=9E01b5lO3ji2wEte0jqqAxO6EzU7eTUFjSnqcONGvZc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=qPDAHpXryy/zsx9k3xi+1+JktRZXpwTSAAaZbCxu+fVm9me6Ucvf+J9wFHMvFMyAG
	 rBbYwq3eCJu6qGSz87s/qsiRexf7/6RQDU/9N8q8kIVua1fJW0NBw8/BqbLHm1yBxT
	 8bKkjOm2LgfkvqIbD8gyG473RFCpgZvZidgSvDuY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A666eAH057444
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 00:06:40 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 00:06:40 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 00:06:40 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A666cvV042705;
	Wed, 6 Nov 2024 00:06:39 -0600
Date: Wed, 6 Nov 2024 11:36:38 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <kishon@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <cassel@kernel.org>,
        <dlemoal@kernel.org>, <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v2 1/2] PCI: keystone: Set mode as RootComplex for
 "ti,keystone-pcie" compatible
Message-ID: <5983ad5e-729d-4cdc-bdb4-d60333410675@ti.com>
References: <20240524105714.191642-2-s-vadapalli@ti.com>
 <20241106005758.GA1498067@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241106005758.GA1498067@bhelgaas>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Nov 05, 2024 at 06:57:58PM -0600, Bjorn Helgaas wrote:

Hello Bjorn,

> On Fri, May 24, 2024 at 04:27:13PM +0530, Siddharth Vadapalli wrote:
> > From: Kishon Vijay Abraham I <kishon@ti.com>
> > 
> > commit 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x
> > Platforms") introduced configuring "enum dw_pcie_device_mode" as part of
> > device data ("struct ks_pcie_of_data"). However it failed to set mode
> > for "ti,keystone-pcie" compatible. Set mode as RootComplex for
> > "ti,keystone-pcie" compatible here.
> 
> 23284ad677a9 appeared in v5.10.  
> 
> But I guess RC support has not been broken since v5.10 because we
> never used ks_pcie_rc_of_data.mode anyway?
> 
> It looks like the only use is here:
> 
>   #define DW_PCIE_VER_365A                0x3336352a
>   #define DW_PCIE_VER_480A                0x3438302a
> 
>   ks_pcie_probe
>   {
>     ...
>     mode = data->mode;
>     ...
>     if (dw_pcie_ver_is_ge(pci, 480A))
>       ret = ks_pcie_am654_set_mode(dev, mode);
>     else
>       ret = ks_pcie_set_mode(dev);

"mode" is used later on during probe at:

....
	switch (mode) {
	case DW_PCIE_RC_TYPE:
	...
	case DW_PCIE_EP_TYPE:
	...
	default:
		dev_err(dev, "INVALID device type %d\n", mode);
	}
....

> 
> so we don't even look at .mode unless the version is v4.80a or later,
> and this is v3.65a?
> 
> So this is basically a cosmetic fix (but still worth doing for
> readability!) and doesn't need a stable backport, right?

I suppose that "data->mode" will default to zero for v3.65a prior to
this commit, corresponding to "DW_PCIE_UNKNOWN_TYPE" rather than the
correct value of "DW_PCIE_RC_TYPE". Since I don't have an SoC with the
v3.65a version of the controller, I cannot test it out, but I presume
that the "INVALID device type 0" error will be displayed. Though the probe
will not fail since the "default" case doesn't return an error code, the
controller probably will not be functional as the configuration associated
with the "DW_PCIE_RC_TYPE" case has been skipped. Hence, I believe that
this fix should be backported.

Regards,
Siddharth.

