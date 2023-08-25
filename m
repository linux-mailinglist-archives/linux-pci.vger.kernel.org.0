Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC73787F42
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 07:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjHYF37 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 01:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbjHYF3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 01:29:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195B31FEC;
        Thu, 24 Aug 2023 22:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692941391; x=1724477391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7nAS5EPhqPsXIEPfnQNT4dt/gCwc/kV+DfYfbtVOcpQ=;
  b=KSkzoGoc5XZA7h2+Nwo4eMYJLk3JiZonsrG+gi1wbn5V0SNzBQXxhLKS
   Lw5JUk1dyBchxLiYSHU4nlbeHX4IvLfgTX9jAdchrF+kX8PF/XCnoswwP
   eIvNuBzxA+V2vCDZ/LoOieVEPGjefVwyyDAQf5XfuEm1zQbGPK1T0J6aj
   ETrMvgTSpTCQFToWULJI0JixR+LqaAtWa5bGkRHn1dn5vob1H479MpjYe
   SxsekyJWpuhRQFJSR0fXydzt95x75l3yQmQOKer/r+PuGp0u6Bi8YIBFA
   FE+mtl7DKUV5YXba06E3FEYn7Gja8PCuPEUahRXMlS5I8EWwUaI4w8SXY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="405636265"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="405636265"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 22:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="730916357"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="730916357"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2023 22:29:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2F2351CA; Fri, 25 Aug 2023 08:29:46 +0300 (EEST)
Date:   Fri, 25 Aug 2023 08:29:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Add helper to check if any of ancestor device
 support D3cold
Message-ID: <20230825052946.GX3465@black.fi.intel.com>
References: <20230824044645.423378-1-kai.heng.feng@canonical.com>
 <20230824115656.GW3465@black.fi.intel.com>
 <CAAd53p4Ey15SRkeW-5rDQfxrT8Cif+hYOk2BZ6iQpfd8s51wEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p4Ey15SRkeW-5rDQfxrT8Cif+hYOk2BZ6iQpfd8s51wEw@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 24, 2023 at 09:46:00PM +0800, Kai-Heng Feng wrote:
> Hi,
> 
> On Thu, Aug 24, 2023 at 7:57 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Thu, Aug 24, 2023 at 12:46:43PM +0800, Kai-Heng Feng wrote:
> > > In addition to nearest upstream bridge, driver may want to know if the
> > > entire hierarchy can be powered off to perform different action.
> > >
> > > So walk higher up the hierarchy to find out if any device has valid
> > > _PR3.
> >
> > I'm not entirely sure this is good idea. The drivers should expect that
> > the power will be turned off pretty soon after device enters D3hot. Also
> > _PR3 is not PCI concept it's ACPI concept so API like this would only
> > work on systems with ACPI.
> 
> IIUC, Bjorn wants to limit the AER/DPC disablement when device power
> is really off.
> Is "the power will be turned off pretty soon after device enters
> D3hot" applicable to most devices? Since config space is still
> accessible when device is in D3hot.

Well the device may be part of a topology, say Thunderbolt/USB4 (but can
be NVMe or similar) where it initially goes into D3hot but in the end
the whole topology is put into D3cold. The device driver really should
expect that this happens always and not try to distinguish between the
D3hot or D3cold.

> Unless there are cases when device firmware behave differently to
> D3hot? Then maybe it's better to disable AER for both D3hot, D3cold
> and system S3.

Yes, this makes sense.
