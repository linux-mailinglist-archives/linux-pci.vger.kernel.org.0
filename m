Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFB04A5381
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 00:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiAaXrn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 18:47:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:57377 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbiAaXrm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 18:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643672862; x=1675208862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VTX+qg1zSqMYZJOMVnJMK11n6omzSFDS/8BFYIJOcI8=;
  b=MkqFHWNPTrUhMI8G31EG3/TbF7KkGv700/4geNhZRyvHUo4OPguUnbGl
   r5mUC8DUy8cQwBT0H8TBjoxPnSjDSuIZ83yt/wR6kIZqE0ojbciS3GjyM
   gvuGBwBju0i5uLFORqCOgw+cQuAt9iyu6IWPz05sZrpk6Hn8LEpt/kzMA
   +jMkd8YEcmQLXsdhKzEzkRoGeulKN35NB/uzRUzaQuFmWi1nvAzuE94i/
   MLMbBdNuje959CFN3YniCAMmiL4OjUrwvAIYD20lhoVlf20UzEgAd3Hrr
   wcCPKPk3RUQkfr2esUDu6jfvjqL4z3KLMqPBSqko/u0vgKSboKLkuaBNI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247530643"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="247530643"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:47:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="675902526"
Received: from sssheth-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:47:41 -0800
Date:   Mon, 31 Jan 2022 15:47:40 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 19/40] cxl/port: Up-level cxl_add_dport() locking
 requirements to the caller
Message-ID: <20220131234740.bzg63pqyf2wl3din@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298422000.3018233.4106867312927858722.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164298422000.3018233.4106867312927858722.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-23 16:30:20, Dan Williams wrote:
> In preparation for moving dport enumeration into the core, require the
> port device lock to be acquired by the caller.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/acpi.c            |    2 ++
>  drivers/cxl/core/port.c       |    3 +--
>  tools/testing/cxl/mock_acpi.c |    4 ++++
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index ab2b76532272..e596dc375267 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -342,7 +342,9 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  		return 0;
>  	}
>  
> +	device_lock(&root_port->dev);
>  	rc = cxl_add_dport(root_port, match, uid, ctx.chbcr);
> +	device_unlock(&root_port->dev);
>  	if (rc) {
>  		dev_err(host, "failed to add downstream port: %s\n",
>  			dev_name(match));
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index ec9587e52423..c51a10154e29 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -516,7 +516,7 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
>  {
>  	struct cxl_dport *dup;
>  
> -	cxl_device_lock(&port->dev);
> +	device_lock_assert(&port->dev);
>  	dup = find_dport(port, new->port_id);
>  	if (dup)
>  		dev_err(&port->dev,
> @@ -525,7 +525,6 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
>  			dev_name(dup->dport));
>  	else
>  		list_add_tail(&new->list, &port->dports);
> -	cxl_device_unlock(&port->dev);
>  
>  	return dup ? -EEXIST : 0;
>  }
> diff --git a/tools/testing/cxl/mock_acpi.c b/tools/testing/cxl/mock_acpi.c
> index 4c8a493ace56..667c032ccccf 100644
> --- a/tools/testing/cxl/mock_acpi.c
> +++ b/tools/testing/cxl/mock_acpi.c
> @@ -57,7 +57,9 @@ static int match_add_root_port(struct pci_dev *pdev, void *data)
>  
>  	/* TODO walk DVSEC to find component register base */
>  	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> +	device_lock(&port->dev);
>  	rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
> +	device_unlock(&port->dev);
>  	if (rc) {
>  		dev_err(dev, "failed to add dport: %s (%d)\n",
>  			dev_name(&pdev->dev), rc);
> @@ -78,7 +80,9 @@ static int mock_add_root_port(struct platform_device *pdev, void *data)
>  	struct device *dev = ctx->dev;
>  	int rc;
>  
> +	device_lock(&port->dev);
>  	rc = cxl_add_dport(port, &pdev->dev, pdev->id, CXL_RESOURCE_NONE);
> +	device_unlock(&port->dev);
>  	if (rc) {
>  		dev_err(dev, "failed to add dport: %s (%d)\n",
>  			dev_name(&pdev->dev), rc);
> 

Since I really don't understand, perhaps an explanation as to why you aren't
using cxl_device_lock would help? (Is it just to get around not having a
cxl_device_lock_assert())?
