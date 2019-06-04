Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 460AB34EC4
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 19:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFDR3H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 13:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46887 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfFDR3G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jun 2019 13:29:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9290B3004159;
        Tue,  4 Jun 2019 17:29:06 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 282F21001DD2;
        Tue,  4 Jun 2019 17:29:06 +0000 (UTC)
Date:   Tue, 4 Jun 2019 11:29:05 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Hao Zheng <mowendugu@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Quan Xu <quan.xu0@gmail.com>
Subject: Re: [PATCH 1/1] PCI/IOV: Fix VF0 cached config space size for other
 VFs
Message-ID: <20190604112905.1f16232c@x1.home>
In-Reply-To: <1558358244-35832-1-git-send-email-mowendugu@gmail.com>
References: <1558358244-35832-1-git-send-email-mowendugu@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 04 Jun 2019 17:29:06 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 20 May 2019 21:17:24 +0800
Hao Zheng <mowendugu@gmail.com> wrote:

> Set the pcie_cap field before getting the config space size for
> other VFs. Otherwise, the config space size of other VFs are error
> set to 256, while the size of VF0 is 4096.
> 
> Signed-off-by: Hao Zheng <mowendugu@gmail.com>
> Signed-off-by: Quan Xu <quan.xu0@gmail.com>
> ---
>  drivers/pci/iov.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 3aa115e..239fad1 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -133,6 +133,7 @@ static void pci_read_vf_config_common(struct pci_dev *virtfn)
>  	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
>  			     &physfn->sriov->subsystem_device);
>  
> +	set_pcie_port_type(virtfn);
>  	physfn->sriov->cfg_size = pci_cfg_space_size(virtfn);
>  }
>  

This results in set_pci_port_type() being called multiple times on
VF0.  Why not simply delay calling pci_read_vf_config_common() until
after pci_setup_device()?  Here's the alternate approach:

https://lore.kernel.org/linux-pci/155966918965.10361.16228304474160813310.stgit@gimli.home/

Thanks,
Alex
