Return-Path: <linux-pci+bounces-10806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70F793C9F1
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 22:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045531C21EB0
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D6C13BAE2;
	Thu, 25 Jul 2024 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNGhYjPm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1058222;
	Thu, 25 Jul 2024 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940939; cv=none; b=RwDEqWXHzOKkxiyvnX02pktpjk7AImXWC8gLoritLpaj/0RoO75FtSXGYL8yW8pO2vNpAVj+SAMgby35C0Y6hXj3u3VIZPdiAbJAmchtrlLohzQ4n9lG5C6N8657vChBZHP8kASfH5b9ai4Ikzc1tntVVYxPsbMXTtIzFhZquhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940939; c=relaxed/simple;
	bh=q/ZVXjVJyqULDlY2L9HHIXXTOO2aCFo8z2iw0QdZvFk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DnJuBzCNoH+PlIBkq/h501qZe6SVIbD16U4HJ4OXKoJ4Cp+yPMaJIHDXBBXo2BrGhGruD7jdy1ciAeVpqXd5LkDcT2KmGX3rr06E4f+T/EE7Led0I3Z/GCMvuBjjE6ZpyRGYVaNL8xDS+yTgqZimlicesHGbYaLZIlwPk5p+NT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNGhYjPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBE8C116B1;
	Thu, 25 Jul 2024 20:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721940939;
	bh=q/ZVXjVJyqULDlY2L9HHIXXTOO2aCFo8z2iw0QdZvFk=;
	h=Date:From:To:Subject:In-Reply-To:From;
	b=WNGhYjPmjFIvAT1SwaBYZgJcsw62bVFLXBFg+x8q2lERBtNaSTiui+/tQihI+Opd7
	 cbGaKU4Msb/uGrrz3CqBMswJosEe+z9yCIeWn6Jzd6PSm3Birc3c6B4UdnzoFKMmSd
	 TAVbQ39UCJJ+SP6yfu5sq5YyBCLp2GsGIS+lPEEPwNWXa4tgJcbQK+TYj87PL75D74
	 cxskVvi8m/yF4RwCFMfSWtfAVGMcb6wg8/5HusfF2HluDXMO8UgVd+oJk/ge6cWVON
	 a00y2h9dhYeb3VDHsQ0+jJ5dA+88pSqflp/vhLHiGKifhW+/mxb/XH3xIeVXW0b/26
	 cnmvp2sW8L65w==
Date: Thu, 25 Jul 2024 15:55:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
	Kowshik Jois B S <kowsjois@linux.ibm.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] PCI: Fix crash during pci_dev hot-unplug on pseries
 KVM guest
Message-ID: <20240725205537.GA858788@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p6cs4fxzistpyqkc5bv2sb76inrw7fterocdcu3snnyjpqydbr@thxna6v2umrl>

On Thu, Jul 25, 2024 at 11:15:39PM +0530, Amit Machhiwal wrote:
> ...
> The crash in question is a critical issue that we would want to have
> a fix for soon. And while this is still being figured out, is it
> okay to go with the fix I proposed in the V1 of this patch?

v6.10 has been released already, and it will be a couple months before
the v6.11 release.

It looks like the regression is 407d1a51921e, which appeared in v6.6,
almost a year ago, so it's fairly old.

What target are you thinking about for the V1 patch?  I guess if we
add it as a v6.11 post-merge window fix, it might get backported to
stable kernels before v6.11?  But if the plan is to merge the V1 patch
and then polish it again before v6.11 releases, I'm not sure it's
worth the churn.

Bjorn

