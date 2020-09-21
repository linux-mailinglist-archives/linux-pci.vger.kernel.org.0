Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041E027220F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 13:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIULPg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 07:15:36 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2899 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbgIULPg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 07:15:36 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 9FFDB116C53DF929762B;
        Mon, 21 Sep 2020 12:15:34 +0100 (IST)
Received: from localhost (10.52.121.13) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 21 Sep
 2020 12:15:34 +0100
Date:   Mon, 21 Sep 2020 12:13:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rafael.j.wysocki@intel.com>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@intel.com>, <qiuxu.zhuo@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 05/10] PCI/AER: Apply function level reset to RCiEP
 on fatal error
Message-ID: <20200921121355.00002b77@Huawei.com>
In-Reply-To: <20200918204603.62100-6-sean.v.kelley@intel.com>
References: <20200918204603.62100-1-sean.v.kelley@intel.com>
        <20200918204603.62100-6-sean.v.kelley@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.13]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 18 Sep 2020 13:45:58 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> Attempt to do function level reset for an RCiEP associated with an
> RCEC device on fatal error.

I'm not sure the description is correct. Looks like it will do
the reset even if not associated with an RCEC.
I'd just cut this down to:

"Attempt to do a function level reset for an RCiEP on fatal error."

I'm not 100% sure doing an flr will actually help in most cass if you've
reported a fatal error, but I suppose it does no harm!

So with description changed.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
>  drivers/pci/pcie/err.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index e575fa6cee63..5380ecc41506 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -169,6 +169,17 @@ static void pci_bridge_walk(struct pci_dev *bridge, int (*cb)(struct pci_dev *,
>  		cb(bridge, userdata);
>  }
>  
> +static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
> +{
> +	if (!pcie_has_flr(dev))
> +		return PCI_ERS_RESULT_NONE;
> +
> +	if (pcie_flr(dev))
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  			pci_channel_state_t state,	
>  			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev))
> @@ -195,15 +206,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	if (state == pci_channel_io_frozen) {
>  		pci_bridge_walk(bridge, report_frozen_detected, &status);
>  		if (type == PCI_EXP_TYPE_RC_END) {
> -			pci_warn(dev, "link reset not possible for RCiEP\n");
> -			status = PCI_ERS_RESULT_NONE;
> -			goto failed;
> -		}
> -
> -		status = reset_subordinate_devices(bridge);
> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> -			pci_warn(dev, "subordinate device reset failed\n");
> -			goto failed;
> +			status = flr_on_rciep(dev);
> +			if (status != PCI_ERS_RESULT_RECOVERED) {
> +				pci_warn(dev, "function level reset failed\n");
> +				goto failed;
> +			}
> +		} else {
> +			status = reset_subordinate_devices(bridge);
> +			if (status != PCI_ERS_RESULT_RECOVERED) {
> +				pci_warn(dev, "subordinate device reset failed\n");
> +				goto failed;
> +			}
>  		}
>  	} else {
>  		pci_bridge_walk(bridge, report_normal_detected, &status);


