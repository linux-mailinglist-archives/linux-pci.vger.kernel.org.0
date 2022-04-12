Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0B4FDD16
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377505AbiDLK4j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 06:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356946AbiDLKpq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 06:45:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89D659A67;
        Tue, 12 Apr 2022 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649756593; x=1681292593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=spVnMM+QgRSZn4l/UJxMcwljw0gQjm7dBFN3KL2Wmu8=;
  b=BfLNBKW+Jcc1kgjbSGKCgzpa6M4ePK4vkyxGpKsttfXbFHfeldet2MJz
   0tZtk4uMNgaoosGVD+X8slIPrLAXuBMGXblWAm60DXPQjuzcxnOFLOLox
   xQJIYhKrFdaGm+4auynV+E/RUnbV968//oFVGN2KB2sTdOnahFjVuix2d
   y3vWf4tadhqYdyLgFVXCJM3aX5HC+Y2bglXx45ULwW5O+JdRBnglB5+q1
   U0l8JXNlv2s/gvCn36cQLQeFfoEq4tR3YLyJmHFe9F1GiEPdjmfMgSyvn
   iVUjb+rJmMe81a54sreW7zn9IuEEZRbTS0kiAUsOoXEXwfaC8ZRatjpcf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261771070"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="261771070"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 02:43:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="572683971"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 02:43:01 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 12 Apr 2022 12:42:58 +0300
Date:   Tue, 12 Apr 2022 12:42:58 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 3/9] PCI/PM: Rearrange pci_update_current_state()
Message-ID: <YlVJorXPD1EoqVCB@lahna>
References: <4419002.LvFx2qVVIh@kreacher>
 <11975904.O9o76ZdvQC@kreacher>
 <4721615.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4721615.GXAFRqVoOG@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 11, 2022 at 04:21:04PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Save one config space access in pci_update_current_state() by
> testing the retireved PCI_PM_CTRL register value against
              ^^^^^^^^^
retrieved
