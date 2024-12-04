Return-Path: <linux-pci+bounces-17704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963829E472D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 22:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706AC16A000
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 21:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE9618FDDB;
	Wed,  4 Dec 2024 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCq04lhb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82618C900;
	Wed,  4 Dec 2024 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733348934; cv=none; b=RbPuijSOadbjL0fSvUPIGt7Q0of6zvTF+DDum19e6BmVHhqz8Th1vzib2K60HcwsTJyEqPAiLM6ZGX0bwmjrvgyltUuvHmwRTNZV37k0Had/b5LV518LeWDvPPhwx9SSwSwQ6tjHwskGS3uMM9QjgWEz2/URv3QAm+LOcqHYUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733348934; c=relaxed/simple;
	bh=bYet3lSnC6WeIGaeITC0Oaz3L3iKdeow2WxHvY63XEE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A1gc5Jnfe20LMQ8WasM1ogRL913fZ4TZpXokNUXM3uFFeBB3tkgLbxSnTq0wmQU7WHBwhJL70CO3EzjiWa6I+9i/8nra+0bvU/pyS31d9uuWhyH7GBXpAmuI25yihDHJ2PFtWSNkoyIYnWVQpQhQUcfbVQ5v7MBqgXWzpH4KYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCq04lhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC94C4CECD;
	Wed,  4 Dec 2024 21:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733348933;
	bh=bYet3lSnC6WeIGaeITC0Oaz3L3iKdeow2WxHvY63XEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eCq04lhbsw7EWb1lKqd2nOEKJlg3s1EphiHrA9QhejSdCBB2PAaWfmwo0kRkJaWpJ
	 Wmjg4lYdYcp/BtEicaWL6K2zQUNNLsCb2Agjt2YEkRrE6mm156S9nAml+vep7QchCD
	 ImFYiagi7yckXvor1TnOdK3B3ILwXrV5x/QQnYbLQgssGeUQMALIt9u439r3o+i/gx
	 k7aVYgqQrzAMKaRlHbG4kVvIky9Geu5famIrWJNW/Zb3yr35Pnc8lAq2VsFRCcjCIA
	 l0SepF+2YXvZcobavLYpI1ArFsziNrFx41yCgUzukW1XrbV5cdBB1odL8SPx1Ydyzf
	 hUutvSTb4sUgQ==
Date: Wed, 4 Dec 2024 15:48:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 6/6] PCI: of: Create device-tree PCI host bridge node
Message-ID: <20241204214852.GA3017210@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202131522.142268-7-herve.codina@bootlin.com>

On Mon, Dec 02, 2024 at 02:15:18PM +0100, Herve Codina wrote:
> PCI devices device-tree nodes can be already created. This was
> introduced by commit 407d1a51921e ("PCI: Create device tree node for
> bridge").
> 
> In order to have device-tree nodes related to PCI devices attached on
> their PCI root bus (the PCI bus handled by the PCI host bridge), a PCI
> root bus device-tree node is needed. This root bus node will be used as
> the parent node of the first level devices scanned on the bus. On
> device-tree based systems, this PCI root bus device tree node is set to
> the node of the related PCI host bridge. The PCI host bridge node is
> available in the device-tree used to describe the hardware passed at
> boot.
> 
> On non device-tree based system (such as ACPI), a device-tree node for
> the PCI host bridge or for the root bus do not exist. Indeed, the PCI
> host bridge is not described in a device-tree used at boot simply
> because no device-tree are passed at boot.

s/do not exist/does not exist/

> +void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
> +{
> +	struct device_node *np = NULL;
> +	struct of_changeset *cset;
> +	const char *name;
> +	int ret;
> +
> +	/*
> +	 * If there is already a device-tree node linked to the PCI bus handled
> +	 * by this bridge (i.e. the PCI root bus), nothing to do.
> +	 */
> +	if (pci_bus_to_OF_node(bridge->bus))
> +		return;
> +
> +	/* The root bus has no node. Check that the host bridge has no node too */
> +	if (bridge->dev.of_node) {
> +		pr_err("PCI host bridge of_node already set");

Can we use dev_err() here?

Bjorn

