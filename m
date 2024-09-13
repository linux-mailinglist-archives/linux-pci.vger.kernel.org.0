Return-Path: <linux-pci+bounces-13182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0969784C8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 17:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49DB3B27469
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A51153373;
	Fri, 13 Sep 2024 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i10wbSEX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2172EDF60;
	Fri, 13 Sep 2024 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241073; cv=none; b=oHmu/b65PMfNy93WSTqL6o1AFubaCpu+uYV4f9G/wUXgrH67SD+5P6/X7alvfll+c4NjFv49Qfbxz5pW1b3spZJxCtSGbHNLKchZ9eL3ySSQ4gLtzWGtay2KJVx7vnRryeQwtyErew44POkCbJxmNx1AGqrpoVdESk5jRV+FGw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241073; c=relaxed/simple;
	bh=xlpLRV9hViJBcrtkalP94EioikNI5rImcEjIIh9vJeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kepuyt7fZ7UVKz+cC0jB6X6+2pXmiG2+W9I/L+cMSsiqO0r8/SPiw0rM8GUBMRDFDRDTpBlmguf5/B99gFeVw8daoAkJ9l/VOFqEihbZS11kvaohPvi+zxEdCZn+LDNUPHQe0rQXMVKggtNDewLIx/ILrgS/kRrkc/84J07UM+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i10wbSEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF77C4CEC0;
	Fri, 13 Sep 2024 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726241072;
	bh=xlpLRV9hViJBcrtkalP94EioikNI5rImcEjIIh9vJeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i10wbSEXjicEZUx5Q3t5Ko31o/Rmll4l/df1dDvTnAuLmCzz1wPpYXc3xBV0n+b+Q
	 o8JFVG+3OqAoXPG98QGh5K6y9mYYLIKNF70r9PPQTCT9NuXge1HsFkxJmkyVG7+kx4
	 e3K/eS7MCvCIwBTePFYz7RPka4apRYx9aRtyVarQJr2sg+013QPwJvR8pCL0PnB0QQ
	 nQb1L2KNZPOlCNDhCWbQ9QLmmhW2R+zznvLHh45MPtjNy8JhmLJNqETNOPX7PVaJwq
	 FoMYYVTFOPJ4KNWsREtZcg9T4cfmuHp0CkUXXBtxtfHFvW/RKH+EQIavr68RkEiEnK
	 Ydq59DcQXmh3g==
Date: Fri, 13 Sep 2024 09:24:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	jonathan.derrick@linux.dev, acelan.kao@canonical.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kaihengfeng@gmail.com
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
Message-ID: <ZuRZLRFrCjXlrd4w@kbusch-mbp>
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
 <20240903042852.v7ootuenihi5wjpn@thinkpad>
 <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
 <ZtciXnbQJ88hjfDk@kbusch-mbp>
 <CAAd53p4cyOvhkorHBkt227_KKcCoKZJ+SM13n_97fmTTq_HLuQ@mail.gmail.com>
 <20240904062219.x7kft2l3gq4qsojc@thinkpad>
 <CAAd53p5ox-CiNd6nHb4ogL-K2wr+dNYBtRxiw8E6jf7HgLsH-A@mail.gmail.com>
 <20240912104547.00005865@linux.intel.com>
 <CAAd53p698eNQdZqPFHCmpPQ7pkDoyT4_C9ERXJ4X=V_8QFO8pQ@mail.gmail.com>
 <20240913111142.4cgrmirofhhgrbqm@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913111142.4cgrmirofhhgrbqm@thinkpad>

On Fri, Sep 13, 2024 at 04:41:42PM +0530, Manivannan Sadhasivam wrote:
> I'm not able to understand the bug properly. The erratum indicates that the MSI
> from device reaches the VMD before other writes to the registers. So this is an
> ordering issue as MSI takes precedence over other writes from the device.
> 
> So the workaround is to read the device register in the MSI handler to make sure
> the previous writes from the device are flushed. IIUC, once the MSI reaches the
> VMD, it will trigger the IRQ handler in the NVMe driver and in the handler, CQE
> status register is read first up. This flow matches with the workaround
> suggested.
> 
> Is any write being performed to the NVMe device before reading any register in
> the MSI handler? Or the current CQE read is not able to satisfy the workaround?
> Please clarify.

The CQE is not a device register. It exists in host memory, so reading
that from the driver isn't going to flush writes from IO devices.

