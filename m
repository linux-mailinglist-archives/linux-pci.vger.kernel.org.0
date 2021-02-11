Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59FB319079
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 17:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhBKQ4q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 11:56:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:47864 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbhBKQzA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 11:55:00 -0500
IronPort-SDR: 4PIOMny2LNWNl9rpoudWWMEQx5JwP8a9GMHguB5Le7Ppe4ILQ5Ii2qG17rBrHcZ5Cvb//NqLm8
 pqMV5NBPc7sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="161418670"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="161418670"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 08:54:17 -0800
IronPort-SDR: eqa7Zt7LeUeFWr07RwW6Yo3OMmzIqxQ7k3HTy++wEpIlr3FG91G5Y0vNTl0ZXVnN7aN+toi7f1
 IJHL3eBkFpKw==
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="380757905"
Received: from reknight-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.254])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 08:54:16 -0800
Date:   Thu, 11 Feb 2021 08:54:14 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig
        <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, David
        Hildenbrand <david@redhat.com>, David Rientjes" <rientjes@google.com>,
        "Jon Masters <jcm@jonmasters.org>, Rafael Wysocki
        <rafael.j.wysocki@intel.com>, Randy Dunlap" <rdunlap@infradead.org>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        kernel test robot <lkp@intel.com>,
        Dan Williams <dan.j.willams@intel.com>
Subject: Re: [PATCH v2 4/8] cxl/mem: Add basic IOCTL interface
Message-ID: <20210211165414.wwsu63lhoznzrhof@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-5-ben.widawsky@intel.com>
 <20210210184540.00007536@Huawei.com>
 <CAPcyv4hRUB3jxdCV06y0kYMbKbGroEW6F9yOQ4KB_z6YgWBZ4Q@mail.gmail.com>
 <20210211100646.00007dcc@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211100646.00007dcc@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-11 10:06:46, Jonathan Cameron wrote:
> On Wed, 10 Feb 2021 20:40:52 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > On Wed, Feb 10, 2021 at 10:47 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > [..]
> > > > +#define CXL_CMDS                                                          \
> > > > +     ___C(INVALID, "Invalid Command"),                                 \
> > > > +     ___C(IDENTIFY, "Identify Command"),                               \
> > > > +     ___C(MAX, "Last command")
> > > > +
> > > > +#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> > > > +enum { CXL_CMDS };
> > > > +
> > > > +#undef ___C
> > > > +#define ___C(a, b) { b }
> > > > +static const struct {
> > > > +     const char *name;
> > > > +} cxl_command_names[] = { CXL_CMDS };
> > > > +#undef ___C  
> > >
> > > Unless there are going to be a lot of these, I'd just write them out long hand
> > > as much more readable than the macro magic.  
> > 
> > This macro magic isn't new to Linux it was introduced with ftrace:
> > 
> > See "cpp tricks and treats": https://lwn.net/Articles/383362/
> 
> Yeah. I've dealt with that one a few times. It's very cleaver and compact
> but a PITA to debug build errors related to it.
> 
> > 
> > >
> > > enum {
> > >         CXL_MEM_COMMAND_ID_INVALID,
> > >         CXL_MEM_COMMAND_ID_IDENTIFY,
> > >         CXL_MEM_COMMAND_ID_MAX
> > > };
> > >
> > > static const struct {
> > >         const char *name;
> > > } cxl_command_names[] = {
> > >         [CXL_MEM_COMMAND_ID_INVALID] = { "Invalid Command" },
> > >         [CXL_MEM_COMMAND_ID_IDENTIFY] = { "Identify Comamnd" },
> > >         /* I hope you never need the Last command to exist in here as that sounds like a bug */
> > > };
> > >
> > > That's assuming I actually figured the macro fun out correctly.
> > > To my mind it's worth doing this stuff for 'lots' no so much for 3.  
> > 
> > The list will continue to expand, and it eliminates the "did you
> > remember to update cxl_command_names" review burden permanently.
> 
> How about a compromise.  Add a comment giving how the first entry expands to
> avoid people (me at least :) having to think their way through it every time?
> 
> Jonathan
> 

A minor tweak while here...

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 655fbfde97fd..dac0adb879ec 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -22,7 +22,7 @@
 #define CXL_CMDS                                                          \
        ___C(INVALID, "Invalid Command"),                                 \
        ___C(IDENTIFY, "Identify Command"),                               \
-       ___C(MAX, "Last command")
+       ___C(MAX, "invalid / last command")

 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
 enum { CXL_CMDS };
@@ -32,6 +32,17 @@ enum { CXL_CMDS };
 static const struct {
        const char *name;
 } cxl_command_names[] = { CXL_CMDS };
+
+/*
+ * Here's how this actually breaks out:
+ * cxl_command_names[] = {
+ *     [CXL_MEM_COMMAND_ID_INVALID] = { "Invalid Command" },
+ *     [CXL_MEM_COMMAND_ID_IDENTIFY] = { "Identify Comamnd" },
+ *     ...
+ *     [CXL_MEM_COMMAND_ID_MAX] = { "invalid / last command" },
+ * };
+ */
+
