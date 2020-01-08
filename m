Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19C2134F14
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 22:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgAHVr6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 16:47:58 -0500
Received: from ale.deltatee.com ([207.54.116.67]:50096 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgAHVr6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 16:47:58 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ipJBD-00012Q-Ql; Wed, 08 Jan 2020 14:47:56 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>
References: <20200108213337.GA210184@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <302aff9f-ff12-027c-80c8-2af2afca8359@deltatee.com>
Date:   Wed, 8 Jan 2020 14:47:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200108213337.GA210184@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: dmeyer@gigaio.com, epilmore@gigaio.com, Kelvin.Cao@microchip.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 03/12] PCI/switchtec: Add support for new events
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-01-08 2:33 p.m., Bjorn Helgaas wrote:
> On Mon, Jan 06, 2020 at 12:03:28PM -0700, Logan Gunthorpe wrote:
>> The intercomm notify  event was added for PAX variants of switchtec
>> hardware and the UEC Port was added for the MR1 release of GEN3 firmware.
> 
> Do they actually spell it "intercomm" in the datasheet?  Seems like
> the most common English spelling is "intercom".

Hmm, not sure I don't have this event in my datasheet which is a little
out of date. Kelvin, whose CC'd, would know if we can change the
spelling hopefully he can weigh in on this. As far as I know the define
isn't used anywhere yet.

> Is there some meaningful expansion of "UEC"?

Upstream Error Containment -- I'll mention that in the commit message.

Logan


>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  drivers/pci/switch/switchtec.c       | 3 +++
>>  include/linux/switchtec.h            | 7 +++++--
>>  include/uapi/linux/switchtec_ioctl.h | 4 +++-
>>  3 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
>> index 9c3ad09d3022..218e67428cf9 100644
>> --- a/drivers/pci/switch/switchtec.c
>> +++ b/drivers/pci/switch/switchtec.c
>> @@ -751,10 +751,13 @@ static const struct event_reg {
>>  	EV_PAR(SWITCHTEC_IOCTL_EVENT_MRPC_COMP, mrpc_comp_hdr),
>>  	EV_PAR(SWITCHTEC_IOCTL_EVENT_MRPC_COMP_ASYNC, mrpc_comp_async_hdr),
>>  	EV_PAR(SWITCHTEC_IOCTL_EVENT_DYN_PART_BIND_COMP, dyn_binding_hdr),
>> +	EV_PAR(SWITCHTEC_IOCTL_EVENT_INTERCOMM_REQ_NOTIFY,
>> +	       intercomm_notify_hdr),
