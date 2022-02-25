Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7FC4C4E71
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 20:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiBYTOn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 14:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiBYTOn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 14:14:43 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FFF21BC7B;
        Fri, 25 Feb 2022 11:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645816450; x=1677352450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4F5q6A0jER9Ar6T9F+pJoTaJyetTnnAUTKjDx2UvVrg=;
  b=SykShM49cxmSltRSi32RcAqlr04uMScUa5YRTNxlBYO0S3QvHHe5712X
   5dKPDO614gQC4xY3QolahWwB3DPbhYAeQMVzEIPaKGI1KB7RixBNdCcXW
   oXgWPSZbSV4VI7IYbbdij5u37imuBmMbTqW+AV6Tdpcjhit/2JebCMBeQ
   9F0yqFk9xmgElTm0aWXfVHfEFms6C8bno/g/3LshsasxWO/LbGElH+d9K
   HpXLOddnaTvH7jmKevjgI4pG40wTrjcLR9np3h7tH6+t91H4udjWF+RxP
   FM+eCvThz/oikaGTt1v4DKNtR77EhvihNzCkNSG4KZPpCcnH9X7Fzvkkh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="239967233"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="239967233"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 11:14:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="492065316"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 25 Feb 2022 11:14:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 11:14:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 11:14:04 -0800
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.2308.021;
 Fri, 25 Feb 2022 11:14:04 -0800
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH] PCI/P2PDMA: Update device table with 3rd gen Xeon
 platform information
Thread-Topic: [PATCH] PCI/P2PDMA: Update device table with 3rd gen Xeon
 platform information
Thread-Index: AQHYHdIG4Q22z4JZ0Um0Xan5JCcwz6ylH28A//+ceRA=
Date:   Fri, 25 Feb 2022 19:14:03 +0000
Message-ID: <cde2aa29568a42418ee9cdc2616a2138@intel.com>
References: <20220209162801.7647-1-michael.j.ruhl@intel.com>
 <20220225170944.GA364325@bhelgaas>
In-Reply-To: <20220225170944.GA364325@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>-----Original Message-----
>From: Bjorn Helgaas <helgaas@kernel.org>
>Sent: Friday, February 25, 2022 12:10 PM
>To: Ruhl, Michael J <michael.j.ruhl@intel.com>
>Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
>bhelgaas@google.com; logang@deltatee.com; Williams, Dan J
><dan.j.williams@intel.com>
>Subject: Re: [PATCH] PCI/P2PDMA: Update device table with 3rd gen Xeon
>platform information
>
>On Wed, Feb 09, 2022 at 11:28:01AM -0500, Michael J. Ruhl wrote:
>> In order to do P2P communication the bridge ID of the platform
>> must be in the P2P device table.
>>
>> Update the P2P device table with a device id for the 3rd Gen
>> Intel Xeon Scalable Processors.
>>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>
>Updated the commit log to match previous similar patches and applied
>as below to pci/p2pdma for v5.18, thanks!

Thank you!

>Device ID 0x09a2 doesn't appear at https://pci-ids.ucw.cz/read/PC/8086
>which means "lspci" won't be able to display a human-readable name for
>these devices.  You can easily add a name at that same URL.

I will see about getting this updated asap.

Regards,

M

>Bjorn
>
>
>  commit feaea1fe8b36 ("PCI/P2PDMA: Add Intel 3rd Gen Intel Xeon Scalable
>Processors to whitelist")
>  Author: Michael J. Ruhl <michael.j.ruhl@intel.com>
>  Date:   Wed Feb 9 11:28:01 2022 -0500
>
>    PCI/P2PDMA: Add Intel 3rd Gen Intel Xeon Scalable Processors to whitel=
ist
>
>    In order to do P2P communication the bridge ID of the platform must be=
 in
>    the P2P device table.
>
>    Update the P2P device table with a device ID for the 3rd Gen Intel Xeo=
n
>    Scalable Processors.
>
>    Link: https://lore.kernel.org/r/20220209162801.7647-1-
>michael.j.ruhl@intel.com
>    Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>    Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>
>> ---
>>  drivers/pci/p2pdma.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 1015274bd2fe..30b1df3c9d2f 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -321,6 +321,7 @@ static const struct pci_p2pdma_whitelist_entry {
>>  	{PCI_VENDOR_ID_INTEL,	0x2032, 0},
>>  	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
>>  	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
>> +	{PCI_VENDOR_ID_INTEL,	0x09a2, 0},
>>  	{}
>>  };
>>
>> --
>> 2.31.1
>>
