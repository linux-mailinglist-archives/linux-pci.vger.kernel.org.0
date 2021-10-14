Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B5242E0BA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 20:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhJNSGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 14:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhJNSGg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 14:06:36 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1194C061570;
        Thu, 14 Oct 2021 11:04:31 -0700 (PDT)
Message-ID: <f3aca934-7dee-b294-ad3c-264e773eddda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634234667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMFrwBpcfsevaiNMFqiTtdegTwfr5orDNb22AMJucOs=;
        b=n0gs8a/Zf9lENJoaoMmsmyrrYTaOSxPSqQ5/TvyXccikEz8hQ07tVKqSE2ljB5HJ/OxYXm
        MdFHBGmIm0jvTnQgC74mrXXiASM6NIRGKalb5ZpVCpQV/WMDTs9TiEkbjForHivEHPMhkl
        BsrAsbo5XhzMclQdsgFxaEEmeXRBqjM=
Date:   Thu, 14 Oct 2021 12:04:23 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 15/22] PCI: vmd: Use RESPONSE_IS_PCI_ERROR() to check read
 from hardware
Content-Language: en-US
To:     Naveen Naidu <naveennaidu479@gmail.com>, bhelgaas@google.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
 <84ab7a23647e0673d99a8cf59e9c89af9b862354.1633972263.git.naveennaidu479@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <84ab7a23647e0673d99a8cf59e9c89af9b862354.1633972263.git.naveennaidu479@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: jonathan.derrick@linux.dev
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/11/2021 12:06 PM, Naveen Naidu wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error.  There's no real data to return to satisfy the
> CPU read, so most hardware fabricates ~0 data.
> 
> Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
> data from hardware.
> 
> This helps unify PCI error response checking and make error checks
> consistent and easier to find.
> 
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/controller/vmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a5987e52700e..db81bc4cfe8c 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -538,7 +538,7 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
>  		int ret;
>  
>  		ret = pci_read_config_dword(dev, PCI_REG_VMLOCK, &vmlock);
> -		if (ret || vmlock == ~0)
> +		if (ret || RESPONSE_IS_PCI_ERROR(&vmlock))
>  			return -ENODEV;
>  
>  		if (MB2_SHADOW_EN(vmlock)) {
> 

Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
