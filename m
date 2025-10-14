Return-Path: <linux-pci+bounces-38079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AE9BDAF93
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 20:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EC794E58BC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 18:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D1027979A;
	Tue, 14 Oct 2025 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcbMZCng"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFFF18A956;
	Tue, 14 Oct 2025 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760467896; cv=none; b=YPMoe/yjS988Ytmw604+Stcq67LUbYnjqgmS26yOyw8JcNumD4ss+q0r+DRXaYVd+Z3e+E5hEG+OX6w4AevukAMxy14MjxsbLxpgzC3uY/Tz+wFpETqxslng9bvYxpPlwyMrChOeZi7k8fWFT/czQC8Vs0gT5bDzY+pJZY/8k38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760467896; c=relaxed/simple;
	bh=6W9+dn17q8PcyyIxrsB97A8oP0SfYq9Q/LwPjNYB9HA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BIz6/KkAeeMI7/62Y2dGvuxQRvBsEfEntNYDCUKiptFSvYIjpiMLU7IxDsKF+P6rqMSFL+jrgBIbz4V+pcf6eWWEzd4GslTSv+ahQgaRCNxbI6xolecpfDoVRAJuD9AyCID77aA+4yl53HWjot8eZeoesb0F5KmdS3y/fX0DOYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcbMZCng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A377C4CEE7;
	Tue, 14 Oct 2025 18:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760467895;
	bh=6W9+dn17q8PcyyIxrsB97A8oP0SfYq9Q/LwPjNYB9HA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EcbMZCngfRrA/xLgNse0X1ojCMSb5VC5Pf7eWJWrOBEtGR4pSiO/nM6m441taRqxp
	 6RwwJesb3t0cU0xwdfLpG79hnmGKkcwDq8/1k+25dkILncIB4BFTc/dXyZiF9FVIvf
	 U0PgyZu6rPzKo8G/ftEMpht3oa8gUiuCCNRxXX4NLDA2yk5wkpqjwVCjAJU87f8xgJ
	 jOlHR2DJf84djiHy8+2dUh3KuQUWdCvT7363a7yHmeCGnDBNTu86nIJDahxZ0e9H2I
	 EUf9tKTFoppcXvhmz3vz3Wo5MlDS9JLQhCnQVKzfs+vjzTQgXKkFiGRXSzzopgQ7L+
	 t/CkVozAHmHIg==
Date: Tue, 14 Oct 2025 13:51:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	Christian Zigotzky <info@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	regressions@lists.linux.dev
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251014185134.GA899287@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013210602.GA864364@bhelgaas>

On Mon, Oct 13, 2025 at 04:06:02PM -0500, Bjorn Helgaas wrote:

> #regzbot introduced: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")

#regzbot dup-of: https://github.com/chzigotzky/kernels/issues/17

