Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0025922EB03
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 13:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgG0LSv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 07:18:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2533 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbgG0LSv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 07:18:51 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 0D70944B09787BEA11F6;
        Mon, 27 Jul 2020 12:18:50 +0100 (IST)
Received: from localhost (10.52.121.176) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 27 Jul
 2020 12:18:49 +0100
Date:   Mon, 27 Jul 2020 12:17:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ashok.raj@kernel.org>,
        <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [RFC PATCH 5/9] PCI/AER: Apply function level reset to RCiEP on
 fatal error
Message-ID: <20200727121726.000072a8@Huawei.com>
In-Reply-To: <20200724172223.145608-6-sean.v.kelley@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
        <20200724172223.145608-6-sean.v.kelley@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.176]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 24 Jul 2020 10:22:19 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> Attempt to do function level reset for an RCiEP associated with an
> RCEC device on fatal error.

I'd like to understand more on your reasoning for flr here.
Is it simply that it is all we can do, or is there some basis
in a spec somewhere?

> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
>  drivers/pci/pcie/err.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 044df004f20b..9b3ec94bdf1d 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -170,6 +170,17 @@ static void pci_walk_dev_affected(struct pci_dev *dev, int (*cb)(struct pci_dev
>  	}
>  }
>  
> +static enum pci_channel_state flr_on_rciep(struct pci_dev *dev)
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
>  			enum pci_channel_state state,
>  			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
> @@ -191,15 +202,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_dev_affected(dev, report_frozen_detected, &status);
>  		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> -			pci_warn(dev, "link reset not possible for RCiEP\n");
> -			status = PCI_ERS_RESULT_NONE;
> -			goto failed;
> -		}
> -
> -		status = reset_link(dev);
> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> -			pci_warn(dev, "link reset failed\n");
> -			goto failed;
> +			status = flr_on_rciep(dev);
> +			if (status != PCI_ERS_RESULT_RECOVERED) {
> +				pci_warn(dev, "function level reset failed\n");
> +				goto failed;
> +			}
> +		} else {
> +			status = reset_link(dev);
> +			if (status != PCI_ERS_RESULT_RECOVERED) {
> +				pci_warn(dev, "link reset failed\n");
> +				goto failed;
> +			}
>  		}
>  	} else {
>  		pci_walk_dev_affected(dev, report_normal_detected, &status);


