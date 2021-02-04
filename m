Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF09310013
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 23:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhBDWZL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 17:25:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:53358 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhBDWZI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 17:25:08 -0500
IronPort-SDR: 12SpxswXJ0iiSFsRgV8eyo+WPutEluUsOBOd+o7AL1h+KJhXLY6wzDUqy6mic9bCBlm8IflXWS
 QcgBYfOJFdkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="168455567"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="168455567"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 14:24:27 -0800
IronPort-SDR: y/7S/VUBRnji49Z9RcM7MCK9m9bPc9F2qnjPMyRowJSljxxzoccj0mjoNWsOJdTYwHZYVCzA52
 cylVr2edM40A==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="576429167"
Received: from jguillor-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.14])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 14:24:26 -0800
Date:   Thu, 4 Feb 2021 14:24:25 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     "John Groves (jgroves)" <jgroves@micron.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "daniel.lll@alibaba-inc.com" <daniel.lll@alibaba-inc.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [EXT] Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
Message-ID: <20210204222425.5vlulgaip7stal3z@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-5-ben.widawsky@intel.com>
 <20210201175400.GG197521@fedora>
 <20210201191316.e3kkkwqbx5fujp6y@intel.com>
 <CAPcyv4hP6AOV1OQKbohCqczM1RUPQHQ07+7MuNJ1_p6+opLSQQ@mail.gmail.com>
 <SN6PR08MB46052FE9BC20A747CACD8F50D1B39@SN6PR08MB4605.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR08MB46052FE9BC20A747CACD8F50D1B39@SN6PR08MB4605.namprd08.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-04 21:53:29, John Groves (jgroves) wrote:
>    Micron Confidential
> 
> 
> 
>    From: Dan Williams <dan.j.williams@intel.com>
>    Date: Monday, February 1, 2021 at 1:28 PM
>    To: Ben Widawsky <ben.widawsky@intel.com>
>    Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
>    linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>, Linux ACPI
>    <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List
>    <linux-kernel@vger.kernel.org>, linux-nvdimm
>    <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>,
>    Bjorn Helgaas <helgaas@kernel.org>, Chris Browy
>    <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Ira
>    Weiny <ira.weiny@intel.com>, Jon Masters <jcm@jonmasters.org>, Jonathan
>    Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki
>    <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
>    Vishal Verma <vishal.l.verma@intel.com>, daniel.lll@alibaba-inc.com
>    <daniel.lll@alibaba-inc.com>, John Groves (jgroves)
>    <jgroves@micron.com>, Kelley, Sean V <sean.v.kelley@intel.com>
>    Subject: [EXT] Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
> 
>    CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
>    you recognize the sender and were expecting this message.
>    On Mon, Feb 1, 2021 at 11:13 AM Ben Widawsky <ben.widawsky@intel.com>
>    wrote:
>    >
>    > On 21-02-01 12:54:00, Konrad Rzeszutek Wilk wrote:
>    > > > +#define
>    cxl_doorbell_busy(cxlm)
>    \
>    > > > +   (cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET)
>    &                    \
>    > > > +    CXLDEV_MB_CTRL_DOORBELL)
>    > > > +
>    > > > +#define CXL_MAILBOX_TIMEOUT_US 2000
>    > >
>    > > You been using the spec for the values. Is that number also from it
>    ?
>    > >
>    >
>    > Yes it is. I'll add a comment with the spec reference.
> 
> 
> 
>    From section 8.2.8.4 in the CXL 2.0 spec: “The mailbox command timeout
>    is 2 seconds.”  So this should be:
> 
> 
>    #define CXL_MAILBOX_TIMEOUT_US 2000000
> 
> 
>    …right? 2000us is 2ms…
> 
> 

Thanks. This was caught already in earlier review by David Rientjes
<rientjes@google.com>

It's renamed CXL_MAILBOX_TIMEOUT_MS 2000
