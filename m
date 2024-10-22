Return-Path: <linux-pci+bounces-15041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D739AB79E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 22:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD041F22C8A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 20:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B661CB51C;
	Tue, 22 Oct 2024 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaQ3IJ7c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32BA19C540
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628962; cv=none; b=alBBV5FfgIa/Tu/GvQWGGhYgUP+Q6CIcmwpwN0geL5YteDGUUoeBuglAFpFxa0bvvaxYt7SSuhP+auaQv23LltuooRaQgazz/cXFvWKsxR9/mEHTZjGefDXyuKjcNhuqamss8lV7JOlG6fDha6WZ1zdjt9XEfJShoHex/UDPSIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628962; c=relaxed/simple;
	bh=+xxJk+Geo7RqF4C/eaYzBMxYNQX4wsbgNZ7vmeh7Xgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMK68SlUai3hkaXS7tHpCVu5eJcZnaDMkraF3zoEzU6rLCnzhFp9SQ3vmbOkKbJjurt212YHKqEMXASG44IsaNDXRCzBeJbRFWW5Dy/SKl6gd00zyPjD9R5B7xiQoRGq5tnixANZ9mwv6LNzWs52RBMhDrJ2NvhLV2M3QBobu7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaQ3IJ7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F42C4CEC3;
	Tue, 22 Oct 2024 20:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729628962;
	bh=+xxJk+Geo7RqF4C/eaYzBMxYNQX4wsbgNZ7vmeh7Xgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qaQ3IJ7cRBaX3T39FFXX0tt94RyUfkEn0xAyGa6V7UlHKgk5isQOFyw6BZxWztnFG
	 LyKzDhHsejnf3DTqipYDmrcBByMxhooZJstwPccWuK444iTK6da9KcoeXU+PVJeRlR
	 rBkamPVYcmzakbcm+UNvizRDBf1w1e4OTNo/hZg2R/EkGqmrG+jhCEY4MTiOmqqIuz
	 /jL/DEjGyAcuxFdh+RBxu7VUjmb5aRqZXj1HLmokmV7Ljb4M9Rl/ua2s/vxAoq4FRp
	 5+gBoFnCvWNl2INAtqXK0m4eJyMY3aV2ahGaUJ99U2TfRM7IgUyPt0Ut1dNL8KkP4+
	 YNUx3k306HmUQ==
Date: Tue, 22 Oct 2024 14:29:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv2 2/5] pci: make pci_destroy_dev concurrent safe
Message-ID: <ZxgLH5OqHNktgTkS@kbusch-mbp>
References: <20240827192826.710031-1-kbusch@meta.com>
 <20240827192826.710031-3-kbusch@meta.com>
 <20241003023354.txfw7w4ud247h5va@offworld>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003023354.txfw7w4ud247h5va@offworld>

On Wed, Oct 02, 2024 at 07:34:13PM -0700, Davidlohr Bueso wrote:
> On Tue, 27 Aug 2024, Keith Busch wrote:
> 
> > +static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
> > +{
> > +	return test_and_set_bit(PCI_DEV_REMOVED, &dev->priv_flags);
> > +}
> 
> Same ordering/dependency description observations as mentioned in
> patch 1 (both these cases are fully ordered).

Just rebasing everything so late reply here.

test_and_set_bit already has a memory barrier. It's the "set_bit" that
doesn't, but set_bit is not used for this new flag. This new flag only
indicates the device is being removed, so it's only set once before the
device is deleted. It's never accessed outside this path, and it's
safe compared to looking at the kobj parent.

