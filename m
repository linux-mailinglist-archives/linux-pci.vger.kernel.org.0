Return-Path: <linux-pci+bounces-19652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C5AA0B3F8
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 11:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8ABC3A4FF0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 10:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1BC1FDA85;
	Mon, 13 Jan 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Q7YsBhbS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4318CC1D
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762644; cv=none; b=EWlBg8bRNqP5tmw4jrRZdRlGhRLa8DZfKQxQhsbUtYPKV1U5/P6t4xSvA3ESE2WLNGNSJBD/oV7H6x8MEKMl/E80qf6on++N2cL1P7NBEE7+1DQPnU5x8j4vquTIoiEOQe1Tv4iCVhKmaBS5JAG4eVgFjQFBOSbCw+h/jW5lxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762644; c=relaxed/simple;
	bh=ZOfgHpa8ypvnRMVqtmC+m7Qff2xgsmf54CGkKpjdoWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWVW26qH0+RI+LodJ0TVLm9fDCxI+h6r8hMup9FUJEzH2rHHTA9qJBUv5j5QiBDkWRvN2tsoAkZlitPZEMWZxQ6PsnHlzGhLcIwCIaxs9CUFqGfIIaOJ0gRoNh9cEqqtLuzyQII1LrmSA+UqHf6dJWKXECwVqI08Fz8+d4peFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Q7YsBhbS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so8263776a12.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 02:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1736762641; x=1737367441; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NAozgVCwe5MTkDq2tRs81RaOUpNYbkuEcwNQ118VObQ=;
        b=Q7YsBhbSuc8KZkQ4Dn7p2GSutbBZaRv/ZqVbUw5Pia4cGlYn9EBIj+oZkekT3QGM34
         crPhq5hlN8aUftGAeP4XkBeTloHK/FDA4ytmRHy6fB9XNTFn/h1LVWnkkPunvzJZCIrV
         C9FdaWk0SYsbeY6Y0cA3AyFvGINP2uT3PTIhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736762641; x=1737367441;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAozgVCwe5MTkDq2tRs81RaOUpNYbkuEcwNQ118VObQ=;
        b=dg1Dvc3P7Y/k97hFGv2sz+/bZMPOeZ/nJLNmnYk4dKqn09qWahyHJ6AIqci3FvfTiz
         47jxl713PM6vZ20DO1/CnsH5RvtpIjkpEIlAsiiu1CIL5HIZXfI7teymVpQtn59mOvEQ
         2okJv1CBJIr8gNtH1FEopY1NM0IkcIteSOfefpgssmi9u4lyOuJVvd5FMZZGyKLYdale
         0cct5mVgbnVSygX+qwdwudmihbyceQz9ARK//Mpvq5hUOznGR8TPlP/xP/qLYr+8X4QG
         zTB84a8VadZT6D0kSvEuJYRYymZZKoKomoKAydQjKAARKF6dJ6GqgIWFtdaOxmzwNtSl
         DbWA==
X-Forwarded-Encrypted: i=1; AJvYcCXUKpK5SVO6EYzMwJj/FQKhNRPNnqBLMyV6FSH+y7W4KdtuPuOMYiBpwhusqNOvBsW4G35gw0sevCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4In07UIWUTFNC8XBef+orgYmzPmBMceYHzUWQaSZ2p9mDLFWy
	B0uj/c+uVVJmXZEzLffFAaiRqEMFVVlP0807Q2k1p4AXfj8kagTVw3lBNGlKqM4=
X-Gm-Gg: ASbGncvAM/yVD/2OEFKNkAt1wTLOeOZcfEZlmOx8r7N9CnOccqMXSReSbB+4u7frQNw
	Ltdnc2jqLsu1qCnlJ/FtX7IhIlD1OOu7b0Kw7fzZKLoJU7DlIQNGrjYRI/daTt3MOOz4rMs3Vhl
	Gz92j0LIySdtet/3rP3hADJl92l2Ca+54GRNX5FanVktyEi8Uj5sCT1Oh0byo09kFlJDnwdELM6
	PQvJHZg1SGPov7GYyBhCf6aIdl8AKPsaVaWW3m1EzrNiqtytz8Yn9Wo14Tcew==
