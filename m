Return-Path: <linux-pci+bounces-21438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C86FA35A08
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 10:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF02E3A2A00
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC125221550;
	Fri, 14 Feb 2025 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN/xx1/a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82F021576D
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524698; cv=none; b=mfMZkVvXpPsQ1kCxEFI9398cJK1rq1f2bgZAi7pJnE8Hfg/cUJgNpVh0FWcf4U/Nqjwi3itSCCDQpVgjKfEO2F2I3GX3OokOOjwIwDgUAZ718B3QsXppJEOnLyZ18T/ufePocKOwZ+Jj7dL9uCioO0+1jufFOWymKZLs0wi6zRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524698; c=relaxed/simple;
	bh=JSsNLIQ7zt+yvVfmT/tV86Me2WdXoiS1bzfBSGilYHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUWnWZogmhZgNyKv5HWVeG9tZkZ7/DJpLrXqV7aMOXeRZOphlknK/kpSG98yh2S1rVJNPMQAB6ffDR3G0+jEIk5zGa9gLD2+BqemeWxNHVbo9PTWXkwNBYSNb8oFi/TL8DJFnmDTh4T4Q0NowVnNcRwdJpxg6V7zyEA7euZP+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN/xx1/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2ECC4CED1;
	Fri, 14 Feb 2025 09:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739524698;
	bh=JSsNLIQ7zt+yvVfmT/tV86Me2WdXoiS1bzfBSGilYHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IN/xx1/aNDMrmfxQ5XNI5zPO2ctHsGBrucQCWjH3Fd712dZdvkDWXypTuU3sv+cLh
	 cGJPKYlVBublOoifCQ6TyJNfsuQWzCv/A0NiNc/Cy4oEANnX/KfJ9At71kifq6IXHH
	 B8GLw4ioPb+4n1Kl1PDCaoQYUaSyjevyUtnK+CCltJyb0oT+sGBth1wADrraMjwCjW
	 Cy97dezYQA8X0Wq8tgZRkfbdT9+9/pYCcxX+AAS2k35biSYD4IHHoaJi0d4+0gThxo
	 UBWL9jmmjuw79Fcu7MQMsU0gg/2UJe16ZP+0vInPXLmYcxVUMe81gSrtMKBl1G1dax
	 uEWib/d4OKPMw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tirq7-000000006Wj-11PT;
	Fri, 14 Feb 2025 10:18:27 +0100
Date: Fri, 14 Feb 2025 10:18:27 +0100
From: Johan Hovold <johan@kernel.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Joao.Pinto@synopsys.com
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <Z68KYxSniCxdMMAg@hovoldconsulting.com>
References: <20240130122906.GE83288@thinkpad>
 <Zbkvg92pb-bqEwy2@google.com>
 <20240130183626.GE4218@thinkpad>
 <ZcC_xMhKdpK2G_AS@google.com>
 <20240206171043.GE8333@thinkpad>
 <ZdTikV__wg67dtn5@google.com>
 <20240228172951.GB21858@thinkpad>
 <Zeha9dCwyXH7C35j@google.com>
 <20240310135140.GF3390@thinkpad>
 <Z68JlygEqQBSDWPA@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z68JlygEqQBSDWPA@google.com>

On Fri, Feb 14, 2025 at 02:45:03PM +0530, Ajay Agarwal wrote:

> Restarting this discussion for skipping the 1 sec of wait time if a
> certain platform does not necessarily wish or expect to bring the link
> up during probe time. I discussed with William and we think that a
> module parameter can be added which if true, would lead to the skipping
> of the wait time. By default, this parameter would be false, thereby
> ensuring that the current behaviour to wait for the link is maintained.
> 
> Please let me know if this is worth exploring.

No, module parameters are a thing of the past (except possibly in vendor
kernels). The default behaviour should just work.

Johan

