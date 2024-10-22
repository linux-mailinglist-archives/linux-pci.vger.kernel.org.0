Return-Path: <linux-pci+bounces-15021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2A79AB359
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 18:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36A61C20CEE
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 16:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDEB1A2C0B;
	Tue, 22 Oct 2024 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuLhUTfY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAD919AD93;
	Tue, 22 Oct 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613073; cv=none; b=hW5iiKmpR4hgv33hRjRpIuzEQAYl3DDEa6YR+jlS+fUl+ql3mK0zfQ3Rl9Ldgj/bXT+ORhlwbg4enibrw/0eXyxAiMAoWgLsWJj1hLEsadLGojksURbNFmJ2Tui9IcjKrGHsVVYXfbBld8+oKlOS7np7p4jNKvUU9E/1NG561k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613073; c=relaxed/simple;
	bh=olmWF5ywJz29Bov1x+Xd+EIZX6ic0BwA5ldNmsz55j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlL6Y4Yjkat9m9KO2oosXl6Ad83kbMrUgJswQSniFGX229E2HvO9W8kOyagJEAhxbb7CqjimPclMi5vrpyUxgZRn4CgWbB+6W8FxSCji+LgUMihMRLpa6mjGj5CW7sAyltFSmmDgMmmxL3/71HzshWK46xvfrBiMya2osN0G6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuLhUTfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC0CC4CEF4;
	Tue, 22 Oct 2024 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729613072;
	bh=olmWF5ywJz29Bov1x+Xd+EIZX6ic0BwA5ldNmsz55j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuLhUTfYCpQtK1uFSmv1kDc1PG5frbaXg1t7RKigUlgUseMHxy1qmB7h/I+feQLre
	 XA/Az+JitvhSziC3SZs+eYc2v63V0dCDTpLAcb1k5/Kwac8xxez6SdRUWA5kTyAd82
	 xIOR00PszmAxk1CUrefNASAWKQnEawS+e/ILtjF5eEzat8du7/ipzNVZ7YzCpL6CM2
	 lID8mvXZAN46mxkqolGd9/CR9dX49VHmcAoabQ/vCS2IXr+N6ZDujpgsF6wD0DlnDp
	 yatMT9r9kJfb09ME5046mJouxmV8yxTOHhakvaMQMFeoflf/TJg7EGNfS5gbfgy+rN
	 6mT+gufocebpg==
Date: Tue, 22 Oct 2024 17:04:28 +0100
From: Simon Horman <horms@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/2] PCI: Add
 PCI_VDEVICE_SUB helper macro
Message-ID: <20241022160428.GA402847@kernel.org>
References: <20241021144654.5453-1-piotr.kwapulinski@intel.com>
 <20241022153011.GA879691@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022153011.GA879691@bhelgaas>

On Tue, Oct 22, 2024 at 10:30:11AM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 21, 2024 at 04:46:54PM +0200, Piotr Kwapulinski wrote:
> > PCI_VDEVICE_SUB generates the pci_device_id struct layout for
> > the specific PCI device/subdevice. Private data may follow the
> > output.
> > 
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> 
> This looks OK to me but needs to be included in a series that uses it.
> I looked this message up on lore but can't find the 2/2 patch that
> presumably uses it.
> 
> If 2/2 uses this,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Hi Bjorn,

The threading of this patch-set does seem somehow broken.
But, FWIIW, I believe that patch 2/2 is here:

- [PATCH iwl-next v2 2/2] ixgbevf: Add support for Intel(R) E610 device
  https://lore.kernel.org/netdev/20241021144841.5476-1-piotr.kwapulinski@intel.com/

