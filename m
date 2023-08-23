Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378E07861BE
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 22:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbjHWUuo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 16:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbjHWUu3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 16:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE2C10C8;
        Wed, 23 Aug 2023 13:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4503F626F2;
        Wed, 23 Aug 2023 20:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB78C433C8;
        Wed, 23 Aug 2023 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692823826;
        bh=sLsDlfU5Dekw6NmapwcGF14aGsnd1Vw0nCXSqXj6qnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Im1Ibojw5h1jDDD2Wjvvd4ezFLuK51Ogkm+FWz/3d+s4qeU0grlS/zY7s2psgL8QN
         mgdw0XWL63o1Vx+8A2qr37wm6v0gCtoZk3sJZWfh9Ihq3LwYOOuaCL8DCklVcupxsB
         J/pobnAhxNoTLEiKAmAK19Zdbe5E6zOijgcIe+DbNNVRT+oiMRajdNZ+ib1HpQcOOD
         DFV4lyVTSLz+Qiw7KtFVaJWHynwsri6trHTN/hlmdr72KCF0PvK/OMO8fMUgS2Mrns
         7czlW+o/qPaiOcT1Zcg/+ZlL8x5v2qBhfMKf06MSUbk1wSAY4d+858vNwNlt2VL6pG
         tgYw9SZRInQJw==
Date:   Wed, 23 Aug 2023 15:50:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>, bhelgaas@google.com,
        rafael.j.wysocki@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        anders.roxell@linaro.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, guyinggang@loongson.cn,
        siyanteng@loongson.cn, chenhuacai@loongson.cn,
        loongson-kernel@lists.loongnix.cn, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v2] PCI/PM: Only read PCI_PM_CTRL register when available
Message-ID: <20230823205024.GA481013@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gvP3YRWTLtV9_b+W_QQ=K_wkFEDj-qT4cNW2RYfTPEgg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 02:46:25PM +0200, Rafael J. Wysocki wrote:
> On Wed, Aug 23, 2023 at 9:28 AM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Tue, 22 Aug 2023, Rafael J. Wysocki wrote:
> > > On Tue, Aug 22, 2023 at 3:24 PM Ilpo Järvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > >
> > > > On Tue, 22 Aug 2023, Feiyang Chen wrote:
> > > >
> > > > > When the current state is already PCI_D0, pci_power_up() will return
> > > > > 0 even though dev->pm_cap is not set. In that case, we should not
> > > > > read the PCI_PM_CTRL register in pci_set_full_power_state().
> > > >
> > > > IMHO, this is a bit misleading because after this patch, pci_power_up()
> > > > returns always an error if dev->pm_cap is not set.
> > >
> > > Yes, it does, but it has 2 callers only and the other one ignores the
> > > return value, so this only matters here.
> >
> > I did only mean that the changelog could be more clear how it achieves
> > the desired result (as currently it states opposite of what the code
> > does w.r.t. that return value).
> 
> Fair enough.
> 
> It looks like the changelog has not been updated since v1.
> 
> > I'm not against the approach taken by patch.

Feiyang, would you update the commit log so it matches the code and
post it as a v3?

Bjorn
