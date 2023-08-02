Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC6476D69C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 20:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjHBSOY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 14:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjHBSOY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 14:14:24 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B13171B
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691000063; x=1722536063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UgdXSsyvw65ySj43we4vjITUumnhHwnMR2GnhOr4S6A=;
  b=lEeJSHYVtz8TsbIRTWhor/aMhcbgFNuWYdjwS9y8kzfNgmGInbPDrNVt
   wlva2SkD82cqYv4zWxVymNP1WfLMnabZKAh7HS4gjsdgSq7MIEar5vfJy
   Alde15/7ReJF8ZhVA5Bj3myvcX988AsIqQqnAGxWZjQieXjMdrjIqSeqz
   nBNsrPtB1NnpSrqj/LjbG6+eRH5KHoC2FBX7c4Xhg4t6QZBJfmc3JUGcO
   Qpx0x5WKClUiqz1cIZF9+FC1yoA6Xk2aJXlSiepgOPwr9c6/HnvVbScLR
   kOT1anE6EwAd7issXW2ICUA8vvjk7KU0fvn/NxJaongwmzQ27ZhghsITo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="373302199"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="373302199"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 11:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="764311955"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="764311955"
Received: from rickylop-mobl1.amr.corp.intel.com (HELO [10.212.125.114]) ([10.212.125.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 11:14:22 -0700
Message-ID: <74ea038e-5ec3-c24b-4e05-7b8116f13297@linux.intel.com>
Date:   Wed, 2 Aug 2023 13:14:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/5] PCI: add ArrowLake-S PCI ID for Intel HDAudio
 subsystem.
To:     Mark Brown <broonie@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <206f5a15-29f0-ec7c-1b85-50ace8ae7c2f@linux.intel.com>
 <20230802162541.GA60855@bhelgaas>
 <b1c21bfb-2d47-4c42-87b7-2846de02e017@sirena.org.uk>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <b1c21bfb-2d47-4c42-87b7-2846de02e017@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/2/23 11:34, Mark Brown wrote:
> On Wed, Aug 02, 2023 at 11:25:41AM -0500, Bjorn Helgaas wrote:
>> On Wed, Aug 02, 2023 at 11:07:36AM -0500, Pierre-Louis Bossart wrote:
> 
>>> I am not following. we just agreed a couple of weeks ago to record ALL
>>> Intel/HDaudio PCI IDs in the same pci_ids.h include file.
> 
>> I'm not sure who "we" is here.  If it included me and I signed up to
>> it, I apologize for forgetting, and go ahead and add my:
> 
>>   Acked-by: Bjorn Helgaas <bhelgaas@google.com>

This was the original thread for the record

https://lore.kernel.org/alsa-devel/20230717114511.484999-3-amadeuszx.slawinski@linux.intel.com/

>> I'm just pointing out the usual practice for pci_ids.h, as mentioned
>> in the file itself.

You're actually right that we didn't talk about the minimum criterion to
add a PCI ID to this file. To me it was a central place similar to the
cpu ids, etc., if it wasn't clear to everyone than it's good to agree on
this second point.

> I think the thing with these drivers is that we know they will become
> shared in fairly short order so it just becomes overhead to add then
> move the identifier and update.

Indeed, the sharing part is not always predictable and is subject to
roadmap changes made above my pay grade.

The intended use of the devices can vary as well, some PCI IDs for
desktops are intended to be used only by snd-hda-intel, but if one OEM
starts adding digital microphones then the SOF driver becomes required.

So rather than force everyone to follow changes at Intel or Intel
customers it's simpler to just add PCI IDs in pci_ids.h. We typically
deal with 3-4 PCI IDS per year


