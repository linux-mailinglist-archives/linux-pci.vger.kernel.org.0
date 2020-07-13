Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB1F21DDBC
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 18:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgGMQmy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 12:42:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:34296 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgGMQmx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 12:42:53 -0400
IronPort-SDR: DjaGoNfh/oEYmOpW5z49J9nMo0Zrp5jqJ4TSHlwR/npKUs9xLPEtwPUspAoSLsqMQgdPfapGL+
 P39NRixrti8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="146141285"
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="146141285"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 09:42:53 -0700
IronPort-SDR: dQgS6KRxXnZehQ6xSY5bScIB1NbPYyLT4+zopdkg5S3fiuf5XsC0QhqYiX7EJ72qjhdGaDOB1f
 Vf9essvY4UOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="485064335"
Received: from rrajashe-mobl1.amr.corp.intel.com (HELO [10.212.135.176]) ([10.212.135.176])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jul 2020 09:42:52 -0700
Subject: Re: [RFC PATCH 09/35] nvme-pci: Change PCIBIOS_SUCCESSFUL to 0
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        helgaas@kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        bjorn@helgaas.com, linux-kernel-mentees@lists.linuxfoundation.org
References: <20200713122247.10985-1-refactormyself@gmail.com>
 <20200713122247.10985-10-refactormyself@gmail.com>
From:   "Rajashekar, Revanth" <revanth.rajashekar@intel.com>
Message-ID: <0762f646-90a1-217c-4e4b-6168d85bb08a@intel.com>
Date:   Mon, 13 Jul 2020 10:42:51 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200713122247.10985-10-refactormyself@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 7/13/2020 6:22 AM, Saheed O. Bolarinwa wrote:
> In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
> Their scope should be limited within arch/x86.
>
> Change all PCIBIOS_SUCCESSFUL to 0
>
> Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b1d18f0633c7..d426efb53f44 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1185,7 +1185,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
>  
>  	result = pci_read_config_word(to_pci_dev(dev->dev), PCI_STATUS,
>  				      &pci_status);
> -	if (result == PCIBIOS_SUCCESSFUL)
> +	if (result == 0)
How about simplifying the check to if (!result)?
>  		dev_warn(dev->ctrl.device,
>  			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
>  			 csts, pci_status);
Thanks!
Revanth
