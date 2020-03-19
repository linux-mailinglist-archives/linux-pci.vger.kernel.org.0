Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 193E318C38F
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 00:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgCSXUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 19:20:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:52795 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbgCSXUb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Mar 2020 19:20:31 -0400
IronPort-SDR: 8xhBghOgH8dLeI7AKPAzEDl8892xTKWJAOZDPDrQNWznVg3xFhXpD2fR5TmvxxDgp/LtPZ7rnL
 hShL0uTgfuTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 16:20:30 -0700
IronPort-SDR: HadMi20uLVxGJHG83LdM8Njh7ZI/TT88bere7YVaDRqKjeXLCDNzL6hBB8Cujxa/7djijHK2GA
 9elU9z1ZdyFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,573,1574150400"; 
   d="scan'208";a="245314583"
Received: from samirson-mobl1.amr.corp.intel.com (HELO [10.255.231.67]) ([10.255.231.67])
  by orsmga003.jf.intel.com with ESMTP; 19 Mar 2020 16:20:30 -0700
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Austin.Bolen@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
References: <20200319230303.GA26334@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <6ae88659-7c15-900a-c56d-c08c1f40f3c6@linux.intel.com>
Date:   Thu, 19 Mar 2020 16:20:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319230303.GA26334@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/19/20 4:03 PM, Bjorn Helgaas wrote:
> I made a few of the updates Christoph suggested and updated the
> review/edr branch.  Do you want to start with that as the basis for a
> v18 posting?

Do you want to merge your version of patch set first? or wait till we
address all of the following open issues.

1. Move reset_link callback to pcie_do_recovery().
2. If recovery issue exist in non-hotplug case, investigate
    and fix it ( this needs more testing and review).
3. synchronize EDR handler with hot-plug DLLSC state change handler.
