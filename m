Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791EF4FDE89
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345813AbiDLLuj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 07:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354961AbiDLLtH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 07:49:07 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEEF289B5;
        Tue, 12 Apr 2022 03:31:43 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1649759502; bh=c7RNN2NtUCiYlktRTLZb1F1QUe+9TGp7AyZCCAy5SII=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=i0947lNSEqN2IuVWsHrGspcGTvLXZd/DKWzbOut1/erwhO20GMjCouYMNFs3v9kGf
         c76SbL0mPdFL3XZkE3+b6c1EwH+Q4txbzSyDzYhBm2UhOgx2Ta1CxH90EYRfVBV12P
         oTIILWGKabOdRga3Q5bNS0kU1Is+jaAHnxCIN2kwfNVXSkOsYBIJGfmfSzty9ZZwux
         eVasnqs4aLDGQmvpsapXpngyC/BurhDbrXWZU5CRyMa01DCOBIxfvoFRd1Z55M5/JX
         bjiHCMNeaxf5CU7HF05TAtcNzOW1WGCUGadfFnkke4rPcHn5+UQZWo1ZHo0TVVkgF4
         /qwnGmMNgkqwg==
To:     "Box, David E" <david.e.box@intel.com>,
        "Wang, Wendy" <wendy.wang@intel.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: PCIE ASPM-related trouble with S0ix on Thinkpad X1 (NVME-related?)
In-Reply-To: <MW3PR11MB4522A97808B70EFA41122723A1ED9@MW3PR11MB4522.namprd11.prod.outlook.com>
References: <87k0bvutxf.fsf@toke.dk>
 <MW3PR11MB4522A97808B70EFA41122723A1ED9@MW3PR11MB4522.namprd11.prod.outlook.com>
Date:   Tue, 12 Apr 2022 12:31:40 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <8735ii384z.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"Box, David E" <david.e.box@intel.com> writes:

> There are a few things that could be going on. Please file a bug
> report at bugzilla.kernel.org under Power Management. Provide all this
> information and include the output from lspci -vvv when ran as root.
> Thanks.

Alright, thanks! Opened
https://bugzilla.kernel.org/show_bug.cgi?id=215832

-Toke
