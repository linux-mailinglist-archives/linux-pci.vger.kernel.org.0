Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523DD42E74
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 20:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfFLSTU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 14:19:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfFLSTU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 14:19:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E17C8307D932;
        Wed, 12 Jun 2019 18:19:14 +0000 (UTC)
Received: from x1.home (ovpn-116-190.phx2.redhat.com [10.3.116.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30294600CC;
        Wed, 12 Jun 2019 18:19:10 +0000 (UTC)
Date:   Wed, 12 Jun 2019 12:19:10 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        keith.busch@intel.com, mike.campin@intel.com
Subject: Re: [PATCH v2 1/1] PCI/IOV: Fix incorrect cfg_size for VF > 0
Message-ID: <20190612121910.231368e2@x1.home>
In-Reply-To: <20190612170647.43220-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20190612170647.43220-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 12 Jun 2019 18:19:20 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 12 Jun 2019 10:06:47 -0700
sathyanarayanan.kuppuswamy@linux.intel.com wrote:

> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Commit 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
> other VFs") calculates and caches the cfg_size for VF0 device before
> initializing the pcie_cap of the device which results in using incorrect
> cfg_size for all VF devices > 0. So set pcie_cap of the device before
> calculating the cfg_size of VF0 device.
> 
> Fixes: 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
> other VFs")
> Cc: Ashok Raj <ashok.raj@intel.com>
> Suggested-by: Mike Campin <mike.campin@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v1:
>  * Fixed a typo in commit message.
> 
>  drivers/pci/iov.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 3aa115ed3a65..2869011c0e35 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -160,6 +160,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  	virtfn->device = iov->vf_device;
>  	virtfn->is_virtfn = 1;
>  	virtfn->physfn = pci_dev_get(dev);
> +	virtfn->pcie_cap = pci_find_capability(virtfn, PCI_CAP_ID_EXP);
>  
>  	if (id == 0)
>  		pci_read_vf_config_common(virtfn);

Why not re-order until after we've setup pcie_cap?

https://lore.kernel.org/linux-pci/20190604143617.0a226555@x1.home/T/#

Thanks,
Alex
