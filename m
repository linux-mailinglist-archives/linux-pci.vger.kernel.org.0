Return-Path: <linux-pci+bounces-18522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D499F35DD
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11C9162A31
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE4113B2AF;
	Mon, 16 Dec 2024 16:23:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA8200A0;
	Mon, 16 Dec 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366191; cv=none; b=RabXquD/ueNh1wNDZpuPQmT2df8p2PwsAn//xjSx4wQHfMVz9YNy9GwF4WGBd4qsUl4xXyrvjZF95ccOfmcQEWe5D1uoapLahXWU/ASMz0qI870RbT3kR5ETkDb07raTOz1Tk6uZDWxgviPtQ8YBaIJooK2gBgfDvMNQJ1UFJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366191; c=relaxed/simple;
	bh=IxCVw9mk4aQexmPDAYTgCJ9f+CcSmAxxe7YuRE9OwQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsBHJ+zA+HgW+zqgASlGLRHBzl6rpm4hhmi0sVRhmBHL62LmNLZfXVrWRnCp+xE47v8Rf2BPkeewdQA9C2w0D79JvHIE0QL5XhWhAWMrMWbJc+uN5WKRyrvrLN9F2HlgpKtHM5Nl+NcrL8g2/9lHg6p0Wwp+P4ZSlXh68jNj9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B958768C4E; Mon, 16 Dec 2024 17:23:03 +0100 (CET)
Date: Mon, 16 Dec 2024 17:23:03 +0100
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
Message-ID: <20241216162303.GA26434@lst.de>
References: <20241205232900.GA3072557@bhelgaas> <20241209143821.m4dahsaqeydluyf3@thinkpad> <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net> <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com> <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com> <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
> We need a PM core API that tells the device drivers when it is safe to powerdown
> the devices. The usecase here is with PCIe based NVMe devices but the problem is
> applicable to other devices as well.

Maybe I'm misunderstanding things, but I think the important part is
to indicate when a suspend actually MUST put the device into D3.  Because
doing that should always be safe, but not always optimal.


