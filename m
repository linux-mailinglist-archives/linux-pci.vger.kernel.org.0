Return-Path: <linux-pci+bounces-28335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA262AC2741
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 18:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0720C3BF56B
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 16:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D12951CE;
	Fri, 23 May 2025 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLMKIQgl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00FF1A0BF3;
	Fri, 23 May 2025 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016767; cv=none; b=tgqB25/Ll+9FRlKMxmBIGYAsp9P6nQnf3XJ+CfZUABnB+E3mIJn5B/gz/ypxJySo2/LJmAF/r9gyPpzSEwkMwWJu4jyUkznRXKTsPLHjUapY5O2DuACp2dNHcyqz2uU3yR+qIWtzC6Klkyu+rMRZUaxt3iJutNWOXgC3kk8NQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016767; c=relaxed/simple;
	bh=stvsu4xByc6n2n97XoQi+HIP09rpdP6ynB7YbbNj4KI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NMJM7CwH2DJIgbGIyGbEj5Niq7BT/0EC7ueUHpv+mHfsXp/hNZMZ6pDx9iWemYt3B9nLEWnBoLSK3mFC68HLXh6KcNLf97AZOf1QYFXlpcEqS7PVA3ChWKGxMIGq7xXhSUEhc3JH3K9lL9Ufo8AGuHjWWqRmHUFlnbVmVOKVZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLMKIQgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA36C4CEE9;
	Fri, 23 May 2025 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748016765;
	bh=stvsu4xByc6n2n97XoQi+HIP09rpdP6ynB7YbbNj4KI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gLMKIQglZVHVJrIBT9fuUVoEk86gspRrdu0MSmpWv4I37u4mbh7bM8U2FW2ASJWm0
	 HlIOeJvO4pZYGWJuJTnHz2PDV8OA/gJTLwYNKILEdQlX+bk5xR1FEJyNmY0EA6VKH4
	 HCQNhmtcMFAyGAN5/ymkOF+c94t0ZjngYAfYSCF6GmhvElNxa5t5IH8hmvHXlIlJ4m
	 TPsZdJYlCtR2X3tZL3w8BkiBiwBaeNbrUZSwFNNTtyHlYQ/7iZieQLMwdw6+IOg2CL
	 xSA8Jnjrim//zklWRD/FijrAmNqWRBlJbsq9QFcfyZ9qpt5aYozEULjAbgbSxzXBx7
	 WPrGOeLcX/jfw==
Date: Fri, 23 May 2025 11:12:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v8 16/20] PCI/AER: Convert aer_get_device_error_info(),
 aer_print_error() to index
Message-ID: <20250523161243.GA1559290@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7e7a308-713f-d89b-cccd-8f397e097bae@linux.intel.com>

On Fri, May 23, 2025 at 02:13:52PM +0300, Ilpo Järvinen wrote:
> On Thu, 22 May 2025, Bjorn Helgaas wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Previously aer_get_device_error_info() and aer_print_error() took a pointer
> > to struct aer_err_info and a pointer to a pci_dev.  Typically the pci_dev
> > was one of the elements of the aer_err_info.dev[] array (DPC was an
> > exception, where the dev[] array was unused).

> > -void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> > +void aer_print_error(struct aer_err_info *info, int i)
> >  {
> > -	int layer, agent;
> > -	int id = pci_dev_id(dev);
> > +	struct pci_dev *dev;
> > +	int layer, agent, id;
> >  	const char *level = info->level;
> >  
> > +	if (i >= AER_MAX_MULTI_ERR_DEVICES)
> > +		return;
> 
> Are these OoB checks actually indication of a logic error in the caller 
> side which would perhaps warrant using
> 	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
> ?

Good idea, thanks!  I hope we can someday get rid of this info->dev[]
array and the headaches associated with it.

