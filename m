Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6306474976
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 18:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhLNRdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 12:33:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:47233 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229673AbhLNRdg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Dec 2021 12:33:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236568373"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="236568373"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 09:33:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="609958335"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2021 09:33:12 -0800
Received: from MAHMED6-mobl.amr.corp.intel.com (MAHMED6-mobl.amr.corp.intel.com [10.212.180.156])
        by linux.intel.com (Postfix) with ESMTP id 334F858095D;
        Tue, 14 Dec 2021 09:33:12 -0800 (PST)
Message-ID: <afc2e96167db7e1602a39f8b9aab42a860b0c654.camel@linux.intel.com>
Subject: Re: [PATCH V3 2/2] PCI: vmd: Override ASPM on TGL/ADL VMD devices
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Christoph Hellwig <hch@infradead.org>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adhitya Mohan <me@adhityamohan.in>
Date:   Tue, 14 Dec 2021 09:33:11 -0800
In-Reply-To: <YbhOQx60Qz/tLUKU@infradead.org>
References: <20211209201235.1314584-1-david.e.box@linux.intel.com>
         <20211209201235.1314584-2-david.e.box@linux.intel.com>
         <YbhOQx60Qz/tLUKU@infradead.org>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2021-12-13 at 23:56 -0800, Christoph Hellwig wrote:
> On Thu, Dec 09, 2021 at 12:12:35PM -0800, David E. Box wrote:
> > +static int vmd_enable_aspm(struct pci_dev *pdev, void *userdata)
> > +{
> > +	int features = *(int *)userdata;
> > +
> > +	if (features & VMD_FEAT_QUIRK_OVERRIDE_ASPM &&
> > +	    pdev->class == PCI_CLASS_STORAGE_EXPRESS) {
> > +		int pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> > +
> > +		if (pos) {
> > +			pci_write_config_word(pdev, pos + PCI_LTR_MAX_SNOOP_LAT,
> > 0x1003);
> > +			pci_write_config_word(pdev, pos +
> > PCI_LTR_MAX_NOSNOOP_LAT, 0x1003);
> > +			if (pcie_aspm_policy_override(pdev))
> > +				pci_info(pdev, "Unable of override ASPM
> > policy\n");
> > +		}
> 
> This is completely unredable due to the long lines.  Just return early on
> the two conditionals and it will all be fine.

Sure.

Thanks.

