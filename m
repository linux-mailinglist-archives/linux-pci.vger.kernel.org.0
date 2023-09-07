Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7747976E6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 18:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbjIGQSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 12:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjIGQRl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 12:17:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6524B3C23;
        Thu,  7 Sep 2023 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694102823; x=1725638823;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=pnR5kstqGfQdtJCcOXHBRX9aXdYhQVq6t+ivw38b4fk=;
  b=Cz/mmv3IBGQBlIzGNQeWv6cxO/7eVIRldrPfezNAICRaWZKVm2uSqq9b
   EMT6JwQWm3brtg5v0IxUNn2NrrK3w2IspTchyh5fXZC7e4/Yhf7BFsYWJ
   gu2oi6OR/MLbnUHRaYAQ5Z1l4FfPtOCuVuOO9uxWo3C8DYxtcFIsijth5
   IdY57Mwa/3/HNUUGiFcO04t99MvUFygc/VcjK5IbwZvu1cm4QBRGeq7bf
   yBWoMqgSbVp2hI0kbHWWnc3AecwiDcALjqlVElSjR4Q+k/hI2dI6bnwdf
   ICgBlI50j2JdzIcVpXn3Bu5CEVts0O3M8iZjoeWCUeiZoazg8yFGp40mb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="380025588"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="380025588"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 02:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="832092585"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="832092585"
Received: from iraduica-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.61.21])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 02:43:31 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     suijingfeng <suijingfeng@loongson.cn>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <sui.jingfeng@linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Re: [Nouveau] [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the
 user to select the primary video adapter at boot time
In-Reply-To: <3f41eea5-d441-304d-f441-eaf7ce63d3e1@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <151c0429-dbc2-e987-1491-6c733ca159ac@suse.de>
 <3eced3f5-622f-31a6-f8a0-ff0812be74ff@loongson.cn>
 <6035cf27-1506-dda7-e1ca-d83ce5cb5340@suse.de>
 <3f41eea5-d441-304d-f441-eaf7ce63d3e1@loongson.cn>
Date:   Thu, 07 Sep 2023 12:43:29 +0300
Message-ID: <87edjagvy6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 06 Sep 2023, suijingfeng <suijingfeng@loongson.cn> wrote:
> Another limitation of the 'nomodeset' parameter is that
> it is only available on recent upstream kernel. Low version
> downstream kernel don't has this parameter supported yet.
> So this create inconstant developing experience. I believe that
> there always some people need do back-port and upstream work
> for various reasons.

While that may be true, it's not an argument in favour of adding new
module parameters or special values to existing module parameters. They
would have to be backported just as well.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
