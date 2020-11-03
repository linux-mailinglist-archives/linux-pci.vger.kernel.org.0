Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7713D2A58A0
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 22:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgKCVxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 16:53:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:6507 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731154AbgKCUqM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 15:46:12 -0500
IronPort-SDR: AAOrHUUgNstwmZE27ithy3BEtBC3pF6mmfbtfAhtpSi17ORX3CyQfUZGZnQv35Ob6QcJxfBC0+
 yZiEdzZOM3EA==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="169259935"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="169259935"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 12:46:11 -0800
IronPort-SDR: 4d3Mksw04uYnFdOnVqMv+heD2CrWKg0xX5kobUbQfJIfvAvk01UHTFpuajfIqZcHeHKBfijjqo
 p9zoUleUvbQw==
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="353481014"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 12:46:10 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ka3Cy-003deX-DQ; Tue, 03 Nov 2020 22:47:12 +0200
Date:   Tue, 3 Nov 2020 22:47:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/7] resource: introduce union(), intersection() API
Message-ID: <20201103204712.GI4077@smile.fi.intel.com>
References: <20201103203655.17701-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103203655.17701-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 03, 2020 at 10:36:48PM +0200, Andy Shevchenko wrote:
> Some users may want to use resource library to manage their own resources,
> besides existing users that open code union() and intersection()
> implementations.
> 
> Provide a generic API for wider use.
> 
> Changelog v5:
> - added test cases (Greg)

Sorry, just realized I forgot to add collected tags.
Fixed in v6. Sorry for a bit of spam.

-- 
With Best Regards,
Andy Shevchenko


