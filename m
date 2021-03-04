Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CDC32DDB0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 00:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhCDXT1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 18:19:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:18533 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231539AbhCDXT0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Mar 2021 18:19:26 -0500
IronPort-SDR: GBgoQB3Se8NH45Qo7ULokX7v4ztzys3v+EFhRM/mTocgASeOoRjKpaG5ESYMauGji2ow1KI4Wr
 IlBFvhTWYejg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="175154274"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="175154274"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 15:19:26 -0800
IronPort-SDR: TCKVXZAV5r6HSk0uS/zivBg/B/tMkymAGssYnMfL7KiVr7ZKMOcU2yP0xVLJCqZKb4PyyMO1Kc
 N8ogjv4bxuig==
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="445934378"
Received: from ktphan-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.39.18])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 15:19:26 -0800
Subject: Re: [PATCHv2 3/5] PCI/ERR: Retain status from error notification
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "hinko.kocevar@ess.eu" <hinko.kocevar@ess.eu>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
References: <20210104230300.1277180-1-kbusch@kernel.org>
 <20210104230300.1277180-4-kbusch@kernel.org>
 <fe1defb66b5438f45093d67e05ef4153d0ae60eb.camel@intel.com>
 <d9ee4151-b28d-a52a-b5be-190a75e0e49b@intel.com>
 <20210304200109.GB32558@redsun51.ssa.fujisawa.hgst.com>
 <CAPcyv4gZPc3izOaRBx8sBBM_1YV3F3OMjjZX8Ha0m3PxzJhiCw@mail.gmail.com>
 <23551edc-965c-21dc-0da8-a492c27c362d@intel.com>
 <CAPcyv4jFYtNeA7TdeCBh5v1S=Pw2BGvdv91SMjX0MTj_0VE4DQ@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Message-ID: <4c2a799f-c4e9-b203-3487-f9c117fba5e7@intel.com>
Date:   Thu, 4 Mar 2021 15:19:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jFYtNeA7TdeCBh5v1S=Pw2BGvdv91SMjX0MTj_0VE4DQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/4/21 2:59 PM, Dan Williams wrote:
> On Thu, Mar 4, 2021 at 2:38 PM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@intel.com> wrote:
>>
>> On 3/4/21 2:11 PM, Dan Williams wrote:
>>
>> On Thu, Mar 4, 2021 at 12:03 PM Keith Busch <kbusch@kernel.org> wrote:
>>
>> On Tue, Mar 02, 2021 at 09:46:40PM -0800, Kuppuswamy, Sathyanarayanan wrote:
>>
>> On 3/2/21 9:34 PM, Williams, Dan J wrote:
>>
>> [ Add Sathya ]
>>
>> On Mon, 2021-01-04 at 15:02 -0800, Keith Busch wrote:
>>
>> Overwriting the frozen detected status with the result of the link reset
>> loses the NEED_RESET result that drivers are depending on for error
>> handling to report the .slot_reset() callback. Retain this status so
>> that subsequent error handling has the correct flow.
>>
>> Reported-by: Hinko Kocevar <hinko.kocevar@ess.eu>
>> Acked-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
>>
>> Just want to report that this fix might be a candidate for -stable.
>>
>> Agree.
>>
>> I think it can be merged in both stable and mainline kernels.
>>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Just FYI, this patch is practically a revert of this one:
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=6d2c89441571ea534d6240f7724f518936c44f8d
>>
>> so please let me know if that is still a problem for you.
>>
>> For what it's worth I think "6d2c89441571 PCI/ERR: Update error status
>> after reset_link()" is not justified. The link shouldn't recover if
>> the attached device is not prepared to handle DPC events.
>>
>> I added that fix to address the recovery issue seen in a Dell server
>> platform (for EDR test case). If I understand the history correctly,
>> In EDR case, AER and DPC is owned by firmware, hence we get
>> PCI_ERS_RESULT_NO_AER_DRIVER when executing error_detected() callbacks.
>> So If we continue the pcie_do_recovery() with PCI_ERS_RESULT_NO_AER_DRIVER
>> as error status, then even if we successfully reset the link we will report
>> the recovery status as failure.
> But that's the right response if there is no handler.
If the handler is not available due to AER being owned by firmware,
then it needs to be fixed. In EDR mode, even if DPC/AER is owned
by firmware , OS need to own the recovery part. So I think it
needs further investigation to understand why it reports,
PCI_ERS_RESULT_NO_AER_DRIVER
> If there is a
> device attached that was not prepared for the link to go down then it
> does not matter if the link comes back ok that device will be
> thoroughly confused and should be disconnected.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

