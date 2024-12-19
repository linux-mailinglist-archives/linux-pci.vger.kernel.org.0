Return-Path: <linux-pci+bounces-18753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7529F74D8
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 07:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25661188FCEE
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 06:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C752165F3;
	Thu, 19 Dec 2024 06:31:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19E7082A;
	Thu, 19 Dec 2024 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734589860; cv=none; b=OoK99amnYhSrFlVecc1e1jGPQbBxxxSGmK1ZUnNENQ5LSyo0ys32aSEnBRxtVNrIPwrVRKeYbnGGk+1m/XZB40xKB4Be1jth+a7BXrmZOwmTDtgDSVRtrrxGSn/XtbEMCYxVt+0uswGQ4wsh+HkTaplBe2VtzEC4BAeJM+etjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734589860; c=relaxed/simple;
	bh=GqC3ZxaESZcWlh4tG4IorqV92rQbhlA8oyZLUfRW77Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djsIuLXYujoC5AP35nO9GGH7pg+evc1hdDPQzvGUFpXv2BsDSM0l0QrPCIBIOtAie8xsOuJbcqNXZ1HMDS0b4B70bP6AnzLBsx9PSV95lSmJfnHh1LHaBI9yhHpHF6Ki3mehth0VZeufGnlL01HuErAojovBaYYRBzX38CbG9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C555B68BFE; Thu, 19 Dec 2024 07:30:52 +0100 (CET)
Date: Thu, 19 Dec 2024 07:30:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241219063052.GA20003@lst.de>
References: <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net> <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com> <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com> <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com> <20241216171108.6ssulem3276rkycb@thinkpad> <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com> <20241216175210.mnc5kp6646sq7vzm@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216175210.mnc5kp6646sq7vzm@thinkpad>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 16, 2024 at 11:22:10PM +0530, Manivannan Sadhasivam wrote:
> > So what technically is the problem?
> > 
> 
> NVMe wear out is the problem.

Btw, it's not just the PE cycles, it's also the sheer time a clean
shutdown can take (or the time for an unclean enable if we don't wait
long enough).


