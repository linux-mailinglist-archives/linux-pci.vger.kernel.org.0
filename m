Return-Path: <linux-pci+bounces-2813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 399758429CB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 17:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA051283F6D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 16:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2320986ADC;
	Tue, 30 Jan 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uzqAZKLn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5E8612C;
	Tue, 30 Jan 2024 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633046; cv=none; b=cLXjpcX0Xej2T8NeumuJi1KjULIsi+t2E2cHPuzMQ0sZZCxZh/C1Mz7KYFyr5J1Kwi8ksKQbo9oFsQtehELtIm/N39LoCjjOXoMWSnpYtQCDKUZhNXVeFg+fP2ZYlb8lZwBC28wOhMI/9ZJNwb12CE0hvJLQgSwKlzopVyv/W+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633046; c=relaxed/simple;
	bh=QgABafDNsktgkXRudOCLlwXhcYXw4Ycvqs7d0i/LQ1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcbUSyMx655xevO71/iiR6rWZQQVmpIi7aZCmKXB+2pDPedW0GY/3oUdA5N/HM7vB1kcH88swf4WlAv72BO5ZXtZqc/BXpDgoQpmYjVLVLgUcHlR0NkMa/qsTocjczk+0gqJ5HTJSAqTMMW6IQM1vKm4Y45AlXIPxD/Ot87CDyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uzqAZKLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADF1C433F1;
	Tue, 30 Jan 2024 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706633045;
	bh=QgABafDNsktgkXRudOCLlwXhcYXw4Ycvqs7d0i/LQ1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzqAZKLnLfqAX16wTaHfxzIhJle9n1YAO75dG0h3i7HfVla1jerWbReyXqYPut88f
	 Y0Lft1wcBTSuVpW2zVmxysZP8URMLHnmB5qI8n9dmNgfb7keXFOZTJh6ncc3YYSouz
	 KOofi6pqU7s2S/17CPUT1SNuEz0vb8M/cZYNJEAI=
Date: Tue, 30 Jan 2024 08:44:04 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] sysfs: Introduce a mechanism to hide static
 attribute_groups
Message-ID: <2024013016-sank-idly-dd6b@gregkh>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
 <170660664848.224441.8152468052311375109.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170660664848.224441.8152468052311375109.stgit@dwillia2-xfh.jf.intel.com>

On Tue, Jan 30, 2024 at 01:24:08AM -0800, Dan Williams wrote:
> Add a mechanism for named attribute_groups to hide their directory at
> sysfs_update_group() time, or otherwise skip emitting the group
> directory when the group is first registered. It piggybacks on
> is_visible() in a similar manner as SYSFS_PREALLOC, i.e. special flags
> in the upper bits of the returned mode. To use it, specify a symbol
> prefix to DEFINE_SYSFS_GROUP_VISIBLE(), and then pass that same prefix
> to SYSFS_GROUP_VISIBLE() when assigning the @is_visible() callback:
> 
> 	DEFINE_SYSFS_GROUP_VISIBLE($prefix)
> 
> 	struct attribute_group $prefix_group = {
> 		.name = $name,
> 		.is_visible = SYSFS_GROUP_VISIBLE($prefix),
> 	};
> 
> SYSFS_GROUP_VISIBLE() expects a definition of $prefix_group_visible()
> and $prefix_attr_visible(), where $prefix_group_visible() just returns
> true / false and $prefix_attr_visible() behaves as normal.
> 
> The motivation for this capability is to centralize PCI device
> authentication in the PCI core with a named sysfs group while keeping
> that group hidden for devices and platforms that do not meet the
> requirements. In a PCI topology, most devices will not support
> authentication, a small subset will support just PCI CMA (Component
> Measurement and Authentication), a smaller subset will support PCI CMA +
> PCIe IDE (Link Integrity and Encryption), and only next generation
> server hosts will start to include a platform TSM (TEE Security
> Manager).
> 
> Without this capability the alternatives are:
> 
> * Check if all attributes are invisible and if so, hide the directory.
>   Beyond trouble getting this to work [1], this is an ABI change for
>   scenarios if userspace happens to depend on group visibility absent any
>   attributes. I.e. this new capability avoids regression since it does
>   not retroactively apply to existing cases.
> 
> * Publish an empty /sys/bus/pci/devices/$pdev/tsm/ directory for all PCI
>   devices (i.e. for the case when TSM platform support is present, but
>   device support is absent). Unfortunate that this will be a vestigial
>   empty directory in the vast majority of cases.
> 
> * Reintroduce usage of runtime calls to sysfs_{create,remove}_group()
>   in the PCI core. Bjorn has already indicated that he does not want to
>   see any growth of pci_sysfs_init() [2].
> 
> * Drop the named group and simulate a directory by prefixing all
>   TSM-related attributes with "tsm_". Unfortunate to not use the naming
>   capability of a sysfs group as intended.
> 
> In comparison, there is a small potential for regression if for some
> reason an @is_visible() callback had dependencies on how many times it
> was called. Additionally, it is no longer an error to update a group
> that does not have its directory already present, and it is no longer a
> WARN() to remove a group that was never visible.
> 
> Link: https://lore.kernel.org/all/2024012321-envious-procedure-4a58@gregkh/ [1]
> Link: https://lore.kernel.org/linux-pci/20231019200110.GA1410324@bhelgaas/ [2]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  fs/sysfs/group.c      |   45 ++++++++++++++++++++++++++++-------
>  include/linux/sysfs.h |   63 ++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 87 insertions(+), 21 deletions(-)

You beat me to this again :)

I have tested this patch, and it looks good, I'll send out my series
that uses it for a different subsystem as well.

I guess I can take this as a static tag for others to pull from for this
rc development cycle?

thanks,

greg k-h

