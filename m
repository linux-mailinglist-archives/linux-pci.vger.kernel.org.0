Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4123D837E2
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 19:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfHFR3A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 13:29:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:34235 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbfHFR3A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 13:29:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 10:28:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="374127088"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2019 10:28:59 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id E3D8158044F;
        Tue,  6 Aug 2019 10:28:58 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH] PCI: use PCI_SRIOV_NUM_BARS in loops instead of
 PCI_IOV_RESOURCE_END
To:     Denis Efremov <efremov@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190806140715.19847-1-efremov@linux.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <3322ea7f-c4c7-0dc0-73bd-778f57cc9450@linux.intel.com>
Date:   Tue, 6 Aug 2019 10:26:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190806140715.19847-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/6/19 7:07 AM, Denis Efremov wrote:
> It's a general pattern to write loops with 'i < PCI_SRIOV_NUM_BARS'
> condition. This patch fixes remaining loops which violates this implicit
> agreement.

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>   drivers/pci/iov.c       | 4 ++--
>   drivers/pci/setup-bus.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 525fd3f272b3..9b48818ced01 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -557,8 +557,8 @@ static void sriov_restore_state(struct pci_dev *dev)
>   	ctrl |= iov->ctrl & PCI_SRIOV_CTRL_ARI;
>   	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, ctrl);
>   
> -	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++)
> -		pci_update_resource(dev, i);
> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
> +		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
>   
>   	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
>   	pci_iov_set_numvfs(dev, iov->num_VFs);
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 79b1fa6519be..e7dbe21705ba 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1662,8 +1662,8 @@ static int iov_resources_unassigned(struct pci_dev *dev, void *data)
>   	int i;
>   	bool *unassigned = data;
>   
> -	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
> -		struct resource *r = &dev->resource[i];
> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> +		struct resource *r = &dev->resource[i + PCI_IOV_RESOURCES];
>   		struct pci_bus_region region;
>   
>   		/* Not assigned or rejected by kernel? */

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

