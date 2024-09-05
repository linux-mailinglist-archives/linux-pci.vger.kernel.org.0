Return-Path: <linux-pci+bounces-12849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2B096DFF7
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 18:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF02D1C230F9
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9477E19EEB0;
	Thu,  5 Sep 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkESTD/C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6411A19DF4F;
	Thu,  5 Sep 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554490; cv=none; b=i6IFwEjNW1qF2KdrW8t3Sd/jYtMxcBHbJQFSp/MxmyWOt6Ps+Pa606DLHP/crS+clj7/DXQSVrZyn0un2DwEde0rnr/gT+ZtS8HGuwjS6kHvnoLJiyTabRacfSIT0uTkoqh3qqnjELHP1583NcP6ap8j8ndPo2LCguDJ9dsm9gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554490; c=relaxed/simple;
	bh=t81NYhEdgyeGvQV8hXjxb4ycQfRyFlKdKW21pIiInew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HuP62XDFxYVO2oZOVCAWOKMdREFI99jnZN5E9Bja/DxdW+J3E3mhQDt1IrN9ZEMzMmUv7YuwrA7xAG6ubdaVtDeYmU6AyxBFeuqrhr29TJXUH2NGOMpWIdnk2QlDLzLYSKfkswGTVpQZhU6Dua3l/UWjal2OSq2hTxUILbKCquw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkESTD/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AFFC4CEC3;
	Thu,  5 Sep 2024 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725554489;
	bh=t81NYhEdgyeGvQV8hXjxb4ycQfRyFlKdKW21pIiInew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IkESTD/CsIlgw1ao2GOpqDx/htfJLjnYtVBmVpX5Flh/zO2e6iP32Ta6a0/La0PMy
	 mDQeTXhaXVXtvk+4AK8n9UZ/7QbQLH8K2sXrhwaMxl36EYUNBUr6xrT6olaQ2z8piZ
	 +g2IpnZSHVAKV3hxyxBGVu2nTJn4sbkivWE+goUl0YCelK9NT6W6YHPJFVtln6iJYL
	 ELZ2dhy2LqEgsV0UIHKe7aF7rZvdSF2aLv23aezagM2n5wxsqRjxVPmQx9EWv+Y98Z
	 MjOQhKQDXYB9hrIoBTu80ZykEhDdmJRg1Fpg4/8d7JtsKICQnrM+2+XWeomIByT4MQ
	 gNxWEZYMncWlA==
Date: Thu, 5 Sep 2024 11:41:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V4 02/12] PCI: Add TPH related register definition
Message-ID: <20240905164128.GA391042@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91a05b5b-a642-4cef-9c81-cba246435aa9@amd.com>

On Thu, Sep 05, 2024 at 10:08:33AM -0500, Wei Huang wrote:
> On 9/4/24 14:52, Bjorn Helgaas wrote:
> >> -#define PCI_TPH_CAP_ST_MASK	0x07FF0000	/* ST table mask */
> >> -#define PCI_TPH_CAP_ST_SHIFT	16	/* ST table shift */
> >> -#define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
> >> +#define  PCI_TPH_CAP_NO_ST	0x00000001 /* No ST Mode Supported */
> >> +#define  PCI_TPH_CAP_INT_VEC	0x00000002 /* Interrupt Vector Mode Supported */
> >> +#define  PCI_TPH_CAP_DEV_SPEC	0x00000004 /* Device Specific Mode Supported */
> > 
> > I think these modes should all include "ST" to clearly delineate
> > Steering Tags from the Processing Hints.  E.g.,
> > 
> >   PCI_TPH_CAP_ST_NO_ST       or maybe PCI_TPH_CAP_ST_NONE
> 
> Can I keep "NO_ST" instead of switching over to "ST_NONE"? First, it
> matches with PCIe spec. Secondly, IMO "ST_NONE" implies no ST support at
> all.

Sure.  Does PCI_TPH_CAP_ST_NO_ST work for you?  That follows the same
PCI_TPH_CAP_ST_* pattern as below.

> >   PCI_TPH_CAP_ST_INT_VEC
> >   PCI_TPH_CAP_ST_DEV_SPEC
> 
> Will change

> >> +#define  PCI_TPH_CAP_ST_MASK	0x07FF0000 /* ST Table Size */
> >> +#define  PCI_TPH_CAP_ST_SHIFT	16	/* ST Table Size shift */
> >> +#define PCI_TPH_BASE_SIZEOF	0xc	/* Size with no ST table */
> >> +
> >> +#define PCI_TPH_CTRL		8	/* control register */
> >> +#define  PCI_TPH_CTRL_MODE_SEL_MASK	0x00000007 /* ST Mode Select */
> >> +#define   PCI_TPH_NO_ST_MODE		0x0 /* No ST Mode */
> >> +#define   PCI_TPH_INT_VEC_MODE		0x1 /* Interrupt Vector Mode */
> >> +#define   PCI_TPH_DEV_SPEC_MODE		0x2 /* Device Specific Mode */
> > 
> > These are also internal, but they're new and I think they should also
> > include "ST" to match the CAP #defines.
> > 
> > Even better, maybe we only add these and use them for both CAP and
> > CTRL since they're defined with identical values.
> 
> Can you elaborate here? In CTRL register, "ST Mode Select" is defined as
> a 2-bit field. The possible values are 0, 1, 2. But in CAP register, the
> modes are individual bit masked. So I cannot use CTRL definitions in CAP
> register directly unless I do shifting.

Oops, sorry, I thought they were the same values, but they're not, so
ignore this comment.

