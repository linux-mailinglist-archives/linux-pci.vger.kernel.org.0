Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584C8334B28
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 23:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhCJWJh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 17:09:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:51934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232907AbhCJWJg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Mar 2021 17:09:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB90264FC1;
        Wed, 10 Mar 2021 22:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615414176;
        bh=fR6gW1+1QfgSkn5iHHd/VcUl7Qo8AyFE2dXd9ItkJZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qXtiJNkoo088NuI5CEDONE97IWGjNz1qz+E5RnubQues5PoqSuBaYVJQXtA+0D0M5
         f8yNHr4+85pZkP0t4o2WOBZNANkke+ugfJ0p4uE+qzfmAX10JiPwfqlxK565FUoOOU
         vJoKKbi9VcvH2FlvHjk8izDSt8T8EqlA+FV4DO6E/nfp+3/hTXvk2LwSoPhyLT36NE
         22NZ1phGZIJ+oHZCN/f2zSnwlVKKo3/QT9HfDRHK49AvihOourIhxbfxh+2orRou1O
         5TvEBVfP77yG1N3CilyT8U0HbYDQZVJ+pH3NU2kYxSgmZnO/YSUn1cVmaF1vSjZXRy
         WkAJsm6Y/72ng==
Date:   Wed, 10 Mar 2021 16:09:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/switchtec: Fix Spectre v1 vulnerability
Message-ID: <20210310220934.GA2070222@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210220062837.1683159-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 20, 2021 at 06:28:37AM +0000, Krzysztof Wilczyński wrote:
> The "partition" member of the struct switchtec_ioctl_pff_port can be
> indirectly controlled from user-space through an IOCTL that the device
> driver provides enabling conversion between a PCI Function Framework
> (PFF) number and Switchtec logical port ID and partition number, thus
> allowing for command-line tooling [1] interact with the device from
> user-space.
> 
> This can lead to potential exploitation of the Spectre variant 1 [2]
> vulnerability since the value of the partition is then used directly
> as an index to mmio_part_cfg_all of the struct switchtec_dev to retrieve
> configuration from Switchtec for a specific partition number.
> 
> Fix this by sanitizing the value coming from user-space through the
> available IOCTL before it's then used as an index to mmio_part_cfg_all.
> 
> This issue was detected with the help of Smatch:
> 
>   drivers/pci/switch/switchtec.c:1118 ioctl_port_to_pff() warn:
>   potential spectre issue 'stdev->mmio_part_cfg_all' [r] (local cap)
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [3].
> 
> Related commit 46feb6b495f7 ("switchtec: Fix Spectre v1 vulnerability").
> 
> 1. https://github.com/Microsemi/switchtec-user/blob/master/lib/platform/linux.c
> 2. https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/spectre.html
> 3. https://lore.kernel.org/lkml/CAPcyv4gLKYiCtXsKFX2FY+rW93aRtQt9zB8hU1hMsj770m8gxQ@mail.gmail.com/
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied with Logan's ack to for-linus for v5.12, thanks!

> ---
>  drivers/pci/switch/switchtec.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index ba52459928f7..bb6957101fc0 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1112,12 +1112,15 @@ static int ioctl_port_to_pff(struct switchtec_dev *stdev,
>  	if (copy_from_user(&p, up, sizeof(p)))
>  		return -EFAULT;
>  
> -	if (p.partition == SWITCHTEC_IOCTL_EVENT_LOCAL_PART_IDX)
> +	if (p.partition == SWITCHTEC_IOCTL_EVENT_LOCAL_PART_IDX) {
>  		pcfg = stdev->mmio_part_cfg;
> -	else if (p.partition < stdev->partition_count)
> +	} else if (p.partition < stdev->partition_count) {
> +		p.partition = array_index_nospec(p.partition,
> +						 stdev->partition_count);
>  		pcfg = &stdev->mmio_part_cfg_all[p.partition];
> -	else
> +	} else {
>  		return -EINVAL;
> +	}
>  
>  	switch (p.port) {
>  	case 0:
> -- 
> 2.30.0
> 
