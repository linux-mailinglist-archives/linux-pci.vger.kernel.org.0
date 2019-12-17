Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADB4812336E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 18:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfLQRYc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 12:24:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23609 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726885AbfLQRYb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Dec 2019 12:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576603470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9EWxVih18eWOWqVZH496crr0Ey2713iPaECnfpP2vE=;
        b=WzgiU9HD/0RIy1KMYHbppXdRk6cUoxVgmi9ADIbNXvDuhlaFrhZY/lDaAocBIR/hzYsYXY
        QaiEOkGBdc1Ur9Mq9bBg+Kp0rE81nJwX3KoTmbC4WRH41qMg0RBwjteAjyiYh3HSXyJylv
        a9FLNw8SS2hJgMuuZRK1jd5W2qfJU08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-rLIk8wDJP16gfQOgon_8HA-1; Tue, 17 Dec 2019 12:24:26 -0500
X-MC-Unique: rLIk8wDJP16gfQOgon_8HA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42E7E8017DF;
        Tue, 17 Dec 2019 17:24:24 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12510620A7;
        Tue, 17 Dec 2019 17:24:19 +0000 (UTC)
Subject: Re: [PATCH v3 09/13] iommu/arm-smmu-v3: Handle failure of
 arm_smmu_write_ctx_desc()
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-10-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <bff90d55-4f81-aa60-2341-9fb467cfdd59@redhat.com>
Date:   Tue, 17 Dec 2019 18:24:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191209180514.272727-10-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 12/9/19 7:05 PM, Jean-Philippe Brucker wrote:
> Second-level context descriptor tables will be allocated lazily in
> arm_smmu_write_ctx_desc(). Help with handling allocation failure by
> moving the CD write into arm_smmu_domain_finalise_s1().

nit: would rather change the title to something like "Prepare for
arm_smmu_write_ctx_desc() failure"
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  drivers/iommu/arm-smmu-v3.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index f260abadde6d..fc5119f34187 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2301,8 +2301,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
>  	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
>  	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
> +
> +	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
> +	if (ret)
> +		goto out_free_tables;
> +
>  	return 0;
>  
> +out_free_tables:
> +	arm_smmu_free_cd_tables(smmu_domain);
>  out_free_asid:
>  	arm_smmu_bitmap_free(smmu->asid_map, asid);
>  	return ret;
> @@ -2569,10 +2576,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
>  		master->ats_enabled = arm_smmu_ats_supported(master);
>  
> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
> -		arm_smmu_write_ctx_desc(smmu_domain, 0,
> -					&smmu_domain->s1_cfg.cd);
> -
>  	arm_smmu_install_ste_for_dev(master);
>  
>  	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> 

