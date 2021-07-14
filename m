Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E9F3C855A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 15:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhGNNfs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 09:35:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59872 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhGNNfs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 09:35:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16EDWocJ042933;
        Wed, 14 Jul 2021 08:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626269570;
        bh=VJxlTJ1XN3jRDHNNvgt5P3v8pnejqQJk8QQzrEvGJlU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sRTfR0bptL5MrsOtq4zjQbB0bCM1yvzYHjOfmcDLJznTHpDJ4VSFiy6TkGfRSOfoi
         BsbSjQTEmXK3vB1i+fYz9hR9riuoosga55HkNmYt4s2oAUkGJA4PDDACTIYrTFL41A
         ziP4lRKEry8GH9fOKDVTRizielNsBBddCuu92WP4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16EDWoVr043632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Jul 2021 08:32:50 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 14
 Jul 2021 08:32:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 14 Jul 2021 08:32:50 -0500
Received: from [10.250.235.160] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16EDWkcB018210;
        Wed, 14 Jul 2021 08:32:47 -0500
Subject: Re: [PATCH v2] tools: PCI: Zero-initialize param
To:     Shunyong Yang <yang.shunyong@gmail.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <kw@linux.com>, <leon@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210714132331.5200-1-yang.shunyong@gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9e40fd4c-6aec-db3e-f323-0f2cfb67d58c@ti.com>
Date:   Wed, 14 Jul 2021 19:02:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210714132331.5200-1-yang.shunyong@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 14/07/21 6:53 pm, Shunyong Yang wrote:
> The values in param may be random if they are not initialized, which
> may cause use_dma flag set even when "-d" option is not provided
> in command line. Initializing all members to 0 to solve this.
> 
> Signed-off-by: Shunyong Yang <yang.shunyong@gmail.com>

Thanks for the fix.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>


> ---
> v2: Change {0} to {} as Leon Romanovsky's comment.
> ---
>  tools/pci/pcitest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 0a1344c45213..441b54234635 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -40,7 +40,7 @@ struct pci_test {
>  
>  static int run_test(struct pci_test *test)
>  {
> -	struct pci_endpoint_test_xfer_param param;
> +	struct pci_endpoint_test_xfer_param param = {};
>  	int ret = -EINVAL;
>  	int fd;
>  
> 
