Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA08195E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 14:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfHEMey (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 08:34:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:21145 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfHEMey (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 08:34:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 05:34:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="192410973"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Aug 2019 05:34:50 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 05 Aug 2019 15:34:50 +0300
Date:   Mon, 5 Aug 2019 15:34:50 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Possible PCI Regression Linux 5.3-rc1
Message-ID: <20190805123450.GM2640@lahna.fi.intel.com>
References: <SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20190724133814.GA194025@google.com>
 <SL2P216MB0187E2042E5DB8D9F29E665280C10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <4f5afb8e-9013-980f-0553-c687d17ed8d5@deltatee.com>
 <SL2P216MB018719A03F048FFA0F745FED80DB0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB018719A03F048FFA0F745FED80DB0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Sun, Aug 04, 2019 at 08:47:43AM +0000, Nicholas Johnson wrote:
> Reversing the following commit solves the issue:
> 
> commit c2bf1fc212f7e6f25ace1af8f0b3ac061ea48ba5
> Author: Mika Westerberg <mika.westerberg@linux.intel.com>
> PCI: Add missing link delays required by the PCIe spec
> 
> Mika, care to weigh in (assuming you are back from four weeks leave)? 

I'm back now.

> Clearly this creates delays in "lspci -vt" in some Thunderbolt systems, 
> but not all - otherwise you would have caught it. You mentioned Ice Lake 
> in the commit log so perhaps it works fine on Ice Lake.

I also tried it on other systems but it may be that something is
missing. Can you add "pciepordrv.dyndbg" to the kernel command line (or
change the dev_dbg() in wait_for_downstream_link() to dev_info() instead
and attach the dmesg along with full 'sudo lspci -vv' output to the
following bugzilla (as I think they are the same issue in the end):

  https://bugzilla.kernel.org/show_bug.cgi?id=204413

Thanks!
