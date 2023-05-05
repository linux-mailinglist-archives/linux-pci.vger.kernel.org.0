Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1D86F85F3
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 17:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjEEPhV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 May 2023 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjEEPhU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2023 11:37:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CE314E4A;
        Fri,  5 May 2023 08:37:18 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QCZYC29gcz67yhg;
        Fri,  5 May 2023 23:36:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 5 May
 2023 16:37:15 +0100
Date:   Fri, 5 May 2023 16:37:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     <bhelgaas@google.com>, <mika.westerberg@linux.intel.com>,
        <koba.ko@canonical.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] PCI/AER: Factor out interrupt toggling into
 helpers
Message-ID: <20230505163714.000003a9@Huawei.com>
In-Reply-To: <20230424055249.460381-1-kai.heng.feng@canonical.com>
References: <20230424055249.460381-1-kai.heng.feng@canonical.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Apr 2023 13:52:47 +0800
Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> There are many places that enable and disable AER interrput, so move

interrupt

> them into helpers.

Otherwise looks like a good clean up to me.
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/aer.c | 45 +++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f6c24ded134c..1420e1f27105 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1227,6 +1227,28 @@ static irqreturn_t aer_irq(int irq, void *context)
>  	return IRQ_WAKE_THREAD;
>  }
>  
> +static void aer_enable_irq(struct pci_dev *pdev)
> +{
> +	int aer = pdev->aer_cap;
> +	u32 reg32;
> +
> +	/* Enable Root Port's interrupt in response to error messages */
> +	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> +	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +}
> +
> +static void aer_disable_irq(struct pci_dev *pdev)
> +{
> +	int aer = pdev->aer_cap;
> +	u32 reg32;
> +
> +	/* Disable Root's interrupt in response to error messages */
> +	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> +	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +}
> +
>  /**
>   * aer_enable_rootport - enable Root Port's interrupts when receiving messages
>   * @rpc: pointer to a Root Port data structure
> @@ -1256,10 +1278,7 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>  	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
>  	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
>  
> -	/* Enable Root Port's interrupt in response to error messages */
> -	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	aer_enable_irq(pdev);
>  }
>  
>  /**
> @@ -1274,10 +1293,7 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
>  	int aer = pdev->aer_cap;
>  	u32 reg32;
>  
> -	/* Disable Root's interrupt in response to error messages */
> -	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	aer_disable_irq(pdev);
>  
>  	/* Clear Root's error status reg */
>  	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> @@ -1372,12 +1388,8 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	 */
>  	aer = root ? root->aer_cap : 0;
>  
> -	if ((host->native_aer || pcie_ports_native) && aer) {
> -		/* Disable Root's interrupt in response to error messages */
> -		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> -		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
> -	}
> +	if ((host->native_aer || pcie_ports_native) && aer)
> +		aer_disable_irq(root);
>  
>  	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
>  		rc = pcie_reset_flr(dev, PCI_RESET_DO_RESET);
> @@ -1396,10 +1408,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
>  		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
>  
> -		/* Enable Root Port's interrupt in response to error messages */
> -		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> -		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +		aer_enable_irq(root);
>  	}
>  
>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;

