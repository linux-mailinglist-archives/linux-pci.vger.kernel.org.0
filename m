Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5426D26E16A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 18:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgIQQ5m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 12:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbgIQQ5Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 12:57:25 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 818A72064B;
        Thu, 17 Sep 2020 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600361844;
        bh=nu7RsY28LVyN+IsFpaXaxIpemXjC7Q2RYaAJUnnZ2r8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MJLfb4lmVitwKrAl4tGM9ILl8JGYXcXszpcpnzFEb6k8oJ5ax0iNsfFS8e9FxKUZ0
         C+tYyN/wTuiXpcH172VU1aywBGTfhiTyQoi/GkH/kglPqRuVr8iRxX5dmmGUpJsFdS
         AJ9Faia/pQLEdUCrc/vdPrdf69lvmoVPAZPBsylY=
Date:   Thu, 17 Sep 2020 11:57:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: rpadlpar: use for_each_child_of_node() and
 for_each_node_by_name
Message-ID: <20200917165723.GA1708462@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916062128.190819-1-miaoqinglang@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 02:21:28PM +0800, Qinglang Miao wrote:
> Use for_each_child_of_node() and for_each_node_by_name macro
> instead of open coding it.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Applied to pci/hotplug for v5.10, thanks!

> ---
>  drivers/pci/hotplug/rpadlpar_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index f979b7098..0a3c80ba6 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -40,13 +40,13 @@ static DEFINE_MUTEX(rpadlpar_mutex);
>  static struct device_node *find_vio_slot_node(char *drc_name)
>  {
>  	struct device_node *parent = of_find_node_by_name(NULL, "vdevice");
> -	struct device_node *dn = NULL;
> +	struct device_node *dn;
>  	int rc;
>  
>  	if (!parent)
>  		return NULL;
>  
> -	while ((dn = of_get_next_child(parent, dn))) {
> +	for_each_child_of_node(parent, dn) {
>  		rc = rpaphp_check_drc_props(dn, drc_name, NULL);
>  		if (rc == 0)
>  			break;
> @@ -60,10 +60,10 @@ static struct device_node *find_vio_slot_node(char *drc_name)
>  static struct device_node *find_php_slot_pci_node(char *drc_name,
>  						  char *drc_type)
>  {
> -	struct device_node *np = NULL;
> +	struct device_node *np;
>  	int rc;
>  
> -	while ((np = of_find_node_by_name(np, "pci"))) {
> +	for_each_node_by_name(np, "pci") {
>  		rc = rpaphp_check_drc_props(np, drc_name, drc_type);
>  		if (rc == 0)
>  			break;
> -- 
> 2.23.0
> 
