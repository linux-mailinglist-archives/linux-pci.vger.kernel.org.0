Return-Path: <linux-pci+bounces-31644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6855EAFBE55
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 00:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743503AE0FC
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 22:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB621BCA0E;
	Mon,  7 Jul 2025 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZVTWftW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482814A06
	for <linux-pci@vger.kernel.org>; Mon,  7 Jul 2025 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751928416; cv=none; b=kUuM4BcObpDx8r2cx5tDlQ53IxTYYoIL6f7BKoCNNjMcH6Un68HfHCdOREdx/Uy+o/Yhhl/a6xu6RWMoPDigk9wLrhZvMUuA2j8w9cbMAyjpEqrU+Z0zG18D7vvFS9XiVy5L9dEx0tsOYTTtZxxnQSE6p+Y9IkrciKbgPIe4Mxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751928416; c=relaxed/simple;
	bh=E8roPP4V9Fba7YYDXx/ryQChlv0B27/BLnTywQz6s1I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fv70bx+AVgUWHksJ7DLQDHEWDv+FRoqk3I/vhX3MDeu2lB9eUmy3uDCMPWPJuuTAF4UFd4IT4SIoTxLWIyqBEAjp7Y1TKFABqrZo6wk1qRKZTPCHyMNoz9L7hvBq7vETjR78tcfAUotvg+NKtA3D7ZrT9REXuDd0T36nrli+qKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZVTWftW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0549C4CEE3;
	Mon,  7 Jul 2025 22:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751928415;
	bh=E8roPP4V9Fba7YYDXx/ryQChlv0B27/BLnTywQz6s1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fZVTWftWyFd/1SRIChJWuo/Q58zuaHjJ5wulfz+tEaPo7wTq6wYVTcvbZJRMQ4+Dn
	 JBpfiA8Ne4kbe2MVAcjXPdHF5csLWACbH8vqizumj/4ob0Lx0h89QENRxARHwthi7f
	 UUFLQ0saI0lhpirOl17zSgRzWgHIAt6poqGyl9vsgU2XaCys990IFYqQlK+YT1UNZu
	 QcIcE7/VfVcZ5M28a9Vpt/E57XsxZJR3mEHRJdIVzK9EM7oW3pLuyHf2OUYS5nMNAN
	 uu66w3/aCpQI3Te0S7kRN0zoe4T7ULlL7gS1zGMSJbb1Q4hdwd7+XtEb1OetCBiYlB
	 7hYLmo0Muxq0g==
Date: Mon, 7 Jul 2025 17:46:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/8] pci/tph: Expose
 pcie_tph_get_st_table_size()
Message-ID: <20250707224654.GA2121477@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707195903.GB592765@unreal>

On Mon, Jul 07, 2025 at 10:59:03PM +0300, Leon Romanovsky wrote:
> On Mon, Jul 07, 2025 at 02:40:49PM -0500, Bjorn Helgaas wrote:
> > On Mon, Jul 07, 2025 at 08:03:01PM +0300, Leon Romanovsky wrote:
> > > From: Yishai Hadas <yishaih@nvidia.com>
> > > 
> > > Expose pcie_tph_get_st_table_size() to be used by drivers as will be
> > > done in the next patch from the series.
> > 
> > This series doesn't actually use pcie_tph_get_st_table_size().
> 
> It is in use in patch [PATCH mlx5-next 3/8] net/mlx5: Add support for device steering tag
> https://lore.kernel.org/all/dc4c7f6ba34e6beaf95a3c4f9c2e122925be97c9.1751907231.git.leon@kernel.org/

Oops, sorry, dunno how I missed that.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

