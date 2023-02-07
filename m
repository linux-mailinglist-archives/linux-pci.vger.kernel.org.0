Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BFC68E1E3
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 21:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjBGUcY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 15:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjBGUcX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 15:32:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A8D36FE8;
        Tue,  7 Feb 2023 12:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675801942; x=1707337942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6noEI464CUMFcBf7pZxqivQw9LwN/ttWIrgnoBxYvRY=;
  b=K4VXv0/fKFE96GclVhLuBDGkDnSgeGylapTb4dtxdYYuMdSY3TskKqdv
   lC5yOnsL45/tgD+ixkyWvH0uZ071VESWYA1lfOwUEOtdp+f1VUarj9RVZ
   bac5M5y84t4MjLaDY9EVScTusS1j7DqiqZj7KDF+/Xui47Ebvcvkx//gS
   ojt00VUezx928DcVk4/kG017AGZwUJe/+PYYUnLK83ZwrNlgtmPIcw6on
   21bgSX4pSbijRLVsrUP6ODW6aEgodjfYyhGAgGR+9yW4T71Q7C+Pvk0Pn
   dx5CKMIV9Lt4F+TdNCVoRdRl+RONXmtoqxlG9t/BPrsPor507+TS1Z47b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="317614410"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="317614410"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:32:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="755755078"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="755755078"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.55.98]) ([10.212.55.98])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:32:21 -0800
Message-ID: <c830a68e-014b-ddec-4bab-5db337fc378f@linux.intel.com>
Date:   Tue, 7 Feb 2023 13:32:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0
 controller
Content-Language: en-US
To:     Xinghui Li <korantwork@gmail.com>, Keith Busch <kbusch@kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>
References: <20221222072603.1175248-1-korantwork@gmail.com>
 <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev>
 <Y6TSgGdCTvkwPiVg@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com>
 <d14ac29d-027a-08a7-c5c8-848a6920d4a2@linux.dev>
 <CAEm4hYXncuvL-Gk1aEZExrvkbx=N1aiOQNeNjFdB4443EbKNBA@mail.gmail.com>
 <f05ee82a-4532-b12b-490f-904b946ff7b0@linux.dev>
 <CAEm4hYXk1RuKEw41VukH2iGTo_9GmZjUfrESWK5vFtpFA_O_4A@mail.gmail.com>
 <CAEm4hYWeZFrYxSvAcBJ8iw=t507vZMqfBwiQXFSJd2Hcyfw7fA@mail.gmail.com>
 <9e6cfda1-4309-d1bb-a0cf-404a7fe7d3aa@linux.intel.com>
 <Y+FG2EUpmsmCZqwh@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYWjaVCDFtCCyHrq5vOie4wV5LFn-UVZ5qQbpASxVGy1TA@mail.gmail.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <CAEm4hYWjaVCDFtCCyHrq5vOie4wV5LFn-UVZ5qQbpASxVGy1TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/6/2023 8:18 PM, Xinghui Li wrote:
> Keith Busch <kbusch@kernel.org> 于2023年2月7日周二 02:28写道：
>> On Mon, Feb 06, 2023 at 11:11:36AM -0700, Patel, Nirmal wrote:
>>> I like the idea of module parameter to allow switching between the modes
>>> but keep MSI remapping enabled (non-bypass) by default.
>> Isn't there a more programatic way to go about selecting the best option at
>> runtime?
> Do you mean that the operating mode is automatically selected by
> detecting the number of devices and CPUs instead of being set
> manually?
>> I suspect bypass is the better choice if "num_active_cpus() > pci_msix_vec_count(vmd->dev)".
> For this situation, My speculation is that the PCIE nodes are
> over-mounted and not just because of the CPU to Drive ratio.
> We considered designing online nodes, because we were concerned that
> the IO of different chunk sizes would adapt to different MSI-X modes.
> I privately think that it may be logically complicated if programmatic
> judgments are made.

Also newer CPUs have more MSIx (128) which means we can still have
better performance without bypass. It would be better if user have
can chose module parameter based on their requirements. Thanks.

