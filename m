Return-Path: <linux-pci+bounces-15812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A6A9B9854
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 20:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E44F282EA0
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 19:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADBE1CF5C9;
	Fri,  1 Nov 2024 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ+a0YhH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E151CF5C3
	for <linux-pci@vger.kernel.org>; Fri,  1 Nov 2024 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488877; cv=none; b=tKjU34fxYgANgYJgnqc/lCHGjZdYPFndGWUWvG30KGdv3pjt9bbMhhbH6/O0Yo+0D4g1vzO3KNQuWBrIXovYhdPshTbsX8/GcYXuPJpXgHX0uPcdg23Qo1YaO+KjgY9PvwBo/xOGanJE9kL2Vi+BeygIOMopO3J74Ra8MFgoWeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488877; c=relaxed/simple;
	bh=ywYSlXcpZ0b76L/s1MKRUvmmZICuQ2o8lG0GBqZWsug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKnJXfet4gchH4AGrbk9ztFpSs9jvLRNQONlS+EzQkNXMIroOiYi0wTAbXAnj1VJ0T9G7QgVHV0oe2BcMLSJeh1/7lINFHpeP7hKZivP5knNuJiqBiuepjzKe5WvpG1fUiw9yELB7sKoszIJ4u8xD2T+MLnG9mr3I3JeFFWhaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ+a0YhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD33C4CECD;
	Fri,  1 Nov 2024 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730488876;
	bh=ywYSlXcpZ0b76L/s1MKRUvmmZICuQ2o8lG0GBqZWsug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZ+a0YhHQ2VXKNgftapto8gXASky/FE3VDJNww7BmERZPk0kyxZZ/W3esJ58skc05
	 p82boDJ1R7jATrWwhMWEG+tSMSi+QoQmM+QLQGnIe8BJUWloVHLqawg3uxBfEpiYwW
	 OmZwujO87wF1boNtGRbKFDZ+4mLAzR4kCXCrKQp/R33DCLzoVT0gs33ffrs0G5ny9k
	 C+6rblO5gXgb0tm/xHazHdNMBLd+qcpUFdxYbTNnjCRaJhKzHysC6SXF/t0s39iOmY
	 qEELTf2ZaUURDEkTyphGu2y0jKrPrYX/qtnDWE//qjv3I97M5l8pJFkizq4X1t1WWp
	 ZESoJiQxhO2kA==
Date: Fri, 1 Nov 2024 13:21:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex.williamson@redhat.com,
	ameynarkhede03@gmail.com, raphael.norwitz@nutanix.com
Subject: Re: [PATCHv2 2/2] pci: warn if a running device is unaware of reset
Message-ID: <ZyUqKquBudn3hh5_@kbusch-mbp.dhcp.thefacebook.com>
References: <20241025222755.3756162-1-kbusch@meta.com>
 <20241025222755.3756162-2-kbusch@meta.com>
 <471500804dff90f31320a2a53a48724fffe318b6.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <471500804dff90f31320a2a53a48724fffe318b6.camel@linux.ibm.com>

On Tue, Oct 29, 2024 at 12:27:41PM +0100, Niklas Schnelle wrote:
> For what it's worth on s390 I think the previous proposal of having the
> attribute on the pci_bus would have been better in principle. On s390
> the PCI bus probing is done by firmware and Linux doesn't see a pci_dev
> for bridges but we do create struct pci_bus for example for a PF and
> its child VFs.
> 
> Then again we can't really do a reset on this level, other than
> manually going through the PCI functions and resetting them one by one.
> In fact we may see PCI functions on their own bus while another Linux
> instance (LPAR) sees other functions from that bus. So yeah, I guess
> it's fair not to have this attribute but still wanted to offer these
> thoughts.

This attribute uses the pci_dev bridge control register. If you don't
have the bridge device, I don't think this would be useful, so I guess
you'd have to fallback to resetting individual functions.

It seems people can navigate /sys/bus/pci/devices/ easier than finding a
pci_bus under /sys/devices/, though, so that's a plus for pci_dev.

