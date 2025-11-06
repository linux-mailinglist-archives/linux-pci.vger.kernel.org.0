Return-Path: <linux-pci+bounces-40539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E09C3D56A
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 21:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB421889586
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 20:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEE32F39A5;
	Thu,  6 Nov 2025 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5pcNwpW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0C22DCBFC
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460474; cv=none; b=W44ZapD4IofkEorjPHJOuR9of7pNhXCpwsMmH7GisxPh5xW6IJ4gQn66vZVy+6/oijiLhjycR/rPPcZv48cISqoggmUV51KUtCIEt2kaALt6iTYFaLBtZhb1d99Gz+Ymkw/CWM+/5/NIj0lES/XLEJatclRDRPBjdmISItY2QyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460474; c=relaxed/simple;
	bh=SCmJ8Wig2wT976fqMF2JCXIbSD7pBUn+bQrgigLPAZw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KwU2I67sKitcdRm/DNn2wGTCKqgZeEDCAj6Qr8HiqLLX4NdNWqyYytMjl/OVE+1gmxY2Vt4Xqzez6qdeA0zLUU179Myk/LCodNoTOgHo+7EZcZvy27kf0cQ+xQU//n6oyleNNPmnzKpAnYWi7blymKEghLu1hh9QmN5LIq4PVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5pcNwpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139C8C4CEFB;
	Thu,  6 Nov 2025 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762460474;
	bh=SCmJ8Wig2wT976fqMF2JCXIbSD7pBUn+bQrgigLPAZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f5pcNwpWl1HZg4jmRuItWbRzLO0dBqzE9Vn47l1zy4RX5Ie/C0I3KFutNGhXyNmo5
	 CnzmpXM5kOhfC6iNaymqth/zasn8KaiRAvzOZl35h4MHV+BBTmt/i0gfTe4gGXdLI5
	 cqFUDxrVDjj2cA4jipWbZISDXP0059tbua4ejgtCRBv/ihXZ9i9HpWuZVhOBVm8+dm
	 QHRtt+8TxJjvzpc2IMU8eWsyMaOipbW+AP8d0W8s5Q64CRQEQcOGrKIuUMbPDFk6rb
	 EWaM/B1KrpFHFm9BBvIGNaNgEjLkxiyLU2j31C+smrwAUoU3Q0iAxO2eco8/80MzRL
	 v1bsiFlkxCIxA==
Date: Thu, 6 Nov 2025 14:21:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Wu <michael@allwinnertech.com>, Marc Zyngier <maz@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Fwd: PCIe msi bitmap issue by split nr_irqs for 1 by 1
Message-ID: <20251106202112.GA1966401@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <610ad0fd-cc5a-f19d-77de-c565449f1c5e@allwinnertech.com>

[+to Marc, author of 4615fbc3788d ("genirq/irqdomain: Don't try to
free an interrupt that has no mapping");
+cc Thomas]

On Thu, Nov 06, 2025 at 01:29:12PM +0800, Michael Wu wrote:
> Hi Dear linux-pci team,
> 
> I got some msi-irq bitmap issue when using PCIe NVMe SSD during
> resume/suspend.
> 
> First, we know now all the controller driver using "order_base_2()" to find
> the bitmap in alloc/free.
> 
> Then in my case, SSD request for 9 msi-irqs, and 16 bits is occupy in
> bitmap[31:16].
> Eg. msi_bitmap from 00000001 to ffff0001.
> 
> When in suspend, msi-irqs will be free one by one, but not 9 in one time.
> This will cause bitmap cannot fully clear which was requested, bit[24:16]
> will be free, but bit[31:25] was residue.
> Eg. msi_bitmap from ffff0001 to fffe0001(1st) to fffc0001(2nd) to ... to
> fe000001(9th)
> 
> And I found that this "split" operation was push in below commit:
> 4615fbc3788d ("genirq/irqdomain: Don't try to free an interrupt that has no
> mapping")
> 
> After i revert it, everything goes normal.

Thanks for the report, Michael.  Looks like the same issue reported
here:

  https://lore.kernel.org/all/cc224272-15db-968b-46a0-95951e11b23f@huawei.com/
  https://lore.kernel.org/all/20230720122429.4123447-1-zhanjie9@hisilicon.com/

I see a workaround there, but it doesn't look like anything ever made
it upstream.

