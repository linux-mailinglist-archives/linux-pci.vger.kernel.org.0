Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882AB314722
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 04:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhBIDlj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 22:41:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:10550 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhBIDi3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Feb 2021 22:38:29 -0500
IronPort-SDR: 2IbTFa0MrPgvzhOPJ8WcW+ZzFhiCDepWb4rwMW5pFwV4Wo6wJjQgttosN0uzwKAT6TEppfV+QR
 ec1xtLTmZocA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="178312505"
X-IronPort-AV: E=Sophos;i="5.81,164,1610438400"; 
   d="scan'208";a="178312505"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 19:36:29 -0800
IronPort-SDR: LN03VMDKQ/0sU1LGOQIASxmpP5Dpd6LL7QAsWNf8MtjRaqoKRyx5g591ArznAjEoE1NurvivIm
 LXXEAQG60rFw==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="435915502"
Received: from ashishs1-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.132.35])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 19:36:28 -0800
Date:   Mon, 8 Feb 2021 19:36:27 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 08/14] taint: add taint for direct hardware access
Message-ID: <20210209033611.dgty2z2z4ds7p2td@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-9-ben.widawsky@intel.com>
 <CAPcyv4iPXqO5FL4_bmMQaSvmUm9FVrPv9yPJr3Q4DQWYf4t5hQ@mail.gmail.com>
 <202102081406.CDE33FB8@keescook>
 <CAPcyv4ix=zmQdb5sFKN-9wOZFnitHN0sSwHZJgQeaEM+=6+W1w@mail.gmail.com>
 <CAPcyv4hFLnY4b8a7z+rWVeayHka4BLZyXse_ExSeRWuBRxjCwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hFLnY4b8a7z+rWVeayHka4BLZyXse_ExSeRWuBRxjCwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-08 17:03:25, Dan Williams wrote:
> On Mon, Feb 8, 2021 at 3:36 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Mon, Feb 8, 2021 at 2:09 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, Feb 08, 2021 at 02:00:33PM -0800, Dan Williams wrote:
> > > > [ add Jon Corbet as I'd expect him to be Cc'd on anything that
> > > > generically touches Documentation/ like this, and add Kees as the last
> > > > person who added a taint (tag you're it) ]
> > > >
> > > > Jon, Kees, are either of you willing to ack this concept?
> > > >
> > > > Top-posting to add more context for the below:
> > > >
> > > > This taint is proposed because it has implications for
> > > > CONFIG_LOCK_DOWN_KERNEL among other things. These CXL devices
> > > > implement memory like DDR would, but unlike DDR there are
> > > > administrative / configuration commands that demand kernel
> > > > coordination before they can be sent. The posture taken with this
> > > > taint is "guilty until proven innocent" for commands that have yet to
> > > > be explicitly allowed by the driver. This is different than NVME for
> > > > example where an errant vendor-defined command could destroy data on
> > > > the device, but there is no wider threat to system integrity. The
> > > > taint allows a pressure release valve for any and all commands to be
> > > > sent, but flagged with WARN_TAINT_ONCE if the driver has not
> > > > explicitly enabled it on an allowed list of known-good / kernel
> > > > coordinated commands.
> > > >
> > > > On Fri, Jan 29, 2021 at 4:25 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > > > > For drivers that moderate access to the underlying hardware it is
> > > > > sometimes desirable to allow userspace to bypass restrictions. Once
> > > > > userspace has done this, the driver can no longer guarantee the sanctity
> > > > > of either the OS or the hardware. When in this state, it is helpful for
> > > > > kernel developers to be made aware (via this taint flag) of this fact
> > > > > for subsequent bug reports.
> > > > >
> > > > > Example usage:
> > > > > - Hardware xyzzy accepts 2 commands, waldo and fred.
> > > > > - The xyzzy driver provides an interface for using waldo, but not fred.
> > > > > - quux is convinced they really need the fred command.
> > > > > - xyzzy driver allows quux to frob hardware to initiate fred.
> > > > >   - kernel gets tainted.
> > > > > - turns out fred command is borked, and scribbles over memory.
> > > > > - developers laugh while closing quux's subsequent bug report.
> > >
> > > But a taint flag only lasts for the current boot. If this is a drive, it
> > > could still be compromised after reboot. It sounds like this taint is
> > > really only for ephemeral things? "vendor shenanigans" is a pretty giant
> > > scope ...
> > >
> >
> > That is true. This is more about preventing an ecosystem / cottage
> > industry of tooling built around bypassing the kernel. So the kernel
> > complains loudly and hopefully prevents vendor tooling from
> > propagating and instead directs that development effort back to the
> > native tooling. However for the rare "I know what I'm doing" cases,
> > this tainted kernel bypass lets some experimentation and debug happen,
> > but the kernel is transparent that when the capability ships in
> > production it needs to be a native implementation.
> >
> > So it's less, "the system integrity is compromised" and more like
> > "you're bypassing the development process that ensures sanity for CXL
> > implementations that may take down a system if implemented
> > incorrectly". For example, NVME reset is a non-invent, CXL reset can
> > be like surprise removing DDR DIMM.
> >
> > Should this be more tightly scoped to CXL? I had hoped to use this in
> > other places in LIBNVDIMM, but I'm ok to lose some generality for the
> > specific concerns that make CXL devices different than other PCI
> > endpoints.
> 
> As I type this out it strikes me that plain WARN already does
> TAINT_WARN and meets the spirit of what is trying to be achieved.
> 
> Appreciate the skeptical eye Kees, we'll drop this one.

So I think this is a good compromise for now. However, the point of this taint
was that it is specifically called out what tainted the kernel. It'd be great to
know when we have a bug report it was this specifically that was the issue.
Rambling further I realize now that taint doesn't tell you which module tainted,
which would be great here. That's actually what I'd like.

End ramble.
