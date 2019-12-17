Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD9E122CD6
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 14:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfLQN1V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 08:27:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60022 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726858AbfLQN1V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Dec 2019 08:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576589240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGMaaN2spqRcdKN+t4E7+eJdesmbwVFM0XF+FeuDgsE=;
        b=XmdA6bQnp5MeL1OFawPY7RtI1HJJGxw1Yfl/ijBoKHC7Q+nPd7oSd6VpyR2mMJM/nTAWcf
        0q5hwzISJZuVKGkCByFbr5JiLIilZD5Lo+b1CWK5AcJok0K9q8eaAoNLLYHPGbdiXM2Qfr
        qGs5Bx/oowTZnYGusG56byCo36a/wqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-RtXrFNhiOAiUmij-FHxVzA-1; Tue, 17 Dec 2019 08:27:16 -0500
X-MC-Unique: RtXrFNhiOAiUmij-FHxVzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B59B800D4C;
        Tue, 17 Dec 2019 13:27:14 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D70A7620CA;
        Tue, 17 Dec 2019 13:27:09 +0000 (UTC)
Subject: Re: [PATCH v3 04/13] ACPI/IORT: Support PASID for platform devices
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
 <20191209180514.272727-5-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <f5561d67-7ed8-bfad-a953-9a526f96190f@redhat.com>
Date:   Tue, 17 Dec 2019 14:27:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191209180514.272727-5-jean-philippe@linaro.org>
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
> Named component nodes in the IORT tables describe the number of
> Substream ID bits (aka. PASID) supported by the device. Propagate this
> value to the fwspec structure in order to enable PASID for platform
> devices.
> 
> Acked-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  drivers/acpi/arm64/iort.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 33f71983e001..39f389214ecf 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -11,6 +11,7 @@
>  #define pr_fmt(fmt)	"ACPI: IORT: " fmt
>  
>  #include <linux/acpi_iort.h>
> +#include <linux/bitfield.h>>  #include <linux/iommu.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -924,6 +925,20 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>  	return iort_iommu_xlate(info->dev, parent, streamid);
>  }
>  
> +static void iort_named_component_init(struct device *dev,
> +				      struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_named_component *nc;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	if (!fwspec)
> +		return;
> +
> +	nc = (struct acpi_iort_named_component *)node->node_data;
> +	fwspec->num_pasid_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
> +					   nc->node_flags);
> +}
> +
>  /**
>   * iort_iommu_configure - Set-up IOMMU configuration for a device.
>   *
> @@ -978,6 +993,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  			if (parent)
>  				err = iort_iommu_xlate(dev, parent, streamid);
>  		} while (parent && !err);
> +
> +		if (!err)
> +			iort_named_component_init(dev, node);
>  	}
>  
>  	/*
> 

