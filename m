Return-Path: <linux-pci+bounces-11643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3468950AA7
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 18:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7DA2815BA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818041A2561;
	Tue, 13 Aug 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB98VEtL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A9F1A255A;
	Tue, 13 Aug 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567411; cv=none; b=tF4PH4EyUjXVkDzlikV5GpwgLZmJcu0jN10e8f2V3d7RQBT961RCfdnzoCpj0bHOQArmzXIu4zvFc51ImkLmdlN6ndI8Ggw8ZjA/uM0ws3rlfBFdyAa7gSpyQw910JJS5dDqaBR9Kl5PO4Hhcs+i6ZNjZPBWLrnO5C/7SzIj9tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567411; c=relaxed/simple;
	bh=RiYO5QgCiG46B5wMfDOn91P7Ne0jjaRilLFCxBkm9oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGzk4B390n9b6zmZ+modfv/sWeISMqnyY2mKHAi7pnwrArDcLbgJT0YQpSDzluBpyxscEuDGMjmadNgCU18ev3FmSZgDknJqKGd7nbKX/xijz3seecaiZXUcjCwRpGX0zmucoiIQRgTu4xpB10TV2ePA++MD01S/xDReyWHUivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB98VEtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76125C4AF0B;
	Tue, 13 Aug 2024 16:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723567410;
	bh=RiYO5QgCiG46B5wMfDOn91P7Ne0jjaRilLFCxBkm9oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RB98VEtLU+c8RS00jyMQhUzcLUNRfjQcFL8ppmMAYx7tKDn5190sFuXoZR7MdfvMS
	 oeDSx3tEbc+DR0g0nLs6lOTP4XnxO+2RL7bOWSdy5OOIokyWFkDxS57tnksjsUVn4c
	 QKtntpKVqu+crcEu9CXO7J+GNIzqvALTKztHR7st/Gb7hnPFM6QMfAX9qKQKWaQqcn
	 bdXpHGtAlroCMg+r8XtmJBHzfIJyONhKGjQIk6HDdjSqbXjvIEjrLVS4AdZk0cNznh
	 1hQnBO7nLmD2/ZA/Z19C62QQ8II6DjFvsX2/iVLd7sM5khnS4io7v5eNFdAudKMLQ/
	 Q8iC6UexbTsjw==
Date: Tue, 13 Aug 2024 10:43:29 -0600
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	Saravana Kannan <saravanak@google.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
	Kowshik Jois B S <kowsjois@linux.ibm.com>,
	Lukas Wunner <lukas@wunner.de>, kernel-team@lists.ubuntu.com,
	Stefan Bader <stefan.bader@canonical.com>
Subject: Re: [PATCH v3] PCI: Fix crash during pci_dev hot-unplug on pseries
 KVM guest
Message-ID: <20240813164329.GA1180569-robh@kernel.org>
References: <20240802183327.1309020-1-amachhiw@linux.ibm.com>
 <20240806200059.GA74866@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806200059.GA74866@bhelgaas>

On Tue, Aug 06, 2024 at 03:00:59PM -0500, Bjorn Helgaas wrote:
> On Sat, Aug 03, 2024 at 12:03:25AM +0530, Amit Machhiwal wrote:
> > With CONFIG_PCI_DYNAMIC_OF_NODES [1], a hot-plug and hot-unplug sequence
> > of a PCI device attached to a PCI-bridge causes following kernel Oops on
> > a pseries KVM guest:
> 
> What is unique about pseries here?  There's nothing specific to
> pseries in the patch, so I would expect this to be a generic problem
> on any arch.

Only pseries does PCI hotplug with DT I think. It would happen if 
another system did though, but I think documenting the exact system is 
good. No reason we can't do both though.

Rob

