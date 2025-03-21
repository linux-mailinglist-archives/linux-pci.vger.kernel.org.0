Return-Path: <linux-pci+bounces-24407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8AAA6C54E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C8917A6A6F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 21:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ED3230BC5;
	Fri, 21 Mar 2025 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3tKBjI+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9712A1C9;
	Fri, 21 Mar 2025 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742593320; cv=none; b=m1onO1f5RdN/dJkeK6qh1S4qLCmG4CHn+ULs6rYe9+DPF2Uy573B2N7Z2Qvdo7hXoS1uct2sMCuR0D9EjGlpkV9Bx+5FhCww9a7lwoFDcnTjtv9dhlOAVb00iG3ytgwyFcFgC/RlCaumV/xdfUhP+fwGTslKAr8QO6UsQmam9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742593320; c=relaxed/simple;
	bh=zpnL6pzuhvX6HwfjXa+mYJeuUBroJi8g6uUOP0MicTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VmhB7OEmQyHaH73BoCjr1zZpmPTFhLRAby5UWnwkhHRZLkxYexcghgtv+3qiBrbOFDYMuadMpZshEErUz7xYvlUM/XflWicT00u3b6CZBEdRLxOkj3xcsRnltz9vojvSPvRXXJ3/5P9xFEFUm/jDX5kRxQoOsVNrsh5b91xOvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3tKBjI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2DBC4CEE3;
	Fri, 21 Mar 2025 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742593320;
	bh=zpnL6pzuhvX6HwfjXa+mYJeuUBroJi8g6uUOP0MicTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=d3tKBjI+TSNcgYWne6Utul/2rtsT28YiCC7pUX3/8dqf/0tMRaWSEAEWnq4IbFbHP
	 XWn8WtWMEMyhpgHzeOx42p/UfFgZ8NE/OxLdRrO/bfHbTkvtsOi4jGpYFwUjT3qfrE
	 zUvWmDvY5I9gQSTWVJtsoMIVtv/YaoZieMEd25UmyXYZ6HvtzMm72DK9NJIifz4KCS
	 uQX2Wikw2KlVEldRONkgq38xGQ+7MpDHajZaQxvu7CVhNAwPwS5/JAfGkKJrblNSeL
	 UKsmxWEFqCsEA0/TFJ4DQ4Dz6o0L5ibxtDi9BVXgFKFkiMUZguIt99XUJT78C1mNo2
	 UwafXYGsBzJQw==
Date: Fri, 21 Mar 2025 16:41:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alistair Francis <alistair@alistair23.me>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, lukas@wunner.de,
	alex.williamson@redhat.com, christian.koenig@amd.com,
	kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, alistair23@gmail.com,
	chaitanyak@nvidia.com, rdunlap@infradead.org
Subject: Re: [PATCH v17 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20250321214158.GA1162292@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306075211.1855177-3-alistair@alistair23.me>

On Thu, Mar 06, 2025 at 05:52:10PM +1000, Alistair Francis wrote:
> The PCIe 6 specification added support for the Data Object
> Exchange (DOE).
> When DOE is supported the DOE Discovery Feature must be implemented per
> PCIe r6.1 sec 6.30.1.1. DOE allows a requester to obtain
> information about the other DOE features supported by the device.

> +#ifdef CONFIG_SYSFS
> +static ssize_t doe_discovery_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	return sysfs_emit(buf, "0001:00\n");
> +}
> +DEVICE_ATTR_RO(doe_discovery);

I think this needs:

  static DEVICE_ATTR_RO(doe_discovery);

Otherwise sparse complains:

  $ make C=2 drivers/pci/doe.o
    CHECK   scripts/mod/empty.c
    CALL    scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
    CHECK   drivers/pci/doe.c
  drivers/pci/doe.c:109:1: warning: symbol 'dev_attr_doe_discovery' was not declared. Should it be static?


Right?  I added this in, so we're all set unless you think that's
wrong.

Bjorn

