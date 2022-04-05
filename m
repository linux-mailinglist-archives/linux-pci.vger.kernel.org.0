Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949D14F36E7
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 16:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbiDELI5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 07:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353169AbiDEKFt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 06:05:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385E2BE9D3;
        Tue,  5 Apr 2022 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649152465; x=1680688465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FvrfFAwIBkVcQbb44q338G+GvCQgvfd7wKltudNp7nY=;
  b=hhOW0vpitTEhCP8nc2qeltOhLzwnDzEgjFoVOlq6WKo/MkNN8vZcojXN
   FE0bDOvgd2gW7m+F88iRODUsH1GyVrmWrTr/Vs9J3VZetdLwXonY/p4u7
   Ius0XkJI+OSRMCMjI1Coz4WWeUMI8A2idxgEwiA6CffOdh0TPbnIBHIum
   UqL+xCpg/ujcZlexuK7ZD6aiBQvni8oXv5yPIPT7P1JwLU+WagVQyvX2P
   wpDwVDc5XGE5EIjFUWywBeWIeqWtAuItnv4yNJb3+oG8/Utf2pUK52Mid
   j2XasMRuahzsz7JZAP1mQbcCKwT9NZjpfVSn+7nz6Hg/7vJZdxx78RXfc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="347150668"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="347150668"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 02:54:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="556460066"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 02:54:21 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 05 Apr 2022 12:54:19 +0300
Date:   Tue, 5 Apr 2022 12:54:19 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v1 2/2] PCI: PM: Resume bus after putting the bridge into
 D0 entirely
Message-ID: <YkwRyxJWTFs7HnDM@lahna>
References: <4198163.ejJDZkT8p0@kreacher>
 <1807986.atdPhlSkOF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1807986.atdPhlSkOF@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 04, 2022 at 05:42:27PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is rather counter-intuitive to attempt to resume devices on a bus
> segment before completing a transition of their parent bridge into
> D0, so do that when the transition is complete.
> 
> This matters especially when the transition in question is not
> successful, in which case it doesn't make sense to even try to
> resume the child devices at all.

Good point.

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
