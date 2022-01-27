Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC2649DAC7
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 07:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiA0Gf5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 01:35:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:55342 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236813AbiA0Gf4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 01:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643265356; x=1674801356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qfCEG17eUg1nUtn5Bjyg0zcAkUJsBlQnqzVAjVIbB6I=;
  b=XXP7IbrkI9V1VOrSDVgU7kEFa4uvcu3eTeQz/NLhMlt1mggrUpwvXOze
   1IEn49C+gJe2OUaxP9CDH6O8MPG5U1ootk6poAlgTt+9kkTjpjdBo9YXm
   sUPTWk/DkyvMHp9xcuALH2K6Sv1KLf/uzcogBXhGlJG8x0f18DRAoH/v7
   ZtMA6VY24IqA2SbpueKLpp3Gxy5Uh1jra5HzpIf0Xa6WcLlFQf0GUJLlH
   M5TCGNH3+9E/sJvilcrL+zSZNd7cKW+kZ3Md/ileNXXsmhV+WEPBJOjD5
   wOhWC4slpGRYew4cvkm4q5DIYciwX6udKnUdG3ITRZJh85BnVGpUyaB5r
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="227437977"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="227437977"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:35:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="477753942"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:35:51 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 27 Jan 2022 08:35:27 +0200
Date:   Thu, 27 Jan 2022 08:35:27 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/AER: Disable AER when link is in L2/L3 ready, L2
 and L3 state
Message-ID: <YfI9L01LI/0rZIuP@lahna>
References: <20220126071853.1940111-1-kai.heng.feng@canonical.com>
 <YfEqZMUS9jyiErmF@lahna>
 <CAAd53p7H3RApEHOzJYorD9VBnaPqYRkzE2g+8hAUXRToc=jbGg@mail.gmail.com>
 <YfI7u5XSlNlx2w4I@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfI7u5XSlNlx2w4I@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 08:29:22AM +0200, Mika Westerberg wrote:
> > For example, should we convert commit a697f072f5da8 ("PCI: Disable PTM
> > during suspend to save power") to PM hooks in PTM service?
> 
> Yes, I think that's the right thing to do. I wonder how it was not using
> the PM hooks in the first place.

Actually no. The reason it is not using PM hooks is that PTM is not a
port "service" so it needs to be dealt in the core.
