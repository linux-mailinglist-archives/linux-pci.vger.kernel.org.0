Return-Path: <linux-pci+bounces-16161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0CE9BF49B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 18:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98547B23C34
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 17:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8553A2071E2;
	Wed,  6 Nov 2024 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHyA8XQo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3B42036E2;
	Wed,  6 Nov 2024 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915461; cv=none; b=n2SnmmDtGGqa0iTtotDdZ8z0BRKSsz50QqvO3YQQr9bIM8Nlsn3lU4JvXQt7IIMJ8/Lq2pdlsZZP+OXU9RvkMv0eFrXi9PsBQT3qoLm6X9sqx+KNjgIkR0Q9iXj0Q+TePRQIZQM9ppkethi7obp5X6MUWan/fNnerZqSR7xLwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915461; c=relaxed/simple;
	bh=eGE+JvjEAxRC3XXv8UCLb6VqT7OxpYjwPHHZhlH0s2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVGiamzPoJDu2OJ2gwphUHrLW+F+vvVMW/fvmReX+7z+G7/gVK22zzApdwjWpC7NYswzk45/C4MDq4tCsVRts1f+3p2AOOfkhSoF5UNd/6nKhPro6jaDbwq9sOUikTL0C5qTemPvgEbeUBqaxAQXPGOb6sUp8q3Mf5VZR4Du02g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHyA8XQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101C6C4CED0;
	Wed,  6 Nov 2024 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730915460;
	bh=eGE+JvjEAxRC3XXv8UCLb6VqT7OxpYjwPHHZhlH0s2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHyA8XQoMkIT6nDYTR4tSxHXWA160F57jbl6rLg0o95nxKlPKgKn/svyWJYzvM54y
	 48JVbg4rtQbeUQN6/de/EIxk1gFquy03qwH0BglNNrw572JbcKk5ZD66T8vehqPwJe
	 ucX4PSKLfiMy8DR+GFSivshfKXVU8NMqM+qreEFD/1QN7JmoTcnoM08NmFBMse4sq9
	 EARL8AUb83hldPhpOnK01rfBQPBNd2z2S+ywjvKWrpE4FvkE+tz7bTKqwi0wt3Gmwz
	 U6QVswTEzRiK44rVR/vmOVGcrOi7aZm0IthSICKttOHGb095Vyi7xwLHUtrSroWmM8
	 Cwkcmxe97OOCg==
Date: Wed, 6 Nov 2024 19:50:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sanman Pradhan <sanman.p211993@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com,
	sanmanpradhan@meta.com, andrew+netdev@lunn.ch,
	vadim.fedorenko@linux.dev, jdamato@fastly.com, sdf@fomichev.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <20241106175054.GG5006@unreal>
References: <20241106122251.GC5006@unreal>
 <20241106171257.GA1529850@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106171257.GA1529850@bhelgaas>

On Wed, Nov 06, 2024 at 11:12:57AM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 06, 2024 at 02:22:51PM +0200, Leon Romanovsky wrote:
> > On Tue, Nov 05, 2024 at 04:26:25PM -0800, Sanman Pradhan wrote:
> > > Add PCIe hardware statistics support to the fbnic driver. These stats
> > > provide insight into PCIe transaction performance and error conditions,
> > > including, read/write and completion TLP counts and DWORD counts and
> > > debug counters for tag, completion credit and NP credit exhaustion
> > > 
> > > The stats are exposed via ethtool and can be used to monitor PCIe
> > > performance and debug PCIe issues.
> > 
> > And how does PCIe statistics belong to ethtool?
> > 
> > This PCIe statistics to debug PCIe errors and arguably should be part of
> > PCI core and not hidden in netdev tool.
> 
> How would this be done in the PCI core?  As far as I can tell, all
> these registers are device-specific and live in some device BAR.

I would expect some sysfs file/directory exposed through PCI core.
That sysfs needs to be connected to the relevant device through
callback, like we are doing with .sriov_configure(). So every PCI
device will be able to expose statistics without relation to netdev.

That interface should provide read access and write access with zero
value to reset the counter/counters.

Thanks

> 
> Bjorn

