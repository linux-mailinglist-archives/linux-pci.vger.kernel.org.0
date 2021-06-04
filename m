Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4EA39BAE6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhFDOa2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 10:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhFDOa2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 10:30:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EE43613FF;
        Fri,  4 Jun 2021 14:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622816921;
        bh=r1dsTOKQ8C/+R7voi2gDtIS6+mbQM5/TYn1mLjS/iVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YrQK79g4bJM+dfdx3yZPQ8guH2GsyhOL23SAbr8T+Xb2rhXO9FhzTmngrlXweAR+u
         4Fmu2x8jFloWZ7AEhMECaEUGc9HaH+z+JF3ty8neeBu2I2UDZwiUuUFEp+2iL4gszb
         sQw0etgiOoRr5yEqVSqSMfGRBvq2mw+6+E87TuHJZRAloedoJEf9y8uf59T2T3yM3u
         7cOzgecXrkhrqkjUHZjWqxUzALb49BRkgebJJb6/U6KzeHY00DjQRvzAOEei5TlVRu
         edvNffjKdDV+u732gACb5VQAic2LOSv7OCNE2TiNbSyzC1KbBAirc/vuvJi9GTOjOT
         EAReA+eGr0AYw==
Date:   Fri, 4 Jun 2021 09:28:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 3/6] PCI/sysfs: Fix trailing newline handling of
 resource_alignment_param
Message-ID: <20210604142839.GA2206654@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210604133230.983956-4-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 04, 2021 at 01:32:27PM +0000, Krzysztof Wilczyński wrote:
> The value of the "resource_alignment" can be specified using a kernel
> command-line argument (using the "pci=resource_alignment=") or through
> the corresponding sysfs object under the /sys/bus/pci path.
> 
> Currently, when the value is set via the kernel command-line argument,
> and then subsequently accessed through sysfs object, the value read back
> will not be correct, as per:
> 
>   # grep -oE 'pci=resource_alignment.+' /proc/cmdline
>   pci=resource_alignment=20@00:1f.2
>   # cat /sys/bus/pci/resource_alignment
>   20@00:1f.
> 
> This is also true when the value is set through the sysfs object, but
> the trailing newline has not been included, as per:
> 
>   # echo -n 20@00:1f.2 > /sys/bus/pci/resource_alignment
>   # cat /sys/bus/pci/resource_alignment
>   20@00:1f.
> 
> When the value set through the sysfs object includes the trailing
> newline, then reading it back will work as intended, as per:
> 
>   # echo 20@00:1f.2 > /sys/bus/pci/resource_alignment
>   # cat /sys/bus/pci/resource_alignment
>   20@00:1f.2
> 
> To fix this inconsistency, append a trailing newline in the show()
> function and strip the trailing line in the store() function if one is
> present.
> 
> Also, allow for the value previously set using either a command-line
> argument or through the sysfs object to be cleared at run-time.
> 
> Fixes: e499081da1a2 ("PCI: Force trailing new line to resource_alignment_param in sysfs")
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/pci.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5ed316ea5831..68f57d86b243 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6439,34 +6439,40 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
>  
>  	spin_lock(&resource_alignment_lock);
>  	if (resource_alignment_param)
> -		count = sysfs_emit(buf, "%s", resource_alignment_param);
> +		count = sysfs_emit(buf, "%s\n", resource_alignment_param);
>  	spin_unlock(&resource_alignment_lock);
>  
> -	/*
> -	 * When set by the command line, resource_alignment_param will not
> -	 * have a trailing line feed, which is ugly. So conditionally add
> -	 * it here.
> -	 */
> -	if (count >= 2 && buf[count - 2] != '\n' && count < PAGE_SIZE - 1) {
> -		buf[count - 1] = '\n';
> -		buf[count++] = 0;
> -	}
> -
>  	return count;
>  }
>  
>  static ssize_t resource_alignment_store(struct bus_type *bus,
>  					const char *buf, size_t count)
>  {
> -	char *param = kstrndup(buf, count, GFP_KERNEL);
> +	char *param, *old, *end;
> +
> +	if (count >= (PAGE_SIZE - 1))
> +		return -EINVAL;
>  
> +	param = kstrndup(buf, count, GFP_KERNEL);
>  	if (!param)
>  		return -ENOMEM;
>  
> +	end = strchr(param, '\n');
> +	if (end)
> +		*end = '\0';
> +
>  	spin_lock(&resource_alignment_lock);
> -	kfree(resource_alignment_param);
> -	resource_alignment_param = param;
> +	old = resource_alignment_param;
> +	if (strlen(param)) {
> +		resource_alignment_param = param;
> +	} else {
> +		kfree(param);

I folded this kfree change (free "param" instead of
"resource_alignment_param" as in v6) into my pci/sysfs branch.

> +		resource_alignment_param = NULL;
> +	}
>  	spin_unlock(&resource_alignment_lock);
> +
> +	kfree(old);
> +
>  	return count;
>  }
>  
> -- 
> 2.31.1
> 
