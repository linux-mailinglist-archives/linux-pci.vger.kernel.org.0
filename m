Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED7F71266C
	for <lists+linux-pci@lfdr.de>; Fri, 26 May 2023 14:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbjEZMRt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 May 2023 08:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjEZMRs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 May 2023 08:17:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10B6A4;
        Fri, 26 May 2023 05:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685103467; x=1716639467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SC394MjXAyrqe3bKzmS1W+BXidwEdrV5wN/hm3izlwI=;
  b=YIliS6CFEUUVfgXkOoSlPkPYGnsqAtXzlmQhSddZr6zCFUc3AlysXWZT
   H2DknxzHFGK5nW9XTuJygcPRfCt6IlwEvzHQQ9m4KdzXmNQzoe6C77O9L
   FB82GrW2UsaCzwYZpw3dwPmggSgNyWvioFqCL0NRLHZj+PAmEogm0kqRI
   jfaHvtzLOQMlEbdFQ4d1ZjeoinHxmh6kzC7O1u3MxTJUHGJ73eTb5/hnP
   86zxb2Fw9v7ZdWZDiMOyIVbev6fFCeSTib5vmJgoThqgD5B6VJ7RtR4gn
   8rAB6QSnhZes4EucCOPfytn88z94XFZEVxxFWT/u9K7EMy0yjU4AOSzRF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="353031196"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="353031196"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 05:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="682700451"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="682700451"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 26 May 2023 05:17:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3723A413; Fri, 26 May 2023 15:17:48 +0300 (EEST)
Date:   Fri, 26 May 2023 15:17:48 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Iain Lane <iain@orangesquash.org.uk>
Subject: Re: [PATCH v4 2/2] PCI: Don't assume root ports from > 2015 are
 power manageable
Message-ID: <20230526121748.GV45886@black.fi.intel.com>
References: <20230524190726.17012-1-mario.limonciello@amd.com>
 <20230524190726.17012-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524190726.17012-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 24, 2023 at 02:07:26PM -0500, Mario Limonciello wrote:
> Using a USB keyboard or mouse to wakeup the system from s2idle fails when
> that XHCI device is connected to a USB-C port for an AMD USB4 router.

nit: I think the correct is "xHCI" but no need to spin a new version
just for that.

> Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> all PCIe ports go into D3 during s2idle.
> 
> When specific root ports are put into D3 over s2idle on some AMD platforms
> it is not possible for the platform to properly identify wakeup sources.
> This happens whether the root port goes into D3hot or D3cold.
> 
> Comparing registers between Linux and Windows 11 this behavior to put
> these specific root ports into D3 at suspend is unique to Linux. On an
> affected system Windows does not put those specific root ports into D3
> over Modern Standby.
> 
> Windows doesn't put the root ports into D3 because root ports are not
> power manageable.

Probably better is to say:

 Windows avoids putting Root Ports that are not power manageable (e.g do
 not have platform firmware support) into low power states.

but again no need to respin just for that.

> Linux shouldn't assume root ports support D3 just because they're on a
> machine newer than 2015, the ports should also be deemed power manageable.
> Add an extra check explicitly for root ports to ensure D3 isn't selected
> for these ports.
> 
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
