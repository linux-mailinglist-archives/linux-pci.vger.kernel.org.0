Return-Path: <linux-pci+bounces-43201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD03ACC8890
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A149631532B7
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 15:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B81934886F;
	Wed, 17 Dec 2025 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ordEiJjJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3833DEDD
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984797; cv=none; b=dSNAJjTI6PP8kolA7WmeTqO8VF4Tms8TXHIt8lMR7zKSrPy/dogMifHXA7RsXDlKJNMoX+wxJEdpaIz4Mw9mWeBL1Bkm89Azx39ulTAaShyK/rcqakXjHngoKzDFWKjwu51XwyrIXDvF/LFTVeg1X/bpztLCq9GNEVzLN+7iv3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984797; c=relaxed/simple;
	bh=w09mEle/83MrqdWuYBx70gmLmKQyKlIHpYyvZMInlts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAlbXpa1khjl2svMHKZ+uFHm7FLHDzUnyA2Y386f8HDXeoAazOfzvANlBfiTj4IeC9uMVUwP1HIKW7yrEsbPhN6mUDgNGIagvsRMaazBBfyNAltYbX1ZYYLi7k0EsnHHSUUghOlkUmK0cQOGjZ6q1BGE85kdf4MeIbyMiAh2EKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ordEiJjJ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8888a444300so45652496d6.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 07:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1765984794; x=1766589594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxrhj48Q2FAUnhlUyBprvMI5hH+9ez7d9ool74khOYc=;
        b=ordEiJjJoYbgJ2voN2AXY5IGFRQnvCAmUA99nTQyhdR587kZxbApDaQt/lI8yRHE9z
         7thSRea9GEtC0WKdA6gD3N8PyGJZKG5+Vc2QPLIXHXTK+8uH8z++SQPGQc0uGs6eakax
         ltBOFdQoAsoBERcw06QFKKETNAwn9b0K4Gw6C8YAJHfNIrm43lUZOspvyoccHv+yRlbv
         J7vgQgJUMTaFALcWff3AR8rXDLwbk6npZ5kDpngxYvK7I/MGyl8K7NPnwPL+dMsZV+5a
         TBbx1YygeFYwOBQ7sOze4TiCQj9oATNod0KfIGFVpJUSMdSa2ly4nTAEWcD65ObBVWPJ
         KFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765984794; x=1766589594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxrhj48Q2FAUnhlUyBprvMI5hH+9ez7d9ool74khOYc=;
        b=Ilvt3NT7ashByNknWveRqBwii/oVCw/+xQ5X811RBV4OJw7lKBrvL2mm9PT1JuhIAM
         sRREZV936eNv1cvNJGlamyr6wTCX/vY19ITtBV81VMX83J3S3GuxQnfqPtnYpSvaB6Y2
         5MBbjQP3DpP1jVJOLEi2LWmP5c4lACjfkdFIscKsnnSn+aOexaw37HOTNcTBdgCcIojZ
         qxn6o+nnDCoTlLh0+tJW6SlifBwsHZZ3Y2tbOe3CmM34XhzwBVHcofb9vBj2LlkqslmY
         A4g/AIdJ1rImNlDpjStMQgqO83LoUgAyQzsYzUtwge1AGA0OWnBTAKwx/RLRuhYuHpNy
         J3bA==
X-Forwarded-Encrypted: i=1; AJvYcCVSp7Uim/kc3tQYTgHOLlCUQYTM/H8FBvpFtBwaxVXXM6W+B2pMq1toBj7bvSXAPwVL/Hc94of3RV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzenkx0nbMZEmVheW8tqWgBCpZuo+pN2tMdouQua91zwogKcel8
	Y9kKhCLsiMXq0iD9tujPaxD3/cZWN4MUYY10ItMqmygudLKizz+QvD8wpN75akzqqFiJG8pSKkC
	jIPtz
X-Gm-Gg: AY/fxX6Xk2Hdlgm4hpsnaB0VAJ/b82xlP27VfyGkpr3/OLZnYRS0j2YEtYMmmQ4wcfV
	eCRwDzOC3xOuN9G6XgBOAUigcdzmCfADNkB6zzdgSvZY5OsJE5ES8oNQ0dy5mRImGFvYJCL8/R9
	o9C55XGEBkl6rq5SFhK/u+Ag07fYNl72jWEuvlAwE7ruEoDdeE2rGyyJrFLzHjUW0Km+NmitBip
	7MXMkFgRCvCC81UONLjx41pZ10mMo4CL1zLQA7va6FAkPUtddqPjGOuzEJD37jeZX/g7bnuue50
	sDMURjWfi9lZxpO6fd0SaAgCf5BsZUIbSQaH2S2UqMkJTXZHE8XhyrtzFG13YgSaoa87bxFaiVR
	xTLy/Q3VMS4KQ7BmIOj17vyxVmTUQd7lvJM4ZHTEJ528V5YSkQGzvmEzF8tyJKN2cjPm5iHhrKg
	Wa3dqhb/9mT45grFPfJs9dTYw6rZLFYvraDAQRWzAYLb/mtH8+r6cO7sco
X-Google-Smtp-Source: AGHT+IEeo4DfupIp4K/iDP3a2ivWiR3/Wwq/tP1+vTPnDZ7ZmGlvxllQ8uMMWjnMBj8/Zu8fu6Z/FQ==
X-Received: by 2002:a05:6214:4601:b0:88a:2fb5:a085 with SMTP id 6a1803df08f44-88a2fb5a22dmr183537496d6.63.1765984793976;
        Wed, 17 Dec 2025 07:19:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8899e7598c7sm96636706d6.28.2025.12.17.07.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 07:19:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vVtJg-00000000jxk-3jhU;
	Wed, 17 Dec 2025 11:19:52 -0400
Date: Wed, 17 Dec 2025 11:19:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Message-ID: <20251217151952.GG31492@ziepe.ca>
References: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
 <20251202-pci_acs-v2-3-5d2759a71489@oss.qualcomm.com>
 <20251202191533.GI812105@ziepe.ca>
 <4d3asssmv5xkttasl2xl2f6q3l5ki4jxmsrbyy6hvrd7djgsnj@y7drlazpwzi3>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3asssmv5xkttasl2xl2f6q3l5ki4jxmsrbyy6hvrd7djgsnj@y7drlazpwzi3>

On Tue, Dec 09, 2025 at 08:20:39PM +0900, Manivannan Sadhasivam wrote:
> On Tue, Dec 02, 2025 at 03:15:33PM -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 02, 2025 at 07:52:50PM +0530, Manivannan Sadhasivam wrote:
> > > @@ -544,6 +544,7 @@ struct pci_dev {
> > >  #endif
> > >  	u16		acs_cap;	/* ACS Capability offset */
> > >  	u16		acs_capabilities; /* ACS Capabilities */
> > > +	u16		acs_broken_cap; /* Broken ACS Capabilities */
> > 
> > Why do we need this? Have the quirk function accep tthe
> > acs_capabilities from the register and return the value to program
> > into struct pci_dev ?
> > 
> 
> We dont have any quirk levels between pci_acs_init() and pci_acs_enable() that
> will allow us to modify pci_dev::acs_capabilities in the quirk function. Hence,
> I came up with one more member to pass the broken caps.

Call the quirk function directly from the ACS path? We have things
like that already for ACS?

Jason

