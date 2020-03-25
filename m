Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A4E191E84
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 02:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgCYBRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 21:17:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:63498 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgCYBRp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Mar 2020 21:17:45 -0400
IronPort-SDR: QXzpPXbxaPpPJryQvXagFSmUyif5iRMs77RQhaTLJivW2cC1Fzgi9LAEfC2hBBZe4OtKY1xNYX
 HLY8/0T6UuTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 18:17:45 -0700
IronPort-SDR: kxzbOiJ4c7MKljyC35eszgw9oLZcg/hkKSPkEMFCGkM+EqZIi88KJ2Wh0Mp0P2RgkGVK2zxPSM
 ugAHk/cjthVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,302,1580803200"; 
   d="scan'208";a="265371309"
Received: from hmendezc-mobl1.amr.corp.intel.com (HELO [10.254.108.97]) ([10.254.108.97])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2020 18:17:44 -0700
Subject: Re: [PATCH v18 03/11] PCI/DPC: Fix DPC recovery issue in non hotplug
 case
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200324234944.GA73526@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <e5af8e6e-ce37-eba4-330e-94b43bd0adb7@linux.intel.com>
Date:   Tue, 24 Mar 2020 18:17:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324234944.GA73526@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/24/20 4:49 PM, Bjorn Helgaas wrote:
> I don't understand why hotplug is relevant here.  This path
> (dpc_reset_link()) is only used for downstream ports that support DPC.
> DPC has already disabled the link, which resets everything below the
> port, regardless of whether the port supports hotplug.
> 
> I do see that PCI_ERS_RESULT_NEED_RESET seems to promise a lot more
> than it actually*does*.  The doc (pci-error-recovery.rst) says
> .error_detected() can return PCI_ERS_RESULT_NEED_RESET to*request*  a
> slot reset.  But if that happens, pcie_do_recovery() doesn't do a
> reset at all.  It calls the driver's .slot_reset() method, which tells
> the driver "we've reset your device; please re-initialize the
> hardware."
> 
> I guess this abuses PCI_ERS_RESULT_NEED_RESET by taking advantage of
> that implementation deficiency in pcie_do_recovery(): we know the
> downstream devices have already been reset via DPC, and returning
> PCI_ERS_RESULT_NEED_RESET means we'll call .slot_reset() to tell the
> driver about that reset.
> 
> I can see how this achieves the desired result, but if/when we fix
> pcie_do_recovery() to actually*do*  the reset promised by
> PCI_ERS_RESULT_NEED_RESET, we will be doing*two*  resets: the first
> via DPC and a second via whatever slot reset mechanism
> pcie_do_recovery() would use.
When we fix this issue, if we make sure the reset logic is
implemented before we call .reset_link callback we should be
able to avoid resetting the device twice. Before we call DPC
.reset_link callback, the device link will not up and hence we
should not able to reset it.
> 
> So I guess the real issue (as you allude to in the commit log) is that
> we rely on hotplug to unbind/rebind the driver, and without hotplug we
> need to at least tell the driver the device was reset.
Agree
> 
> I'll try to expand the comment here so it reminds me what's going on
> when we have to look at this again:)   Let me know if I'm on the right
> track.
Yes, your understanding is correct.
