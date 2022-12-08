Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134B5647160
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 15:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLHOMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 09:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiLHOMB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 09:12:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECE9AE63
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 06:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670508720; x=1702044720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yUQTEKvQjQ4QXRZzJbaWLgJ89uPgoiydI0Ag/KDyonU=;
  b=HW4FYQxXP4LFht/nswm5/5ty3UUm+cd0+itYoyReSjeG35qq2Moa+e0r
   +5LbmYvrE96UJU/hBz/hNtysFt2hldeM2wpZcf9CivqXbiCDVAnskbP6N
   RUC1H7nyXq7tGTsSlg5nnC2OmGszXuNxG7RvzQ02uNUOVo/U2OBjc5C6+
   9zfuNbw52/lxoF0qnGrbHPv1u2RptfeDKet+vFCCNqwT4frDbdICEFhK7
   U6fMMUGn+/9m60bx8ZwHwiZtZq/guHlGQQ2C9v4kp5L43UDvzQi3Jm5QS
   AIBiqNlV9XGj5idbjoH+H/V3HsdnxxV2BwYDdvRfw+rpd1Yq71yro02d4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="315896063"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="315896063"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 06:12:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="821348514"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="821348514"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 08 Dec 2022 06:11:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B3787132; Thu,  8 Dec 2022 16:12:26 +0200 (EET)
Date:   Thu, 8 Dec 2022 16:12:26 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Do not require an interrupt for all AER
 capable ports
Message-ID: <Y5HwyuakOOjwtj83@black.fi.intel.com>
References: <Y5F9EnsNqyc3hEeK@black.fi.intel.com>
 <20221208122349.GA1525911@bhelgaas>
 <Y5HtezTzYaU6ZOcM@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5HtezTzYaU6ZOcM@black.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 08, 2022 at 03:58:19PM +0200, Mika Westerberg wrote:
> If there is no driver attached to PCI device (this case upstream port)
> it will not enter low power states. It allows GPU to suspend but it
> does not allow the whole topology to enter low power states.

Ah, also in our case they saw the portdv probe fail in the logs.
