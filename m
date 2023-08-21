Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3277830D2
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 21:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHUTNI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 15:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjHUTNH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 15:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F44E48;
        Mon, 21 Aug 2023 12:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 722DC63A1A;
        Mon, 21 Aug 2023 19:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95652C433C8;
        Mon, 21 Aug 2023 19:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692645178;
        bh=OOZ4kFfEqbg85LKt+jWFAAcHUoGmUO/aZufE4dL7PEw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BHuUivl6+HAwmJnI+mMIejsRhIAqOV+IeMIteekVUPdu51rGqJOihfDqrVly55315
         Uq3knRP9sn8+UBW+5qkLefayRIJz5XJsNB6puUHe6PLtBa2vnQtgIdyVXVRs2vjxGu
         f1+F3RSV7mDp6N+faLdEhmhZeg8/WpLVhnykRg0Hb6HjIYvoZfO8NjUcKXfIrHGh3X
         y/s4W6cAaMryAXuYZqEkLZ3udYwbmufJyj4LlcU3vm0uUgm97DnFaGyDbdI2PmYIle
         mGzEYnKMR5yaFYDIF3W+S72RxuU9hHu8LvgkpoTjBGUVRovZ2wx3Rjwh4mpdclx6FT
         1qhdSUD+JoUoQ==
Date:   Mon, 21 Aug 2023 14:12:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
        Jonas =?iso-8859-1?Q?Dre=DFler?= <verdre@v0yd.nl>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v5 06/11] drm/radeon: Use RMW accessors for changing
 LNKCTL
Message-ID: <20230821191256.GA365126@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR12MB5144FF7542426AB3B4C66082F71BA@BL1PR12MB5144.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 04:12:57PM +0000, Deucher, Alexander wrote:
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

Added your ack, thanks!  I dropped the stable tag on the whole series.

Bjorn
