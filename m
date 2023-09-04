Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC8A791620
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 13:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjIDLQV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 07:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIDLQU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 07:16:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6257ACCC;
        Mon,  4 Sep 2023 04:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693826177; x=1725362177;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xkahQRlb+qqO8DI8MibV257P8p0Bcb75uJfNntA0nb4=;
  b=Z1hR9teG57Iv9oKhNP3RMkTX9p9c6v+ogVM7IdbRvsuSxWlf5ZdAzHeN
   2ZrmcVaj29be02spgXGh45ov7AgTJW8QUY3HV/QODPky53NE1/63aH03J
   1lkYEux0YBm3pzEbMKhqO2EWII6OSpSe3Jskk2xdeDtjgM++8HmhGNOiu
   KUXvzc9yFh3KEZovWYWFy1Y0BD7Gq7FQ9cwDYFUqDp+GC2Oh5WGFkgopp
   cwEZJbAigoS3ahaT9Tel/9FoRUb1Qw2YinYxR6v5Fa1rt/Qhp+jfKmk3m
   XXfKQ7ELFUU1nqjDG4/WvcHQpzjYMymnaItBh7aRnsufJgRnH1cB0P8aX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="442976688"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="442976688"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 04:16:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="769958337"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="769958337"
Received: from okozlyk-mobl.ger.corp.intel.com ([10.249.44.17])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 04:16:13 -0700
Date:   Mon, 4 Sep 2023 14:16:07 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 00/10] Add PCIe Bandwidth Controller
In-Reply-To: <fa5a20d0-77db-58bd-3956-ac664dffa587@quicinc.com>
Message-ID: <21b95d9-86a5-dcb0-9dda-3f1cdd426b9e@linux.intel.com>
References: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com> <fa5a20d0-77db-58bd-3956-ac664dffa587@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1050272405-1693826176=:1759"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1050272405-1693826176=:1759
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 4 Sep 2023, Krishna Chaitanya Chundru wrote:

> 
> On 8/17/2023 5:46 PM, Ilpo Järvinen wrote:
> > Hi all,
> > 
> > This series adds PCIe bandwidth controller (bwctrl) and associated PCIe
> > cooling driver to the thermal core side for limiting PCIe link speed
> > due to thermal reasons. PCIe bandwidth controller is a PCI express bus
> > port service driver. A cooling device is created for each port the
> > service driver finds if they support changing speeds.
> 
> I see we had support for only link speed changes here but we need to add
> support for
> 
> link width change also as bandwidth notification from PCIe supports both link
> speed and link width.

Hi,

Thanks for the comment. In case you mean that the changes in Link Width 
should be reported correctly, they already are since the sysfs interface 
reads them directly from LNKSTA register.

Or did you perhaps mean that Bandwidth Controller should support also 
changing Link Width? If this is the case I don't know how it can be 
realized so a pointer on how it can be achieved would be appreciated.

-- 
 i.

> > bwctrl now is built on top of BW notifications revert. I'm just not
> > sure what is the best practice when re-adding some old functionality in
> > a modified form so please let me know if I need to somehow alter that
> > patch.
> > 
> > The series is based on top of the RMW changes in pci/pcie-rmw.
> > 
> > Ilpo Järvinen (10):
> >    PCI: Protect Link Control 2 Register with RMW locking
> >    drm/radeon: Use RMW accessors for changing LNKCTL2
> >    drm/amdgpu: Use RMW accessors for changing LNKCTL2
> >    drm/IB/hfi1: Use RMW accessors for changing LNKCTL2
> >    PCI: Store all PCIe Supported Link Speeds
> >    PCI: Cache PCIe device's Supported Speed Vector
> >    PCI/LINK: Re-add BW notification portdrv as PCIe BW controller
> >    PCI/bwctrl: Add "controller" part into PCIe bwctrl
> >    thermal: Add PCIe cooling driver
> >    selftests/pcie_bwctrl: Create selftests
> > 
> >   MAINTAINERS                                   |   8 +
> >   drivers/gpu/drm/amd/amdgpu/cik.c              |  41 +--
> >   drivers/gpu/drm/amd/amdgpu/si.c               |  41 +--
> >   drivers/gpu/drm/radeon/cik.c                  |  40 +--
> >   drivers/gpu/drm/radeon/si.c                   |  40 +--
> >   drivers/infiniband/hw/hfi1/pcie.c             |  30 +-
> >   drivers/pci/pcie/Kconfig                      |   9 +
> >   drivers/pci/pcie/Makefile                     |   1 +
> >   drivers/pci/pcie/bwctrl.c                     | 309 ++++++++++++++++++
> >   drivers/pci/pcie/portdrv.c                    |   9 +-
> >   drivers/pci/pcie/portdrv.h                    |  10 +-
> >   drivers/pci/probe.c                           |  38 ++-
> >   drivers/pci/remove.c                          |   2 +
> >   drivers/thermal/Kconfig                       |  10 +
> >   drivers/thermal/Makefile                      |   2 +
> >   drivers/thermal/pcie_cooling.c                | 107 ++++++
> >   include/linux/pci-bwctrl.h                    |  33 ++
> >   include/linux/pci.h                           |   3 +
> >   include/uapi/linux/pci_regs.h                 |   1 +
> >   tools/testing/selftests/Makefile              |   1 +
> >   tools/testing/selftests/pcie_bwctrl/Makefile  |   2 +
> >   .../pcie_bwctrl/set_pcie_cooling_state.sh     | 122 +++++++
> >   .../selftests/pcie_bwctrl/set_pcie_speed.sh   |  67 ++++
> >   23 files changed, 795 insertions(+), 131 deletions(-)
> >   create mode 100644 drivers/pci/pcie/bwctrl.c
> >   create mode 100644 drivers/thermal/pcie_cooling.c
> >   create mode 100644 include/linux/pci-bwctrl.h
> >   create mode 100644 tools/testing/selftests/pcie_bwctrl/Makefile
> >   create mode 100755
> > tools/testing/selftests/pcie_bwctrl/set_pcie_cooling_state.sh
> >   create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_speed.sh
> > 
> 
--8323329-1050272405-1693826176=:1759--
