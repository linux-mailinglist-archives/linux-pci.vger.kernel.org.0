Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0A0613A5C
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 16:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiJaPlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 11:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiJaPlD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 11:41:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4676598;
        Mon, 31 Oct 2022 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667230850; x=1698766850;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vsRtz59r9+hBD/aRtnV2XsZe5ltc86zFnduMHYgvoqU=;
  b=jnZGJ/ou2d8Aa6BUdQroHFxQTTbDudOHV3OsAdmlWdO8+5CodKlFzauc
   6aGW9bWC8dzMlG0uuGUjzsLl/MoDgyo78VXv91Sg9NNk3MDFeLLwHfb2G
   Nlyvl9DLlq6i33rGeKM/YvCX0eHU62Hm/g1qRtUZCYL4XWXldu5cY72ak
   MSHf8EgVsk59jlypiglIhhcXWnzynw+vtVzswcEYus/DlIavVm9z84Z4u
   1u+l6xtQmvGXmhXSV7t1mqoR/wGpXSoYiAK1Kk73+RZVoFBWiTvr/dYTI
   FL69HZ++H3mfk7+A6GpzjvxXZwWWcKpmKPkna5tUp8pYjFnfHVlyaScK1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="395242924"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="395242924"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 08:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="878774354"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="878774354"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 31 Oct 2022 08:40:49 -0700
Received: from maheshgo-mobl.amr.corp.intel.com (unknown [10.255.229.142])
        by linux.intel.com (Postfix) with ESMTP id 491C6580BDF;
        Mon, 31 Oct 2022 08:40:49 -0700 (PDT)
Message-ID: <ddd1c452d8843fa137bc294b04ee5195967e4b67.camel@linux.intel.com>
Subject: Re: [PATCH V7 3/4] PCI: vmd: Add vmd_device_data
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 31 Oct 2022 08:40:49 -0700
In-Reply-To: <Y19zcYqxk7LcGQfG@infradead.org>
References: <20221025004411.2910026-4-david.e.box@linux.intel.com>
         <20221028191308.GA903098@bhelgaas> <Y19zcYqxk7LcGQfG@infradead.org>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2022-10-31 at 00:04 -0700, Christoph Hellwig wrote:
> On Fri, Oct 28, 2022 at 02:13:08PM -0500, Bjorn Helgaas wrote:
> > It looks like these devices come in families where several device IDs
> > share the same features.  I think this would be more readable if you
> > defined each family outside this table and simply referenced the
> > family here.  E.g., you could do something like:
> > 
> >   static struct vmd_device_data vmd_v1 = {
> >     .features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> > 		VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > 		VMD_FEAT_OFFSET_FIRST_VECTOR,
> >   };
> > 
> >   {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> >     .driver_data = (kernel_ulong_t) &vmd_v1,
> > 
> > Then you can add VMD_FEAT_BIOS_PM_QUIRK and the .ltr value in one place
> > instead of repeating it a half dozen times.
> 
> I wonder why we need the ltr field at all.  For those that set it
> is always the same value, so it could just be a quirk flag to set it.

Yeah, this makes sense particularly since this isn't intended as a permanent
fix. I'll get rid of it.

> 
> Tat being said I think thegrouping makes a lot of sense, but I'd just
> do it with a #define for the set of common quirk flags.

Works for me. I'll create a VMD_FEATS_CLIENT group but I'll keep the ltr quirk
separate since future client systems won't be using it.

David

