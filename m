Return-Path: <linux-pci+bounces-36160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1188B57E67
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 16:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4717A1894F6B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084E52F998B;
	Mon, 15 Sep 2025 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dONxxnm5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CFC221726;
	Mon, 15 Sep 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945275; cv=none; b=a69REpmnzz2eab0oVOn+6rSNBdJyjfgxlb/qIg5UCOc2mLf7fwykQsf1Bw6BkzCePWUsPXQDOV+RCqReoUArR1m3S6C+v3H4BR4h+l6KQ6A7nVY+2ZCIznX7O2aX7v8BP2ZVB3IRtzyUg+mDA+4WSuguSxNz4wdPVOWcP8UwOzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945275; c=relaxed/simple;
	bh=VrFwXhOHdy+zl9ovJ+7hv5z6W0WKS/altUCPkdutIak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0pmLAS3sV+DVAckJiGLk1npr/bjm0egN9ihZMci38xjvuxIijwjL1aiXr94nb5cv0ACOVx6b8zzwL2N+/cDrlx/qVEdW/m6V22BoM5RJNUCxvURMZLRG+NgCFWt2NsgrIwSG1pFd/HNQl2ngLD/W7a2eRr3gTGh+wIONN5ZoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dONxxnm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BE5C4CEF1;
	Mon, 15 Sep 2025 14:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757945275;
	bh=VrFwXhOHdy+zl9ovJ+7hv5z6W0WKS/altUCPkdutIak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dONxxnm5mwP1eiMfYo4uecgpV50A89DnH1OvLhBQ5OrOgW2mTKhi2pYbGlr3WJj+U
	 BLjiPaaLhCTjx/0rQIYZluP4A3OjFPWzeHwWPLB0f/kRnBTLEXl1YcXYqDWgTcU2xy
	 Jywh/klogP5pZD0b0pjcxIpTFsi793ZLfwE99Hn4nti99NQDy+Hw/H1RHBcPX5Ko2V
	 dz07xAROKT0KEE5Ja60xCoeaDbn/RI7MmOhlGXju4zcpEc+5Cq1dw5FxOz5+DzOGCS
	 pPxKez9K+3wuEpUs04qp+b8utjhZ+PdHH46mh36jANhhNgk1gIWMdlMNsHi1rBOrtn
	 I7asbRyNsTS4w==
Date: Mon, 15 Sep 2025 19:37:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: daire.mcnamara@microchip.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xichao Zhao <zhao.xichao@vivo.com>
Subject: Re: [External] : Re: [PATCH] PCI: plda: Remove the use of
 dev_err_probe()
Message-ID: <7vtlzppunpkrzwpdfplyzcm53fpxik335wtng7ethfjyvu4tph@df5xusqn25it>
References: <20250820085200.395578-1-zhao.xichao@vivo.com>
 <cl52jts26ulfcanbzz42w35g3bcjlwfhteph2oze4drveajzg3@a4kq3cxfzn2l>
 <cf18193a-5a49-4e0c-b07a-a4f705fc5c8c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf18193a-5a49-4e0c-b07a-a4f705fc5c8c@oracle.com>

On Mon, Sep 15, 2025 at 06:55:29PM GMT, ALOK TIWARI wrote:
> Hi Mani,
> 
> On 9/8/2025 3:43 PM, Manivannan Sadhasivam wrote:
> > On Wed, Aug 20, 2025 at 04:52:00PM GMT, Xichao Zhao wrote:
> > > The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> > > Therefore, remove the useless call to dev_err_probe(), and just
> > > return the value instead.
> > > 
> > 
> > Change is fine as it is. But I think devm_pci_alloc_host_bridge() should return
> > the actual error pointer instead of NULL and let the callers guess the errno.
> > 
> > Callers are using both -ENOMEM and -ENODEV, both of then will mask the actual
> > errno that caused the failure.
> > 
> > Cleanup task for someone interested :)
> > 
> > - Mani
> 
> Did you really intend to do that,

No, I don't have bandwidth right now.

> Should that be an RFC (for cleanup task) patch ?
> 

No need of RFC.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

