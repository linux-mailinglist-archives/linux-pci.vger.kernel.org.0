Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAA17826A9
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 11:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjHUJ57 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 05:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjHUJ56 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 05:57:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477CCCA;
        Mon, 21 Aug 2023 02:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692611875; x=1724147875;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RPCj/Hzk+FNFieDTs98XdiamY2Vzer2lf8C6QZtmz6c=;
  b=Xv9vmsnH7XpW7frGVIRr3semZoj8E0Z6sE0UaEz6W2PyM/95xjfBvVrT
   u4uWD1zlIlIkvGc4v6ifKASWwKD3FGomj9wwYKL+GhEScpJC11vxcs6Cl
   U8HvJjm9sRSH9JZXaom474XA5pDwQgRGiPJWTEEOfl060aKkabCSu4s++
   mxgfP27Erlr7O0b3d7+m+VFNclEgnvYzi16oy25MrZME4ZDPQS0Q7mPmI
   4I88/lgqeL6wkV+8M/dLrFY/Nu/eXXCWAHeL8bRWfKGERN0cWKZsgLz2l
   TMi+P3GjoQemNIIHx/de8NTTDLyIKOZHlAiduQ9NULEQ3963FnoQYitqJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="437470460"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="437470460"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 02:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="765304744"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="765304744"
Received: from nsnaveen-mobl.gar.corp.intel.com ([10.252.54.252])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 02:57:46 -0700
Date:   Mon, 21 Aug 2023 12:57:39 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        =?ISO-8859-15?Q?Jonas_Dre=DFler?= <verdre@v0yd.nl>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v5 06/11] drm/radeon: Use RMW accessors for changing
 LNKCTL
In-Reply-To: <BL1PR12MB5144FF7542426AB3B4C66082F71BA@BL1PR12MB5144.namprd12.prod.outlook.com>
Message-ID: <674c5c35-9ce7-a144-719d-206ff2c16e8f@linux.intel.com>
References: <20230717120503.15276-1-ilpo.jarvinen@linux.intel.com> <20230717120503.15276-7-ilpo.jarvinen@linux.intel.com> <BL1PR12MB5144FF7542426AB3B4C66082F71BA@BL1PR12MB5144.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-229501122-1692611873=:1744"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-229501122-1692611873=:1744
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 18 Aug 2023, Deucher, Alexander wrote:

> [Public]
> 
> > -----Original Message-----
> > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Sent: Monday, July 17, 2023 8:05 AM
> > To: linux-pci@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; Lorenzo
> > Pieralisi <lorenzo.pieralisi@arm.com>; Rob Herring <robh@kernel.org>;
> > Krzysztof Wilczyński <kw@linux.com>; Emmanuel Grumbach
> > <emmanuel.grumbach@intel.com>; Rafael J . Wysocki <rafael@kernel.org>;
> > Heiner Kallweit <hkallweit1@gmail.com>; Lukas Wunner <lukas@wunner.de>;
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> > Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; amd-
> > gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org
> > Cc: Dean Luick <dean.luick@cornelisnetworks.com>; Jonas Dreßler
> > <verdre@v0yd.nl>; Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>;
> > stable@vger.kernel.org
> > Subject: [PATCH v5 06/11] drm/radeon: Use RMW accessors for changing
> > LNKCTL
> >
> > Don't assume that only the driver would be accessing LNKCTL. ASPM policy
> > changes can trigger write to LNKCTL outside of driver's control.
> > And in the case of upstream bridge, the driver does not even own the device
> > it's changing the registers for.
> >
> > Use RMW capability accessors which do proper locking to avoid losing
> > concurrent updates to the register value.
> >
> > Fixes: 8a7cd27679d0 ("drm/radeon/cik: add support for pcie gen1/2/3
> > switching")
> > Fixes: b9d305dfb66c ("drm/radeon: implement pcie gen2/3 support for SI")
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: stable@vger.kernel.org
> 
> For this and the amdgpu patch:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> I'm not sure if this is stable material however.  Is there some issue today?

These were added without Cc stable into pci.git/pcie-rmw.

-- 
 i.

--8323329-229501122-1692611873=:1744--
