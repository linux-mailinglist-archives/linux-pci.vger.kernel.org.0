Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75F42AFBF9
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 02:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgKLBbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 20:31:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbgKKXDv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 18:03:51 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3389A208B8;
        Wed, 11 Nov 2020 23:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605135830;
        bh=Gj/5UEDBt8CVEIKja1eDcZ0nlYSBbNDAl0pvJ3rUQaU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uz/yGw5r6zcJSFWqdQ/nPbjnM+LdVbVX7fddaeUEOKOruCKsR3fihP5jd++PBF4CR
         Z++JbK1FAvmwbgig45ygXjHe4EdZLSnNzJPL/RkAMqah5+XXFFWNejWZyjvhtrXzVb
         WK4x4hLX9jkyk/0R+jOhczjsK8wY8vgBGj+PBxq8=
Date:   Wed, 11 Nov 2020 17:03:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
Message-ID: <20201111230348.GA978803@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111054356.793390-2-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 09:43:48PM -0800, Ben Widawsky wrote:

> +static int acpi_cxl_add(struct acpi_device *adev)
> +{
> +	struct acpi_cxl_desc *acpi_desc;
> +	struct device *dev = &adev->dev;
> +	struct acpi_table_header *tbl;
> +	acpi_status status = AE_OK;

Pointless init.

> +	acpi_size sz;
> +	int rc = 0;

Pointless init.

> +	status = acpi_get_table(ACPI_SIG_CEDT, 0, &tbl);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "failed to find CEDT at startup\n");
> +		return 0;
> +	}
> +
> +	rc = devm_add_action_or_reset(dev, acpi_cedt_put_table, tbl);
> +	if (rc)
> +		return rc;
