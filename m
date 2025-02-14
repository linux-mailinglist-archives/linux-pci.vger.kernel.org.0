Return-Path: <linux-pci+bounces-21470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08A6A361B1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6C13A8E55
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F3326656A;
	Fri, 14 Feb 2025 15:28:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEE1747F;
	Fri, 14 Feb 2025 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546928; cv=none; b=gAHrKOEkzUt98i1fBLkiQo8vZRXWUxIy5MSFJBKEeL2v8r2fNdwlETYSbsg8METfdB54u+RmWCTXCCpnU4lo4uA0skKAPCVaup+zLGSkykJ2JqdbR92dKHy/8FuQdere6V2+B7xjL44zyyS6tzsNFuf+2I7oNftSeq35DLD5vtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546928; c=relaxed/simple;
	bh=QGoEqJ4Pyx+hYl5icZkKTw5uyF1Gu5Jen5eezGi8pdI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+u2Lismt7cA53NnCWHC2VdfothX7jBrJT8IoVtSnPaQm5dDVRhe1Xv3/deIBKvyT0pSsZK5PXlxuaXovSj2NsmApe1MuRpe6VmwhzV+v4NTaoD6Eg4hoPlbos5chr7Cw1q0+rTZwc4tlkRD12omy8NmuqlZ75Bz1W6LLawL5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvbWs0N9Lz6HJfF;
	Fri, 14 Feb 2025 23:27:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AD021140B38;
	Fri, 14 Feb 2025 23:28:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 16:28:41 +0100
Date: Fri, 14 Feb 2025 15:28:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v7 10/17] cxl/pci: Add log message and add type check in
 existing RAS handlers
Message-ID: <20250214152840.00002172@huawei.com>
In-Reply-To: <d56fcbea-8405-4f61-9c32-63db88f1483c@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
	<20250211192444.2292833-11-terry.bowman@amd.com>
	<67ad27da2f65c_2d2c294b9@dwillia2-xfh.jf.intel.com.notmuch>
	<d56fcbea-8405-4f61-9c32-63db88f1483c@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 12 Feb 2025 18:08:13 -0600
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 2/12/2025 4:59 PM, Dan Williams wrote:
> > Terry Bowman wrote: =20
> >> The CXL RAS handlers do not currently log if the RAS registers are
> >> unmapped. This is needed in order to help debug CXL error handling. Up=
date
> >> the CXL driver to log a warning message if the RAS register block is
> >> unmapped.
> >>
> >> Also, add type check before processing EP or RCH DP.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> >> Reviewed-by: Gregory Price <gourry@gourry.net>
> >> ---
> >>  drivers/cxl/core/pci.c | 20 ++++++++++++++------
> >>  1 file changed, 14 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> >> index 69bb030aa8e1..af809e7cbe3b 100644
> >> --- a/drivers/cxl/core/pci.c
> >> +++ b/drivers/cxl/core/pci.c
> >> @@ -658,15 +658,19 @@ static void __cxl_handle_cor_ras(struct device *=
dev,
> >>  	void __iomem *addr;
> >>  	u32 status;
> >> =20
> >> -	if (!ras_base)
> >> +	if (!ras_base) {
> >> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
> >>  		return;
> >> +	}
> >> =20
> >>  	addr =3D ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> >>  	status =3D readl(addr);
> >> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> >> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> >> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> >> +		return;
> >> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> >> +
> >> +	if (is_cxl_memdev(dev))
> >>  		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status); =20
> > I think trace_cxl_aer_correctable_error() should always fire and this
> > should somehow be unified with the CPER record trace-event for protocol
> > errors.
> >
> > The only usage of @memdev in this trace is retrieving the device serial
> > number. If the device is not a memdev then print zero for the serial
> > number, or something like that.
> >
> > In the end RAS daemon should only need to enable one trace event to get
> > protocol errors and header logs from ports or endpoints, either
> > natively, or via CPER.
> > =20
> That would be: we use 'struct *device' instead of 'struct *cxl_memdev'
> and pass serial# in as a parameter (0 in non-EP cases)?

For a USP may well have a serial number cap. Might be worth getting it?

slightly nasty thing here will be change of memdev=3D%s to devname=3D%s or
similar.  Meh. It's a TP_printk() I'm not sure anyone will care.
Need to be careful with the tracepoint itself though and the rasdaemon
etc handling.
https://github.com/mchehab/rasdaemon/blob/master/ras-cxl-handler.c#L351
We may have to just add another field.

>=20
> >> -	}
> >>  }
> >> =20
> >>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> >> @@ -702,8 +706,10 @@ static bool __cxl_handle_ras(struct device *dev, =
void __iomem *ras_base)
> >>  	u32 status;
> >>  	u32 fe;
> >> =20
> >> -	if (!ras_base)
> >> +	if (!ras_base) {
> >> +		dev_warn_once(dev, "CXL RAS register block is not mapped"); =20
> > Is this a "never can happen" print? It seems like an oversight in an
> > upper layer to get this far down error reporting without the registers
> > mapped.
> >
> > Like maybe this is a bug in a driver that should crash, or the driver
> > should not be registering broken error handlers? =20
> Correct. The error handler assignment and enablement is gated by RAS mapp=
ing
> in cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
>=20
> Terry
> =A0=A0=A0=A0=A0=A0=A0
>=20
>=20
>=20
>=20


