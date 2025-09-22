Return-Path: <linux-pci+bounces-36709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B36DB92A62
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 20:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CC53B4291
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 18:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772B331A061;
	Mon, 22 Sep 2025 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6rxD+h3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786A31770B;
	Mon, 22 Sep 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758567039; cv=none; b=I26PUNgZkYXa/1++D7og5LdxEbapcIdFMJ3ITah2xr9QClUZY+pWnvAgPb0bAXItw5JKkuwppY/Z0lBfc049upHAeeowwVRqhXjthXj/1Fqjh8TmG7SSD3cpslDcYi8goBX6lcn+kGV0DBSki9IqY5jneq5+Rz9VMco6HuWDlgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758567039; c=relaxed/simple;
	bh=+7bS2iPOloX1IuEKSuByzzTRY2xC/ysrOVLvNJL5bVI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tS3SPpXET7YC0FZXc/mswr0l1vMhn9HZeVFvAylnD2zECliO9K8VEUGnSd6UevQMQlboFOx8zJnmB3ZZLjhNySMcW344I++kfSnQoqRlrI/K2QQEf2ceSvlr/hKu2xLp+nx8WR/kt3LmvRPi2PQ4ZcanmieJ+tv8QWNmJWxiheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6rxD+h3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C480EC116C6;
	Mon, 22 Sep 2025 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758567037;
	bh=+7bS2iPOloX1IuEKSuByzzTRY2xC/ysrOVLvNJL5bVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t6rxD+h3TyOQzPQXSKiS3MIrqFBQQ1k1o42aHxRjOMD2aAiS8ZkCQKx7uCie9Wfdo
	 UJ03t29aCML5QAMRJkjcJ305lwNX1wElrteR3Gms5Inn/sWUTHijIF69XZygP3MQoH
	 I7ethjDDuqbOi0ASZYuvg7THtgBHvR5GVM08/Q/sycaLiF6Xa/AP3ojUrEEDDLgCf9
	 SrCaZ+yQMLnii4eh0cWpAr8WJ3YyQt7UPMYvDD9BARIM0dCkF/BbJ21H+PADunf0/e
	 kLS9y85vBCAzF+JqDhpZurD5B6utVPWCpNatcJ7Y7LEJmmxvxJwiJe8kK+eXipJC0P
	 xVl0t1Nj9Z9hw==
Date: Mon, 22 Sep 2025 13:50:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Zhang Qilong <zhangqilong3@huawei.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/3] PCI/sysfs: Use runtime PM class macro for
 auto-cleanup
Message-ID: <20250922185036.GA1983521@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1950293.tdWV9SEqCh@rafael.j.wysocki>

On Mon, Sep 22, 2025 at 05:31:53PM +0200, Rafael J. Wysocki wrote:
> From: Takashi Iwai <tiwai@suse.de>
> 
> Use the newly introduced class macro to simplify the code.
> 
> Also, add the proper error handling for the PM runtime get errors.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Link: https://patch.msgid.link/20250919163147.4743-3-tiwai@suse.de
> [ rjw: Adjusted the subject and the name of the class ]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> 
> v2 -> v3: No changes
> 
> v1 -> v2:
>    * Adjust the name of the class to handle the disabled runtime PM case
>      transparently (like the original code).
> 
> ---
>  drivers/pci/pci-sysfs.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct
>  		return count;
>  	}
>  
> -	pm_runtime_get_sync(dev);
> -	struct device *pmdev __free(pm_runtime_put) = dev;
> +	CLASS(pm_runtime_get_active, pmdev)(dev);
> +	if (IS_ERR(pmdev))
> +		return -ENXIO;
>  
>  	if (sysfs_streq(buf, "default")) {
>  		pci_init_reset_methods(pdev);
> 
> 
> 

