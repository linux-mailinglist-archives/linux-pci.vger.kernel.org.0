Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672D75B0A73
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 18:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiIGQpP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIGQpH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 12:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CD927CE9;
        Wed,  7 Sep 2022 09:44:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A73619E9;
        Wed,  7 Sep 2022 16:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756ECC433D6;
        Wed,  7 Sep 2022 16:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662569087;
        bh=YA4emI2WlIyJgBHuczQnrAYy5P3DUtcl4VWIIUWK+7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tGtSPNHZYAfghhJCEFLUeRyDmk9LIfy9iJ7licoebP5rlWtpUJfg3nWQp60tqgX+G
         7BMLwyutaFgKMhI4FsHQk5YytRSOlbTWhRkoFMsjl0z7HiaA+xuOv9oUTyn5MTx8pV
         1pMHe7vyI8aNqQW3/Jx+ByviLqt4Jf2drVGWoptHpKfQxDNwowmEh44S4ZZ/HxDIad
         LGZquUmYCrnylbryi9P4ErYKfHHcrC1MFX4B/pmH62GDK8pZtd0Csb53ZSwymgHiiy
         xU2bgxrHhhhF/UBMWVCiR/EEGIvhnHguJvpBAx8Ed5EIRZjtyomXUZ1VvtEyVCa7TO
         d4leeHmYD8F3w==
Date:   Wed, 7 Sep 2022 11:44:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 07/10] PCI/PTM: Add suspend/resume
Message-ID: <20220907164445.GA121443@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxgshzycVe5HGymH@black.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 07, 2022 at 08:30:47AM +0300, Mika Westerberg wrote:
> On Tue, Sep 06, 2022 at 05:23:48PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> 
> I think it is good to explain here why this patch is needed. Even if
> just one sentence.

Absolutely, sorry I missed this!  I see I also forgot the SoB.
