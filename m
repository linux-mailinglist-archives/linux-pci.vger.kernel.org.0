Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAD6481674
	for <lists+linux-pci@lfdr.de>; Wed, 29 Dec 2021 20:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhL2Txl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Dec 2021 14:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhL2Txl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Dec 2021 14:53:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067B7C061574;
        Wed, 29 Dec 2021 11:53:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89A3BB81A07;
        Wed, 29 Dec 2021 19:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDAEC36AE9;
        Wed, 29 Dec 2021 19:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640807618;
        bh=3xKmMCx2enRDWAiWh/qr4iF+67cL5V1MVZFQOA249zM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nFvGxfdDHW1NCKzpjvB1CObAOB3Dyk2uPMdjSZ1SowsnzpHGae3Mw5KQoS2yHlVPy
         3qbRcxIVbkxgf0gp/9a89NCvwjUs93FkOSYAhPbKsf29f3vuWv+SJbAJIN5+8c8iWu
         p1sAzp21Hw/ZPdi/qxYgUCpVxx35nm9uE4aWYkOTRH+V6bbqy2BsJsBQSG9MTnBZUP
         /l5dnqK1LhzlAuVmC5ZHFL39VD/lS40efzNGISlQKBCZ7vdUnUT9E9WrcJkWzaoKYu
         tJqTqMRW6e/QqsnSRvESei8dpoerdy1XxDbzLz3X/XoNqnVTM2uiXSLeQz8V1B1LjJ
         0AELG4tQr2rag==
Date:   Wed, 29 Dec 2021 13:53:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: slot: use default_groups in kobj_type
Message-ID: <20211229195336.GA1697694@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228135722.381023-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 28, 2021 at 02:57:22PM +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the PCI slot code to use default_groups field which has
> been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to pci/enumeration for v5.17, thanks!

> ---
>  drivers/pci/slot.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 751a26668e3a..a0c67191a8b9 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -96,11 +96,12 @@ static struct attribute *pci_slot_default_attrs[] = {
>  	&pci_slot_attr_cur_speed.attr,
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(pci_slot_default);
>  
>  static struct kobj_type pci_slot_ktype = {
>  	.sysfs_ops = &pci_slot_sysfs_ops,
>  	.release = &pci_slot_release,
> -	.default_attrs = pci_slot_default_attrs,
> +	.default_groups = pci_slot_default_groups,
>  };
>  
>  static char *make_slot_name(const char *name)
> -- 
> 2.34.1
> 
