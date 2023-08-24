Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C873786E8D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 13:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbjHXL5b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 07:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241233AbjHXL5B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 07:57:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05663198A;
        Thu, 24 Aug 2023 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692878220; x=1724414220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7UV7BtqtKgzvNx05ctOUS2boseBXq82sEYT3Sr1qdKY=;
  b=oF3V5puabHiF6+tdl157gZ7ilTajMegFxn0YZwNzcBLYwm4kracHGOjp
   YAOGSmCvvsOjxAWv0/vIg1fyC38CrA8eAnFA6ERnS1LaJP+rP9vsagrSX
   b2LM8wCRc8+m4HvagdttjzvDlxAOpX2hagLF7D9lOfWNsBWPj9Loocikb
   B8w0T4sqGXJcsd6nHhubwgIiK6AfgDajhzCAABnnJAzFkqeKVxcE3x7J2
   UyS7Ien++rCmNru8Pv4f8PDAYcF2KTwwsFT3syrOfHv/ZeUk0Aa3Rg2AJ
   GW1v6zxlReTxIWKo0GKgz3X311Wb7cQdwmO3iQSVbh5Tem7ruQBb+PIwi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405424867"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="405424867"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 04:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="851478410"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="851478410"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 24 Aug 2023 04:56:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B937317F; Thu, 24 Aug 2023 14:56:56 +0300 (EEST)
Date:   Thu, 24 Aug 2023 14:56:56 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Add helper to check if any of ancestor device
 support D3cold
Message-ID: <20230824115656.GW3465@black.fi.intel.com>
References: <20230824044645.423378-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824044645.423378-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Aug 24, 2023 at 12:46:43PM +0800, Kai-Heng Feng wrote:
> In addition to nearest upstream bridge, driver may want to know if the
> entire hierarchy can be powered off to perform different action.
> 
> So walk higher up the hierarchy to find out if any device has valid
> _PR3.

I'm not entirely sure this is good idea. The drivers should expect that
the power will be turned off pretty soon after device enters D3hot. Also
_PR3 is not PCI concept it's ACPI concept so API like this would only
work on systems with ACPI.
