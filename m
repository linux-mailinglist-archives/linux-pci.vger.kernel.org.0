Return-Path: <linux-pci+bounces-8846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D8F908FEA
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908F5B28F4A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626B180A76;
	Fri, 14 Jun 2024 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="encO+XLL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0491802BF;
	Fri, 14 Jun 2024 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381685; cv=none; b=IpD8Tv/kzVg4DU7yj3L/WnKIIrwgTAWDWHJSS8Raj5T0ZVCbFwHexx3KAycFkrW0i/FZw14cQNPYvC37CLr9hst1cCkKUodEVc4fsG4Nmlb8ipkcrwEf6wyMEnZVb8SYeAUgGhLOGF0eNxoGJznbOkgRHfzHOmx+wfbkCNDZ/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381685; c=relaxed/simple;
	bh=6/hK32YyxB/oulfz7g+LC1o7De7LeZULQu3LvuNUbpA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mOAkbbAHTHnOQ5mNreM2Ai9R7aYD28JRi8fxyFdRUGm7TG5F01H58rRFL4o/ukIprEpz1EqA/LwzI9qzSQJf6vQFRiMo9kxuKTA0pq2RFPLr328rXb/x4VSN3GHZXKEJoQE4OJpDalNJ/563JFijYu/NUeXq9Frr1m88Wlg1+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=encO+XLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D12C2BD10;
	Fri, 14 Jun 2024 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718381685;
	bh=6/hK32YyxB/oulfz7g+LC1o7De7LeZULQu3LvuNUbpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=encO+XLLfhclLh17ucfRA+1G9aZik3WtQrNyy4rlKnHJu4hNRHt4R43pIB5q86mHn
	 6YmT4CewVfuozNLkvqBo1uinKkkObS+JYNQvYZq+sjtQWW7QR+f1sbZcXCXXUqygM+
	 3vapXlNKDHrMWWyDRx+ogl/wc5ZpYMAt5lPYLAmvvnwJE5BhZN0rARQZvm2+H1pmOl
	 Zp5D5IqmLygidHzHDYSuOeQl5JqXu6Vs4wtV5AtqScgYEnqmGmS/fpGqlktvgJ4zOi
	 I9nuLYjzcIVwJHDH6s5PAz98cIgtmygUQIkUPEbvPhvjrWhhuPSn0qiIvjBQ9Fkbdn
	 /VFthmuytJ4RQ==
Date: Fri, 14 Jun 2024 11:14:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 10/13] PCI: Give pci_intx() its own devres callback
Message-ID: <20240614161443.GA1115997@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d38858130e129fd3568e97d466a4b905e864f8f.camel@redhat.com>

On Fri, Jun 14, 2024 at 10:09:46AM +0200, Philipp Stanner wrote:
> On Thu, 2024-06-13 at 16:06 -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 13, 2024 at 01:50:23PM +0200, Philipp Stanner wrote:
> > > pci_intx() is one of the functions that have "hybrid mode" (i.e.,
> > > sometimes managed, sometimes not). Providing a separate pcim_intx()
> > > function with its own device resource and cleanup callback allows
> > > for
> > > removing further large parts of the legacy PCI devres
> > > implementation.
> > > 
> > > As in the region-request-functions, pci_intx() has to call into its
> > > managed counterpart for backwards compatibility.
> > > 
> > > As pci_intx() is an outdated function, pcim_intx() shall not be
> > > made
> > > visible to drivers via a public API.
> > 
> > What makes pci_intx() outdated?  If it's outdated, we should mention
> > why and what the 30+ callers (including a couple in drivers/pci/)
> > should use instead.
> 
> That is 100% based on Andy Shevchenko's (+CC) statement back from
> January 2024 a.D. [1]
> 
> Apparently INTx is "old IRQ management" and should be done through
> pci_alloc_irq_vectors() nowadays.

Do we have pcim_ support for pci_alloc_irq_vectors()?

> [1] https://lore.kernel.org/all/ZabyY3csP0y-p7lb@surfacebook.localdomain/

