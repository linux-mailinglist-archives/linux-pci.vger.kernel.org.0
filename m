Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A08786A17
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 10:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjHXIbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 04:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240544AbjHXIb3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 04:31:29 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931161724
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 01:31:25 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:3c6b:f703:5ab5:f36d])
        by andre.telenet-ops.be with bizsmtp
        id dLXN2A00B01sfPQ01LXNtj; Thu, 24 Aug 2023 10:31:22 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qZ5kQ-001ccI-BO;
        Thu, 24 Aug 2023 10:31:22 +0200
Date:   Thu, 24 Aug 2023 10:31:22 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Subject: Re: [PATCH V13 4/5] of: overlay: Extend of_overlay_fdt_apply() to
 specify the target node
In-Reply-To: <1692120000-46900-5-git-send-email-lizhi.hou@amd.com>
Message-ID: <2aae84b8-41f9-3c24-bac9-8f882d2211b@linux-m68k.org>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com> <1692120000-46900-5-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-249000650-1692865882=:386713"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-249000650-1692865882=:386713
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

 	Hi Lizhi,

On Tue, 15 Aug 2023, Lizhi Hou wrote:
> Currently, in an overlay fdt fragment, it needs to specify the exact
> location in base DT. In another word, when the fdt fragment is generated,
> the base DT location for the fragment is already known.
>
> There is new use case that the base DT location is unknown when fdt
> fragment is generated. For example, the add-on device provide a fdt
> overlay with its firmware to describe its downstream devices. Because it
> is add-on device which can be plugged to different systems, its firmware
> will not be able to know the overlay location in base DT. Instead, the
> device driver will load the overlay fdt and apply it to base DT at runtime.
> In this case, of_overlay_fdt_apply() needs to be extended to specify
> the target node for device driver to apply overlay fdt.
>    int overlay_fdt_apply(..., struct device_node *base);
>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Thanks for your patch, which is now commit 47284862bfc7fd56 ("of:
overlay: Extend of_overlay_fdt_apply() in dt-rh/for-next.

> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -715,6 +730,7 @@ static struct device_node *find_target(struct device_node *info_node)
> /**
>  * init_overlay_changeset() - initialize overlay changeset from overlay tree
>  * @ovcs:		Overlay changeset to build
> + * @target_base:	Point to the target node to apply overlay
>  *
>  * Initialize @ovcs.  Populate @ovcs->fragments with node information from
>  * the top level of @overlay_root.  The relevant top level nodes are the

As an overlay can contain one or more fragments, this means the
base (when specified) will be applied to all fragments, and will thus
override the target-path properties in all fragments.

However, for the use case of an overlay that you can plug into
a random location (and of which there can be multiple instances),
there can really be only a single fragment.  Even nodes that typically
live at the root level (e.g. gpio-leds or gpio-keys) must be inserted
below the specified location, to avoid conflicts.

Hence:
   1. Should init_overlay_changeset() return -EINVAL if target_base is
      specified, and there is more than one fragment?

   2. Should there be a convention about the target-path property's
      contents in the original overlay?
      drivers/of/unittest-data/overlay_pci_node.dtso in "[PATCH V13 5/5]
      of: unittest: Add pci_dt_testdrv pci driver" uses

          target-path="";

      which cannot be represented when using sugar syntax.
      "/" should work fine, though.

Thanks!

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
--8323329-249000650-1692865882=:386713--
