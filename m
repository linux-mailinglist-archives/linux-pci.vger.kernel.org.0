Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5E268AB29
	for <lists+linux-pci@lfdr.de>; Sat,  4 Feb 2023 17:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjBDQXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Feb 2023 11:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjBDQXL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Feb 2023 11:23:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF615552;
        Sat,  4 Feb 2023 08:23:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F062BB80AEC;
        Sat,  4 Feb 2023 16:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70506C433EF;
        Sat,  4 Feb 2023 16:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675527786;
        bh=GW1ACmXKBNrpKVcgej0zSNr6jh0aqwGGlnfV1C4ghAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pSoTIYf0iREhh6mkf+z07L0TFNOBOEeRJfTsVFMjwrTSVUCNw+JYLBzG4avN7WFuk
         lYAFX1DxLDStHq57p/ZnovAo35FDbMoezbaAYFMDIKV9erAXBN+6D+1K98EcYDJ+PT
         o0g382x4E96BW4NbIj2bAQnFGL77IKankPqdJObPKF/UqPhyh0PV3PjMZXiLi89Ibn
         793v+PW3fhfb2JRPQuQLls+itHkVjBjsmW7gJOuKsQX7R2M/sP3Aw/WVRkIepM/SSG
         Ho2q9kDAB6q1lCo08+Cw3sEanI7FfaPCgqTNvLsZJ0S0PptsnfETVpf4U6k0VetsuB
         8uayRn7y0GcYA==
Date:   Sat, 4 Feb 2023 10:23:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Helge Deller <deller@gmx.de>, Zeno Davatz <zdavatz@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Revert "fbdev: Remove conflicting devices on PCI bus"
Message-ID: <20230204162305.GA2098741@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204085018.GA31758@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 04, 2023 at 09:50:18AM +0100, Lukas Wunner wrote:
> On Fri, Feb 03, 2023 at 05:09:09PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > This reverts commit 145eed48de278007f646b908fd70ac59d24ed81a.
> > 
> > Zeno Davatz reported that 145eed48de27 ("fbdev: Remove conflicting devices
> > on PCI bus") caused a console hang.  The machine was actually still usable
> > via ssh, etc., but there was no activity on the console.
> > 
> > Reverting 145eed48de27 for the nvidiafb on that system fixed the problem.
> > 
> > Revert 145eed48de27 ("fbdev: Remove conflicting devices on PCI bus") since
> > we don't know what caused the problem.
> > 
> > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=216859
> 
> Shouldn't that rather be:
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216859
> Fixes: 145eed48de27 ("fbdev: Remove conflicting devices on PCI bus")
> Cc: stable@vger.kernel.org # v6.1+

Yes, of course, thank you, Lukas!
