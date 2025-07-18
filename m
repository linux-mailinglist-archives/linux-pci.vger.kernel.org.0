Return-Path: <linux-pci+bounces-32544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A59CB0A8FE
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 19:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39F0562195
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873432E5B07;
	Fri, 18 Jul 2025 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYs05sUQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ADB2E2665
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858040; cv=none; b=tYrEBj/npDiYrFF3ljKxfVmZBL5+kQKu5yyAZwwULzo6OiV9tLxSEAB1svge5nKa8EzYJbpJL6frztlEUNmAp25ZYmy2hdxYHrAfTFd/8QQMTKkNBhvSm1U3ZB0WWSGFaPhuW7HHa/8CQvosEZjteR9azS3sj0vaGhr3DTFSfOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858040; c=relaxed/simple;
	bh=NGTEs1iPjqY7DQJVXbL8qqzk+idrSdKhj2YQm6rUdPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTSclgP2gHEVgnMXMjUAiW/3fPxQPC15OMdxKT2dkrp3GuoWwPT7tFRcorViXlV55sbaOGRPvZWWQKZJVOXRPqPqxHEHdM7xChAOUX9zsfUbnDF3iCRBdiM6CJYX4BDpQXp5QhAb7g6pPFSCTRwPnGkkxlArdDeOeqljocTc0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYs05sUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEADAC4CEEB;
	Fri, 18 Jul 2025 17:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752858039;
	bh=NGTEs1iPjqY7DQJVXbL8qqzk+idrSdKhj2YQm6rUdPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYs05sUQXMFjqqeZF3dFrH+gkWP8x9pyEHrYP92O9CXz2kVCUXLbwqjqSUq03YqsE
	 JCpmtrEgsST11n+dQKuQwXiOWSgS5Oo5+F/TYgv6Q60TewhZfqodXvPnEJlXAp5btS
	 qACpAvdpWXrcZyX9wg4n0PGVskGawp+ucArWYgIm8+aLZdM88RZa3TSHVnNKMQgkZv
	 kUVXu1NywcEjnZbs7zClzyLk2APzOxN5xJ/Ndeh6MOG4Q8Z/OhIJ+zxg315C0bLhZN
	 sfUScUm9hcscI0lkgVbFXWDqLr5tYAIXmbsjvEcObGWUTTPCveZJz4jHeBMbf9lJvu
	 0tXg6h/BYDdwQ==
Date: Fri, 18 Jul 2025 22:30:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, 
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix warning without CONFIG_VIDEO
Message-ID: <rdqrqwoye3b4tut4mgqckshmlslycg2weyleasduxawhyoifq6@pyykudf4ncke>
References: <20250718134134.1710578-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718134134.1710578-1-superm1@kernel.org>

On Fri, Jul 18, 2025 at 08:41:33AM GMT, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> When compiled without CONFIG_VIDEO pci_create_boot_display_file() will
> never create a sysfs file for boot_display. Guard the sysfs file
> declaration against CONFIG_VIDEO.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20250718224118.5b3f22b0@canb.auug.org.au/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6b1a0ae254d3a..f6540a72204d3 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -680,12 +680,14 @@ const struct attribute_group *pcibus_groups[] = {
>  	NULL,
>  };
>  
> +#ifdef CONFIG_VIDEO
>  static ssize_t boot_display_show(struct device *dev, struct device_attribute *attr,
>  				 char *buf)
>  {
>  	return sysfs_emit(buf, "1\n");
>  }
>  static DEVICE_ATTR_RO(boot_display);

I failed to give my comment during the offending series itself, but it is never
late than never. Why are we adding non-PCI attributes under bus/pci in the first
place? Though the underlying device uses PCI as a transport, only the PCI bus
specific attrbutes should be placed under bus/pci and the driver/peripheral
specific attrbutes should belong to the respective bus/class/device hierarchy.

Now, if other peripherals (like netdev) start adding these device specific
attributes under bus/pci, it will turn out to be a mess.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

