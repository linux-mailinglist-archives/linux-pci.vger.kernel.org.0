Return-Path: <linux-pci+bounces-38096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83444BDBA5D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 00:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39A474F59EC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 22:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F530DEA3;
	Tue, 14 Oct 2025 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALJ/lsQq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDEF30DEA2;
	Tue, 14 Oct 2025 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480982; cv=none; b=QNrNsqMcPhE6fCF12D42n6JFrT0XnlpNZXhLKF7PUU+QgHzLpl3vJ/ClXHITNiARYZytuxh82L4mZJWHuCr7M8pFU5h2z5bqucuYPMLes6VejbWMvqnCq8yAVvRlkZhSl5NffeoH3K2pWkPoSYRhtLaoJcndvOPUxyjnVdZlOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480982; c=relaxed/simple;
	bh=fczDAyZtv8K84OVARqfM4KVFW127OZ6qLS5n/2jelD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tzrwmTwETqEXqATokcdbzHhYD1zPO07cm/gzA8prRyNDJehQjXU28b9Jcv3aulB3exUeH7paNo7xzUd6pY8LP5xYZvkueze1R5Pid+albtRkh3z1N1NUTmrQmlFYFnqDMOkTpbmbyfot6cbTIklMhM3ZtE/MDa7HFLDlyahld4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALJ/lsQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE3BC4CEE7;
	Tue, 14 Oct 2025 22:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760480982;
	bh=fczDAyZtv8K84OVARqfM4KVFW127OZ6qLS5n/2jelD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ALJ/lsQqPvS1w8tuSVW1Ed4tkZvVql++wrAdpO9Swuz+UMkzijiq3/iM7pvcK1L0b
	 sgKv7F3xEvA5fdwriXMZm4GfkPGOsn2gB1YyefpKNsm3TIwu/AFXlGoL8/H0UUbrea
	 oQY9E2SAI4cR8B5oD55ey5fVbl/2428JoA5Jm0wWMQjAxA2GUAo6N7VXLIl5gfx37D
	 wufVUF+IKM//asOyQnvOnv347aLoQoeCNHBEIvan0tnV8JZwFJhX7PZk7TB6qRXS2H
	 nkA8EqxylWTDf1H1YfB+mB2q0evZXAVeTMHuOj+2dxLXRRK0rBts3FVUmcvTXDbiCu
	 hERPkrLuMFqsA==
Date: Tue, 14 Oct 2025 17:29:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 1/4] of/irq: Add msi-parent check to of_msi_xlate()
Message-ID: <20251014222940.GA913235@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014095845.1310624-2-lpieralisi@kernel.org>

On Tue, Oct 14, 2025 at 11:58:42AM +0200, Lorenzo Pieralisi wrote:
> In some legacy platforms the MSI controller for a PCI host bridge is
> identified by an msi-parent property whose phandle points at an MSI
> controller node with no #msi-cells property, that implicitly means

Looks like you intended to continue the sentence here?

> For such platforms, mapping a device ID and retrieving the MSI controller
> node becomes simply a matter of checking whether in the device hierarchy
> there is an msi-parent property pointing at an MSI controller node with
> such characteristics.
> 
> Add a helper function to of_msi_xlate() to check the msi-parent property in
> addition to msi-map and retrieve the MSI controller node (with a 1:1 ID
> deviceID-IN<->deviceID-OUT  mapping) to provide support for deviceID
> mapping and MSI controller node retrieval for such platforms.

