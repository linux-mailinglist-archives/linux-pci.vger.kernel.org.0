Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337D4758895
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 00:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjGRWhv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 18:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGRWhv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 18:37:51 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A6C1993
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 15:37:47 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae953.dynamic.kabel-deutschland.de [95.90.233.83])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 13B7361E5FE37;
        Wed, 19 Jul 2023 00:37:20 +0200 (CEST)
Message-ID: <0221c4b6-096b-c8fb-2b83-cdfbab668589@molgen.mpg.de>
Date:   Wed, 19 Jul 2023 00:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] igc: Correct the short
 interval between PTM requests.
To:     Sasha Neftin <sasha.neftin@intel.com>
Cc:     Michael Edri <michael.edri@intel.com>, linux-pci@vger.kernel.org,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20230717171927.78516-1-sasha.neftin@intel.com>
 <80bfadb3-5af3-0100-30bb-c5008660d5a5@molgen.mpg.de>
 <af05bc6d-adf3-a0d1-534d-976f99e96d58@intel.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <af05bc6d-adf3-a0d1-534d-976f99e96d58@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Cc: +Vinicius]

Dear Sasha,


Am 18.07.23 um 18:15 schrieb Neftin, Sasha:
> On 7/17/2023 20:32, Paul Menzel wrote:
>> [Cc: +linux-pci@vger.kernel.org]

[…]

>> Maybe be more specific in the commit message summary. Maybe:
>>
>> igc: Decrease PTM short interval from 10 us to 1 us
> 
> Good.
> 
>> Am 17.07.23 um 19:19 schrieb Sasha Neftin:
>>> With the 10us interval, we were seeing PTM transactions taking around 12us.
>>> With the 1us interval, PTM dialogs took around 2us. Checked with the
>>> PCIe sniffer.
>>
>> On what board, and with what device and what firmware versions?
> 
> Any with the PTM support. HW feature and not dependent on the firmware.

Still you tested it. It’s always beneficial to at least denote one of 
the systems with all the details. Especially as it shouldn’t cost you 
more than a minute to add these details.

>>> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
>>> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>>> ---
>>>   drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h 
>>> b/drivers/net/ethernet/intel/igc/igc_defines.h
>>> index 44a507029946..c3722f524ea7 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
>>> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
>>> @@ -549,7 +549,7 @@
>>>   #define IGC_PTM_CTRL_SHRT_CYC(usec)    (((usec) & 0x2f) << 2)
>>>   #define IGC_PTM_CTRL_PTM_TO(usec)    (((usec) & 0xff) << 8)
>>> -#define IGC_PTM_SHORT_CYC_DEFAULT    10  /* Default Short/interrupted cycle interval */
>>> +#define IGC_PTM_SHORT_CYC_DEFAULT    1   /* Default short cycle 
>>> interval */
>>
>> Why is the comment updated?
> 
> Interval, not interrupt...

Sorry, I do not understand your answer. It’d be great, if you elaborated.

>>>   #define IGC_PTM_CYC_TIME_DEFAULT    5   /* Default PTM cycle time */
>>>   #define IGC_PTM_TIMEOUT_DEFAULT        255 /* Default timeout for PTM errors */


Kind regards,

Paul
