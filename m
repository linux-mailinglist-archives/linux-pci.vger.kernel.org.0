Return-Path: <linux-pci+bounces-4549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE438730DE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 09:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB122282566
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 08:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B1E433B9;
	Wed,  6 Mar 2024 08:37:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25842E641;
	Wed,  6 Mar 2024 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714236; cv=none; b=S3/8jVErCVDmFY1gHAasRuj+UOrr49D0uZULcVks+nStnReajggxMGX2EdYHJyoModEhDlnoiqjJ08vKDCupzIfHs08Qr/uOWH1qrDBlT4ihEgbzUJxyyBWC6JiGrc7VbmC0TxJMjtLceh39iud7tmNhOArTf56bm+ho3k5ZEi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714236; c=relaxed/simple;
	bh=pVkIVjusGyr1EkP89Dyn+PH2VQQIhsIQuXVHkrAagPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/9mlLKngE8jg3n7/FkAgXU+uVKM0/gZscFO4rzkyMKTMPOxusLqvS7XtapCwKcapYSIGFngenlkHWq5CEHqdlqFVLwjzhC4wb5qnrgbaER5Tfqgb0QEdg5KAVKv9wKfZ97D3LYX3PvsjelGY10hZerYg0w6DuKTNl+JHVEAOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id B631C2800B1A2;
	Wed,  6 Mar 2024 09:37:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A48EC41192; Wed,  6 Mar 2024 09:37:04 +0100 (CET)
Date: Wed, 6 Mar 2024 09:37:04 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH kernel v2] pci/doe: Support discovery version
Message-ID: <ZegrMMTehDk2e4A8@wunner.de>
References: <20240226033114.3100118-1-aik@amd.com>
 <20240227204116.GA30259@wunner.de>
 <089cddf1-3686-4403-a480-07fddd66ab4b@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089cddf1-3686-4403-a480-07fddd66ab4b@amd.com>

On Tue, Mar 05, 2024 at 05:02:27PM +1100, Alexey Kardashevskiy wrote:
> On 28/2/24 07:41, Lukas Wunner wrote:
> > > +	u32 disver = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER,
> > > +				(capver >= 2) ? 2 : 0);
> > >   	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> > > -				    *index);
> > > +				    *index) | disver;
> > 
> > Hm, why use a separate "disver" variable?  This could be combined
> > into a single statement.
> 
> Less ugly since we want to keep it 80 chars long

I don't quite follow, this stays exactly within 80 chars:

	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
-				    *index);
+				    *index) |
+			 FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER,
+				    (capver >= 2) ? 2 : 0);

And if you replace DISCOVER_VER with VERSION as I've suggested,
it becomes even shorter:

	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
-				    *index);
+				    *index) |
+			 FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_VERSION,
+				    (capver >= 2) ? 2 : 0);

Thanks,

Lukas

