Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94B0314374
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 00:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBHXG2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 18:06:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:42431 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhBHXG0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Feb 2021 18:06:26 -0500
IronPort-SDR: Ac6srf6szgDU9urgXTO5//h7lXwB69NwEkQgauulrWi6PtfCiB9qyvjw7WP+52h+Vko7XBK6nb
 v8DwdCDaadbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="160949495"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="160949495"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 15:05:45 -0800
IronPort-SDR: dZGsPb3PToeX1jGvq3Hjh+AuXcZBJNOGQocMMYrdNFTa2r3l93ZhZkx6Vf/2wpcBbRvauqsGhB
 9hAmBWPuN1Fw==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="411328411"
Received: from svetsa-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.133.103])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 15:05:43 -0800
Date:   Mon, 8 Feb 2021 15:05:42 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20210208230542.6qxga32zxxtit5hk@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-9-ben.widawsky@intel.com>
 <CAPcyv4iPXqO5FL4_bmMQaSvmUm9FVrPv9yPJr3Q4DQWYf4t5hQ@mail.gmail.com>
 <202102081406.CDE33FB8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202102081406.CDE33FB8@keescook>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-08 14:09:19, Kees Cook wrote:
> On Mon, Feb 08, 2021 at 02:00:33PM -0800, Dan Williams wrote:
> > [ add Jon Corbet as I'd expect him to be Cc'd on anything that
> > generically touches Documentation/ like this, and add Kees as the last
> > person who added a taint (tag you're it) ]
> > 
> > Jon, Kees, are either of you willing to ack this concept?
> > 
> > Top-posting to add more context for the below:
> > 
> > This taint is proposed because it has implications for
> > CONFIG_LOCK_DOWN_KERNEL among other things. These CXL devices
> > implement memory like DDR would, but unlike DDR there are
> > administrative / configuration commands that demand kernel
> > coordination before they can be sent. The posture taken with this
> > taint is "guilty until proven innocent" for commands that have yet to
> > be explicitly allowed by the driver. This is different than NVME for
> > example where an errant vendor-defined command could destroy data on
> > the device, but there is no wider threat to system integrity. The
> > taint allows a pressure release valve for any and all commands to be
> > sent, but flagged with WARN_TAINT_ONCE if the driver has not
> > explicitly enabled it on an allowed list of known-good / kernel
> > coordinated commands.
> > 
> > On Fri, Jan 29, 2021 at 4:25 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > For drivers that moderate access to the underlying hardware it is
> > > sometimes desirable to allow userspace to bypass restrictions. Once
> > > userspace has done this, the driver can no longer guarantee the sanctity
> > > of either the OS or the hardware. When in this state, it is helpful for
> > > kernel developers to be made aware (via this taint flag) of this fact
> > > for subsequent bug reports.
> > >
> > > Example usage:
> > > - Hardware xyzzy accepts 2 commands, waldo and fred.
> > > - The xyzzy driver provides an interface for using waldo, but not fred.
> > > - quux is convinced they really need the fred command.
> > > - xyzzy driver allows quux to frob hardware to initiate fred.
> > >   - kernel gets tainted.
> > > - turns out fred command is borked, and scribbles over memory.
> > > - developers laugh while closing quux's subsequent bug report.
> 
> But a taint flag only lasts for the current boot. If this is a drive, it
> could still be compromised after reboot. It sounds like this taint is
> really only for ephemeral things? "vendor shenanigans" is a pretty giant
> scope ...
> 
> -Kees
> 

Good point. Any suggestions?

> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  Documentation/admin-guide/sysctl/kernel.rst   | 1 +
> > >  Documentation/admin-guide/tainted-kernels.rst | 6 +++++-
> > >  include/linux/kernel.h                        | 3 ++-
> > >  kernel/panic.c                                | 1 +
> > >  4 files changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> > > index 1d56a6b73a4e..3e1eada53504 100644
> > > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > > @@ -1352,6 +1352,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
> > >   32768  `(K)`  kernel has been live patched
> > >   65536  `(X)`  Auxiliary taint, defined and used by for distros
> > >  131072  `(T)`  The kernel was built with the struct randomization plugin
> > > +262144  `(H)`  The kernel has allowed vendor shenanigans
> > >  ======  =====  ==============================================================
> > >
> > >  See :doc:`/admin-guide/tainted-kernels` for more information.
> > > diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> > > index ceeed7b0798d..ee2913316344 100644
> > > --- a/Documentation/admin-guide/tainted-kernels.rst
> > > +++ b/Documentation/admin-guide/tainted-kernels.rst
> > > @@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that to the aforementioned
> > >  script, but if you need something quick you can use this shell command to check
> > >  which bits are set::
> > >
> > > -       $ for i in $(seq 18); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
> > > +       $ for i in $(seq 19); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
> > >
> > >  Table for decoding tainted state
> > >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > @@ -100,6 +100,7 @@ Bit  Log  Number  Reason that got the kernel tainted
> > >   15  _/K   32768  kernel has been live patched
> > >   16  _/X   65536  auxiliary taint, defined for and used by distros
> > >   17  _/T  131072  kernel was built with the struct randomization plugin
> > > + 18  _/H  262144  kernel has allowed vendor shenanigans
> > >  ===  ===  ======  ========================================================
> > >
> > >  Note: The character ``_`` is representing a blank in this table to make reading
> > > @@ -175,3 +176,6 @@ More detailed explanation for tainting
> > >       produce extremely unusual kernel structure layouts (even performance
> > >       pathological ones), which is important to know when debugging. Set at
> > >       build time.
> > > +
> > > + 18) ``H`` Kernel has allowed direct access to hardware and can no longer make
> > > +     any guarantees about the stability of the device or driver.
> > > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > > index f7902d8c1048..bc95486f817e 100644
> > > --- a/include/linux/kernel.h
> > > +++ b/include/linux/kernel.h
> > > @@ -443,7 +443,8 @@ extern enum system_states {
> > >  #define TAINT_LIVEPATCH                        15
> > >  #define TAINT_AUX                      16
> > >  #define TAINT_RANDSTRUCT               17
> > > -#define TAINT_FLAGS_COUNT              18
> > > +#define TAINT_RAW_PASSTHROUGH          18
> > > +#define TAINT_FLAGS_COUNT              19
> > >  #define TAINT_FLAGS_MAX                        ((1UL << TAINT_FLAGS_COUNT) - 1)
> > >
> > >  struct taint_flag {
> > > diff --git a/kernel/panic.c b/kernel/panic.c
> > > index 332736a72a58..dff22bd80eaf 100644
> > > --- a/kernel/panic.c
> > > +++ b/kernel/panic.c
> > > @@ -386,6 +386,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
> > >         [ TAINT_LIVEPATCH ]             = { 'K', ' ', true },
> > >         [ TAINT_AUX ]                   = { 'X', ' ', true },
> > >         [ TAINT_RANDSTRUCT ]            = { 'T', ' ', true },
> > > +       [ TAINT_RAW_PASSTHROUGH ]       = { 'H', ' ', true },
> > >  };
> > >
> > >  /**
> > > --
> > > 2.30.0
> > >
> 
> -- 
> Kees Cook
