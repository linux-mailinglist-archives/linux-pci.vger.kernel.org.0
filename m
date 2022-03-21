Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5554E2E14
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 17:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346096AbiCUQcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351252AbiCUQby (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 12:31:54 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6B251590;
        Mon, 21 Mar 2022 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=s3lcHJdrwD/PP8Ft4hyr0+q/Au2xCLskRoPRksjWMDg=; b=UwUD9IU51AOICt2I/+sVTjvxII
        wZYBfeMssjoQe2T0qlG1+L0eYZ4LbVhcubFCRO/2OS6wOLtS9+XiopbD1EkH+toG9GKQoClCJUVBv
        IXGJGpStTl5+srDQmYp1xbkjL/b8dXXVh3kbHOW/QgabccEOt3Q/SGd3CbmUdfTlPH7Cc9yKpvFJm
        XnNtNmvFPHvcnaLjr27SJuHOEcXm/aLsMTjQzMLS13rRqckIbHhKxCJ9met+H609042RTJShHnwRq
        WDfUEL7aLMgguvqD6o9STcOThPCqp5XPPdV+nNmO8bywSRkP+xXRIhBZG4mhAEBPQRE/5mi0B8P3A
        jpCtmouQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nWKvE-005YHB-DD; Mon, 21 Mar 2022 10:30:20 -0600
Message-ID: <026bf48f-caf1-2d1e-b4de-553a6625a51b@deltatee.com>
Date:   Mon, 21 Mar 2022 10:30:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-CA
To:     Shlomo Pongratz <shlomopongratz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, bhelgaas@google.com,
        Shlomo Pongratz <shlomop@pliops.com>
References: <20220321143120.12191-1-shlomop@pliops.com>
 <981016a7-f994-f0dd-422e-66ac909371c7@deltatee.com>
 <302CF9D7-ACBD-49D6-AE56-4830B746CE1F@gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <302CF9D7-ACBD-49D6-AE56-4830B746CE1F@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: shlomopongratz@gmail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, andrew.maier@eideticom.com, bhelgaas@google.com, shlomop@pliops.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v1] Intel Sky Lake-E host root ports check.
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-03-21 10:21, Shlomo Pongratz wrote:
> See inline
> 
> Shlomo.
> 
>> On 21 Mar 2022, at 17:46, Logan Gunthorpe <logang@deltatee.com
>> <mailto:logang@deltatee.com>> wrote:
>>
>>
>>
>> On 2022-03-21 08:31, Shlomo Pongratz wrote:
>>> On commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports
>>> B, C, D to the whitelist")
>>> Andrew Maier added the Sky Lake-E additional devices
>>> 2031, 2032 and 2033 root ports to the already existing 2030 device.
>>> Note that the Intel devices 2030, 2031, 2032 and 2033 are ports A, B,
>>> C and D.
>>> Consider on a bus X only port C is connected downstream so in the PCI
>>> scan only
>>> device 8086:2032 on 0000:X:02.0 will be found as bridges that have no
>>> children are ignored.
>>> As a result the routine pci_host_bridge_dev will return NULL for
>>> devices under slot C.
>>> In the proposed patch port field is added to the whitelist which is 0
>>> for 2030, 1 for 2031,
>>> 2 for 2032 3 for 2033 and 0 for all other devices.
>>
>> The patch looks largely ok, but I'm not sure I follow this description.
>>
>> It sounds like in practice the host bridges B, C and D are not addressed
>> at function 0 as was assumed. But what does it mean that only C is
>> connected downstream? How can a bridge not be connected downstream?
>>
> Maybe it is wrong usage of words.
> I mean three are no devices behind port A and B, it is possible if there
> if one has empty PCI slots.
> I my case I had only on NVMe SSD connected to port C.

If a bridge has no devices behind it, it's not ever going to get into
the p2pdma code; so I'm not sure how that's relevant. And just because
one user doesn't have any device behind a bridge, doesn't mean that all
users have no devices under that bridge.

Sounds like the commit description and comments just neeed to change to
note that the function of each of the bridge is not always zero, as
originally assumed.

Logan
