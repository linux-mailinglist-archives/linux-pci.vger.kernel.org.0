Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812AD57A9AD
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 00:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiGSWQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 18:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGSWQp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 18:16:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8FC4C62C;
        Tue, 19 Jul 2022 15:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EACCDB81D78;
        Tue, 19 Jul 2022 22:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC72C341CA;
        Tue, 19 Jul 2022 22:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658268999;
        bh=mYGEOu11Ux+xMeeiBucT0QIkBYxBBFukVuPKg0cuYv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vLyWN6P4TRw1hKQN86GnXE4o6I0Q6Cll+rIOfs4lDOP14D1qtAlX6AAFEZ6xvRmIF
         cqsRhUY1mzKXqFL982KD6QQfystVrLY5hNRVdamwFPLfdlkNa8rGfASy9qnA0tFcpg
         SLcjVpb+p2l216lkKklVE7+Dph3XzutZIIlQCX+mwD/lUsOqW5t+0CLdABUFCCYtd4
         8bL7w6s5IT6Q3TNxTCtF1G2jhLtKk3+XsJyYakqMe7xAVu+eKLNaSORi2WPkSGgbhD
         wOd9Rg0FuWvjuSX3bBlB9k42jZp5v9UkyEkF/0MlDTDSEJQMJXGPyzNWMaK8iQRKQb
         YnYz+bSwBzVkg==
Date:   Tue, 19 Jul 2022 17:16:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V16 4/6] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <20220719221637.GA1585132@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719205249.566684-5-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, s/mailbox's/mailboxes/

On Tue, Jul 19, 2022 at 01:52:47PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> DOE mailbox objects will be needed for various mailbox communications
> with each memory device.
> 
> Iterate each DOE mailbox capability and create PCI DOE mailbox objects
> as found.
> 
> It is not anticipated that this is the final resting place for the
> iteration of the DOE devices.  The support of switch ports will drive
> this code into the PCIe side.  In this imagined architecture the CXL
> port driver would then query into the PCI device for the DOE mailbox
> array.
> 
> For now creating the mailboxes in the CXL port is good enough for the
> endpoints.  Later PCIe ports will need to support this to support switch
> ports more generically.

> +static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u16 off = 0;
> +
> +	xa_init(&cxlds->doe_mbs);
> +	if (devm_add_action(&pdev->dev, cxl_pci_destroy_doe, &cxlds->doe_mbs)) {
> +		dev_err(dev, "Failed to create XArray for DOE's\n");

s/DOE's/DOEs/

> +		return;
> +	}
> +
> +	/*
> +	 * Mailbox creation is best effort.  Higher layers must determine if
> +	 * the lack of a mailbox for their protocol is a device failure or not.
> +	 */
> +	pci_doe_for_each_off(pdev, off) {
> +		struct pci_doe_mb *doe_mb;
> +
> +		doe_mb = pcim_doe_create_mb(pdev, off);
> +		if (IS_ERR(doe_mb)) {
> +			dev_err(dev, "Failed to create MB object for MB @ %x\n",

Maybe "%#x" to avoid ambiguity?  Also below.

> +				off);
> +			continue;
> +		}
> +
> +		if (xa_insert(&cxlds->doe_mbs, off, doe_mb, GFP_KERNEL)) {
> +			dev_err(dev, "xa_insert failed to insert MB @ %x\n",
> +				off);
> +			continue;
> +		}
> +
> +		dev_dbg(dev, "Created DOE mailbox @%x\n", off);
> +	}
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -434,6 +476,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
>  
> +	devm_cxl_pci_create_doe(cxlds);
> +
>  	rc = cxl_pci_setup_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> -- 
> 2.35.3
> 
