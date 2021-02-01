Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D164C30AD7B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 18:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhBARLg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 12:11:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:58996 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhBARLe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 12:11:34 -0500
IronPort-SDR: QgyF0Z6EBtn3RwR8+WhIQw5DjW+pGNhuuz3EbZoP8aQDa+JqIVk0tTnbBtxNOCbRZ/SrMXj+j2
 UAuM2KXcPpTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="178155859"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="178155859"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 09:10:53 -0800
IronPort-SDR: HBYH405ROlMEXT03PmawXS4NPL/f9eJXfesa31754JNg5yULll9HHRdK5HY/0W32JLDR6YU/lE
 D8fqecKtWQ/Q==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="432430624"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 09:10:52 -0800
Date:   Mon, 1 Feb 2021 09:10:51 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 05/14] cxl/mem: Register CXL memX devices
Message-ID: <20210201171051.m3cbr3udczxwghqh@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-6-ben.widawsky@intel.com>
 <ecd93422-b272-2b76-1ec-cf6af744ae@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd93422-b272-2b76-1ec-cf6af744ae@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-01-30 15:52:01, David Rientjes wrote:
> On Fri, 29 Jan 2021, Ben Widawsky wrote:
> 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > new file mode 100644
> > index 000000000000..fe7b87eba988
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -0,0 +1,26 @@
> > +What:		/sys/bus/cxl/devices/memX/firmware_version
> > +Date:		December, 2020
> > +KernelVersion:	v5.12
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) "FW Revision" string as reported by the Identify
> > +		Memory Device Output Payload in the CXL-2.0
> > +		specification.
> > +
> > +What:		/sys/bus/cxl/devices/memX/ram/size
> > +Date:		December, 2020
> > +KernelVersion:	v5.12
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) "Volatile Only Capacity" as reported by the
> > +		Identify Memory Device Output Payload in the CXL-2.0
> > +		specification.
> > +
> > +What:		/sys/bus/cxl/devices/memX/pmem/size
> > +Date:		December, 2020
> > +KernelVersion:	v5.12
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) "Persistent Only Capacity" as reported by the
> > +		Identify Memory Device Output Payload in the CXL-2.0
> > +		specification.
> 
> Aren't volatile and persistent capacities expressed in multiples of 256MB?

As of the spec today, volatile and persistent capacities are required to be
in multiples of 256MB, however, future specs may not have such a requirement and
I think keeping sysfs ABI easily forward portable makes sense.
