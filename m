Return-Path: <linux-pci+bounces-43819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D84DCCE7C17
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 18:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E18EC300462E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 17:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCC318A6A8;
	Mon, 29 Dec 2025 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+0m2qhG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDD2110;
	Mon, 29 Dec 2025 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767029468; cv=none; b=oXkoGj6WDMvz3snWDxZ1tWePA8M6kyNEWCIRbK/9/4xCKzx0/TraBDxYTFAAycJPh+jlb5biZt1sqZ/Uxwa1uZh6QyRB8UwFe+COZNFF4K5MuqIeB1nMS8Bjw5zN0JxbzfAxfLglmlLzb8nBNAsYunKJWUqiG0+4QMDB40i39B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767029468; c=relaxed/simple;
	bh=wTyW+CJrvSvt1v8k+Jj5oo3naPQS7wVINsI91G+SwRk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tuVOwfvCv6twNVhct0c54s6lt1133eqbGtlS8oe3m5KEwLPbm+F+Z3U+fUsCWFAMbE1PdeyPztHXqOLduaUji2zk0mm2lBt3SgsTIwu4up4ePAJwvMhCtIt6zYCBmB+KF/8pCOdb6mjSmt4JiNmk3Fp+aA9WHQJeAhxWOi33gOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+0m2qhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A66C4CEF7;
	Mon, 29 Dec 2025 17:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767029467;
	bh=wTyW+CJrvSvt1v8k+Jj5oo3naPQS7wVINsI91G+SwRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r+0m2qhGmYN0C7dfHmaMViA4KfgBXc6uOXLp4o11OBwlnuJOeXK+IRkKnUmvrqZNU
	 GSM3IbNBuHSQ0q+nYLnqTVEWP9861Xr7dIJVNi3L2fVoe/E1EV0YztI4+CameeLSkv
	 o9ZRTSqmhoLFuuLkGZZ6OZ0yY10CJVZzo7rJrTiRv8CSxlvoJoWNMdpA9Mt5ysB9x7
	 RPYOYpiJHHSPU9QeShP+axkgbOaqPSbVM5BVIM/NuP0mvu/ndM+6TUsJS+YSK0A34w
	 RyAeuS5RmX9ohSja3Ls+7LUsBHqhEYKvMpJtn3ufz6DMjJT57mrEvm97x1fSTeCv6z
	 dxtLORnkhGCHg==
Date: Mon, 29 Dec 2025 11:31:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziming Du <duziming2@huawei.com>
Cc: bhelgaas@google.com, jbarnes@virtuousgeek.org, chrisw@redhat.com,
	alex.williamson@redhat.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
Subject: Re: [PATCH v2 1/3] PCI/sysfs: Fix null pointer dereference during
 hotplug
Message-ID: <20251229173106.GA69373@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224092721.2034529-2-duziming2@huawei.com>

On Wed, Dec 24, 2025 at 05:27:17PM +0800, Ziming Du wrote:
> During the concurrent process of creating and rescanning in VF, the
> resource files for the same pci_dev may be created twice. The second
> creation attempt fails, resulting the res_attr in pci_dev to kfree(),
> but the pointer is not set to NULL. This will subsequently lead to
> dereferencing a null pointer when removing the device.
> 
> When we perform the following operation:
>   echo $vfcount > /sys/class/net/"$pfname"/device/sriov_numvfs &

Is the value of $vfcount relevant here?  Can you use the actual values
here instead of the variables so this is more useful to others?

>   sleep 0.5
>   echo 1 > /sys/bus/pci/rescan
>   pci_remove "$pfname"
> system will crash as follows:

