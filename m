Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF639520314
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 19:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiEIREj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 13:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbiEIREj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 13:04:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382FC2CDFA;
        Mon,  9 May 2022 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652115644; x=1683651644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IQAaOGNIHup3dlqcEGLfloOcfZwKgAymQIYObqEo9ug=;
  b=KPxKsQJXqR+fhIOmVJeVuOGTxP2zwDKVBQIhuweR0v60vkP3n43eGHYJ
   TxVWu2xHMwbEP7g42rdxQzpevnc+30et/an27vJhJSopwGwOyMtiN+1oj
   hP4ubsu+bYvZwfKoaV/Jzhqkaq7xOzXtdNPrvHyW5t0jwi75ehD0in75d
   b/BJd10es0quPNFMcq7I5JbF/xdXnzbzatOCSYPO7kmu5XP7GsklzvoqJ
   VayQFHIexq+8OB8cmcA0WTACiatGOMDUIlOdbi6v//Bb/gizteqmCsNCO
   37Ubbl4RQlwFrL5sZMacLEbRULUr+iwjIHKoZnnWnpqNm3hNI3mwOrwA9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249644226"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="249644226"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 10:00:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="634101067"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 10:00:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1no6kN-00Dzp9-Tv;
        Mon, 09 May 2022 20:00:35 +0300
Date:   Mon, 9 May 2022 20:00:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] add dynamic PCI device of_node creation for overlay
Message-ID: <YnlIs312R4Temgu3@smile.fi.intel.com>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
 <96db62bb-18be-f44a-6f53-05b22319f23a@gmail.com>
 <20220509141634.16158c38@xps-bootlin>
 <f9b0cbf1-dde2-ff97-cca0-5d2895734f91@gmail.com>
 <20220509180917.0f0ae851@xps-bootlin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220509180917.0f0ae851@xps-bootlin>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 09, 2022 at 06:09:17PM +0200, Clément Léger wrote:
> Le Mon, 9 May 2022 10:56:36 -0500,
> Frank Rowand <frowand.list@gmail.com> a écrit :

...

> > On the surface, it appears that your need might be well met by having
> > a base devicetree that describes all of the pcie nodes, but with each
> > node having a status of "disabled" so that they will not be used.
> > Have a devicetree overlay describing the pcie card (as you proposed),
> > where the overlay also includes a status of "ok" for the pcie node.
> > Applying the overlay, with a method of redirecting the target to a
> > specific pcie node would change the status of the pcie node to enable
> > its use.  (You have already proposed a patch to modify
> > of_overlay_fdt_apply() to allow a modified target, so not a new
> > concept from me.)  My suggestion is to apply the overlay devicetree
> > to the base devicetree before the combined FDT devicetree is passed
> > to the kernel at boot.  The overlay apply could be done by several
> > different entities.  It could be before the bootloader executes, it
> > could be done by the bootloader, it could be done by a shim between
> > the bootloader and the kernel.  This method avoids all of the issues
> > of applying an overlay to a running system that I find problematic.
> > It is also a method used by the U-boot bootloader, as an example.
> 
> Ok, that is actually possible on a system that is given a device-tree
> by the bootloader. But on a system that is desrcibed using ACPI (such
> as the x86), this is much more difficult (at least to my knowledge)...
> We want this feature to be easy to use for the end user. Adding such
> configuration which also differs between various architecture is
> clearly not so easy to setup.
> 
> Moreover, since the PCI is meant to be "Plug and Play", such
> configuration would completely break that. If the user switches the
> PCIe card from one slot to another, the bootloader configuration will
> need to be modified. This seems a big no way for me (and for the user).

The main problem here is that Linux does not support hotplugging for the
devices behind non-hotpluggable buses. You need to develop something to
say that the device tree (in terms of hardware) can morph at run-time
transparently to the user. I think the closest one is what FPGA does,
or at least should do.

> > The other big issue is mixing ACPI and devicetree on a single system.
> > Historically, the Linux devicetree community has not been receptive
> > to the ides of that mixture.  Your example might be a specific case
> > where the two can be isolated from each other, or maybe not.  (For
> > disclosure, I am essentially ACPI ignorant.)  I suspect that mixing
> > ACPI and devicetree is a recipe for disaster in the general case.
> 
> Agreed, on that fact, it did raised some eyebrows, and it was for that
> specific concern that initially, I proposed the fwnode solution.
> Honestly, the fwnode conversion represent a lot of work (hundreds of
> lines easily) + requires a conversion of all the subsystem that are not
> fwnode ready (spoiler: almost all of them are not ready). 

In either case you need to provide a format that would be suitable for
DT-based as well as ACPI-based platforms.

-- 
With Best Regards,
Andy Shevchenko


