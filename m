Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2F589A14
	for <lists+linux-pci@lfdr.de>; Thu,  4 Aug 2022 11:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiHDJr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 05:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiHDJr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 05:47:56 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ADF248CD
        for <linux-pci@vger.kernel.org>; Thu,  4 Aug 2022 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1659606475; x=1691142475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vc1h0NRm07mjXGVv1T9LW++SlzLJ0GRpU0Wya3/buP8=;
  b=DSFHEWmZ6ps02t2AjG7Y7798n3vIh0rnLjx1nwpoE82tQp+9DV+Kyo0f
   ztbmQNL3De7UEeTHlaNvLSDZt7JzkXX7n8dFFPuDZ+VMuLFO/Zm1MWCs3
   afq8d+arzTYh2c5/foxOkYpYr+CD/KUQyLj5IZYU+0UplAq+QQ+w6Wess
   c=;
X-IronPort-AV: E=Sophos;i="5.93,215,1654560000"; 
   d="scan'208";a="115685414"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-5c4a15b1.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 09:47:39 +0000
Received: from EX13D17EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-5c4a15b1.us-west-2.amazon.com (Postfix) with ESMTPS id F06E84488E;
        Thu,  4 Aug 2022 09:47:37 +0000 (UTC)
Received: from EX13D47EUB004.ant.amazon.com (10.43.166.79) by
 EX13D17EUB001.ant.amazon.com (10.43.166.85) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Thu, 4 Aug 2022 09:47:36 +0000
Received: from EX13D47EUB004.ant.amazon.com ([10.43.166.79]) by
 EX13D47EUB004.ant.amazon.com ([10.43.166.79]) with mapi id 15.00.1497.036;
 Thu, 4 Aug 2022 09:47:36 +0000
From:   "Arinzon, David" <darinzon@amazon.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "Dagan, Noam" <ndagan@amazon.com>,
        "Agroskin, Shay" <shayagr@amazon.com>,
        "Brandes, Shai" <shaibran@amazon.com>,
        "Kiyanovski, Arthur" <akiyano@amazon.com>,
        "mk@semihalf.com" <mk@semihalf.com>
Subject: vfio/pci - uAPI for WC
Thread-Topic: vfio/pci - uAPI for WC
Thread-Index: AdiiigdYqDp6n2o4TKqtyqvA3T6TdQFXQ8iw
Date:   Thu, 4 Aug 2022 09:47:36 +0000
Message-ID: <d42f195bffa444719065f4e84098fe0c@EX13D47EUB004.ant.amazon.com>
References: <c98f484bda1c44bbba73b0a67a2e4465@EX13D47EUB004.ant.amazon.com>
In-Reply-To: <c98f484bda1c44bbba73b0a67a2e4465@EX13D47EUB004.ant.amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.46]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

There's currently no mechanism for vfio that exposes WC-related operations =
(check if memory is WC capable, ask to WC memory) to user space module enti=
ties, such as DPDK, for example.
This topic has been previously discussed in [1], [2] and [3], but there was=
 no follow-up.
This capability is very useful for DPDK, specifically to the DPDK ENA drive=
r that uses vfio-pci, which requires memory to be WC on the TX path. Withou=
t WC, higher CPU utilization and performance degradation are observed.
In the above mentioned discussions, three options were suggested: sysfs, io=
ctl, mmap extension (extra attributes).

Was there any progress on this area? Is there someone who's looking into th=
is?
We're leaning towards the ioctl option, if there are no objections, we'd co=
me up with an RFC.

[1]: https://patchwork.kernel.org/project/kvm/patch/20171009025000.39435-1-=
aik@ozlabs.ru/
[2]: https://lore.kernel.org/linux-pci/2b539df4c9ec703458e46da2fc879ee3b310=
b31c.camel@kernel.crashing.org/
[3]: https://lore.kernel.org/lkml/20210429162906.32742-2-sdonthineni@nvidia=
.com/

Thanks,
David
