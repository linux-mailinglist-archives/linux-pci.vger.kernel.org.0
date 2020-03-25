Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A101192F71
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 18:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgCYRgn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 13:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgCYRgn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Mar 2020 13:36:43 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9851220740;
        Wed, 25 Mar 2020 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585157802;
        bh=9eALJJ0UKt97tZhSwa153d6PnCQpDgqwxiG7b/BKNNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Jvqm2z5+n+JIXKtrVRk+K6LFURZFenqK0y85Fut6knhbH195aLD6AjZ58rECOiX4i
         0Jbevi5XNmp3ESw1WGQk5lgpnIlRY7AclRSRlxk/hJgY8sMj+P1k530xqbGu698cc2
         TvSbA5VmzSl1exhbzEMUnJ6uZI0XOp8PiGqiq5qY=
Date:   Wed, 25 Mar 2020 12:36:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        bp@alien8.de, james.morse@arm.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, zhangliguang@linux.alibaba.com,
        tglx@linutronix.de, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        yangyicong@hisilicon.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v5 2/2] PCI: HIP: Add handling of HiSilicon HIP PCIe
 controller errors
Message-ID: <20200325173639.GA484@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24330bd8-afaa-d7ac-594c-f9fda4242400@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Dan]

On Wed, Mar 25, 2020 at 01:55:18PM +0000, Shiju Jose wrote:
> The HiSilicon HIP PCIe controller is capable of handling errors
> on root port and perform port reset separately at each root port.
> 
> This patch add error handling driver for HIP PCIe controller to log
> and report recoverable errors. Perform root port reset and restore
> link status after the recovery.
> 
> Following are some of the PCIe controller's recoverable errors
> 1. completion transmission timeout error.
> 2. CRS retry counter over the threshold error.
> 3. ECC 2 bit errors
> 4. AXI bresponse/rresponse errors etc.
> 
> Also fix the following Smatch warning:
> warn: should '((((1))) << (9 + i))' be a 64 bit type?
> if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
>      ^^^ This should be BIT_ULL() because it goes up to 9 + 32.
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

I'm glad you did this fix, and thanks for acknowledging Dan, but I
don't think it's necessary to mention it in the commit log here
because it won't really be useful in the future.  It's only relevant
when comparing the unmerged versions of this series, e.g., v4 compared
to v3.

If we were fixing something that's already been merged upstream, we
should absolutely include this, but since this hasn't been merged yet
Dan's report is basically the same as other review comments, which we
normally just address and mention in the change history in the [0/n]
cover letter (as you're already doing, thanks for that!).

Also, I think it's nice to CC: anybody who has commented on previous
versions of the patch series, so I added Dan to the CC: list here.
That way he can chime in if we're not addressing his report correctly.

> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> --
> drivers/pci/controller/Kconfig           |   8 +
> drivers/pci/controller/Makefile          |   1 +
> drivers/pci/controller/pcie-hisi-error.c | 336
> +++++++++++++++++++++++++++++++
> 3 files changed, 345 insertions(+)
> create mode 100644 drivers/pci/controller/pcie-hisi-error.c

As I mentioned in the other message, I think this file should be
drivers/pci/controller/dwc/pcie-hisi-error.c so it's right next to
pcie-hisi.c.  If there's some reason it needs to be here instead,
please mention that in the commit log.

> ---
>  drivers/pci/controller/Kconfig           |   8 +
>  drivers/pci/controller/Makefile          |   1 +
>  drivers/pci/controller/pcie-hisi-error.c | 357 +++++++++++++++++++++++
>  3 files changed, 366 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-hisi-error.c

> +struct hisi_pcie_err_data {
> +	u64   val_bits;
> +	u8    version;
> +	u8    soc_id;
> +	u8    socket_id;
> +	u8    nimbus_id;
> +	u8    sub_module_id;
> +	u8    core_id;
> +	u8    port_id;
> +	u8    err_severity;
> +	u16   err_type;
> +	u8    reserv[2];
> +	u32   err_misc[HISI_PCIE_ERR_MISC_REGS];
> +};
> +
> +struct hisi_pcie_err_info {
> +	struct hisi_pcie_err_data err_data;
> +	struct platform_device *pdev;
> +};
> +
> +struct hisi_pcie_err_private {
> +	struct notifier_block nb;
> +	struct platform_device *pdev;
> +};

Either align all the struct members or none of them.  Currently
hisi_pcie_err_data is aligned but hisi_pcie_err_info and
hisi_pcie_err_private are not.

> +	/* Call the ACPI handle to reset root port */

Superfluous comment.

> +	s = acpi_evaluate_integer(handle, "RST", &arg_list, &data);
> +	if (ACPI_FAILURE(s)) {
> +		dev_err(dev, "No RST method\n");
> +		return -EIO;
> +	}

> +static void hisi_pcie_handle_one_error(const struct hisi_pcie_err_data
> *err,
> +				    struct platform_device *pdev)

Align "struct platform_device ..." under "const struct
hisi_pcie_err_data ...".

Bjorn
