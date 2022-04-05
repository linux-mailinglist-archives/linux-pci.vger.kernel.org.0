Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994624F36EC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 16:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbiDELJF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 07:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352509AbiDEKEk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 06:04:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9CFBABBC;
        Tue,  5 Apr 2022 02:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649152401; x=1680688401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VDvK04o8caLp/soQY/A5TNib+Od/eTs0oaHnfnSXUpM=;
  b=FrsnyGkAIkTD0AcRxqYLFSi5XIyq4VA/CIf89Obgl//h2vsoLi/xhh2g
   SAgjvBUlouH1ZvsXf8HNqP7Uzgcb0TcMjODl/6MFr+ZOZirLvrqhzZ0ar
   20qo7NfGr24hf5YnYTyXGnT2C/eD/wkIFEz2lHuxBq9NoKdFzd9yOvNY9
   KN51ujmKxnh1b/63bCh4mtorwdWaj4D58EQa3gvF90FaMds+Fcd6UQQae
   aci5/ocdnsn+Zh4pHTGKHj0eUFwK21+8BVdNbbhk0SpLk220FZr/8X9/X
   /w/P42AcL1Wa8wh4JI2/Kcd75w75diqetS21XAAoBrFLvM7efYeT2wDg5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323883734"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="323883734"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 02:53:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="505219314"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 02:53:18 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 05 Apr 2022 12:53:16 +0300
Date:   Tue, 5 Apr 2022 12:53:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v1 1/2] PCI: PM: Avoid leaving devices in
 D0-uninitialized in pci_power_up()
Message-ID: <YkwRjI0KvpmiJjvK@lahna>
References: <4198163.ejJDZkT8p0@kreacher>
 <3623886.MHq7AAxBmi@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3623886.MHq7AAxBmi@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 04, 2022 at 05:41:13PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In theory, pci_power_up() may leave a device in D0-uninitialized
> during a transition from D3cold to D0.
> 
> Say, a PCIe device depending on some ACPI power resources is put into
> D3cold, so the power resources in question are all turned off.  Then,
> pci_power_up() is called to put it into D0.
> 
> It first calls pci_platform_power_transition() which invokes
> platform_pci_set_power_state() to turn on the ACPI power resources
> depended on by the device and, if that is successful, it calls
> pci_update_current_state() to update the current_state field of
> the PCI device object.  If the device's configuration space is
> accessible at this point, which is the case if
> platform_pci_set_power_state() leaves it in D0-uninitialized (and
> there's nothing to prevent it from doing so), current_state will be
> set to PCI_D0 and the pci_raw_set_power_state() called subsequently
> will notice that the device is in D0 already and do nothing.
> However, that is not correct, because it may be still necessary to
> restore the device's BARs at this point.
> 
> To address this issue, set current_state temporarily to PCI_D3hot
> in the cases in which pci_raw_set_power_state() may need to do more
> than just changing the power state of the device.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
