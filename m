Return-Path: <linux-pci+bounces-18297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D8F9EEAD6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54473169ED5
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5408E216E3B;
	Thu, 12 Dec 2024 15:14:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A421504F;
	Thu, 12 Dec 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016440; cv=none; b=n5/vzpTfnTVFPJe34xyinG8kncafo+pxq7Sw+DdQiZI3K0rF9b62WPXOo9zcxAcJcp4iW4uUJ8dWYuTLrmyvg34pkHnyKzhnPVGNM1cGuj2DcwZ/dDR4Ej5CTfpDpyrxZQumyD4VLZMRc9z7YSnsZFaH4vzkm030dFP6ugTIU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016440; c=relaxed/simple;
	bh=Ft3aN7Fuvj3eIO2pitlS3DT5i3VatB+kG35YKggl9iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t07nfjORLn21mM3f8w0HgDhl5ORH/dXjDoIZAR95DnFTMF4y2uMisaTH5HXng7qSNxsLVLc5ICyUa4eZJT9Ouw2+9aQnhOlfK8HSmF+fs0Xv9jlGxQtbIO6MLVeW6vxNSLREYgO+N7TOBqYCy8zZgseL5LFNhN+FxQIP/Kn62N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3BF9668D32; Thu, 12 Dec 2024 16:13:54 +0100 (CET)
Date: Thu, 12 Dec 2024 16:13:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241212151354.GA7708@lst.de>
References: <20241205232900.GA3072557@bhelgaas> <20241209143821.m4dahsaqeydluyf3@thinkpad> <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net> <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 12, 2024 at 01:49:15PM +0100, Ulf Hansson wrote:
> Right. This seems to somewhat work for ACPI types of systems, because
> ACPI is controlling the low power state for all the devices. Based on
> the requested system wide low power state, ACPI can then decide to
> call pm_set_suspend_via_firmware() or not.
> 
> Still there is a problem with this for ACPI too.
> 
> How does ACPI know whether it's actually a good idea to keep the NVMe
> storage powered in s2idle (ACPI calls pm_set_suspend_via_firmware()
> only for S2R and S2disk!?)? Especially when my laptop only supports
> s2idle and that's what I will use when I close the lid. In this way,
> the NMVe storage will certainly contribute to draining the battery,
> especially when I won't be using my laptop for a couple of days.
> 
> In my opinion, we need a better approach that is both flexible and
> that dynamically adjusts based upon the use case.

Agreed.  I'd be happy to work with the PM maintainers to do this,
but I don't really know enough about the PM core to drive it
(as the reply from Rafael to my mail makes pretty clear :))


