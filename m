Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E97F79E675
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 13:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbjIMLSB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 07:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbjIMLRr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 07:17:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718BC212F;
        Wed, 13 Sep 2023 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694603856; x=1726139856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EINwWwU3qdAxq238HtvPTy5ZZC9fwj5Kb64aFwlmnKA=;
  b=hCgtB19j3gze5LQduMLa2fAsAlqLqw+L4ENuunch4Tg43U6dpjmNkQX6
   Gj6ZpKRlvZY1y17F1HS1L/1z1hfWz+m/mlApsK8XL4/TAq6S+uHRElVjV
   B9xJS2Le3k49L6N0hl2htiUQ+MLiVKEnSVQyIjcNJ4EcfRfrIC0DnTBGj
   LHRdOzLoeL6okjwjqnf7S20/z778ispEQO/6lr+8LJZzNW1rHTFH6Q6aO
   da4IHcAA4bj09mdRWcy9Kmztu3UvGcLo+6Sid4/b2WD1HAo2lOu1T92O6
   +lIigPsBo0ipTNjxvP0bXfKiM9ITXdY9Mccm60McTBQK5nFUQ+Ogu7D6u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="382435268"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="382435268"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867753665"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="867753665"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:17:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qgNsA-008qeM-1X;
        Wed, 13 Sep 2023 14:17:30 +0300
Date:   Wed, 13 Sep 2023 14:17:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, Andrew Lunn <andrew@lunn.ch>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Subject: Re: [PATCH V13 0/5] Generate device tree node for pci devices
Message-ID: <ZQGaSr+G5qu/8nJZ@smile.fi.intel.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
 <ZP96feVs2ev7098Y@smile.fi.intel.com>
 <CAL_JsqKfQJFrd8MOdjW55cYdEb8yyPyR+P3ran9+X3dCwUgdyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKfQJFrd8MOdjW55cYdEb8yyPyR+P3ran9+X3dCwUgdyA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 12, 2023 at 02:12:04PM -0500, Rob Herring wrote:
> On Mon, Sep 11, 2023 at 3:37 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Aug 15, 2023 at 10:19:55AM -0700, Lizhi Hou wrote:

...

> > Can you point out to the ACPI excerpt(s) of the description of anything related
> > to the device(s) in question?
> 
> I don't understand what you are asking for.

Through the email thread it was mentioned that this series was tested on the
ACPI enabled platform, Jonathan (IIRC) asked why do we need to have a shadow
DT for the something that ACPI already describes. That's why I'm trying to
understand if it's the case. and if so, how can we improve the approach.

-- 
With Best Regards,
Andy Shevchenko