X-Google-Smtp-Source: AGHT+IHN6cLAzIHvJBapqtn9TCnnP24m5RjiZPdKHg1bO2RsIgvurTxekJiYNBk5q8SmCTsIwdMt3A==
X-Received: by 2002:a17:907:60cf:b0:aa6:88f5:5fef with SMTP id a640c23a62f3a-ab2ab6fb426mr1905306566b.32.1736762641198;
        Mon, 13 Jan 2025 02:04:01 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90d9b19sm474988566b.73.2025.01.13.02.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 02:03:59 -0800 (PST)
Date: Mon, 13 Jan 2025 11:03:58 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] vmd: disable MSI remapping bypass under Xen
Message-ID: <Z4TlDhBNn8TMipdB@macbook.local>
References: <20250110140152.27624-3-roger.pau@citrix.com>
 <20250110222525.GA318386@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250110222525.GA318386@bhelgaas>

On Fri, Jan 10, 2025 at 04:25:25PM -0600, Bjorn Helgaas wrote:
> Match historical subject line style for prefix and capitalization:
> 
>   PCI: vmd: Set devices to D0 before enabling PM L1 Substates
>   PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel client SKUs
>   PCI: vmd: Fix indentation issue in vmd_shutdown()
> 
> On Fri, Jan 10, 2025 at 03:01:49PM +0100, Roger Pau Monne wrote:
> > MSI remapping bypass (directly configuring MSI entries for devices on the VMD
> > bus) won't work under Xen, as Xen is not aware of devices in such bus, and
> > hence cannot configure the entries using the pIRQ interface in the PV case, and
> > in the PVH case traps won't be setup for MSI entries for such devices.
> > 
> > Until Xen is aware of devices in the VMD bus prevent the
> > VMD_FEAT_CAN_BYPASS_MSI_REMAP capability from being used when running as any
> > kind of Xen guest.
> 
> Wrap to fit in 75 columns.

Hm, OK, but isn't the limit 80 columns according to the kernel coding
style (Documentation/process/coding-style.rst)?

I don't mind adjusting, but if you are going to ask every submitter to
limit to 75 columns then the coding style document should be updated
to reflect that.

> Can you include a hint about *why* Xen is not aware of devices below
> VMD?  That will help to know whether it's a permanent unfixable
> situation or something that could be done eventually.

Xen would need to be made aware of the devices exposed behind the VMD
bridge, so it can manage them.  For example Xen is the entity that
controls the local APICs, and hence interrupts must be configured by
Xen.  Xen needs knowledge about the devices behind the VMD bridge,
and how to access those devices PCI config space to at least configure
MSI or MSI-X capabilities.  It could possibly be exposed similarly to
how Xen currently deals with ECAM areas.

None of this is present at the moment, could always be added later and
Linux be made aware that the limitation no longer applies.  That would
require changes in both Xen and Linux to propagate the VMD information
into Xen.

> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> >  drivers/pci/controller/vmd.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index 264a180403a0..d9b7510ace29 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -965,6 +965,15 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
> >  	struct vmd_dev *vmd;
> >  	int err;
> >  
> > +	if (xen_domain())
> > +		/*
> > +		 * Xen doesn't have knowledge about devices in the VMD bus.
> 
> Also here.

Would you be OK with something like:

"Xen doesn't have knowledge about devices in the VMD bus because the
config space of devices behind the VMD bridge is not known to Xen, and
hence Xen cannot discover or configure them in any way.

Bypass of MSI remapping won't work in that case as direct write by
Linux to the MSI entries won't result in functional interrupts, as
it's Xen the entity that manages the local APIC and must configure
interrupts."

Thanks, Roger.

