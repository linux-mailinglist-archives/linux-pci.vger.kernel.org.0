Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2F079E504
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjIMKfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 06:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjIMKfJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 06:35:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED05C3;
        Wed, 13 Sep 2023 03:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694601305; x=1726137305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FxXFLcgS0tkbgwbgFkV6clvTTkE1UGaCelT0BV73iS0=;
  b=OWCboalundD7bKSlQkAAFEXLNHuiSKzu6OFwFA5pzx0pmSvCNuBRqbeD
   1+rnXqAEBDREVvrGVcCfKSnKm13/iGup2sw/prwwaHJ/QWl3kgDmIpFg0
   EdGPfJdQIIrBNaJdi8KsB9nDdUIRv0+tN/6qzEIioSgHuHe4NjaftUwu5
   3HneZWbU5sFFSwkShEiK0HxPlHvWI0LpKEyASawO3qsMzUyo2itzL+Gtn
   EEyIPBhlHMoF9sm4Eo91SrXdA+/nYAMa9Y6DzLYYq7ApTjl1hQSXiJTNc
   7P81Ps1JSZCy1D2uhFMGF6ICz6THRUVhVqsYD5kpTaO83MhBfQerKYvj4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409572475"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="409572475"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:35:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="1074903148"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="1074903148"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Sep 2023 03:35:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E28A6C0D; Wed, 13 Sep 2023 13:34:59 +0300 (EEST)
Date:   Wed, 13 Sep 2023 13:34:59 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
Subject: Re: [PATCH v18 1/2] PCI: Move the `PCI_CLASS_SERIAL_USB_USB4`
 definition to common header
Message-ID: <20230913103459.GH1599918@black.fi.intel.com>
References: <20230913040832.114610-1-mario.limonciello@amd.com>
 <20230913040832.114610-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230913040832.114610-2-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 12, 2023 at 11:08:31PM -0500, Mario Limonciello wrote:
> `PCI_CLASS_SERIAL_USB_USB4` may be used by code outside of thunderbolt.
> Move the declaration into the common pci_ids.h header.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Mika Westerberberg <mika.westerberg@linux.intel.com>
