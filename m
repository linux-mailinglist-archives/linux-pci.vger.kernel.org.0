Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE46712658
	for <lists+linux-pci@lfdr.de>; Fri, 26 May 2023 14:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbjEZMNA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 May 2023 08:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjEZMM7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 May 2023 08:12:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2121A4;
        Fri, 26 May 2023 05:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685103178; x=1716639178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3mF6zurg5dlS4/06LH1kw8Ah/Zk773sNRWv9o+cBqOA=;
  b=YAgA8Lfe4wIO0aqhFink1Fbq2FkRg+EgJ0+WLBmull2koXjqd5zXyyJX
   CF/Br24jilWAuf2jOqHM3YeXq4xHLOjzlP1t/Q99LFE54upTqPQ2Sl1CY
   JWN6Xg9fL2/Ql/cu9amiYemQN7DwPZ8azyruj4o0N6BV6eGpd/cIkt3dm
   swyStxP9SVT46FTXP1+Hp++wytOw/qEK88qAXIIcFRknnGX51hs27CJFA
   AuKSd6s6Orel8i3Dkd2VmUMdWj+3nDsSrhaCC2NPIUtu1MYAGWDc72QLo
   AOccGyUczBkfo2+feQmCHHCQeAThkX+pJhauvh8Td0+lNhAK2IUAjImzp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="357441214"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="357441214"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 05:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="655611684"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="655611684"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 26 May 2023 05:12:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 85068413; Fri, 26 May 2023 15:12:41 +0300 (EEST)
Date:   Fri, 26 May 2023 15:12:41 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4 1/2] PCI: Refactor pci_bridge_d3_possible()
Message-ID: <20230526121241.GU45886@black.fi.intel.com>
References: <20230524190726.17012-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524190726.17012-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 24, 2023 at 02:07:25PM -0500, Mario Limonciello wrote:
> All of the cases handled by pci_bridge_d3_possible() are specific
> to these branches:
> ```
> 	case PCI_EXP_TYPE_ROOT_PORT:
> 	case PCI_EXP_TYPE_UPSTREAM:
> 	case PCI_EXP_TYPE_DOWNSTREAM:
> ```
> Drop a level of indentation by returning false in the default case
> instead.  No intended functional changes.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
