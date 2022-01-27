Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D6449DABF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 07:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiA0Gds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 01:33:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:58739 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbiA0Gdr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 01:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643265227; x=1674801227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oAtC2UENBb/Yx/gPjIbAsh8DxMuVnWALhMreXORpLwE=;
  b=knOstGt2xMcWq2/x8KS+lysgkI+tzHVex2DPwuJg2uZcLQLwwaH/0vxY
   fl3p0sWqR6mqMOx6UMiwTaOLuPbxh/Qs6y+Cgendxwnw3SQPg8kyXaCjG
   zWBfzY1KkeOnthv1ZHQBRwFE6zAkVfwgoyS+Ui8M5Qw3tssYDkxCAgdzf
   bJOr0kr9KN1eLR5phrfACLOkUJ3SxCL1ZYLz1Dtf4TzJhhMsqIfzK2lVx
   ZqiO3qgAgIJ3SXTobP+3s0KX5C3y3mRbiKwY8c4TcGUBRKKfvCrE/F7IY
   55OAirMne9aAcjfF5CnPMruQHGIUm3wrIbvjoripA5eOkLRMRicj0Sonp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="310077855"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="310077855"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:33:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="521097307"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:33:38 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 27 Jan 2022 08:31:20 +0200
Date:   Thu, 27 Jan 2022 08:31:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI/DPC: Disable DPC service when link is in
 L2/L3 ready, L2 and L3 state
Message-ID: <YfI8OGuAWKtPsv+J@lahna>
References: <20220127025418.1989642-1-kai.heng.feng@canonical.com>
 <20220127025418.1989642-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127025418.1989642-2-kai.heng.feng@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 10:54:18AM +0800, Kai-Heng Feng wrote:
> Since TLP and DLLP transmission is disabled for a Link in L2/L3 Ready,
> L2 and L3 (i.e. device in D3hot and D3cold), and DPC depends on AER, so
> also disable DPC here.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
